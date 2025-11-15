package com.csc340.spartanfitness.review;

import com.csc340.spartanfitness.customer.CustomerService;
import com.csc340.spartanfitness.provider.ProviderService;
import com.csc340.spartanfitness.workoutplans.Workout;
import com.csc340.spartanfitness.workoutplans.WorkoutService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
public class ReviewController {
    private final ReviewService reviewService;
    private final CustomerService customerService;
    private final ProviderService providerService;
    private final WorkoutService workoutService;

    @PostMapping
    public ResponseEntity<Review> createReview(@Valid @RequestBody Review review) {
        return ResponseEntity.ok(reviewService.createReview(review));
    }

    @PostMapping("/{id}/provider-response")
    public ResponseEntity<Review> addProviderResponse(@PathVariable Long id, @RequestBody String response) {
        return ResponseEntity.ok(reviewService.addProviderResponse(id, response));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable Long Id) {
        reviewService.deleteReview(Id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/workout/{workoutId}")
    public ResponseEntity<List<Review>> getWorkoutReviews(@PathVariable Long workoutId) {
        return ResponseEntity.ok(reviewService.getReviewsByWorkout(workoutService.getWorkoutById(workoutId)));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Review>> getCustomerReviews(@PathVariable Long customerId) {
        return ResponseEntity.ok(reviewService.getReviewsByCustomer(customerService.getCustomerById(customerId)));
    }

    @GetMapping("/provider/{providerId}")
    public ResponseEntity<List<Review>> getProviderReviews(@PathVariable Long providerId) {
        return ResponseEntity.ok(reviewService.getReviewsByProvider(providerService.getProviderById(providerId)));
    }

    @GetMapping("/workout/{workoutId}/average-rating")
    public ResponseEntity<Map<String, Double>> getWorkoutRatings(@PathVariable Long workoutId) {
        Workout workout = workoutService.getWorkoutById(workoutId);
        Map<String, Double> ratings = new HashMap<>();
        ratings.put("overall", reviewService.getAverageRating(workout));
        return ResponseEntity.ok(ratings);
    }
}

