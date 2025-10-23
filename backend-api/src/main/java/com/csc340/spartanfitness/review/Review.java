package com.csc340.spartanfitness.review;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.WorkoutPlans.Workout;

@Data
@NoArgsConstructor
@Entity
@Table(name = "reviews")
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @JsonIgnoreProperties({"reviews", "subscriptions"})
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "workout_id", nullable = false)
    @JsonIgnoreProperties({"reviews"})
    private Workout workout;

    @NotNull@Min(1)
    @Max(5)
    private Double rating;

    @Column(columnDefinition = "TEXT")
    private String comment;

    @NotNull
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(columnDefinition = "TEXT")
    private String trainerResponse;

    private LocalDateTime trainerResponseDate;   
}
