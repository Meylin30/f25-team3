package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.trainer.Trainer;
import com.csc340.spartanfitness.workout.Workout;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class SubscriptionService {
    private final SubscriptionRepository subscriptionRepository;

    public Subscription createSubscription(Subscription subscription) {
        return subscriptionRepository.save(subscription);
    }

    public Subscription updateSubscription(Long id, Subscription subscriptionDetails) {
        Subscription subscription = subscriptionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subscription not found with id: " + id));

        subscription.setType(subscriptionDetails.getType());
        subscription.setActive(subscriptionDetails.isActive());
        subscription.setStartDate(subscriptionDetails.getStartDate());
        subscription.setEndDate(subscriptionDetails.getEndDate());
        
        return subscriptionRepository.save(subscription);
    }

    public void cancelSubscription(Long id) {
        Subscription subscription = subscriptionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subscription not found with id: " + id));
        subscription.setActive(false);
        subscriptionRepository.save(subscription);
    }

    public List<Subscription> getActiveSubscriptionsByCustomer(Customer customer) {
        return subscriptionRepository.findByCustomerAndActive(customer);
    }

    public List<Subscription> getSubscriptionsByWorkout(Workout workout) {
        return subscriptionRepository.findByWorkout(workout);
    }

    public List<Subscription> getSubscriptionsByTrainer(Trainer trainer) {
        return subscriptionRepository.findByWorkoutTrainer(trainer);
    }
}
