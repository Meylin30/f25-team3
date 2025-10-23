package com.csc340.spartanfitness.customer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
    List<Customer> findByNameContainingIgnoreCase(String name);
    List<Customer> findByAge(Integer age);
    boolean existsByEmail(String email);
    Optional<Customer> findByEmail(String email);

}
