<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${workout.title} Subscribers</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

    <link rel="stylesheet" href="/css/style.css">
</head>

<body>
<div class="card workouts-card">

    <h1>Subscribers for <span style="color: var(--secondary);">${workout.title}</span></h1>

    <p class="role">Total Subscribers: ${subscribers?size}</p>

    <hr class="divider">

    <#if subscribers?? && subscribers?size gt 0>

        <table style="width:100%; text-align:left; color:white; border-spacing:0 10px;">
            <tr style="color: var(--secondary); font-weight:600;">
                <th>Customer Name</th>
                <th>Email</th>
                <th>Start Date</th>
                <th>Status</th>
            </tr>

            <#list subscribers as sub>
                <tr style="background: rgba(255,255,255,0.1); padding:12px; border-radius:10px;">
                    <td>${sub.customer.name!"N/A"}</td>
                    <td>${sub.customer.email!"N/A"}</td>
                    <td>
                        ${sub.startDate?datetime("yyyy-MM-dd'T'HH:mm")?string("MMM dd, yyyy")}
                    </td>
                    <td>
                        <#if sub.active>
                            <span style="color: var(--secondary);">Active</span>
                        <#else>
                            <span style="color: var(--font-secondary);">Inactive</span>
                        </#if>
                    </td>
                </tr>
            </#list>
        </table>

    <#else>
        <p>No subscribers yet for this workout.</p>
    </#if>

    <a href="/providers/${provider.id}/dashboard" class="back-link">
        ← Back to Dashboard
    </a>

</div>
</body>
</html>

