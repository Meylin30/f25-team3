package com.csc340.spartanfitness.WorkoutPlans;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


import java.util.ArrayList;
import java.util.List;

import com.csc340.spartanfitness.Provider.Provider;
import com.csc340.spartanfitness.subscription.Subscription;
import com.csc340.spartanfitness.review.Review;

@Data
@NoArgsConstructor
@Entity
@Table(name = "workouts")

public class Workout {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    
    @ManyToOne
    @JoinColumn(name = "provider_id", nullable = false)
    @JsonIgnoreProperties("workoutPlans")
    private Provider provider;

    @NotBlank
    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @NotNull
    @Column(nullable = false)
    private boolean active = true;

    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private FitnessLevel fitnessLevel;

    
   @OneToMany(mappedBy = "workout", cascade = CascadeType.ALL)
    @JsonIgnoreProperties("workout")
    private List<Subscription> subscriptions = new ArrayList<>();

    @OneToMany(mappedBy = "workout", cascade = CascadeType.ALL)
    @JsonIgnoreProperties("workout")
    private List<Review> reviews = new ArrayList<>();

    public enum FitnessLevel {
        BEGINNER,
        INTERMEDIATE,
        ADVANCED
    }
}
    

