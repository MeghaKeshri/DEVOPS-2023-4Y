# Student Details Entry System

A simple Spring Boot web application to manage student records with secure login, registration, and role-based access.

---

## 🔑 Features
- User registration and login (with BCrypt password encryption)
- Role-based access control:
  - **ADMIN** – Full student CRUD (Create, Read, Update, Delete)
  - **USER** – View-only access
- Dashboards:
  - Admin Dashboard (`/dashboard`)
  - User Home (`/home`)
- Student management pages:
  - List students
  - Add student
  - Edit student
  - Delete student

---

## 🧭 Use Case Behaviour
- Users register → login → redirected based on role:
  - **ADMIN** → Admin Dashboard
  - **USER** → User Home
- Common actions:
  - View all students: `/students`
- Admin-only actions:
  - Create student: `/students/new`
  - Save student: `POST /students`
  - Edit student: `/students/edit/{id}`
  - Delete student: `/students/delete/{id}`

---

## 🖼️ UI Overview
- Simple Thymeleaf pages:
  - Login page
  - Register page
  - Admin Dashboard
  - User Home
  - Students List
  - Create & Edit Student Forms

---

## 🛠️ Tools & Technologies
- **Spring Boot**
- **Spring MVC**
- **Spring Security**
- **Spring Data JPA / Hibernate**
- **Thymeleaf**
- ** H2 Database**
- **Maven**

> ☁️ *Previously deployed using AWS Academy Learner Lab (now expired).*


## Screenshots of Swagger API
<img width="1497" height="785" alt="Screenshot 2025-12-04 at 7 50 00 PM" src="https://github.com/user-attachments/assets/9b0546ec-0a3a-43a7-85d5-ab0d9de3bd68" />
<img width="1506" height="790" alt="Screenshot 2025-12-04 at 7 50 06 PM" src="https://github.com/user-attachments/assets/a74a80ea-5083-426e-90b4-22a3ed17171b" />
<img width="1477" height="349" alt="Screenshot 2025-12-04 at 7 50 13 PM" src="https://github.com/user-attachments/assets/6201d5c9-5e68-41c3-909f-8325f2ae1701" />



---

## 🚀 How to Run Locally
```bash
mvn spring-boot:run
