package com.csc340.spartanfitness.provider;

import java.util.ArrayList;
import java.util.List;

import com.csc340.spartanfitness.workoutplans.Workout;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@Entity
@Table(name = "providers")
public class Provider {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Column(nullable = false)
    private String name;

    @Email
    @NotBlank
    @Column(unique = true, nullable = false)
    private String email;

    @NotBlank
    @Column(nullable = false)
    private String password;

    @OneToMany(mappedBy = "provider", cascade = CascadeType.ALL)
    @JsonIgnoreProperties("provider")
    private List<Workout> workoutPlans = new ArrayList<>();

   
    public Provider(Long id) {
        this.id = id;
    }
    private String pin; // like password or 4-digit code

    @Column(nullable = false)
    private double overallRating = 0.0;

    public void setOverallRating(double overallRating) {
        this.overallRating = overallRating;
    }
    public double getOverallRating() {
        return overallRating;
    }

}
