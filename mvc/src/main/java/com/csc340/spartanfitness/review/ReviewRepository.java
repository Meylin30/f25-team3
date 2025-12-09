package com.csc340.spartanfitness.review;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.workoutplans.Workout;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByWorkout(Workout workout);
    List<Review> findByCustomer(Customer customer);
    List<Review> findByWorkoutProvider(Provider provider);

    
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.workout.provider.id = :id")
    Optional<Double> findAverageRating(Long id);

   
    @Query("SELECT COUNT(r) FROM Review r WHERE r.workout.provider.id = :id")
    int countByProvider(Long id);

    
    @Query("""
        SELECT r.rating, COUNT(r)
        FROM Review r
        WHERE r.workout.provider.id = :id
        GROUP BY r.rating
    """)
    List<Object[]> countRatingsGrouped(Long id);

    @Query("""
       SELECT r.rating, COUNT(r)
       FROM Review r
       JOIN r.workout w
       WHERE w.provider.id = :providerId
       GROUP BY r.rating
       """)
List<Object[]> countRatingBreakdown(Long providerId);

}


