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
| Name | Date    | Reason For Changes  | Version   |
| ---- | ------- | ------------------- | --------- |
|      |         |                     |           |
| Elisha | 9/16/25 | Initial SRS       | 1.0       |
|      |         |                     |           |

## 1. Introduction

### 1.1 Document Purpose
Describe the purpose of the SRS and its intended audience.

### 1.2 Product Scope
Identify the product whose software requirements are specified in this document, including the revision or release number. Explain what the product that is covered by this SRS will do, particularly if this SRS describes only part of the system or a single subsystem. 
Provide a short description of the software being specified and its purpose, including relevant benefits, objectives, and goals. Relate the software to corporate goals or business strategies. If a separate vision and scope document is available, refer to it rather than duplicating its contents here.

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
List any other documents or Web addresses to which this SRS refers. These may include user interface style guides, contracts, standards, system requirements specifications, use case documents, or a vision and scope document. Provide enough information so that the reader could access a copy of each reference, including title, author, version number, date, and source or location.

### 1.5 Document Overview
Describe what the rest of the document contains and how it is organized.

## 2. Product Overview
This section should describe the general factors that affect the product and its requirements. This section does not state specific requirements. Instead, it provides a background for those requirements, which are defined in detail in Section 3, and makes them easier to understand.

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

### 3.1 Functional Requirements 
* FR#: The system shall allow customers to browse a list of workout plans.
  + The list of workouts shall have a search and filter option, by level of experience and/or goal.
* FR#: The system shall allow customers to subscribe to any workout plan.
  + A customer may unscribe at any time.
* FR#:The system shall allow the customer to rate the workout based on overall plan, individual exercises of that plan, and difficulty.
  + The customer can also leave a review with their rating.

#### 3.1.1 User interfaces
Define the software components for which a user interface is needed. Describe the logical characteristics of each interface between the software product and the users. This may include sample screen images, any GUI standards or product family style guides that are to be followed, screen layout constraints, standard buttons and functions (e.g., help) that will appear on every screen, keyboard shortcuts, error message display standards, and so on. Details of the user interface design should be documented in a separate user interface specification.

Could be further divided into Usability and Convenience requirements.

#### 3.1.2 Hardware interfaces
Describe the logical and physical characteristics of each interface between the software product and the hardware components of the system. This may include the supported device types, the nature of the data and control interactions between the software and the hardware, and communication protocols to be used.

#### 3.1.3 Software interfaces
Describe the connections between this product and other specific software components (name and version), including databases, operating systems, tools, libraries, and integrated commercial components. Identify the data items or messages coming into the system and going out and describe the purpose of each. Describe the services needed and the nature of communications. Refer to documents that describe detailed application programming interface protocols. Identify data that will be shared across software components. If the data sharing mechanism must be implemented in a specific way (for example, use of a global data area in a multitasking operating system), specify this as an implementation constraint.

### 3.2 Non Functional Requirements 

#### 3.2.1 Performance
If there are performance requirements for the product under various circumstances, state them here and explain their rationale, to help the developers understand the intent and make suitable design choices. Specify the timing relationships for real time systems. Make such requirements as specific as possible. You may need to state performance requirements for individual functional requirements or features.

#### 3.2.2 Security
Specify any requirements regarding security or privacy issues surrounding use of the product or protection of the data used or created by the product. Define any user identity authentication requirements. Refer to any external policies or regulations containing security issues that affect the product. Define any security or privacy certifications that must be satisfied.

#### 3.2.3 Reliability
Specify the factors required to establish the required reliability of the software system at time of delivery.

#### 3.2.4 Availability
NFR#: SpartaFitness will be available 24/7. Scheduled Maintenance should be initialized during scheduled low activity hours such as midnight to minimize conflict with users using the app.
#### 3.2.5 Compliance
NFR#: We will comply to the best of our ability to User data protections to the extent of which the law requires.
NFR#: As well as to accessiblity standards for online navigations.

#### 3.2.6 Cost
NFR#: We expect to spend zero dollars on this project.

#### 3.2.7 Deadline
NFR#: The final product must be delivered by December 2025.
