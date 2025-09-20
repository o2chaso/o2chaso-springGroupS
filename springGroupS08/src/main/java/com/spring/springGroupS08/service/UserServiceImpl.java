package com.spring.springGroupS08.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.springGroupS08.dao.UserDAO;
import com.spring.springGroupS08.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired UserDAO userDAO;
	@Autowired BCryptPasswordEncoder encoder;
	
	@Override
	public List<Map<String, Object>> gettestList() {return userDAO.gettestList();}
	@Override
	public List<String> getUserRolse(int idx) {return userDAO.getUserRolse(idx);}
	@Override
	public UserVO getMidCheck(String mid) {return  userDAO.getMidCheck(mid);}
	@Override
	public UserVO getNickNameCheck(String nickname) {return userDAO.getNickNameCheck(nickname);}
	@Override
	public UserVO getlogin(String mid, String password) {return userDAO.getlogin(mid, password);}
	@Override
	public UserVO getEmailCheck(String email) {return userDAO.getEmailCheck(email);}
	@Override
	public UserVO getprofile(String mid) {return userDAO.getprofile(mid);}
	@Override
	public UserVO getLoginUser(String mid) {return userDAO.getLoginUser(mid);}
	@Override
	public int updateProfileImage(UserVO loginUser) {return userDAO.updateProfileImage(loginUser);}
	@Override
	public void requestUserDelete(int idx) {userDAO.requestUserDelete(idx);}


	
	
	
	
	// 관심사 분리 연습
	@Transactional
	@Override
	public int setUserJoin(UserVO vo) {
		int res = userDAO.setUserJoin(vo);
		if(res > 0) userDAO.insertUserRole(vo.getIdx(), 9);
		return res;
	}
	@Override
	public String updateProfile(UserVO vo, HttpSession session) {
		// 닉네임 중복체크 (본인 제외)
		// userDAO.getNickNameCheck(vo.getNickname()) : DB에서 vo에 입력된 닉네임이 이미 존재하는지 검색
		// 모르겠으면 외워라 : “DAO야, vo 안에 들어있는 닉네임 값을 넘길 테니까, DB에서 이 닉네임을 가진 UserVO가 있는지 찾아와.”
		UserVO nickCheck = userDAO.getNickNameCheck(vo.getNickname());
		// nickCheck != null : DB에 같은 닉네임 가진 사용자가 있다면
    // && nickCheck.getIdx() != vo.getIdx() : 근데 그 사용자가 지금 로그인한 본인(idx)이 아니면 (즉, 다른 사람이 쓰고 있는 닉네임이면)
		if(nickCheck != null && nickCheck.getIdx() != vo.getIdx()) return "redirect:/message/nicknameCheckError";
		UserVO emailCheck = userDAO.getEmailCheck(vo.getEmail());
		if(emailCheck != null && emailCheck.getIdx() != vo.getIdx()) return "redirect:/message/emailCheckError";
		// DB 업데이트 실행
		int res = userDAO.updateProfile(vo);
		if(res == 0) return "redirect:/message/profileUpdateError";
		// 세션 갱신 : 방금 수정된 최신 사용자 정보를 다시 세션에 넣어줌 (화면에서도 변경 즉시 반영되도록)
		session.setAttribute("sLoginUser", userDAO.getprofileIdx(vo.getIdx()));
		
		return "redirect:/message/profileUpdateOk";
	}
	
} 
