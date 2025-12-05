<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card edit-profile-card">

    <h1>Edit Profile</h1>

    <form action="/providers/${provider.id}/edit" method="post">

        <div class="input-box">
            <label>Name</label>
            <input type="text" name="name" value="${provider.name}" required>
        </div>

        <div class="input-box">
            <label>Email</label>
            <input type="email" name="email" value="${provider.email}" required>
        </div>

        <div class="button-group">
            <button type="submit" class="btn-1">Save</button>
            <a href="/providers/${provider.id}/dashboard" class="logout-btn">Cancel</a>
        </div>

    </form>

    <a href="javascript:history.back()" class="back-link">Back</a>

</div>

</body>
</html>


