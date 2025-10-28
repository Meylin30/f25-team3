# SpartanFitness API Documentation

## Customer API Endpoints

### Create Customer
```http
POST /api/customers
Content-Type: application/json

{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "securePassword123",
    "age": 30,
    "height": 175,
    "weight": 70
}
```

### Update Customer
```http
PUT /api/customers/{id}
Content-Type: application/json

{
    "name": "John Doe Updated",
    "email": "john.updated@example.com",
    "password": "securePassword123",
    "age": 31,
    "height": 178,
    "weight": 72
}
```

### Get Customer
```http
GET /api/customers/{id}
```

### Get All Customers
```http
GET /api/customers
```

### Search Customers by Name
```http
GET /api/customers/search/name?name={searchTerm}
```

### Search Customers by Age
```http
GET /api/customers/search/age?age={age}
```

### Delete Customer
```http
DELETE /api/customers/{id}
```

---

## Provider (Trainer) API Endpoints

### Create Provider
```http
POST /api/providers
Content-Type: application/json

{
    "name": "Jane Smith",
    "email": "jane@trainer.com",
    "password": "strongPassword123",
    "specialty": "Strength Training"
}
```

### Update Provider
```http
PUT /api/providers/{id}
Content-Type: application/json

{
    "name": "Jane Smith Updated",
    "email": "jane.updated@trainer.com",
    "specialty": "HIIT and Cardio"
}
```

### Get Provider
```http
GET /api/providers/{id}
```

### Get All Providers
```http
GET /api/providers
```

### Delete Provider
```http
DELETE /api/providers/{id}
```

---

## Workout Plan API Endpoints

### Create Workout Plan
```http
POST /api/workout-plans
Content-Type: application/json

{
    "title": "Full Body Strength Training",
    "description": "A balanced plan for building strength and endurance.",
    "durationWeeks": 8,
    "price": 49.99,
    "active": true,
    "provider": {
        "id": 1
    }
}
```

### Update Workout Plan
```http
PUT /api/workout-plans/{id}
Content-Type: application/json

{
    "title": "Full Body Strength Training - Updated",
    "description": "Updated version with enhanced cardio routines.",
    "durationWeeks": 10,
    "price": 59.99,
    "active": true
}
```

### Get Workout Plan
```http
GET /api/workout-plans/{id}
```

### Get All Active Workout Plans
```http
GET /api/workout-plans
```

### Get Workouts by Provider
```http
GET /api/workout-plans/provider/{providerId}
```

### Delete Workout Plan
```http
DELETE /api/workout-plans/{id}
```

---

## Subscription API Endpoints

### Create Subscription
```http
POST /api/subscriptions
Content-Type: application/json

{
    "customer": {
        "id": 1
    },
    "workout": {
        "id": 1
    },
    "active": true,
    "startDate": "2025-10-06T10:00:00"
}
```

### Update Subscription
```http
PUT /api/subscriptions/{id}
Content-Type: application/json

{
    "active": false
}
```

### Cancel Subscription
```http
POST /api/subscriptions/{id}/cancel
```

### Get Subscriptions by Customer
```http
GET /api/subscriptions/customer/{customerId}
```

### Get Subscriptions by Workout Plan
```http
GET /api/subscriptions/workout/{workoutId}
```

### Get Subscriptions by Trainer
```http
GET /api/subscriptions/trainer/{trainerId}
```

---

## Review API Endpoints

### Create Review
```http
POST /api/reviews
Content-Type: application/json

{
    "customer": {
        "id": 1
    },
    "workout": {
        "id": 1
    },
    "rating": 5,
    "comment": "Amazing workout! Great pacing and variety."
}
```

### Add Trainer Response
```http
POST /api/reviews/{id}/trainer-response
Content-Type: application/json

"Thank you for your feedback! Keep up the great work!"
```

### Delete Review
```http
DELETE /api/reviews/{id}
```

### Get Reviews for Workout
```http
GET /api/reviews/workout/{workoutId}
```

### Get Reviews by Customer
```http
GET /api/reviews/customer/{customerId}
```

### Get Reviews for Trainer
```http
GET /api/reviews/trainer/{trainerId}
```

### Get Average Rating for Workout
```http
GET /api/reviews/workout/{workoutId}/rating
```

Response Example:
```json
{
    "averageRating": 4.7
}
```

---

## Summary of Base Routes
| Resource | Base URL |
|-----------|-----------|
| Customer | `/api/customers` |
| Provider | `/api/providers` |
| Workout Plans | `/api/workout-plans` |
| Subscriptions | `/api/subscriptions` |
| Reviews | `/api/reviews` |
