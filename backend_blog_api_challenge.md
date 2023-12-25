# Simple Blog REST API Challenge

## Description

The objective of this challenge is to create a simple blog REST API that allows users to register, log in, create posts, and manage their own posts.

## Core Functionalities

- **User Registration**: An endpoint to register new users. User schema should include fields for email, password, and name.
- **User Login**: An endpoint for users to authenticate and log in.
- **Create Post**: An endpoint for users to create a new blog post. Post schema should contain title and content.
- **List All Posts**: An endpoint to list all the blog posts.
- **Edit User Posts**: An endpoint to edit a post, but only if it belongs to the logged-in user.
- **Delete User Posts**: An endpoint to delete a post, restricted to posts created by the logged-in user.

## Technical Requirements

- **Framework**: Utilize [Express](https://expressjs.com) or a similar framework for server routing.
- **Password Encryption**: Implement password encryption for user authentication.
- **Data Validation**: Ensure proper validation for user inputs in all endpoints.
- **Database**: Use either [PostgreSQL](https://www.postgresql.org) or [MongoDB](https://www.mongodb.com) for data storage.
- **Documentation**: Provide a README file with clear installation steps.

## Additional Notes

- The user schema should contain fields for email, password, and name.
- The post schema should include fields for title and content.

## Evaluation Criteria

- **Functionality**: The API should meet all the listed functionalities.
- **Code Readability**: Clear, well-structured, and maintainable code.
- **Git Practices**: Use descriptive and organized Git commit messages.
- **Code Linting**: Adherence to standard coding conventions and best practices.

## Bonus Points

- **Swagger Documentation**: Add Swagger documentation for the API.
- **Deployment**: Deploy the API to a cloud service (e.g., AWS, Heroku, Azure).
- **Dockerization**: Containerize the application using Docker.

## Submission

Submit your project as a GitHub repository link. Ensure the README file includes comprehensive setup instructions, an overview of the project, and any other relevant information.

This challenge is designed to test your skills in building RESTful APIs, implementing user authentication, managing database operations, and adhering to best practices in software development. We look forward to seeing your innovative solution and your approach to building a functional and secure blog API. Good luck!
