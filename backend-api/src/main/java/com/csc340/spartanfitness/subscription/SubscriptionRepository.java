package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.trainer.Trainer;
import com.csc340.spartanfitness.workout.Workout;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    List<Subscription> findByCustomerAndActive(Customer customer);
    List<Subscription> findByWorkout(Workout workout);
    List<Subscription> findByWorkoutTrainer(Trainer trainer);
}