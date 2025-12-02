package com.example.studentmanagement;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StudentManagementApplication {

    public static void main(String[] args) {
        // This line makes data save permanently
        System.setProperty("spring.jpa.hibernate.ddl-auto", "update");
        
        SpringApplication.run(StudentManagementApplication.class, args);
    }
}