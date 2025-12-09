package com.csc340.spartanfitness.spoonacular;

import java.util.List;

public class RandomRecipeResponse {
    private List<Recipe> recipes;

    public List<Recipe> getRecipes() {
        return recipes;
    }

    public void setRecipes(List<Recipe> recipes) {
        this.recipes = recipes;
    }

    public static class Recipe {
        private Long id;
        private String title;
        private String instructions;
        private String image;
        // add other fields if needed

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }

        public String getInstructions() { return instructions; }
        public void setInstructions(String instructions) { this.instructions = instructions; }

        public String getImage() { return image; }
        public void setImage(String image) { this.image = image; }
    }
}
