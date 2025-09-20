package com.spring.springGroupS08.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserVO {
	private int idx;                 // 유저 고유 ID
  private String mid;              // 로그인 ID
  private String password;         // 비밀번호 (암호화 저장)
  private String email;            // 이메일
  private String name;             // 이름
  private String nickname;         // 닉네임
  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
  private LocalDate birthDate;     // 생년월일
  private String gender;           // 성별 (M,F,O)
  private String phoneNumber;      // 전화번호
  private String address;          // 주소 (우편번호, 주소, 상세주소 포함)
  private LocalDateTime regDate;   // 가입일
  private LocalDateTime modDate;   // 수정일
  private Integer status;          // 상태 (1=활성, 0=비활성)
  
  private String profileImage;		 // 프로필 이미지
}
