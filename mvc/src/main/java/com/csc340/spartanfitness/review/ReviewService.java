package com.csc340.spartanfitness.review;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.workoutplans.Workout;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
public class ReviewService {

    private final ReviewRepository reviewRepository;

    // Average rating for a single workout
    public double getAverageRating(Workout workout) {
        List<Review> reviews = reviewRepository.findByWorkout(workout);

        return reviews.stream()
                .mapToDouble(r -> r.getRating() != null ? r.getRating() : 0.0)
                .average()
                .orElse(0.0);
    }

    // Average rating for a provider (AUTO via JPQL)
    public double getAverageRating(Provider provider) {
        return reviewRepository.findAverageRating(provider.getId()).orElse(0.0);
    }

    // Create new review
    public Review createReview(Review review) {
        review.setCreatedAt(LocalDateTime.now());
        return reviewRepository.save(review);
    }

    // Customer response logic
    public Review addProviderResponse(Long id, String response) {
        Review review = reviewRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Review not found"));

        review.setProviderResponse(response);
        review.setProviderResponseDate(LocalDateTime.now());
        return reviewRepository.save(review);
    }

    // Delete review
    public void deleteReview(Long id) {
        if (!reviewRepository.existsById(id)) {
            throw new EntityNotFoundException("Review not found");
        }
        reviewRepository.deleteById(id);
    }

    
    public List<Review> getReviewsByWorkout(Workout workout) {
        return reviewRepository.findByWorkout(workout);
    }

    public List<Review> getReviewsByCustomer(Customer customer) {
        return reviewRepository.findByCustomer(customer);
    }

    public List<Review> getReviewsByProvider(Provider provider) {
        return reviewRepository.findByWorkoutProvider(provider);
    }

  
    public double getAverageRating(Long providerId) {
        return reviewRepository.findAverageRating(providerId).orElse(0.0);
    }

    public int countByProvider(Long providerId) {
        return reviewRepository.countByProvider(providerId);
    }

    public Map<Integer, Long> getRatingDistribution(Long providerId) {
        Map<Integer, Long> map = new HashMap<>();

        reviewRepository.countRatingsGrouped(providerId).forEach(row -> {
            Double ratingDouble = (Double) row[0];
            Long count = (Long) row[1];

            Integer rating = ratingDouble.intValue();
            map.put(rating, count);
        });

        return map;
    }

    public Map<String, Long> getRatingBreakdown(Long providerId) {
    Map<String, Long> result = new HashMap<>();

    List<Object[]> rows = reviewRepository.countRatingBreakdown(providerId);

    for (Object[] row : rows) {
        Double rating = (Double) row[0];
        Long count = (Long) row[1];

        result.put(String.valueOf(rating.intValue()), count);
    }

    return result;
}

}

