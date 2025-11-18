<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Workout</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="workout">
<div class="card">
    <h1>Edit Workout</h1>

    <form action="/providers/${provider.id}/workouts/${workout.id}/update" method="post">
        <div class="input-box">
            <input type="text" name="title" value="${workout.title!}" required>
        </div>

        <div class="input-box">
            <textarea name="description" rows="4" required>${workout.description!}</textarea>
        </div>

        <div class="input-box">
            <select name="fitnessLevel" required>
                <option value="">Select Fitness Level</option>
                <#list ["BEGINNER","INTERMEDIATE","ADVANCED"] as level>
                    <option value="${level}" <#if workout.fitnessLevel==level>selected</#if>>${level}</option>
                </#list>
            </select>
        </div>

        <div class="button">
            <input type="submit" value="Save Changes">
        </div>
    </form>

    <a href="/providers/${provider.id}/dashboard" class="back-link">Back to Dashboard</a>
</div>
</body>
</html>

