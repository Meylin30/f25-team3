package com.csc340.spartanfitness.customer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    List<Customer> findByNameContainingIgnoreCase(String name);
    List<Customer> findByDob(LocalDate dob);
    boolean existsByEmail(String email);
    Optional<Customer> findByEmail(String email);
}
