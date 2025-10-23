package com.csc340.spartanfitness.WorkoutPlans;

import com.csc340.spartanfitness.Provider.Provider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface workoutRepository extends JpaRepository<Workout, Long> {

    List<Workout> findByActiveTrue();
      
    List<Workout> findByProviderAndActiveTrue(Provider provider);
}