package com.csc340.spartanfitness.workoutplans;

import com.csc340.spartanfitness.provider.Provider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface WorkoutRepository extends JpaRepository<Workout, Long> {

    List<Workout> findByActiveTrue();
      
    List<Workout> findByProviderAndActiveTrue(Provider provider);
}