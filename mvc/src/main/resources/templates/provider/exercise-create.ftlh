<!DOCTYPE html>
<html>
<head>
    <title>Add Exercise</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<div class="card edit-workout-card">

    <h1>Add Exercise</h1>

    <form method="post">

        <div class="input-box">
            <label>Name</label>
            <input name="name" required>
        </div>

        <div class="input-box">
            <label>Sets</label>
            <input type="number" name="sets" min="1">
        </div>

        <div class="input-box">
            <label>Reps</label>
            <input type="number" name="reps" min="1">
        </div>

        <div class="input-box">
            <label>Description</label>
            <textarea name="description"></textarea>
        </div>

        <div class="input-box">
            <label>Video URL (Optional)</label>
            <input type="text" name="videoUrl" placeholder="https://youtube.com/...">
        </div>

        <button type="submit" class="btn-1">Save Exercise</button>

    </form>

    <a href="javascript:history.back()" class="back-link">Back</a>
</div>

</body>
</html>
