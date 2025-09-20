package com.spring.springGroupS08.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.spring.springGroupS08.vo.UserVO;

public interface UserService {
	

	int setUserJoin(UserVO vo);
	UserVO getlogin(String mid, String password);
	UserVO getMidCheck(String mid);
	UserVO getNickNameCheck(String nickname);
	UserVO getEmailCheck(String email);
	UserVO getLoginUser(String mid);
	UserVO getprofile(String mid);												// 프로필 조회
	String updateProfile(UserVO vo, HttpSession session); // 프로필 수정
	int updateProfileImage(UserVO loginUser);
	void requestUserDelete(int idx);
	List<Map<String, Object>> gettestList();
	List<String> getUserRolse(int idx);
}
