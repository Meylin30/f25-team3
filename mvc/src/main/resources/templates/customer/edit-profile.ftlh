<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="/css/customer-style.css">

    <style>
      /* Container for all workout subscriptions */
      .workout-subscriptions {
          display: flex;
          flex-direction: column;
          gap: 2rem;
          margin-top: 2rem;
      }

      /* Each subscription "card" */
      .workout-card {
          background: #fff;
          padding: 2rem;
          border-radius: 1rem;
          box-shadow: 0 0 1rem rgba(0,0,0,0.08);
          border-left: 0.7rem solid var(--main);
      }

      /* Header row: name + active badge */
      .workout-card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
      }

      /* Workout name */
      .workout-name a {
          font-size: 1.8rem;
          font-weight: 600;
          color: var(--main);
      }

      .workout-name a:hover {
          color: var(--secondary);
      }

      /* Status badges */
      .workout-status {
          font-size: 1.3rem;
          padding: 0.4rem 1rem;
          border-radius: 0.5rem;
          color: white;
          text-transform: none;
      }

      .active-status {
          background: #28a745; /* Green, like your style */
      }

      .inactive-status {
          background: #6c757d; /* Gray */
      }

      /* Workout type text */
      .workout-type {
          margin-top: 1rem;
          font-size: 1.5rem;
          color: var(--font-secondary);
      }

      /* Dates (start, end, last session) */
      .workout-dates {
          margin-top: 1.5rem;
          font-size: 1.4rem;
          color: #333;
          line-height: 1.5;
      }

      /* Browse button when no subscriptions */
      .subscribe-btn {
          display: inline-block;
          margin-top: 2rem;
          padding: 1rem 2rem;
          background: black;
          color: white;
          border-radius: 0.5rem;
          font-size: 1.6rem;
      }

      .subscribe-btn:hover {
          background: var(--secondary);
          color: black;
      }

        .profile-container form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .profile-container label {
            font-weight: 600;
            font-size: 1.4rem;
            color: var(--font-secondary);
        }

        .profile-container input {
            font-size: 1.5rem;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            border: 1px solid #ccc;
            background: #f8f8f8;
            color: #333;
            width: 100%;
            box-sizing: border-box;
        }

        .profile-container input:focus {
            outline: none;
            border-color: var(--main);
            background: #fff;
        }

        /* Submit button matching your current style */
        .submit-btn {
            margin-top: 1rem;
            padding: 1rem 2rem;
            font-size: 1.6rem;
            background: var(--main);
            color: white;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .submit-btn:hover {
            background: var(--secondary);
            color: black;
        }

        .cancel-btn {
            display: inline-block;       /* same as .btn */
            margin-top: 1rem;            /* same */
            padding: 3% 3.5rem;          /* same */
            background: #6c757d;         /* custom color (gray) */
            color: white;                /* text color */
            font-size: 1.7rem;           /* same */
            border-radius: 5rem;         /* same */
            cursor: pointer;             /* same */
            text-decoration: none;
            text-align: center;
            transition: all 0.2s ease;  /* smooth hover transition */
        }
        
        .cancel-btn:hover {
            background: #495057;         /* darker gray on hover */
            color: white;                /* keep text white */
        }

    </style>
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
            <form action="/customers/explore" method="get">
                <input type="search" name="search" placeholder="Search here..." id="search-box">
                <label for="search-box" class="fas fa-search"></label>
                <button type="submit" style="display:none;"></button>
            </form>
        </div>
    </header>

    <section class="profile-container">
        <div class="profile-header">
            <div class="profile-icon">
                <i class="fas fa-user-circle"></i>
            </div>
            <div class="info">
            <h2>${customer.name}</h2>
                <a href="/customers/dashboard" class="cancel-btn">
                    <i class="fas fa-pencil-alt"></i> Cancel Edits
                </a>
            </div>
        </div>

        <!-- Two tabs -->
        <div class="tab-buttons">
            <div class="tab-button active-tab" data-tab="user-info" onclick="showTab('user-info')">User Info</div>
            <div class="tab-button" data-tab="workouts" onclick="showTab('workouts')">Workouts</div>
        </div>

        <!-- Tab 1: User Info -->
        <div class="tab-content active-tab-content" id="user-info">
            <h3>Edit Your Information</h3>
            <#if error??>
                <div class="error-message" style="color: red; margin-bottom: 10px;">
                    ${error}
                </div>
            </#if>
            <form action="/customers/profile/edit" method="post">
                <label for="email">Email</label>
                <input type="email" name="email" placeholder="${customer.email}" value="${customer.email}" required>

                <label for="currentPassword">Current Password</label>
                <input type="password" name="currentPassword" required placeholder="Enter current password.">

                <label for="newPassword">New Password (optional)</label>
                <input type="password" name="newPassword">

                <label for="name">Username</label>
                <input type="text" name="name" placeholder="${customer.name! ''}" value="${customer.name! ''}">

                <label for="dob">Date of Birth</label>
                <input type="date" name="dob" placeholder="${customer.dob! ''}" value="${customer.dob! ''}">

                <label for="height">Height</label>
                <input type="text" name="height" placeholder="${customer.height! ''}" value="${customer.height! ''}">

                <label for="weight">Weight</label>
                <input type="number" name="weight" placeholder="${customer.weight! ''}" value="${customer.weight! ''}" step="0.1">

                <button type="submit" class="submit-btn">Save Changes</button>
            </form>
        </div>

        <!-- Tab 2: Workouts -->
        <div class="tab-content" id="workouts">
            <h3>Subscribed Workouts</h3>
            <div class="workout-subscriptions">
                <#if customer.subscriptions?? && customer.subscriptions?size gt 0>
                    <#list customer.subscriptions as subscription>
                        <div class="workout-card">
                            <div class="workout-card-header">
                                <span class="workout-name">
                                    <a href="/customers/explore/${subscription.workout.id}">${subscription.workout.title}</a>
                                </span>
                                <span class="workout-status ${subscription.active?then('active-status','inactive-status')}">
                                    ${subscription.active?then('Active','Inactive')}
                                </span>
                            </div>
                            <div class="workout-type">${subscription.type}</div>
                            <div class="workout-dates">
                                <small>Start: ${subscription.startDate?datetime.iso}</small>
                                <br>
                                <small>Last Session: 
                                    <#if subscription.lastSessionDate??>
                                        ${subscription.lastSessionDate?datetime.iso}
                                    <#else> No Sessions yet
                                    </#if>
                                </small>
                            </div>
                        </div>
                    </#list>
                <#else>
                    <p>No subscribed workouts yet.</p>
                    <a href="/customers/explore" class="subscribe-btn">Browse Workouts</a>
                </#if>
            </div>
        </div>
    </section>

    <#noparse>
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
    </#noparse>
</body>
</html>