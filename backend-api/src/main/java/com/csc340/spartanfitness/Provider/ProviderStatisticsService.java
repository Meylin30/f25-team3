package com.csc340.spartanfitness.Provider;

import com.csc340.spartanfitness.WorkoutPlans.Workout;
import com.csc340.spartanfitness.WorkoutPlans.workoutRepository;
import com.csc340.spartanfitness.customer.Customer;
import com.csc340.spartanfitness.customer.CustomerRepository;


import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;


@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProviderStatisticsService {
    private final ProviderRepository providerRepository;
    private final CustomerRepository customerRepository;
    private final workoutRepository workoutRepository;
   

    public ProviderStatistics getProviderStatistics(Long providerId) {
        Provider provider = providerRepository.findById(providerId)
                .orElseThrow(() -> new EntityNotFoundException("Provider not found"));

        ProviderStatistics stats = new ProviderStatistics();

        calculateCustomerStatistics(stats, provider);
        calculateWorkoutStatistics(stats, provider);
        

        return stats;
    }

    
    private void calculateCustomerStatistics(ProviderStatistics stats, Provider provider) {
        List<Customer> allCustomers = customerRepository.findByProvider(provider);

        stats.setTotalCustomers(allCustomers.size());
        stats.setActiveCustomers(allCustomers.stream().filter(c -> Boolean.TRUE.equals(c.isActive())).count());

       
        Map<String, Long> customersByMonth = new LinkedHashMap<>();
        DateTimeFormatter monthFormatter = DateTimeFormatter.ofPattern("MMMM yyyy");

        for (int i = 5; i >= 0; i--) {
            LocalDateTime monthStart = LocalDateTime.now().minusMonths(i).withDayOfMonth(1);
            LocalDateTime monthEnd = monthStart.plusMonths(1);

            long count = allCustomers.stream()
                    .filter(c -> c.getJoinDate().isAfter(monthStart) && c.getJoinDate().isBefore(monthEnd))
                    .count();

            customersByMonth.put(monthStart.format(monthFormatter), count);
        }

        stats.setCustomersByMonth(customersByMonth);
    }


    private void calculateWorkoutStatistics(ProviderStatistics stats, Provider provider) {
        List<Workout> workouts = workoutRepository.findByProviderAndActiveTrue(provider);

        stats.setTotalWorkouts(workouts.size());
        stats.setActiveWorkouts((int) workouts.stream().filter(Workout::isActive).count());
    }
       
}
    

