package com.csc340.spartanfitness.spoonacular;

import com.csc340.spartanfitness.spoonacular.RandomRecipeResponse;
import com.csc340.spartanfitness.spoonacular.SpoonacularService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/spoonacular")
public class SpoonacularController {

    private final SpoonacularService spoonacularService;

    public SpoonacularController(SpoonacularService spoonacularService) {
        this.spoonacularService = spoonacularService;
    }

    @GetMapping("/randomRecipe")
    public RandomRecipeResponse getRandomRecipe(
            @RequestParam(required = false, defaultValue = "") String includeTags,
            @RequestParam(required = false, defaultValue = "") String excludeTags) {

        // Hardcode includeNutrition = true and number = 1
        return spoonacularService.getRandomRecipe(true, includeTags, excludeTags, 1);
    }

    @GetMapping("/quickAnswer")
    public QuickAnswerResponse getQuickAnswer(@RequestParam String question) {
        return spoonacularService.getQuickAnswer(question);
    }

}

