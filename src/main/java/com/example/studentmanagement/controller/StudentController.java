package com.example.studentmanagement.controller;

import com.example.studentmanagement.entity.Student;
import com.example.studentmanagement.entity.User;
import com.example.studentmanagement.repository.StudentRepository;
import com.example.studentmanagement.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class StudentController {

    @Autowired private StudentRepository studentRepo;
    @Autowired private UserRepository userRepo;
    @Autowired private BCryptPasswordEncoder encoder;

    @GetMapping({"/", "/login"})
    public String login() {
        return "login";
    }

    // ADMIN DASHBOARD
    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {
        model.addAttribute("count", studentRepo.count());
        return "dashboard";
    }

    // USER DASHBOARD (normal students)
    @GetMapping("/home")
    public String userHome() {
        return "home";
    }

    @GetMapping("/students")
    public String listStudents(Model model) {
        model.addAttribute("students", studentRepo.findAll());
        return "students";
    }

    // ==================== ADMIN ONLY ====================
    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/students/new")
    public String createForm(Model model) {
        model.addAttribute("student", new Student());
        return "create_student";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/students")
    public String saveStudent(Student student) {
        studentRepo.save(student);
        return "redirect:/students";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/students/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        model.addAttribute("student", studentRepo.findById(id).orElse(null));
        return "edit_student";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/students/{id}")
    public String updateStudent(@PathVariable Long id, Student student) {
        student.setId(id);
        studentRepo.save(student);
        return "redirect:/students";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Long id) {
        studentRepo.deleteById(id);
        return "redirect:/students";
    }

    // ==================== REGISTRATION (everyone) ====================
    @GetMapping("/register")
    public String registerForm() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           Model model) {
        if (userRepo.findByUsername(username).isPresent()) {
            model.addAttribute("error", "Username already taken");
            return "register";
        }
        User u = new User();
        u.setUsername(username);
        u.setPassword(encoder.encode(password));
        u.setRole("USER");
        userRepo.save(u);
        return "redirect:/login?registered";
    }
}