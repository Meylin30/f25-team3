package com.csc340.spartanfitness.provider;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional

public class ProviderService {
    private final ProviderRepository providerRepository;

    public Provider createProvider(Provider provider) {
        if (providerRepository.existsByEmail(provider.getEmail())) {
            throw new IllegalStateException("Email already registered");
        }
        return providerRepository.save(provider);
    }

    public Provider updateProvider(Long id, Provider providerDetails) {
        Provider provider = providerRepository.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("Provider not found"));

        provider.setName(providerDetails.getName());
        if (!provider.getEmail().equals(providerDetails.getEmail()) &&
            providerRepository.existsByEmail(providerDetails.getEmail())) {
            throw new IllegalStateException("Email already registered");
        }
        provider.setEmail(providerDetails.getEmail());
        

        return providerRepository.save(provider);
    }

    public Provider getProviderById(Long id) {
        return providerRepository.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("Provider not found"));
    }

    public Provider getProviderByEmail(String email) {
        return providerRepository.findByEmail(email)
        .orElseThrow(() -> new EntityNotFoundException("Provider not found"));
    }
    public void deleteProvider(Long id) {
    if (!providerRepository.existsById(id)) {
        throw new EntityNotFoundException("Provider not found");
    }
    providerRepository.deleteById(id);
    }

   public List<Provider> getAllProviders() {
    return providerRepository.findAll();
    }
}
    
