<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/resources/css/profile.css?ver=<%=System.currentTimeMillis()%>"/>
	<title>profileUpdate.jsp</title>
</head>
<body>
<h2 style="text-align:center; margin:20px 0;">프로필 수정</h2>

<div class="profile-container">
  <div class="profile-card">
    <div class="profile-avatar">
      <img id="profileImage" src="${empty vo.profileImage ? ctp.concat('/resources/img/profile/default.png') : ctp.concat(vo.profileImage)}" alt="프로필 이미지">
      <div class="avatar-overlay" onclick="document.getElementById('fileInput').click();">
        <span class="edit-icon">&#9998;</span> <!-- 연필 아이콘 -->
      </div>
      <form id="profileForm" action="${ctp}/personal/profileImage" method="post" enctype="multipart/form-data" style="display:none;">
        <input type="file" id="fileInput" name="profileImage" accept="image/*" onchange="profileImageSubmit()">
      </form>
    </div>
    <!-- 프로필 수정 폼 -->
    <form action="${ctp}/personal/profileUpdate" method="post" style="width:100%;">
      <!-- 상세 정보 -->
      <div class="profile-details">
        <table>
          <tr><th>아이디</th><td><input type="text" value="${vo.mid}" readonly class="input"/></td></tr>
          <tr><th>이름</th><td><input type="text" name="name" value="${vo.name}" class="input" required/></td></tr>
          <tr><th>닉네임</th><td><input type="text" name="nickname" value="${vo.nickname}" class="input"/></td></tr>
          <tr><th>이메일</th><td><input type="email" name="email" value="${vo.email}" class="input" required/></td></tr>
          <tr><th>주소</th><td><input type="text" name="address" value="${vo.address}" class="input"/></td></tr>
          <tr><th>전화번호</th><td><input type="text" name="phoneNumber" value="${vo.phoneNumber}" class="input"/></td></tr>
          <tr><th>생년월일</th><td><input type="date" name="birthDate" value="${vo.birthDate}" class="input"/></td></tr>
          <tr><th>성별</th>
            <td>
              <select name="gender" class="input">
                <option value="M" ${vo.gender eq 'M' ? 'selected' : ''}>남자</option>
                <option value="F" ${vo.gender eq 'F' ? 'selected' : ''}>여자</option>
                <option value="O" ${vo.gender eq 'O' ? 'selected' : ''}>기타</option>
              </select>
            </td>
          </tr>
        </table>
      </div>
      <!-- 버튼 -->
      <div class="profile-actions">
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="${ctp}/personal/profile" class="btn btn-secondary">취소</a>
      </div>
    </form>
  </div>
</div>
</body>
</html>