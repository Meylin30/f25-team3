<!DOCTYPE html>
<html>
<head>
    <title>${provider.name}'s Workouts</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body class="profile">
<div class="header__wrapper">
    <h1>${provider.name}'s Workouts</h1>
    <a class="btn-1" href="/providers/${provider.id}/workouts/create">Create New Workout</a>
    <ul class="programs">
        <#list workouts as w>
            <li>
                <strong>${w.title}</strong> - ${w.fitnessLevel} 
                <a href="/providers/${provider.id}/workouts/${w.id}/edit">Edit</a>
            </li>
        </#list>
    </ul>
</div>
</body>
</html>
