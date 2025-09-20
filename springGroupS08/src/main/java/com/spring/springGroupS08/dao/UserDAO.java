package com.spring.springGroupS08.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS08.vo.UserVO;

@Mapper
public interface UserDAO {
	UserVO getlogin(@Param("mid") String mid, @Param("password") String password);
	UserVO getMidCheck(@Param("mid") String mid);
	UserVO getNickNameCheck(@Param("nickname") String nickname);
	UserVO getEmailCheck(@Param("email") String email);
	UserVO getprofile(@Param("mid") String mid);
	UserVO getLoginUser(@Param("mid") String mid);
	UserVO getprofileIdx(@Param("idx") int idx);
	int updateProfile(@Param("vo") UserVO vo);
	int setUserJoin(@Param("vo") UserVO vo);
	int updateProfileImage(@Param("loginUser")UserVO loginUser);
	void requestUserDelete(@Param("idx") int idx);
	void insertUserRole(@Param("userId") int userId, @Param("roleId") int roleId);

	List<Map<String, Object>> gettestList();
	List<String> getUserRolse(@Param("userId") int userId);
}
