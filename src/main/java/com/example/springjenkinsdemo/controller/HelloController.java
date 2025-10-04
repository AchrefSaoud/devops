package com.example.springjenkinsdemo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
        return "Hello World! Spring Boot application is running successfully!";
    }

    @GetMapping("/health")
    public String health() {
        return "Application is healthy!";
    }
}