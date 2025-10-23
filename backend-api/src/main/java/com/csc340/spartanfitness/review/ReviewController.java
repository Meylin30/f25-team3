package com.csc340.spartanfitness.review;


import com.csc340.spartanfitness.customer.CustomerService;
import com.csc340.spartanfitness.trainer.TrainerService;
import com.csc340.spartanfitness.workout.Workout;
import com.csc340.spartanfitness.workout.WorkoutService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
public class ReviewController {
    private final ReviewService reviewService;
    private final TrainerService trainerService;
    private final CustomerService customerService;
    private final WorkoutService workoutService;

    @PostMapping
    public ResponseEntity<Review> createReview(@Valid @RequestBody Review review) {
        return ResponseEntity.ok(reviewService.createReview(review));
    }

    @PostMapping("/{id}/trainer-response")
    public ResponseEntity<Review> addTrainerResponse(@PathVariable Long id, @RequestBody String response) {
        return ResponseEntity.ok(reviewService.addTrainerResponse(id, response));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable Long id) {
        reviewService.deleteReview(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/workout/{workoutId}")
    public ResponseEntity<List<Review>> getWorkoutReviews(@PathVariable Long workoutId) {
        return ResponseEntity.ok(reviewService.getReviewsByWorkout(workoutService.getWorkoutById(workoutId)));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Review>> getCustomerReviews(@PathVariable Long customerId) {
        return ResponseEntity.ok(reviewService.getReviewsByCustomer(customerService.getCustomerById(customerId)));
    }

    @GetMapping("/trainer/{trainerId})")
    public ResponseEntity<List<Review>> getTrainerReviews(@PathVariable Long trainerId) {
        return ResponseEntity.ok(reviewService.getReviewsByTrainer(trainerService.getTrainerById(trainerId)));
    }

    @GetMapping("/workout/{workoutId}/rating")
    public ResponseEntity<Map<String, Double>> getWorkoutRatings(@PathVariable Long workoutId) {
        Workout workout = workoutService.getWorkoutById(workoutId);
        double averageRating = reviewService.getAverageRatingForWorkout(workout);
        Map<String, Double> ratings = new HashMap<>();
        ratings.put("averageRating", reviewService.getAverageRatingForWorkout(workout));
        return ResponseEntity.ok(ratings);
    }
}
