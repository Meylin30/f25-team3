package com.csc340.spartanfitness.Provider;

import lombok.Data;
import java.util.Map;

@Data
public class ProviderStatistics {
    private long totalCustomers;
    private long activeCustomers;
    private Map<String, Long> customersByMonth;

    private int totalWorkouts;
    private int activeWorkouts;
    private Map<String, Long> mostPopularWorkouts;

    private double averageOverallRating;
    private double averageMotivationRating;
    private double averageKnowledgeRating;
    private Map<String, Double> ratingsByWorkout;

    private long totalReviews;
    private double responseRate; 
    private Map<Double, Long> ratingDistribution; 
}