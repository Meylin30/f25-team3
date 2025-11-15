package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.workoutplans.Workout;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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
        return subscriptionRepository.findByCustomerAndActive(customer, true);
    }

    public List<Subscription> getSubscriptionsByWorkout(Workout workout) {
        return subscriptionRepository.findByWorkout(workout);
    }

    public List<Subscription> getSubscriptionsByProvider(Provider provider) {
        return subscriptionRepository.findByWorkoutProvider(provider);
    }

    public Subscription recordWorkoutSession(Long id, LocalDateTime sessionDate) {
        Subscription subscription = subscriptionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subscription not found with id: " + id));

        subscription.setLastSessionDate(sessionDate);
        return subscriptionRepository.save(subscription);
    }
}
