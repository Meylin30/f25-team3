package com.csc340.spartanfitness.mvc.controller;

import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.provider.ProviderService;
import com.csc340.spartanfitness.workoutplans.Workout;
import com.csc340.spartanfitness.workoutplans.WorkoutService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeMvcController {
    private final ProviderService providerService;
    private final WorkoutService workoutService;

    public HomeMvcController(ProviderService providerService, WorkoutService workoutService) {
        this.providerService = providerService;
        this.workoutService = workoutService;
    }

    @GetMapping("/")
    public String home(Model model) {
        /*List<Provider> Featuredproviders = providerService.stream()
        .limit(3)
        .toList();
        List<Workout> Featuredworkouts = workoutService.stream()
        .limit(3)
        .toList();

        model.addAttribute("providers", Featuredproviders);
        model.addAttribute("workouts", Featuredworkouts);*/
        return "home";
    }

    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }

    @GetMapping("/signin")
    public String signin(HttpSession session) {
        if (session.getAttribute("customerId") != null) {
            return "redirect:/customers/dashboard";
        }

        if (session.getAttribute("providerId") != null) {
            Long id =(Long) session.getAttribute("providerId");
            return "redirect:/providers/" + id + "dashboard";
        }
        
        return "signin";
    }
}
