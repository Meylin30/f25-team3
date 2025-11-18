package com.csc340.spartanfitness.mvc.controller;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.provider.ProviderService;
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

    
   // Dashboard 
    @GetMapping("/{id}/dashboard")
    public String dashboard(@PathVariable Long id, Model model) {
        Provider provider = providerService.getProviderById(id);
        model.addAttribute("provider", provider);
        model.addAttribute("workouts", workoutService.getWorkoutsByProvider(provider));
        return "provider/dashboard";  
    }

    // Create Workout 
    @GetMapping("/workouts/create")
    public String createWorkoutForm(HttpSession session, Model model) {
        Long providerId = (Long) session.getAttribute("providerId");
        if (providerId == null) {
            return "redirect:/signin"; 
        }
        Provider provider = providerService.getProviderById(providerId);
        model.addAttribute("provider", provider);
        return "provider/create-workout";  
    }

    @PostMapping("/workouts/create")
public String createWorkout(
        HttpSession session,
        @RequestParam String title,
        @RequestParam(required = false) String description,
        @RequestParam FitnessLevel fitnessLevel,
        @RequestParam(defaultValue = "false") boolean active) {

    Long providerId = (Long) session.getAttribute("providerId"); 
    if(providerId == null) {
        return "redirect:/signin"; 
    } 
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

//  Edit Workout 
    @GetMapping("/workouts/{workoutId}/edit")
    public String editWorkoutForm(@PathVariable Long providerId,
                                  @PathVariable Long workoutId,
                                  Model model) {
        Provider provider = providerService.getProviderById(providerId);
        Workout workout = workoutService.getWorkoutById(workoutId);
        model.addAttribute("provider", provider);
        model.addAttribute("workout", workout);
        return "provider/edit-workout";  
    }

    @PostMapping("/workouts/${workout.id}/edit")
    public String editWorkout(@PathVariable Long providerId,
                              @PathVariable Long workoutId,
                              @Valid @ModelAttribute("workout") Workout workoutDetails,
                              BindingResult result, Model model) {
        Provider provider = providerService.getProviderById(providerId);
        if (result.hasErrors()) {
            model.addAttribute("provider", provider);
            return "provider/edit-workout";
        }
        Workout workout = workoutService.getWorkoutById(workoutId);
        workout.setTitle(workoutDetails.getTitle());
        workout.setDescription(workoutDetails.getDescription());
        workout.setActive(workoutDetails.isActive());
        workout.setFitnessLevel(workoutDetails.getFitnessLevel());
        workoutService.updateWorkout(workoutId, workout);
        return "redirect:/providers/" + providerId + "/dashboard";
    }



    //  Edit Profile 
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
        if (result.hasErrors()) {
            return "provider/edit-profile";
        }
        providerService.updateProvider(id, providerDetails);
        return "redirect:/providers/" + id + "/dashboard";
    }


    // Edit profile form
    @GetMapping("/{id}/edit")
    public String editProfileView(@PathVariable Long id, Model model) {
        Provider provider = providerService.getProviderById(id);
        model.addAttribute("provider", provider);
        return "provider/edit-profile";
    }

    // Update profile
    @PostMapping("/{id}/edit")
    public String updateProfile(@PathVariable Long id, @ModelAttribute Provider provider) {
        providerService.updateProvider(id, provider);
        return "redirect:/providers/" + id + "/dashboard";
    }

      @GetMapping("/signup")
    public String signupForm(Model model) {
        model.addAttribute("provider", new Provider());
        return "provider/signin";
    }

    @PostMapping("/signup")
    public String signup(@ModelAttribute Provider provider) {
        providerService.createProvider(provider);
        return "redirect:/signin";
    }
      @PostMapping("/signin")
    public String signin(@RequestParam String email, @RequestParam String password, HttpSession session) {
        try {
            Provider provider = providerService.authenticate(email, password);
            session.setAttribute("providerId", provider.getId());
            return "redirect:/providers/dashboard";
        } catch (Exception e) {
            return "redirect:/signin?error";
        }
    }
}