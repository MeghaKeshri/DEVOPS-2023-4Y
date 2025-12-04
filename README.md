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
- **MySQL / H2 Database**
- **Maven**

> ☁️ *Previously deployed using AWS Academy Learner Lab (now expired).*

---

## 🚀 How to Run Locally
```bash
mvn spring-boot:run
