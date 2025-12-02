package com.example.studentmanagement.config;

import com.example.studentmanagement.entity.User;
import com.example.studentmanagement.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.*;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserRepository userRepo) {
        return username -> {
            User user = userRepo.findByUsername(username)
                    .orElseThrow(() -> new UsernameNotFoundException("User not found"));

            String role = user.getRole(); // "ADMIN" or "USER"
            return org.springframework.security.core.userdetails.User
                    .withUsername(user.getUsername())
                    .password(user.getPassword())
                    .roles(role) // <-- this was the bug (now fixed)
                    .build();
        };
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
    .requestMatchers("/", "/login", "/register", "/home", "/h2-console/**").permitAll()
    .requestMatchers("/dashboard", "/students", "/students/**").hasRole("ADMIN")
    .anyRequest().authenticated()
)
           .formLogin(form -> form
    .loginPage("/login")
    .successHandler((request, response, authentication) -> {
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
        if (isAdmin) {
            response.sendRedirect("/dashboard");
        } else {
            response.sendRedirect("/home");
        }
    })
    .permitAll()
)
            .logout(logout -> logout
                .logoutSuccessUrl("/login?logout")
                .permitAll()
            )
            .csrf(csrf -> csrf.disable())
            .headers(headers -> headers.frameOptions(frame -> frame.disable()));

        return http.build();
    }

    // Auto-create admin on first start
    @Bean
    CommandLineRunner initAdmin(UserRepository repo, BCryptPasswordEncoder encoder) {
        return args -> {
            if (repo.findByUsername("admin").isEmpty()) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword(encoder.encode("admin"));
                admin.setRole("ADMIN");
                repo.save(admin);
            }
        };
    }
}