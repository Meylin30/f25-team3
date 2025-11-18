<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${title!"Provider Dashboard"}</title>

    <link rel="stylesheet"
       <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>


<body class="workout">
  <div class="card">
    <h1>Create Workout</h1>
    <form action="/providers/${provider.id}/workouts" method="post">
      <div class="input-box">
        <input type="text" name="title" placeholder="Workout Title" required>
      </div>
      <div class="input-box">
        <textarea name="description" placeholder="Description"></textarea>
      </div>
      <div class="input-box">
        <select name="fitnessLevel">
          <option value="BEGINNER">Beginner</option>
          <option value="INTERMEDIATE">Intermediate</option>
          <option value="ADVANCED">Advanced</option>
        </select>
      </div>
      <div class="input-box">
        <label>
          Active
          <input type="checkbox" name="active" checked>
        </label>
      </div>
      <div class="button">
        <input type="submit" value="Create Workout">
      </div>
    </form>
    <a href="/providers/${provider.id}/dashboard" class="back-link">Back to Dashboard</a>
  </div>
</body>
</html>
