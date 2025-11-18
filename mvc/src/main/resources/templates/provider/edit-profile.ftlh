<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="profile">

<div class="edit-profile-container">
    <h2>Edit Profile</h2>

    <form action="/providers/${provider.id}/edit" method="post">
        <label for="name">Name</label>
        <input type="text" id="name" name="name" value="${provider.name}" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" value="${provider.email}" required>

        <button type="submit" class="btn-1">Save Changes</button>
        <a href="/providers/${provider.id}/dashboard" class="btn-1">Cancel</a>
    </form>
</div>

</body>
</html>

