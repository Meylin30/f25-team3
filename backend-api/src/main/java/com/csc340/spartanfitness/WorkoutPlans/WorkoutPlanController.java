package com.csc340.spartanfitness.WorkoutPlans;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.csc340.spartanfitness.Provider.ProviderService;


import java.util.List;

@RestController
@RequestMapping("/api/workout-plans")
@RequiredArgsConstructor
public class WorkoutPlanController {
    
    private final workoutService workoutService;
    private final ProviderService providerService;

    
    @PostMapping
    public ResponseEntity<Workout> createWorkout(@Valid @RequestBody Workout workout) {
        return ResponseEntity.ok(workoutService.createWorkout(workout));
    }

    // Update an existing workout
    @PutMapping("/{id}")
    public ResponseEntity<Workout> updateWorkout(
            @PathVariable Long id,
            @Valid @RequestBody Workout workoutDetails) {
        return ResponseEntity.ok(workoutService.updateWorkout(id, workoutDetails));
    }

    //  Delete a workout
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteWorkout(@PathVariable Long id) {
        workoutService.deleteWorkout(id);
        return ResponseEntity.noContent().build();
    }

    // ✅ Get a workout by its ID
    @GetMapping("/{id}")
    public ResponseEntity<Workout> getWorkout(@PathVariable Long id) {
        return ResponseEntity.ok(workoutService.getWorkoutById(id));
    }

    //  Get all active workouts
    @GetMapping
    public ResponseEntity<List<Workout>> getActiveWorkouts() {
        return ResponseEntity.ok(workoutService.getActiveWorkouts());
    }

    //  Get all workouts for a specific provider
    @GetMapping("/provider/{providerId}")
    public ResponseEntity<List<Workout>> getWorkoutsByProvider(@PathVariable Long providerId) {
        return ResponseEntity.ok(
                workoutService.getWorkoutsByProvider(providerService.getProviderById(providerId))
        );
    }
}
    
