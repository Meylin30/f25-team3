package com.csc340.spartanfitness.Provider;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/providers")
@RequiredArgsConstructor

public class ProviderController {
    
private final ProviderService providerService;

   @PostMapping
    public ResponseEntity<Provider> createProvider(@Valid @RequestBody Provider provider) {
        return ResponseEntity.ok(providerService.createProvider(provider));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Provider> updateProvider(@PathVariable Long id, @Valid @RequestBody Provider providerDetails) {
        return ResponseEntity.ok(providerService.updateProvider(id, providerDetails));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Provider> getProvider(@PathVariable Long id) {
        return ResponseEntity.ok(providerService.getProviderById(id));
    }
    @GetMapping
    public ResponseEntity<List<Provider>> getAllProviders() {
    return ResponseEntity.ok(providerService.getAllProviders());
    }   

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProvider(@PathVariable Long id) {
    providerService.deleteProvider(id);
    return ResponseEntity.noContent().build();
    }

}