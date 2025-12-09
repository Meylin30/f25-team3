package com.csc340.spartanfitness.Exercise;

import com.csc340.spartanfitness.workoutplans.Workout;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseRepository extends JpaRepository<Exercise, Long> {
    List<Exercise> findByWorkout(Workout workout);
    
    
}
