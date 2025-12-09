<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Workout</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card edit-workout-card">

    <h1>Edit Workout</h1>

    <form action="/providers/${provider.id}/workouts/${workout.id}/edit" method="post">

        <div class="input-box">
            <label>Title</label>
            <input type="text" name="title" value="${workout.title!}" required>
        </div>

        <div class="input-box">
            <label>Description</label>
            <textarea name="description" required>${workout.description!}</textarea>
        </div>

        <div class="input-box">
            <label>Fitness Level</label>
            <select name="fitnessLevel" required>
                <#list ["BEGINNER","INTERMEDIATE","ADVANCED"] as level>
                    <option value="${level}" <#if workout.fitnessLevel==level>selected</#if>>${level}</option>
                </#list>
            </select>
        </div>

        <div class="input-box active-row">
            <label class="active-label">
                <input type="checkbox" name="active"
                       <#if workout.active?? && workout.active>checked</#if> >
                Active
            </label>
        </div>

        <div class="button-group">
            <button type="submit" class="btn-1">Save Changes</button>
            <a href="/providers/${provider.id}/dashboard" class="logout-btn">Back</a>
        </div>

    </form>

    <hr class="divider">
    <h2 class="section-title">Exercises in This Workout</h2>

    <#if workout.exercises?? && workout.exercises?size gt 0>
        <#list workout.exercises as ex>
            <div class="workout-item">
                <strong>${ex.name}</strong> — ${ex.sets} sets × ${ex.reps} reps
                <p>${ex.description!"No description provided."}</p>

                <div class="button-group">

                   
                    <a href="/providers/${provider.id}/workouts/${workout.id}/exercises/${ex.id}/edit"
                       class="btn-1 small-btn">Edit</a>

                   
                    <form action="/providers/${provider.id}/workouts/${workout.id}/exercises/${ex.id}/delete"
                          method="post" style="display:inline;">
                        <button class="btn-delete small-btn" type="submit">Delete</button>
                    </form>
                </div>
            </div>
        </#list>
    <#else>
        <p>No exercises added yet.</p>
    </#if>

 
    <a href="/providers/${provider.id}/workouts/${workout.id}/exercises/create"
       class="btn-1 new-plan-btn">
       ➕ Add Exercise
    </a>

    <button onclick="document.getElementById('deleteForm').submit()" class="btn-delete delete-bottom">
        Delete Workout
    </button>

    <form id="deleteForm"
          action="/providers/${provider.id}/workouts/${workout.id}/delete"
          method="post"></form>

</div>

</body>
</html>





