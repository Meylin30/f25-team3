package com.csc340.spartanfitness.subscription;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.provider.Provider;
import com.csc340.spartanfitness.workoutplans.Workout;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {

    
List<Subscription> findByCustomerAndActive(Customer customer, boolean active);


    List<Subscription> findByWorkout(Workout workout);
    

    @Query("""
           SELECT s
           FROM Subscription s
           WHERE s.workout.provider = :provider
           """)
    List<Subscription> findSubscriptionsByProvider(Provider provider);


    @Query("""
            SELECT COUNT(s)
            FROM Subscription s
            WHERE s.workout.provider.id = :id
              AND s.active = true
            """)
    int countActiveSubscribers(Long id);


    @Query("""
            SELECT s.workout.title, COUNT(s)
            FROM Subscription s
            WHERE s.workout.provider.id = :id
            GROUP BY s.workout.title
            ORDER BY COUNT(s) DESC
            """)
    List<Object[]> countSubscribersByWorkout(Long id);

   
    @Query("""
            SELECT s.workout.title
            FROM Subscription s
            WHERE s.workout.provider.id = :id
            GROUP BY s.workout.title
            ORDER BY COUNT(s) DESC
            """)
    List<String> findWorkoutOrderBySubscriberCount(Long id);
}

