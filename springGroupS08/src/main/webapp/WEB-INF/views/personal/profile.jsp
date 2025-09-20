<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/resources/css/profile.css?ver=<%=System.currentTimeMillis()%>"/>
	<title>profile.jsp</title>
	<script>
		'use strict'
		function profileImageSubmit() {
			const fileInput = document.getElementById("fileInput");
			const img = document.getElementById("profileImage");
			if(fileInput.files && fileInput.files[0]) {
				let reader = new FileReader();
				reader.onload = e => {
					img.src = e.target.result;	//	미리보기
					document.getElementById("profileForm").submit();
				}
				reader.readAsDataURL(fileInput.files[0]);
			}
		}
		
		//	회원탈퇴
		function userDelete() {
			let ans = confirm("회원을 탈퇴하시겠습니까? 탈퇴 시 7일간 회원님의 정보를 보관합니다.");
		}
	</script>
</head>
<body>
<h2 style="text-align:center; margin:20px 0;">내 프로필</h2>
<div class="profile-container">
  <div class="profile-card">
    <!-- 프로필 이미지 -->
    <div class="profile-avatar">
      <img id="profileImage" src="${empty vo.profileImage ? ctp.concat('/resources/img/profile/default.png') : ctp.concat(vo.profileImage)}" alt="프로필 이미지">
      <div class="avatar-overlay" onclick="document.getElementById('fileInput').click();">
        <span class="edit-icon">&#9998;</span> <!-- 연필 아이콘 -->
      </div>
      <form id="profileForm" action="${ctp}/personal/profileImage" method="post" enctype="multipart/form-data" style="display:none;">
        <input type="file" id="fileInput" name="profileImage" accept="image/*" onchange="profileImageSubmit()">
      </form>
    </div>

    <!-- 프로필 기본 정보 -->
    <div class="profile-info">
      <h3 class="nickname">${vo.nickname != null ? vo.nickname : vo.name}</h3>
      <p class="email">${vo.email}</p>
      <p class="address">${vo.address}</p>
    </div>

    <!-- 상세 정보 -->
    <div class="profile-details">
      <table>
        <tr><th>아이디</th><td>${vo.mid}</td></tr>
        <tr><th>이름</th><td>${vo.name}</td></tr>
        <tr><th>닉네임</th><td>${vo.nickname}</td></tr>
        <tr><th>이메일</th><td>${vo.email}</td></tr>
        <tr><th>주소</th><td>${vo.address}</td></tr>
      </table>
    </div>

    <!-- 버튼 -->
    <div class="profile-actions">
      <a href="${ctp}/personal/profileUpdate" class="btn btn-primary">정보 수정</a>
      <a href="${ctp}/" class="btn btn-secondary">메인으로</a>
    </div>
  </div>
</div>
</body>
</html>