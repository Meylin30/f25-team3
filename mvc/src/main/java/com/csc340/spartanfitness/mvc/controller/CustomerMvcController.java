package com.csc340.spartanfitness.mvc.controller;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.customer.CustomerService;
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
import java.util.List;

@Controller
@RequestMapping("/customers")
public class CustomerMvcController {
    private final CustomerService customerService;
    private final SubscriptionService subscriptionService;
    private final WorkoutService workoutService;
    private final ReviewService reviewService;

    public CustomerMvcController(CustomerService customerService,
                                 SubscriptionService subscriptionService,
                                 WorkoutService workoutService,
                                 ReviewService reviewService) {
        this.customerService = customerService;
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

        Customer customer = customerService.getCustomerById(customerId);
        
        try {
            customerService.authenticate(customer.getEmail(), currentPassword);

            Customer updatedCustomer = new Customer();
            updatedCustomer.setName(name);
            updatedCustomer.setEmail(email);
            updatedCustomer.setWeight(weight != null && !weight.trim().isEmpty()
                 ? new BigDecimal(weight).setScale(2, RoundingMode.HALF_UP) : customer.getWeight());
            updatedCustomer.setHeight(height != null && !height.trim().isEmpty()
                 ? height : customer.getHeight());     
            updatedCustomer.setPassword(newPassword != null && !newPassword.trim().isEmpty()
                 ? newPassword : customer.getPassword());
            updatedCustomer.setDob(dob != null
                 ? LocalDate.parse(dob, DateTimeFormatter.ISO_DATE) : customer.getDob()
);

            customerService.updateCustomer(customerId, updatedCustomer);
            return "redirect:/customers/dashboard";
        } catch (Exception e) {
            Customer originalCustomer = customerService.getCustomerById(customerId);
            model.addAttribute("customer", originalCustomer);
            model.addAttribute("error", "Current password is incorrect.");
            return "redirect:/edit-profile";
        }
    }
/* 
    @GetMapping("/explore")
    public String browseWorkouts(Model model) {
        List<Workout> availableWorkouts + workoutService.getAvailableWorkouts();
        model.addAttribute("workouts", availableWorkouts);
        return "customer/explore";
    }
*/
    @GetMapping("/explore/{id}")
    public String workoutDetails(@PathVariable Long id, Model model, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        }

        Workout workout = workoutService.getWorkoutById(id);
        model.addAttribute("workout", workout);
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

        return "redirect:/customers/dashboard";
    }

    @GetMapping("/explore/{workoutId}/review")
    public String reviewForm(@PathVariable Long workoutId, Model model, HttpSession session) {
        Long customerId = (Long) session.getAttribute("customerId");
        if(customerId == null) {
            return "redirect:/signin";
        }

        Customer customer = customerService.getCustomerById(customerId);
        Workout workout = workoutService.getWorkoutById(workoutId);

        boolean hasSubscription = customer.getSubscriptions().stream()
                .anyMatch(sub -> sub.getWorkout().getId().equals(workoutId));

        if (!hasSubscription) {
            return "redirect:/customers/dashboard";
        }
        
        Review review = new Review();
        review.setCustomer(customer);
        review.setWorkout(workout);
        model.addAttribute("review", review);
        model.addAttribute("workout", workout);
        
        return "customer/review-form";
    }

    @PostMapping("/explore/{workoutid}/review")
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

        return "redirect:/customers/dashboard";
    }
}