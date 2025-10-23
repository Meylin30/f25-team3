package com.csc340.spartanfitness.WorkoutPlans;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

import java.util.List;
import org.springframework.web.bind.annotation.*;

import com.csc340.spartanfitness.Provider.Provider;

@RestController
@RequestMapping("/api/workout-plans")
@RequiredArgsConstructor

public class workoutService {
   private final workoutRepository workoutRepository;

    // Create a new workout
    public Workout createWorkout(Workout workout) {
        return workoutRepository.save(workout);
    }

    // Update an existing workout
    public Workout updateWorkout(Long id, Workout workoutDetails) {
        Workout workout = workoutRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Workout not found"));

        workout.setTitle(workoutDetails.getTitle());
        workout.setDescription(workoutDetails.getDescription());
        workout.setActive(workoutDetails.isActive());
        workout.setFitnessLevel(workoutDetails.getFitnessLevel());

        return workoutRepository.save(workout);
    }

    //  Delete a workout by ID
    public void deleteWorkout(Long id) {
        if (!workoutRepository.existsById(id)) {
            throw new EntityNotFoundException("Workout not found");
        }
        workoutRepository.deleteById(id);
    }

    // Get a workout by ID
    public Workout getWorkoutById(Long id) {
        return workoutRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Workout not found"));
    }

    // Get all workouts
    public List<Workout> getAllWorkouts() {
        return workoutRepository.findAll();
    }

    // Get all active workouts
    public List<Workout> getActiveWorkouts() {
        return workoutRepository.findByActiveTrue();
    }

    // Get all active workouts for a specific provider
    public List<Workout> getWorkoutsByProvider(Provider provider) {
        return workoutRepository.findByProviderAndActiveTrue(provider);
    }
}