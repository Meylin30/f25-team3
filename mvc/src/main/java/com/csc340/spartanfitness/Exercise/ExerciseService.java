package com.csc340.spartanfitness.Exercise;

import com.csc340.spartanfitness.workoutplans.Workout;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ExerciseService {

    private final ExerciseRepository exerciseRepository;

    public Exercise addExerciseToWorkout(Workout workout, Exercise exercise) {
        exercise.setWorkout(workout);
        return exerciseRepository.save(exercise);
    }

    public List<Exercise> getExercisesByWorkout(Workout workout) {
        return exerciseRepository.findByWorkout(workout);
    }

    public Exercise getExerciseById(Long id) {
        return exerciseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Exercise not found"));
    }

    public void updateExercise(Long id, Exercise newInfo) {
        Exercise ex = exerciseRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Exercise not found"));

        ex.setName(newInfo.getName());
        ex.setDescription(newInfo.getDescription());
        ex.setSets(newInfo.getSets());
        ex.setReps(newInfo.getReps());
        ex.setVideoUrl(newInfo.getVideoUrl());

        exerciseRepository.save(ex);
    }

    public void deleteExercise(Long id) {
        exerciseRepository.deleteById(id);
    }
}