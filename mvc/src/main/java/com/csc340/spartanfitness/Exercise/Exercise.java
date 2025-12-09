package com.csc340.spartanfitness.Exercise;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.csc340.spartanfitness.workoutplans.Workout;

@Data
@NoArgsConstructor
@Entity
@Table(name = "exercises")

public class Exercise {

      @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;          
    private String description;  
    private int sets;             
    private int reps;            
    private String videoUrl;     

    @ManyToOne
    @JoinColumn(name = "workout_id")
    private Workout workout;     
}
    
