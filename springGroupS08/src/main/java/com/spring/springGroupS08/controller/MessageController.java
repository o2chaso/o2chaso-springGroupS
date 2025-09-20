package com.spring.springGroupS08.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	@RequestMapping(value = "message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, HttpSession session,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx
			) {
		if(msgFlag.equals("joinOk")) {
			model.addAttribute("message", mid + "님 환영합니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("joinError")) {
			model.addAttribute("message", "회원가입 실패, 관리자에게 문의해주세요.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("midCheckError")) {
			model.addAttribute("message", "아이디를 다시 한번 확인해 주세요.");
			model.addAttribute("url", "/personal/join");
		}
		else if(msgFlag.equals("nicknameCheckError")) {
			model.addAttribute("message", "닉네임을 다시 한번 확인해 주세요.");
			model.addAttribute("url", "/personal/join");
		}
		else if(msgFlag.equals("passwordMismatch")) {
			model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "/personal/join");
		}
		else if(msgFlag.equals("emailCheckError")) {
			model.addAttribute("message", "이미 사용중인 이메일입니다.");
			model.addAttribute("url", "/personal/join");
		}
		else if(msgFlag.equals("addressCheckError")) {
			model.addAttribute("message", "주소를 입력해주세요.");
			model.addAttribute("url", "/personal/join");
		}
		else if(msgFlag.equals("profileUpdateError")) {
			model.addAttribute("message", "Profile Update Error(DB).");
			model.addAttribute("url", "/personal/profile");
		}
		else if(msgFlag.equals("profileUpdateOk")) {
			model.addAttribute("message", "프로필이 수정되었습니다.");
			model.addAttribute("url", "/personal/profile");
		}
		else if(msgFlag.equals("LoginError")) {
			model.addAttribute("message", "아이디 혹은 비밀번호를 확인하세요.");
			model.addAttribute("url", "/personal/login");
		}
		else if(msgFlag.equals("LoginLock")) {
			model.addAttribute("message", "탈퇴 진행중인 회원입니다. 고객센터를 이용해주세요");
			model.addAttribute("url", "/personal/login");
		}
		
		
		
		
		return "include/message";
	}
}
