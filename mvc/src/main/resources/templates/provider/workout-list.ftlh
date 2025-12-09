<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${provider.name}'s Workouts</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>

<div class="card workouts-card">

    <h1>${provider.name}'s Workouts</h1>

    <a class="btn-1 create-btn" href="/providers/${provider.id}/workouts/create">
        + Create New Workout
    </a>

    <div class="filters">
        <input type="text" id="searchInput" placeholder="Search workouts...">

        <select id="filterLevel">
            <option value="">All Levels</option>
            <option value="BEGINNER">Beginner</option>
            <option value="INTERMEDIATE">Intermediate</option>
            <option value="ADVANCED">Advanced</option>
        </select>

        <select id="sortOrder">
            <option value="newest">Newest First</option>
            <option value="oldest">Oldest First</option>
        </select>
    </div>

    <div id="workoutList" class="workout-list">

        <#if workouts?? && workouts?size gt 0>
            <#list workouts as w>

                <div class="workout-list-item"
                     data-title="${(w.title!'')?lower_case}"
                     data-level="${w.fitnessLevel!'UNKNOWN'}"
                     data-id="${w.id}">

                    <div class="workout-info">
                        <div class="workout-title">${w.title!''}</div>
                        <div class="fitness-level">${w.fitnessLevel!''}</div>
                        <p class="workout-title-line">${w.description!''}</p>
                    </div>

                    <div class="workout-actions">
                        <a href="/providers/${provider.id}/workouts/${w.id}/edit"
                           class="btn-1 small-edit">Edit</a>

                        <form action="/providers/${provider.id}/workouts/${w.id}/delete"
                              method="post"
                              onsubmit="return confirm('Delete this workout?');">
                            <button type="submit" class="btn-delete small-delete">Delete</button>
                        </form>
                    </div>

                </div>

            </#list>

        <#else>
            <p>No workouts created yet.</p>
        </#if>

    </div>

    <a href="/" class="back-link">
        ← Back to Home
    </a>

</div>

<script>
    const searchInput = document.getElementById("searchInput");
    const filterLevel = document.getElementById("filterLevel");
    const sortOrder = document.getElementById("sortOrder");
    const workoutList = document.getElementById("workoutList");
    const items = Array.from(workoutList.children);

    function updateList() {
        let query = searchInput.value.toLowerCase();
        let level = filterLevel.value;

        let filtered = items.filter(item => {
            let title = item.dataset.title || "";
            let itemLevel = item.dataset.level || "";
            return title.includes(query) &&
                   (level === "" || level === itemLevel);
        });

        if (sortOrder.value === "newest") filtered.reverse();

        workoutList.innerHTML = "";
        filtered.forEach(item => workoutList.appendChild(item));
    }

    searchInput.addEventListener("input", updateList);
    filterLevel.addEventListener("change", updateList);
    sortOrder.addEventListener("change", updateList);
</script>

</body>
</html>




