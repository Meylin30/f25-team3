package com.csc340.spartanfitness.mvc.controller;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.customer.CustomerService;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.provider.ProviderService;
import com.csc340.spartanfitness.workoutplans.Workout;
import com.csc340.spartanfitness.workoutplans.WorkoutService;
import com.csc340.spartanfitness.review.Review;
import com.csc340.spartanfitness.review.ReviewService;
import com.csc340.spartanfitness.subscription.Subscription;
import com.csc340.spartanfitness.subscription.SubscriptionService;
import com.csc340.spartanfitness.subscription.SubscriptionType;
import jakarta.servlet.http.HttpSession;

import org.hibernate.boot.registry.classloading.spi.ClassLoaderService.Work;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/customers")
public class CustomerMvcController {
    private final CustomerService customerService;
    private final ProviderService providerService;
    private final SubscriptionService subscriptionService;
    private final WorkoutService workoutService;
    private final ReviewService reviewService;

    public CustomerMvcController(CustomerService customerService,
                                 ProviderService providerService,
                                 SubscriptionService subscriptionService,
                                 WorkoutService workoutService,
                                 ReviewService reviewService) {
        this.customerService = customerService;
        this.providerService = providerService;
        this.subscriptionService = subscriptionService;
        this.workoutService = workoutService;
        this.reviewService = reviewService;
    }

