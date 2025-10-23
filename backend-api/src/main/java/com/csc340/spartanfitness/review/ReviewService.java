package com.csc340.spartanfitness.review;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.Provider.Provider;
import com.csc340.spartanfitness.WorkoutPlans.Workout;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.OptionalDouble;

@Service
@RequiredArgsConstructor
@Transactional
public class ReviewService {
    private final ReviewRepository reviewRepository;

    public double getAverageRating(Workout workout) {
        List<Review> reviews = reviewRepository.findByWorkout(workout);
        OptionalDouble average = reviews.stream()
                .mapToDouble(review -> review.getRating() != null ? review.getRating() : 0.0)
                .average();
        return average.orElse(0.0);
    }

    public Review createReview(Review review) {
        review.setCreatedAt(LocalDateTime.now());
        return reviewRepository.save(review);
    }

    public Review addTrainerResponse(Long id, String response) {
        Review review = reviewRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Review not found with id: " + id));

        review.setTrainerResponse(response); 
        review.setTrainerResponseDate(LocalDateTime.now());
        return reviewRepository.save(review);       
    }

    public void deleteReview(Long id) {
        if (!reviewRepository.existsById(id)) {
            throw new EntityNotFoundException("Review not found with id: " + id);
        }
        reviewRepository.deleteById(id);
    }

    public List<Review> getReviewsByWorkout(Workout workout) {
        return reviewRepository.findByWorkout(workout);
    }

    public List<Review> getReviewsByCustomer(Customer customer) {
        return reviewRepository.findByCustomer(customer);
    }
    public List<Review> getReviewsByTrainer(Provider trainer) {
        return reviewRepository.findByWorkoutTrainer(trainer);
    }
}
