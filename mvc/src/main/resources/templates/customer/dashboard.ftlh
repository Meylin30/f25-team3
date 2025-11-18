<!DOCTYPE html>
<html>
<head>
    <title>${title! "Homepage"}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">
</head>
<body>

    <header>
        <a href="/" class="logo">Spartan Fitness<span>.</span></a>       
        <nav class="navbar">
        <#if customerId??>
                <a href="/customers/explore">Workouts</a>
                <a href="/customers/dashboard">Profile</a>
                <a href="/customers/logout">Logout</a>
        <#else>
            <a href="/signin">Sign In</a>
            <a href="/signup">Sign Up</a>
        </#if>    
        </nav>
        <div class="container">
            <form action="">
                <input type="search" name="" placeholder="Search here..." id="search-box">
                <label for="search-box" class="fas fa-search"></label>
            </form>
        </div>
    </header>

    <section class="profile-container">
        <div class="profile-header">
            <div class="profile-icon">
            <i class="fas fa-user-circle"></i>
            </div>
        <div class="info">
            <h2>${customer.name!}</h2>
            <p>Member since 2023 • Goal: Build muscle</p>
        </div>
        </div>

        <div class="tab-buttons">
          <div class="tab-button active-tab" data-tab="user-info" onclick="showTab('user-info')">User Info</div>
          <div class="tab-button" data-tab="progress" onclick="showTab('progress')">Progress</div>
          <div class="tab-button" data-tab="workouts" onclick="showTab('workouts')">Workouts</div>
        </div>
    
        <!-- TAB 1 -->
        <div class="tab-content" id="user-info">
          <h3>User Information</h3>
          <!--
          <p><strong>Email:</strong> ${customer.email! 'NA'}</p>
          <p><strong>Date of Birth:</strong> ${customer.dob?string("MM/dd/yyyy")! 'NA'}</p>
          <p><strong>Height:</strong> ${customer.height! 'NA'}</p>
          <p><strong>Weight:</strong> ${customer.weight! 'NA'}</p>
          -->
        </div>
    
        <!-- TAB 2 -->
        <div class="tab-content" id="progress">
          <h3>Progress</h3>
          <p><strong>Weight Change:</strong> 140 lbs → 135 lbs</p>
          <p><strong>Workouts Completed:</strong> 52 this year</p>
        </div>
    
        <!-- TAB 3 -->
        <div class="tab-content" id="workouts">
          <h3>Subscribed Workouts</h3>
          <!--
          <#if customer.subscriptions?? && customer.subscriptions?size gt 0>
          <ul>
            <#list customer.subscriptions as subscription>
              <li>
                ${subscription.workout.name} – 
                Started: ${subscription.startDate?string("yyyy-MM-dd HH:mm")} – 
                Type: ${subscription.type}
              </li>
            </#list>
          </ul>
          <#else>
              <p>No subscribed workouts yet.</p>
              <a href="/customers/explore" class="btn btn-primary">Browse Workouts</a>
          </#if>
          -->
        </div>
    </section>
        
    <script defer>
        function showTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(tab => tab.style.display = 'none');
        document.getElementById(tabId).style.display = 'block';

        document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active-tab'));
        document.querySelector(`[data-tab="${tabId}"]`).classList.add('active-tab');
        }

        document.addEventListener('DOMContentLoaded', () => {
        showTab('user-info');
        });
    </script>

</body>
</html>