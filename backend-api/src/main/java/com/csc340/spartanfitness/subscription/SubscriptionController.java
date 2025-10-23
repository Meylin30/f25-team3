package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.CustomerService;
import com.csc340.spartanfitness.trainer.TrainerService;
import com.csc340.spartanfitness.workout.WorkoutService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.hibernate.boot.registry.classloading.spi.ClassLoaderService.Work;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/subscriptions")
@RequiredArgsConstructor
public class SubscriptionController {
    private final SubscriptionService subscriptionService;
    private final WorkoutService workoutService;
    private final CustomerService customerService;
    private final TrainerService trainerService;

    @PostMapping
    public ResponseEntity<Subscription> createSubscription(@Valid @RequestBody Subscription subscription) {
        return ResponseEntity.ok(subscriptionService.createSubscription(subscription));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Subscription> updateSubscription(@PathVariable Long id, @Valid @RequestBody Subscription subscriptionDetails) {
        return ResponseEntity.ok(subscriptionService.updateSubscription(id, subscriptionDetails));
    }

    @PostMapping("/{id}/cancel")
    public ResponseEntity<Subscription> cancelSubscription(@PathVariable Long id) {
        subscriptionService.cancelSubscription(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Subscription>> getCustomerSubscriptions(@PathVariable Long customerId) {
        return ResponseEntity.ok(subscriptionService.getActiveSubscriptionsByCustomer(customerService.getCustomerById(customerId)));
    }

    @GetMapping("/workout/{workoutId}")
    public ResponseEntity<List<Subscription>> getWorkoutSubscriptions(@PathVariable Long workoutId) {
        return ResponseEntity.ok(subscriptionService.getSubscriptionsByWorkout(workoutService.getWorkoutById(workoutId)));
    }

    @GetMapping("/trainer/{trainerId}")
    public ResponseEntity<List<Subscription>> getTrainerSubscriptions(@PathVariable Long trainerId) {
        return ResponseEntity.ok(subscriptionService.getSubscriptionsByTrainer(trainerService.getTrainerById(trainerId)));
    }
}
