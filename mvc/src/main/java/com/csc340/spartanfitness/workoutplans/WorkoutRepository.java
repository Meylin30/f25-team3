package com.csc340.spartanfitness.workoutplans;

import com.csc340.spartanfitness.provider.Provider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WorkoutRepository extends JpaRepository<Workout, Long> {

    List<Workout> findByActiveTrue();

    List<Workout> findByProviderAndActiveTrue(Provider provider);

    @Query("SELECT COUNT(w) FROM Workout w WHERE w.provider.id = :id")
    int countByProvider(Long id);


    @Query("""
            SELECT w.fitnessLevel, COUNT(w)
            FROM Workout w
            WHERE w.provider.id = :id
            GROUP BY w.fitnessLevel
            """)
    List<Object[]> countLevelDistribution(Long id);


    @Query("""
        SELECT w.fitnessLevel
        FROM Workout w
        WHERE w.provider.id = :id
        GROUP BY w.fitnessLevel
        ORDER BY COUNT(w) DESC
        """)
List<Workout.FitnessLevel> findTopLevels(Long id);

}
