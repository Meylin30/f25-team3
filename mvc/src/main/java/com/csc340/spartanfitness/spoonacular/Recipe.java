package com.csc340.spartanfitness.spoonacular;

public class Recipe {
    private int id;
    private String title;
    private String summary;
    private String image;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}
