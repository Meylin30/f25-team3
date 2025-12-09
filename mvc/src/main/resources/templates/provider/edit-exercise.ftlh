<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Exercise</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card edit-workout-card">

    <h1>Edit Exercise</h1>

    <form action="/providers/${providerId}/workouts/${workout.id}/exercises/${exercise.id}/edit" method="post">

        <div class="input-box">
            <label>Name</label>
            <input type="text" name="name" value="${exercise.name!}" required>
        </div>

        <div class="input-box">
            <label>Sets</label>
            <input type="number" name="sets" min="1" value="${exercise.sets!}">
        </div>

        <div class="input-box">
            <label>Reps</label>
            <input type="number" name="reps" min="1" value="${exercise.reps!}">
        </div>

        <div class="input-box">
            <label>Description</label>
            <textarea name="description" required>${exercise.description!}</textarea>
        </div>

        <div class="input-box">
            <label>Video URL (optional)</label>
            <input type="url" name="videoUrl" value="${exercise.videoUrl!}">
        </div>

        <div class="button-group">
            <button type="submit" class="btn-1">Save Exercise</button>
            <a href="/providers/${providerId}/workouts/${workout.id}/edit" class="logout-btn">Cancel</a>
        </div>
    </form>

    <form action="/providers/${providerId}/workouts/${workout.id}/exercises/${exercise.id}/delete"
          method="post">
        <button class="btn-delete delete-bottom" type="submit">
            Delete Exercise
        </button>
    </form>

</div>

</body>
</html>
