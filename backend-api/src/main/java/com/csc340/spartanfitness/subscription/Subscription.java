package com.csc340.spartanfitness.subscription;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.time.LocalDateTime;

import org.hibernate.boot.registry.classloading.spi.ClassLoaderService.Work;
import org.springframework.cglib.core.Local;

import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.workout.Workout;

@Data
@NoArgsConstructor
@Entity
@Table(name = "subscriptions")
public class Subscription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @JsonIgnoreProperties("subscriptions")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "workout_id", nullable = false)
    @JsonIgnoreProperties({"subscriptions", "reviews"})
    private Workout workout;

    @NotNull
    @Enumerated(EnumType.STRING)
    private SubscriptionType type;

    @NotNull
    private LocalDateTime startDate;

    private LocalDateTime endDate;

    @NotNull
    private boolean active = true;
}

enum SubscriptionType {
    ONE_TIME,
    BIWEEKLY,
    MONTHLY,
    YEARLY
}