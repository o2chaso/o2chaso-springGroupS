package com.spring.springGroupS08.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS08.service.UserService;

@Controller
@RequestMapping("/personal/admin")
public class AdminController {
	@Autowired UserService userService;
	
	@GetMapping("/adminMenu")
	public String adminMenuGet() {
		return "personal/admin/adminMenu";
	}
}
