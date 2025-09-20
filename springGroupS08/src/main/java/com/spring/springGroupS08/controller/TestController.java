package com.spring.springGroupS08.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS08.service.UserService;

@Controller
@RequestMapping("/test")
public class TestController {
	@Autowired UserService service;
	
	
	@GetMapping("/testList")
	public String testListGet(Model model) {
		List<Map<String, Object>> userList = service.gettestList();
		model.addAttribute("userList", userList);
		return "test/testList";
	}
}
