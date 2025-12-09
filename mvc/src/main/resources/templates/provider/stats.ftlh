<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${provider.name} | Statistics</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card workouts-card">

    <h1>${provider.name}'s Statistics</h1>

    <div class="stats-summary" style="text-align:left; margin-bottom:25px;">
        <p><strong>Total Workouts:</strong> ${workoutCount}</p>
        <p><strong>Total Reviews:</strong> ${reviewCount}</p>
        <p><strong>Average Rating:</strong> ⭐ ${avgRating?string("0.0")}</p>
        <p><strong>Most Created Level:</strong> ${topLevel!"None"}</p>
        <p><strong>Active Subscribers:</strong> ${subscriberCount}</p>
        <p><strong>Most Subscribed Workout:</strong> ${mostSubscribedWorkout!"None"}</p>
    </div>

    <hr class="divider">

    <h2 class="section-title">Subscribers Per Workout</h2>

    <#if subscriberBreakdown?? && subscriberBreakdown?size gt 0>
        <ul>
            <#list subscriberBreakdown?keys as title>
                <li>${title}: ${subscriberBreakdown[title]}</li>
            </#list>
        </ul>
    <#else>
        <p>No subscriber statistics available yet.</p>
    </#if>

    <a href="/providers/${provider.id}/dashboard" class="back-link">
        ← Back to Dashboard
    </a>
</div>

</body>
</html>


