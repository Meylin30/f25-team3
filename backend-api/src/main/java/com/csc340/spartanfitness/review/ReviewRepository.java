package com.csc340.spartanfitness.review;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.Provider.Provider;
import com.csc340.spartanfitness.WorkoutPlans.Workout;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByWorkout(Workout workout);
    List<Review> findByCustomer(Customer customer);
    List<Review> findByWorkoutTrainer(Provider trainer);
    
}
