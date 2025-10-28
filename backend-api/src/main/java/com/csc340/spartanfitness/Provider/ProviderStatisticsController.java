package com.csc340.spartanfitness.Provider;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/providers/statistics")
@RequiredArgsConstructor

public class ProviderStatisticsController {

     private final ProviderStatisticsService providerStatisticsService;

    @GetMapping("/{providerId}")
    public ResponseEntity<ProviderStatistics> getProviderStatistics(@PathVariable Long providerId) {
        return ResponseEntity.ok(providerStatisticsService.getProviderStatistics(providerId));
    }
}
    

