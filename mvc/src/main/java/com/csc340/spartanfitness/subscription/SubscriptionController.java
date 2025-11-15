package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.CustomerService;
import com.csc340.spartanfitness.provider.ProviderService;
import com.csc340.spartanfitness.workoutplans.WorkoutService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/subscriptions")
@RequiredArgsConstructor
public class SubscriptionController {
    private final SubscriptionService subscriptionService;
    private final CustomerService customerService;
    private final ProviderService providerService;
    private final WorkoutService workoutService;

    @PostMapping
    public ResponseEntity<Subscription> createSubscription(@Valid @RequestBody Subscription subscription) {
        return ResponseEntity.ok(subscriptionService.createSubscription(subscription));
    }

    @PostMapping("/{id}/cancel")
    public ResponseEntity<Subscription> cancelSubscription(@PathVariable Long id) {
        subscriptionService.cancelSubscription(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Subscription> updateSubscription(@PathVariable Long Id, @Valid @RequestBody Subscription subscriptionDetails) {
        return ResponseEntity.ok(subscriptionService.updateSubscription(Id, subscriptionDetails));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Subscription>> getCustomerSubscriptions(@PathVariable Long customerId) {
        return ResponseEntity.ok(subscriptionService.getActiveSubscriptionsByCustomer(customerService.getCustomerById(customerId)));
    }

    @GetMapping("/workout/{workoutId}")
    public ResponseEntity<List<Subscription>> getWorkoutSubscriptions(@PathVariable Long workoutId) {
        return ResponseEntity.ok(subscriptionService.getSubscriptionsByWorkout(workoutService.getWorkoutById(workoutId)));
    }
    @GetMapping("/provider/{providerId}")
    public ResponseEntity<List<Subscription>> getProviderSubscriptions(@PathVariable Long providerId) {
        return ResponseEntity.ok(subscriptionService.getSubscriptionsByProvider(providerService.getProviderById(providerId)));
    }

}