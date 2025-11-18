package com.csc340.spartanfitness.workoutplans;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import com.csc340.spartanfitness.provider.Provider;

@Service
@RequiredArgsConstructor
@Transactional

public class WorkoutService {
   private final WorkoutRepository workoutRepository;

    // Create a new workout for a specific provider
    public Workout createWorkout(Provider provider, Workout workout) {
        workout.setProvider(provider);  
        return workoutRepository.save(workout);
    }

    public Workout updateWorkout(Long id, Workout workoutDetails) {
        Workout workout = workoutRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Workout not found"));

        workout.setTitle(workoutDetails.getTitle());
        workout.setDescription(workoutDetails.getDescription());
        workout.setActive(workoutDetails.isActive());
        workout.setFitnessLevel(workoutDetails.getFitnessLevel());

        return workoutRepository.save(workout);
    }

    public void deleteWorkout(Long id) {
        if (!workoutRepository.existsById(id)) {
            throw new EntityNotFoundException("Workout not found");
        }
        workoutRepository.deleteById(id);
    }

    public Workout getWorkoutById(Long id) {
        return workoutRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Workout not found"));
    }

    public List<Workout> getAllWorkouts() {
        return workoutRepository.findAll();
    }

    public List<Workout> getActiveWorkouts() {
        return workoutRepository.findByActiveTrue();
    }

    public List<Workout> getWorkoutsByProvider(Provider provider) {
        return workoutRepository.findByProviderAndActiveTrue(provider);
    }

}