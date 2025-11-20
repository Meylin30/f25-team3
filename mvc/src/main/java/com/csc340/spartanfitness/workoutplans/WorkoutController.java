package com.csc340.spartanfitness.workoutplans;

import com.csc340.spartanfitness.provider.ProviderService;
import com.csc340.spartanfitness.provider.Provider;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/boxes")
@RequiredArgsConstructor
public class WorkoutController {
    private final WorkoutService workoutService;
    private final ProviderService providerService;

    @PostMapping
    public ResponseEntity<Workout> createWorkout(@Valid @RequestBody Provider provider, @Valid @RequestBody Workout workout) {
        return ResponseEntity.ok(workoutService.createWorkout(provider, workout));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Workout> updateWorkout(@PathVariable Long id, @Valid @RequestBody Workout workoutDetails) {
        return ResponseEntity.ok(workoutService.updateWorkout(id, workoutDetails));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteWorkout(@PathVariable Long id) {
        workoutService.deleteWorkout(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Workout> getWorkout(@PathVariable Long id) {
        return ResponseEntity.ok(workoutService.getWorkoutById(id));
    }

    @GetMapping
    public ResponseEntity<List <Workout>> getActiveWorkouts() {
        return ResponseEntity.ok(workoutService.getActiveWorkouts());
    }
    
    @GetMapping("/provider/{providerId}")
    public ResponseEntity<List <Workout>> getWorkoutByProvider(@PathVariable Long providerId) {
        return ResponseEntity.ok(workoutService.getWorkoutsByProvider(providerService.getProviderById(providerId)));
    }
}    
