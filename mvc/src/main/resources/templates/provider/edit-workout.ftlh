<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Workout</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="workout">

<div class="workout-card">
    <h1>Edit Workout</h1>

    <!-- Update Workout Form -->
    <form action="/providers/${provider.id}/workouts/${workout.id}/edit" method="post" class="workout-form">
        <div class="input-box">
            <input type="text" name="title" value="${workout.title!}" placeholder="Workout Title" required>
        </div>

        <div class="input-box">
            <textarea name="description" placeholder="Workout Description" required>${workout.description!}</textarea>
        </div>

        <div class="input-box">
            <select name="fitnessLevel" required>
                <#list ["BEGINNER","INTERMEDIATE","ADVANCED"] as level>
                    <option value="${level}" <#if workout.fitnessLevel==level>selected</#if>>${level}</option>
                </#list>
            </select>
        </div>

        <div class="input-box checkbox-box">
            <label>
                <input type="checkbox" name="active" <#if workout.active?? && workout.active>checked</#if>>
                Active
            </label>
        </div>

        <div class="button-group">
            <input type="submit" value="Save Changes" class="btn-save">
            <a href="/providers/${provider.id}/dashboard" class="btn-back">Back</a>
        </div>
    </form>

    <!-- Delete Workout Form -->
    <form action="/providers/${provider.id}/workouts/${workout.id}/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this workout?');">
        <button type="submit" class="btn-delete">Delete Workout</button>
    </form>
</div>

</body>
</html>



