package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.workoutplans.Workout;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
                .orElseThrow(() -> new EntityNotFoundException("Subscription not found"));

        subscription.setType(subscriptionDetails.getType());
        subscription.setActive(subscriptionDetails.isActive());
        subscription.setStartDate(subscriptionDetails.getStartDate());
        subscription.setEndDate(subscriptionDetails.getEndDate());

        return subscriptionRepository.save(subscription);
    }

    public void cancelSubscription(Long id) {
        Subscription subscription = subscriptionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subscription not found"));
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
        return subscriptionRepository.findSubscriptionsByProvider(provider);
    }

    public Subscription recordWorkoutSession(Long id, LocalDateTime sessionDate) {
        Subscription subscription = subscriptionRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Subscription not found"));
        subscription.setLastSessionDate(sessionDate);
        return subscriptionRepository.save(subscription);
    }



    public int getActiveSubscriberCount(Long providerId) {
        return subscriptionRepository.countActiveSubscribers(providerId);
    }

    public Map<String, Long> getSubscribersByWorkout(Long providerId) {
        Map<String, Long> result = new HashMap<>();

        List<Object[]> rows = subscriptionRepository.countSubscribersByWorkout(providerId);

        for (Object[] row : rows) {
            String workoutTitle = (String) row[0];
            Long count = (Long) row[1];
            result.put(workoutTitle, count);
        }

        return result;
    }

    public String getMostSubscribedWorkout(Long providerId) {
    List<String> list = subscriptionRepository.findWorkoutOrderBySubscriberCount(providerId);
    return list.isEmpty() ? "None" : list.get(0);
}

}