    @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "customer/signup";
    }

    @PostMapping("/signup")
    public String signup(@ModelAttribute Customer customer) {
        customerService.createCustomer(customer);
        return "redirect:/signin";
    }

    @PostMapping("/signin")
    public String signin(@RequestParam String email, @RequestParam String password, HttpSession session) {
        try {
            Customer customer = customerService.authenticate(email, password);
            session.setAttribute("customerId", customer.getId());
            return "redirect:/customers/dashboard";
        } catch (Exception e) {
            return "redirect:/signin?error";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Long customerId = (Long) session.getAttribute("customerId");
        if (customerId == null) {
            return "redirect:/signin";
        }
        Customer customer = customerService.getCustomerById(customerId);
        model.addAttribute("customer", customer);
        return "customer/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("customerId");
        return "redirect:/";
    }

    @GetMapping("/profile/edit")
    public String editProfileForm(HttpSession session, Model model) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        }

        Customer customer = customerService.getCustomerById(customerId);
        model.addAttribute("customer", customer);
        return "customer/edit-profile";
    }

    @PostMapping("/profile/edit")
    public String UpdateProfile(@RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String dob,
                                @RequestParam(required = false) String weight,
                                @RequestParam(required = false) String height,
                                @RequestParam String currentPassword,
                                @RequestParam(required = false) String newPassword,
                                HttpSession session,
                                Model model) {
        Long customerId = (Long) session.getAttribute("customerId");
        if (customerId == null) {
            return "redirect:/signin";
        }

        System.out.println("linking customer to database");
        Customer customer = customerService.getCustomerById(customerId);
        
        try {
            System.out.println("Starting profile edit");
            customerService.authenticate(customer.getEmail(), currentPassword);
            System.out.println("\u001B[32m" +"authentication successful!" + "\u001B[0m");
            Customer updatedCustomer = new Customer();
            
            updatedCustomer.setName(name);
            System.out.println("Update name complete");
            updatedCustomer.setEmail(email);
            System.out.println("Update email complete");
            updatedCustomer.setWeight(weight != null && !weight.trim().isEmpty()
                 ? new BigDecimal(weight).setScale(2, RoundingMode.HALF_UP) : customer.getWeight());
                 System.out.println("Update weight complete");
            updatedCustomer.setHeight(height != null && !height.trim().isEmpty()
                 ? height : customer.getHeight());
                 System.out.println("Update height complete");     
            updatedCustomer.setPassword(newPassword != null && !newPassword.trim().isEmpty()
                 ? newPassword : customer.getPassword());
                 System.out.println("Update password complete");
            updatedCustomer.setDob(dob != null && !dob.isBlank()
                 ? LocalDate.parse(dob, DateTimeFormatter.ISO_DATE) : customer.getDob());     
            customerService.updateCustomer(customerId, updatedCustomer);
            System.out.println("Update dob complete");

            return "redirect:/customers/dashboard";
        } catch (Exception e) {
            Customer originalCustomer = customerService.getCustomerById(customerId);
            model.addAttribute("customer", originalCustomer);
            model.addAttribute("error", "Current password is incorrect.");
            return "customer/edit-profile";
        }
    }

    @GetMapping("/explore")
    public String browseWorkouts(@RequestParam(value = "search", required = false) String search, Model model) {
        List<Workout> availableWorkouts = workoutService.getActiveWorkouts();
        List<Provider> allProviders = providerService.getAllProviders();

         // Filter workouts independently
        List<Workout> filteredWorkouts = (search != null && !search.isBlank())
                ? availableWorkouts.stream()
                    .filter(w -> w.getTitle().toLowerCase().contains(search.toLowerCase()) ||
                                 w.getDescription().toLowerCase().contains(search.toLowerCase()))
                    .toList() : List.of();

        // Filter providers independently
        List<Provider> filteredProviders = (search != null && !search.isBlank())
                ? allProviders.stream()
                    .filter(p -> p.getName().toLowerCase().contains(search.toLowerCase()))
                    .toList() : List.of();

        model.addAttribute("searchWorkouts", filteredWorkouts);
        model.addAttribute("searchProviders", filteredProviders);

        model.addAttribute("beginnerWorkouts", availableWorkouts.stream()
            .filter(w -> w.getFitnessLevel() == Workout.FitnessLevel.BEGINNER)
            .toList());

        model.addAttribute("intermediateWorkouts", availableWorkouts.stream()
            .filter(w -> w.getFitnessLevel() == Workout.FitnessLevel.INTERMEDIATE)
            .toList());

        model.addAttribute("advancedWorkouts", availableWorkouts.stream()
            .filter(w -> w.getFitnessLevel() == Workout.FitnessLevel.ADVANCED)
            .toList());

        model.addAttribute("workouts", availableWorkouts);
        model.addAttribute("providers", allProviders);    

        return "customer/explore";
    }

    @GetMapping("/explore/{id}")
    public String workoutDetails(@PathVariable Long id, Model model, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        }

        Workout workout = workoutService.getWorkoutById(id);
        if(workout == null){
            return "redirect:/customers/explore";
        }
        List<Review> allReviews = reviewService.getReviewsByWorkout(workout);
        Customer customer = customerService.getCustomerById(customerId);
        boolean subscribed = customer.getSubscriptions().stream()
            .anyMatch(sub -> sub.isActive() && sub.getWorkout().getId().equals(id));
        double averageRating = reviewService.getAverageRating(workout);
        String latestCustomerName = "Anonymous";    
        model.addAttribute("workout", workout);
        model.addAttribute("reviews", allReviews);
        model.addAttribute("subscribed", subscribed);
        model.addAttribute("averageRating", averageRating);

        
        if (!allReviews.isEmpty() && allReviews.get(0).getCustomer() != null && allReviews.get(0).getCustomer().getName() != null) {
            latestCustomerName = allReviews.get(0).getCustomer().getName();
            }
        model.addAttribute("latestCustomerName", latestCustomerName);
        
        return "customer/workout-details";
    }

    @PostMapping("/explore/{id}/subscribe")
    public String subscribe(@PathVariable Long id, @RequestParam SubscriptionType subscriptionType, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if (customerId == null) {
            return "redirect:/signin";
        }

        Customer customer = customerService.getCustomerById(customerId);
        Workout workout = workoutService.getWorkoutById(id);

        Subscription subscription = new Subscription();
        subscription.setCustomer(customer);
        subscription.setWorkout(workout);
        subscription.setType(subscriptionType);
        subscription.setStartDate(LocalDateTime.now());
        subscription.setActive(true);
        subscriptionService.createSubscription(subscription);

        return "redirect:/customers/explore/" + id;
    }

    @GetMapping("/explore/{workoutId}/review")
    public String reviewForm(@PathVariable Long workoutId, Model model, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        }

        Customer customer = customerService.getCustomerById(customerId);
        Workout workout = workoutService.getWorkoutById(workoutId);
        List<Review> allReviews = reviewService.getReviewsByWorkout(workout);

        boolean hasSubscription = customer.getSubscriptions().stream()
                .anyMatch(sub -> sub.getWorkout().getId().equals(workoutId));

        if (!hasSubscription) {
            return "redirect:/customers/dashboard";
        }

        List<Review> sortedByLatestReviews = allReviews.stream()
        .sorted((r1, r2) -> r2.getCreatedAt().compareTo(r1.getCreatedAt()))
        .collect(Collectors.toList());

        sortedByLatestReviews.forEach(r -> {
        if (r.getCustomer() != null) {
            r.getCustomer().getName(); // just access it
        }
        });
        
        Review review = new Review();
        review.setCustomer(customer);
        review.setWorkout(workout);
        model.addAttribute("review", review);
        model.addAttribute("workout", workout);
        model.addAttribute("sortedByLatestReviews", sortedByLatestReviews);
        
        return "customer/review-form";
    }

    @PostMapping("/explore/{workoutId}/review")
    public String submitReview(@PathVariable Long workoutId,
                                @ModelAttribute Review review,
                                @RequestParam Double rating,
                                @RequestParam(required = false) String comment,
                                HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        } 
        
        Customer customer = customerService.getCustomerById(customerId);
        Workout workout = workoutService.getWorkoutById(workoutId);

        review.setCustomer(customer);
        review.setWorkout(workout);
        review.setRating(rating);
        review.setComment(comment);
        review.setCreatedAt(LocalDateTime.now());

        reviewService.createReview(review);

        return "redirect:/customers/explore/" + workoutId;
    }

    @GetMapping("/explore/trainer/{id}")
    public String viewProfile(@PathVariable Long id, Model model, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        }

        Provider provider = providerService.getProviderById(id);
        if(provider == null){
            return "redirect:/customers/explore";
        }
        List<Workout> workoutsByProvider = workoutService.getWorkoutsByProvider(provider);
        List<Review> reviewsByProvider = reviewService.getReviewsByProvider(provider);

        Map<String, Double> workoutAverageRatings = new HashMap<>();
        Map<String, List<Review>> workoutReviews = new HashMap<>();
        for (Workout w : workoutsByProvider) {
            workoutAverageRatings.put(w.getId().toString(), reviewService.getAverageRating(w));
            workoutReviews.put(w.getId().toString(), reviewService.getReviewsByWorkout(w));
        }
        
        model.addAttribute("provider", provider);
        model.addAttribute("workouts", workoutsByProvider);
        model.addAttribute("reviews", reviewsByProvider);
        model.addAttribute("workoutAverageRatings", workoutAverageRatings);
        model.addAttribute("workoutReviews", workoutReviews);

        return "customer/view-profile";
    }  
    
    @PostMapping("/dashboard/unsubscribe/{id}")
    public String unsubscribe(@PathVariable Long id, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if (customerId == null) {
            return "redirect:/signin";
        }

        Customer customer = customerService.getCustomerById(customerId);
        List<Subscription> activeSubscriptions = subscriptionService.getActiveSubscriptionsByCustomer(customer);

        Subscription subscriptionToCancel = activeSubscriptions.stream()
            .filter(s -> s.getId().equals(id))
            .findFirst()
            .orElse(null);

        if (subscriptionToCancel != null) {
        subscriptionToCancel.setActive(false);
        subscriptionToCancel.setEndDate(LocalDateTime.now());
        subscriptionService.updateSubscription(subscriptionToCancel.getId(), subscriptionToCancel);
    }
        return "redirect:/customers/dashboard";
    }
}