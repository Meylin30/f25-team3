# Software Requirements Specification
## For <project name>

Version 0.1  
Prepared by <author>  
<organization>  
<date created> 

Table of Contents
=================
* [Revision History](#revision-history)
* 1 [Introduction](#1-introduction)
  * 1.1 [Document Purpose](#11-document-purpose)
  * 1.2 [Product Scope](#12-product-scope)
  * 1.3 [Definitions, Acronyms and Abbreviations](#13-definitions-acronyms-and-abbreviations)
  * 1.4 [References](#14-references)
  * 1.5 [Document Overview](#15-document-overview)
* 2 [Product Overview](#2-product-overview)
  * 2.1 [Product Functions](#21-product-functions)
  * 2.2 [Product Constraints](#22-product-constraints)
  * 2.3 [User Characteristics](#23-user-characteristics)
  * 2.4 [Assumptions and Dependencies](#24-assumptions-and-dependencies)
* 3 [Requirements](#3-requirements)
  * 3.1 [Functional Requirements](#31-functional-requirements)
    * 3.1.1 [User Interfaces](#311-user-interfaces)
    * 3.1.2 [Hardware Interfaces](#312-hardware-interfaces)
    * 3.1.3 [Software Interfaces](#313-software-interfaces)
  * 3.2 [Non-Functional Requirements](#32-non-functional-requirements)
    * 3.2.1 [Performance](#321-performance)
    * 3.2.2 [Security](#322-security)
    * 3.2.3 [Reliability](#323-reliability)
    * 3.2.4 [Availability](#324-availability)
    * 3.2.5 [Compliance](#325-compliance)
    * 3.2.6 [Cost](#326-cost)
    * 3.2.7 [Deadline](#327-deadline)

## Revision History

| Name      | Date    | Reason For Changes  | Version   |
| ----------| ------- | ------------------- | --------- |
| Meylin    | 9/16    | Initial SRS         | 1.0       |
| Elisha    | 9/16    | Initial SRS         | 1.0       |
|           |         |                     |           |



## 1. Introduction

### 1.1 Document Purpose
The purpose of this Software Requirement Document (SRD) is to outline both the client-oriented and developed-oriented requirements for the SpartanFitness application. From the client perspective, the document defines the needs of different types of users- such as fitness enthusiasts, beginners looking for guided fitness routines, or advance athletes seeking personalized training plans. From the developer persperctive, the SRD specifies the functional capabilities, data requirements, performance expectations, and other technical considerations necessary to ensure that SpartanFitness operates efficiently, delivers a seamless user experience, and meets the goals of providing a reiable and engaging online fitness platform.

### 1.2 Product Scope
The purpose of the SpartanFitness system is to connect individuals with the tools and resources they need to achieve their health and fitness goals while providing trainers and coaches with a convenient and easy to use platform to reach and support their clients. The system is a web-based application designed to simplify access to workout plans, and progress tracking features. A secure server will support users of different fitness levels and training programs. Above all, SpartanFitness aims to deliver a comfortable and motivating user experience while offering the highest quality fitness resouces and personalized guidance available. 

### 1.3 Definitions, Acronyms and Abbreviations                                                                              
| Reference  | Definition                                                                                                        |
|------------|-------------------------------------------------------------------------------------------------------------------|
| API        | Application Programming Interface. This will be used to interface the backend and the fronted of our application. |
| CSS        | Cascading Style Sheets. Will be used to add styles and appearance to the web app.                                 |
| HTML       | Hypertext Markup Language. This is the code that will be used to structure and design the web application and its content.|
| Java       | A programming language originally developed by James Gosling at Sun Microsystems. We will be using this language to build the backend service.|
| JavaScript | An object-oriented computer programming language commonly used to create interactive effects within web browsers.Will be used in conjuction with HTML and CSS to make the web app.|
| Postgresql | Open-source relational database management system.                                                                |
| Spring Web | Will be used to build our web application by using Spring MVC. This is one of the dependencies of our system.     |
| SpringBoot | An open-source Java-based framework used to create a micro Service. This will be used to create and run our application.|
| VS Code    | An integrated development environment (IDE) for Java. This is where our system will be created.                   |


### 1.4 References
https://spring.io/guides

### 1.5 Document Overview
This Software Requirements Document (SRD) for SpartanFitness is organized into three sections. Section 1 provides a general introduction to the document and the system, outlining its purpose, scope, and overall objectives for all readers. Section 2 focuses on the product and its features, describing the value SpartanFitness offers, the user groups it supports, and the key functionality available, this section is primarily intended for customers. Section 3 details the specific requirements and constraints of the system and development process, covering functional, non-functional, and technical considerations.

## 2. Product Overview
SpartanFitness is web-based platform designed to help individuals of all fitness levels access structured training programs, workout resources, and progress tracking tools. Users can explore customized exercise routines, monitors their performance over time, and engage with a supportive community to stay motivated. Trainers can create and share personalized workout plans, track client achievements, and provide feedback directly through the system. The platform supports multiple user roles, including members, trainers, and administrators, each tailored tools to ensure an engaging effective, and goal-oritented fitness experience.

### 2.1 Product Functions
SpartanFitness allows Providers to:
+ create and customize their individual profiles intuitively
+ create and customize workout plans.
+ manage subscriptions at their own discression.

SpartanFitness allows Users to:
+ create and customize their individual profiles intuitively
+ subscribe and unsubscribe to any workout plan of their choosing.
+ provide feedback to workout plans through a rating system.

### 2.2 Product Constraints
At this point the program will only be running on a computer with Java jdk 21, however it may be 22 or later at some point in the future. The front end of the program will be limited to JavaScript as the webpages will be written in HTML. The providers using this program must be certified to offer their services. Scalability, due to  use of a free version of a Postgresql database.
  
### 2.3 User Characteristics
The users of this app will fall into two classes: customer and provider. Our website application does not expect our users to have any prior knowledge of a computer, apart from using a web browser. The features of this application will adhere to the structure of other apps within its category, this will increase the likelihood that our users will be familiar with its functionality. Customers are expected to use the app daily or casually, while providers are expected to use daily. Their will be a special class of provider that has admin capabilites, who can add providers as they must meet external qualifications before being registered.

### 2.4 Assumptions and Dependencies
We will be using Java, with our program being dependent on Spring & SpringBoot, and RestAPI to connect to external APIs and developed with VS Code. We expect to use extern calendar API for tracking workouts during the week.

## 3. Requirements


### 3.1 Functional Requirements \
  * FR#1: The system shall allow providers to create and publish workout plans.
    + The system shalll allow providers to specify details for each plan, including level of experience and fitness goal.
  * FR#2: The system shall allow providers to manage their workout plans. 
    + The system shall allow providers to update, edit, or remove workout plans any time.
  * FR#3: The system shall allow display user progress metrics, such as completed workouts, exercise performance, and consistency. 
  * FR #4: The system shall allow the provider to respond to reviews. 
  * FR#: The system shall allow customers to browse a list of workout plans.
    + The list of workouts shall have a search and filter option, by level of experience and/or goal.
  * FR#: The system shall allow customers to subscribe to any workout plan.
    + A customer may unscribe at any time.
  * FR#:The system shall allow the customer to rate the workout based on overall plan, individual exercises of that plan, and difficulty.
    + The customer can also leave a review with their rating.


#### 3.1.1 User interfaces
1. User Protal 
  * Browse, search, and filter workout plans 
  * Subscribe/unsubscribe to workout plans 
  * Rate and review workout plans 
  * Track personal progress and achievements
2. Provider Portal 
  * Create, edit, and publish workout plans 
  * Manage existing workout plans (update, delete)
  * View user subscription and cancellations
  * View user ratings, review, and progress data. 

Web pages using HTML, CSS, and Java.

#### 3.1.2 Hardware interfaces
The system shall support multiple device types, including desktops/laptops, mobile devices, and tablets, with potential future integration for fitness trackers like smartwatches. 

#### 3.1.3 Software interfaces
  * Java jdk 21
  * SpringBoot 3.4.5 
  * PostgreSQL 17 


### 3.2 Non Functional Requirements 

#### 3.2.1 Performance
  * NFR0: A user shall be able to subscribe to a workout plan and acess their first workout is less than 5 minutes.
  * NFR1: Updating progress shall reflect in the user dashboard within 10 second. 
  * NFR2: Searching or filtering workout plans shall return results within 5 seconds. 

#### 3.2.2 Security
  * The system shall be available only to authorized users using valid username and password. 

#### 3.2.3 Reliability
* User data, including subscriptions, progress, and reviews shall remain accurate and consistent at all times.

#### 3.2.4 Availability
NFR#: SpartaFitness will be available 24/7. Scheduled Maintenance should be initialized during scheduled low activity hours such as midnight to minimize conflict with users using the app.
#### 3.2.5 Compliance
NFR#: We will comply to the best of our ability to User data protections to the extent of which the law requires.
NFR#: As well as to accessiblity standards for online navigations.

#### 3.2.6 Cost
NFR#: We expect to spend zero dollars on this project.

#### 3.2.7 Deadline
NFR#: The final product must be delivered by December 2025.
