package com.spring.springGroupS08.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS08.service.UserService;
import com.spring.springGroupS08.vo.UserVO;

@Controller
@RequestMapping("/personal")
public class UserController {
  @Autowired UserService userService;
  @Autowired BCryptPasswordEncoder passwordEncoder;

  // 회원가입
  @GetMapping("/join")
  public String joinGet() { return "personal/join"; }
  @PostMapping("/join")
  public String joinPost(UserVO vo, HttpServletRequest request) {
  	// 아이디 중복체크
    if(userService.getMidCheck(vo.getMid()) != null) return "redirect:/message/midCheckError";
    // 닉네임 중복체크
    if(vo.getNickname() != null && !vo.getNickname().isEmpty() &&
            userService.getNickNameCheck(vo.getNickname()) != null) return "redirect:/message/nicknameCheckError";
    // 비밀번호 확인
    String confirm = request.getParameter("passwordConfirm");
    if(confirm == null || !confirm.equals(vo.getPassword())) return "redirect:/message/passwordMismatch";
    // 이메일 중복체크
    if(userService.getEmailCheck(vo.getEmail()) != null) return "redirect:/message/emailCheckError";
    // 주소입력 체크
    if(vo.getAddress() == null || vo.getAddress().trim().isEmpty()) return "redirect:/message/addressCheckError";
    
    // 비밀번호 암호화
    vo.setPassword(passwordEncoder.encode(vo.getPassword()));
    // 상태값 기본 1(활성)
    if(vo.getStatus() == null) vo.setStatus(1);
    int res = userService.setUserJoin(vo);
    if(res == 0) return "redirect:/message/joinError";
    return "redirect:/message/joinOk";
  }
  
  // 로그인
  @GetMapping("/login")
  public String loginGet() { return "personal/login"; }
  @PostMapping("/login")
  public String loginPost(Model model, HttpSession session,
                          @RequestParam("mid") String mid,
                          @RequestParam("password") String password) {
    UserVO user = userService.getLoginUser(mid); // 비밀번호 없는 UserVO 가져오기
    
    if(user == null) return "redirect:/message/LoginError";
    else if(user.getStatus() == 0) return "redirect:/message/LoginLock";
    boolean loginOk = false;
    if("admin".equals(mid)) {
    	if (password.equals(user.getPassword())) {
    		loginOk = true;
			}
    }
    // 비밀번호 확인
    else {
    	if(passwordEncoder.matches(password, user.getPassword())) {
    		loginOk = true;
    	}
    }
    if(!loginOk) {
    	return "redirect:/message/LoginError";
    }
    // 세션 저장
    session.setAttribute("sLoginUser", user);
    session.setAttribute("sMid", mid);
    List<String> roles = userService.getUserRolse(user.getIdx()); // 권한 가져오기
    session.setAttribute("sRoles", roles);
    return "redirect:/";
  }

  // 로그아웃
  @GetMapping("/logout")
  public String logoutGet(HttpSession session, HttpServletRequest request) {
  	request.getSession().invalidate();
    return "redirect:/";
  }

  // 프로필 조회
  @GetMapping("/profile")
  public String profileGet(Model model, HttpSession session) {
    UserVO loginUser = (UserVO)session.getAttribute("sLoginUser");
    if(loginUser == null) return "redirect:/personal/login";
    model.addAttribute("vo", userService.getprofile(loginUser.getMid()));
    return "personal/profile";
  }
  // 프로필 업데이트
  @GetMapping("/profileUpdate")
  public String profileUpdateGet(Model model, HttpSession session) {
  	UserVO loginUser = (UserVO) session.getAttribute("sLoginUser");
  	if(loginUser == null) return "redirect:/personal/login";
  	model.addAttribute("vo", userService.getprofile(loginUser.getMid()));
  	return "personal/profileUpdate";
  }
  @PostMapping("/profileUpdate")
  public String profileUpdatePost(UserVO vo, HttpSession session) {
  	UserVO loginUser = (UserVO) session.getAttribute("sLoginUser");
  	if(loginUser == null) return "redirect:/personal/login";
  	// 본인 계정만 수정되도록 로그인 된 본인 idx 세팅
  	vo.setIdx(loginUser.getIdx());
  	// 나머지 로직(중복체크, DB update, 세션 갱신)은 전부 Service에서 처리(관심사 분리연습)
  	return userService.updateProfile(vo, session);
  }

  // 프로필 이미지 업로드
  @PostMapping("/profileImage")
  public String profileImagePost(@RequestParam("profileImage") MultipartFile file,
                                 HttpSession session) throws IllegalStateException, IOException {
    UserVO loginUser = (UserVO)session.getAttribute("sLoginUser");
    if(loginUser == null) return "personal/login";

    if(!file.isEmpty()) {
      String realPath = session.getServletContext().getRealPath("/resources/img/profile");
      File dir = new File(realPath);
      if(!dir.exists()) dir.mkdirs();

      String oFileName = file.getOriginalFilename();
      String sFileName = oFileName.substring(oFileName.lastIndexOf("."));
      String nFileName = loginUser.getMid() + sFileName;

      File dest = new File(realPath, nFileName);
      file.transferTo(dest);

      loginUser.setProfileImage("/resources/img/profile/" + nFileName);
      int res = userService.updateProfileImage(loginUser);
      if(res == 0) return "redirect:/message/profileUpdateError";

      session.setAttribute("sLoginUser", loginUser);
    }
    return "redirect:/personal/profile";
  }

  // 탈퇴 안내 페이지
  @GetMapping("/userDelete")
  public String UserDeleteGet() {
    return "personal/userDelete";
  }

  // 탈퇴 처리
  @ResponseBody
  @PostMapping("/userDelete")
  public String userDeletePost(@RequestParam("password") String password, HttpSession session) {
    UserVO loginUser = (UserVO)session.getAttribute("sLoginUser");
    if(loginUser == null) return "fail";

    UserVO userData = userService.getLoginUser(loginUser.getMid());
    if(userData != null && passwordEncoder.matches(password, userData.getPassword())) {
        userService.requestUserDelete(userData.getIdx());
        session.invalidate();
        return "success";
    }
    return "fail";
  }
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
