# NestJS API Service Challenge

## Objective

Build a scalable and maintainable API service using NestJS, focusing on a comprehensive User management system and a health check endpoint.

## Task Description

### 1. NestJS Project Setup

- Initialize a new NestJS project.

### 2. User Endpoint Implementation

Develop a RESTful API for user management with the following functionalities:

- **User Registration**: Endpoint to register new users with details like name, email, and password.
- **User Login**: Endpoint for user authentication and token generation.
- **User Profile**: Endpoint to view and update user profile details (e.g., name, email).
- **Password Change**: Endpoint to allow users to change their password.
- Ensure proper data validation for each endpoint.

### 3. Database Integration

- Use a relational database (e.g., PostgreSQL) with TypeORM or Prisma.
- Implement a `User` model to manage user data.

### 4. Health Check Endpoint (`/healthz`)

- Implement a `/healthz` endpoint to monitor the health of the application, focusing on the database connection status.
- The endpoint should return a success response if the database is connected, and an error response if not.

### 5. Dockerization

- Containerize the application using Docker for easy setup and deployment.

## Evaluation Criteria

- **API Design and Implementation**: Effectiveness and usability of the user management API.
- **Code Quality**: Adherence to clean, efficient, and idiomatic NestJS practices.
- **Database Integration**: Correctness of database operations and data modeling.
- **Health Check**: Accurate and functional implementation of the health check endpoint.
- **Docker Setup**: Proper Docker configuration and setup.

## Deliverables

- A GitHub repository containing the NestJS project.
- A `README.md` file in the repository, documenting:
  - Setup and running instructions for the project.
  - Detailed descriptions of the API endpoints and their functionalities.

## Notes

- Focus on code quality, project structure, and adherence to NestJS best practices.
- Pay attention to security aspects, especially in user authentication and data handling.
- Document your code and setup procedures to ensure clarity and maintainability.
