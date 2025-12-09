package com.csc340.spartanfitness.spoonacular;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.web.util.UriUtils;

@Service
public class SpoonacularService {
    @Value("${spoonacular.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate = new RestTemplate();

    public RandomRecipeResponse getRandomRecipe(
        boolean includeNutrition,
        String includeTags,
        String excludeTags,
        int number
) {
    includeTags = includeTags == null ? "" : includeTags;
    excludeTags = excludeTags == null ? "" : excludeTags;

    String url = UriComponentsBuilder.fromUriString("https://api.spoonacular.com/recipes/random")
            .queryParam("apiKey", apiKey)
            .queryParam("number", number)
            .queryParam("tags", includeTags)         // correct param
            .queryParam("excludeTags", excludeTags)  // correct param
            .queryParam("includeNutrition", includeNutrition)
            .build()
            .toUriString();

    return restTemplate.getForObject(url, RandomRecipeResponse.class);
}

    public QuickAnswerResponse getQuickAnswer(String question) {
    String url = UriComponentsBuilder.fromUriString("https://api.spoonacular.com/recipes/quickAnswer")
            .queryParam("apiKey", apiKey)
            .queryParam("q", question)
            .build()
            .toUriString();

    return restTemplate.getForObject(url, QuickAnswerResponse.class);
    }
}
