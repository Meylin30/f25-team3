package com.csc340.spartanfitness.workoutplans;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import com.csc340.spartanfitness.provider.Provider;

@Service
@RequiredArgsConstructor
@Transactional
public class WorkoutService {

    private final WorkoutRepository workoutRepository;

    public Workout createWorkout(Provider provider, Workout workout) {
        workout.setProvider(provider);
        return workoutRepository.save(workout);
    }

    public Workout updateWorkout(Long id, Workout details) {
        Workout workout = workoutRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Workout not found"));

        workout.setTitle(details.getTitle());
        workout.setDescription(details.getDescription());
        workout.setActive(details.isActive());
        workout.setFitnessLevel(details.getFitnessLevel());

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

    public int countByProvider(Long providerId) {
        return workoutRepository.countByProvider(providerId);
    }

    public String getTopLevel(Long providerId) {
    List<Workout.FitnessLevel> levels = workoutRepository.findTopLevels(providerId);
    return levels.isEmpty() ? "None" : levels.get(0).name();  
}


    public Map<String, Long> getLevelCounts(Long providerId) {
        Map<String, Long> result = new HashMap<>();
        List<Object[]> rows = workoutRepository.countLevelDistribution(providerId);
            if (rows == null || rows.isEmpty()) {
            return result;
        }
            for (Object[] row : rows) {
                if (row[0] == null || row[1] == null) {
                continue; 
            }
                Workout.FitnessLevel level = (Workout.FitnessLevel) row[0];
            Long count = (Long) row[1];

            result.put(level.name(), count);
        }

        return result;
    }
}




