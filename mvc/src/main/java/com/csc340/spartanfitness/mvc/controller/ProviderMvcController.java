package com.csc340.spartanfitness.mvc.controller;

import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.provider.ProviderService;
import com.csc340.spartanfitness.review.ReviewService;
import com.csc340.spartanfitness.workoutplans.Workout;
import com.csc340.spartanfitness.workoutplans.Workout.FitnessLevel;
import com.csc340.spartanfitness.workoutplans.WorkoutService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/providers")
@RequiredArgsConstructor
public class ProviderMvcController {

    private final ProviderService providerService;
    private final WorkoutService workoutService;
    private final ReviewService reviewService;


    @GetMapping("/{id}/dashboard")
    public String dashboard(@PathVariable Long id, Model model) {
        Provider provider = providerService.getProviderById(id);
        if (provider == null) return "redirect:/signin";

        model.addAttribute("provider", provider);
        model.addAttribute("workouts", workoutService.getWorkoutsByProvider(provider));
        model.addAttribute("reviews", reviewService.getReviewsForProvider(provider));
        return "provider/dashboard";
    }


    @GetMapping("/{providerId}/workouts")
    public String providerWorkouts(@PathVariable Long providerId, Model model) {
        Provider provider = providerService.getProviderById(providerId);
        if (provider == null) return "redirect:/signin";

        model.addAttribute("provider", provider);
        model.addAttribute("workouts", workoutService.getWorkoutsByProvider(provider));
        return "provider/workout-list";
    }


    @GetMapping("/workouts/create")
    public String createWorkoutForm(HttpSession session, Model model) {
        Long providerId = (Long) session.getAttribute("providerId");
        if (providerId == null) return "redirect:/signin";

        Provider provider = providerService.getProviderById(providerId);
        model.addAttribute("provider", provider);
        return "provider/create-workout";
    }

    @PostMapping("/workouts/create")
    public String createWorkout(HttpSession session,
                                @RequestParam String title,
                                @RequestParam(required = false) String description,
                                @RequestParam FitnessLevel fitnessLevel,
                                @RequestParam(defaultValue = "false") boolean active) {

        Long providerId = (Long) session.getAttribute("providerId");
        if (providerId == null) return "redirect:/signin";

        Provider provider = providerService.getProviderById(providerId);

        Workout workout = new Workout();
        workout.setProvider(provider);
        workout.setTitle(title);
        workout.setDescription(description);
        workout.setActive(active);
        workout.setFitnessLevel(fitnessLevel);

        workoutService.createWorkout(provider, workout);
        return "redirect:/providers/" + providerId + "/dashboard";
    }


    @GetMapping("/{providerId}/workouts/{workoutId}/edit")
    public String editWorkoutForm(@PathVariable Long providerId,
                                  @PathVariable Long workoutId,
                                  Model model) {

        Provider provider = providerService.getProviderById(providerId);
        Workout workout = workoutService.getWorkoutById(workoutId);

        model.addAttribute("provider", provider);
        model.addAttribute("workout", workout);
        return "provider/edit-workout";
    }

    @PostMapping("/{providerId}/workouts/{workoutId}/edit")
    public String editWorkout(@PathVariable Long providerId,
                              @PathVariable Long workoutId,
                              @RequestParam String title,
                              @RequestParam(required = false) String description,
                              @RequestParam FitnessLevel fitnessLevel,
                              @RequestParam(defaultValue = "false") boolean active) {

        Workout workout = workoutService.getWorkoutById(workoutId);
        workout.setTitle(title);
        workout.setDescription(description);
        workout.setFitnessLevel(fitnessLevel);
        workout.setActive(active);

        workoutService.updateWorkout(workoutId, workout);
        return "redirect:/providers/" + providerId + "/dashboard";
    }


    @PostMapping("/{providerId}/workouts/{workoutId}/delete")
    public String deleteWorkout(@PathVariable Long providerId,
                                @PathVariable Long workoutId) {

        workoutService.deleteWorkout(workoutId);
        return "redirect:/providers/" + providerId + "/dashboard";
    }


    @GetMapping("/{id}/edit-profile")
    public String editProfileForm(@PathVariable Long id, Model model) {
        Provider provider = providerService.getProviderById(id);
        model.addAttribute("provider", provider);
        return "provider/edit-profile";
    }

    @PostMapping("/{id}/edit-profile")
    public String editProfile(@PathVariable Long id,
                              @Valid @ModelAttribute("provider") Provider providerDetails,
                              BindingResult result) {

        if (result.hasErrors()) return "provider/edit-profile";

        providerService.updateProvider(id, providerDetails);
        return "redirect:/providers/" + id + "/dashboard";
    }


    @GetMapping("/{id}/edit")
    public String editProfileView(@PathVariable Long id, Model model) {
        Provider provider = providerService.getProviderById(id);
        model.addAttribute("provider", provider);
        return "provider/edit-profile";
    }

    @PostMapping("/{id}/edit")
    public String updateProfile(@PathVariable Long id, @ModelAttribute Provider provider) {
        providerService.updateProvider(id, provider);
        return "redirect:/providers/" + id + "/dashboard";
    }


    @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("provider", new Provider());
        return "provider/signup";
    }

    @PostMapping("/signup")
    public String signup(@ModelAttribute Provider provider) {
        providerService.createProvider(provider);
        return "redirect:/signin";
    }


    @PostMapping("/signin")
    public String signin(@RequestParam String email,
                         @RequestParam String password,
                         HttpSession session) {

        try {
            Provider provider = providerService.authenticate(email, password);
            session.setAttribute("providerId", provider.getId());
            return "redirect:/providers/" + provider.getId() + "/dashboard";
        } catch (Exception e) {
            return "redirect:/signin?error";
        }
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("providerId");
        return "redirect:/";
    }


    @PostMapping("/{providerId}/reviews/{reviewId}/reply")
    public String replyToReview(@PathVariable Long providerId,
                                @PathVariable Long reviewId,
                                @RequestParam String providerResponse) {

        reviewService.addProviderResponse(reviewId, providerResponse);
        return "redirect:/providers/" + providerId + "/reviews";
    }

    @GetMapping("/{providerId}/reviews")
    public String viewProviderReviews(@PathVariable Long providerId, Model model) {
        Provider provider = providerService.getProviderById(providerId);
        model.addAttribute("provider", provider);
        model.addAttribute("reviews", reviewService.getReviewsForProvider(provider));
        return "provider/reviews";
    }

}
