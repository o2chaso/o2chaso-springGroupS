<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Test List</title>
  <style>
	.user-table {
	  margin: 20px auto;       /* 테이블 자체를 가로 중앙 */
	  border-collapse: collapse;
	  text-align: center;      /* 셀 안 텍스트 가로 중앙 */
	}
	.user-table th, .user-table td {
	  padding: 8px 12px;
	  vertical-align: middle;  /* 셀 텍스트 세로 중앙 */
	}
	.title-center {
  	text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
  <h2 style="text-align:center;">회원 전체 목록 (권한 포함)</h2>
  <table border="1" class="user-table">
	  <tr>
	    <th>ID</th>
	    <th>아이디</th>
	    <th>이메일</th>
	    <th>이름</th>
	    <th>상태</th>
	    <th>권한</th>
	  </tr>
	  <c:forEach var="user" items="${userList}">
	    <tr>
	      <td>${user.idx}</td>
	      <td>${user.mid}</td>
	      <td>${user.email}</td>
	      <td>${user.name}</td>
	      <c:choose>
	      	<c:when test="${user.status == 1}">
	      		<td style="color: blue;">활동중</td>
	      	</c:when>
	      	<c:when test="${user.status == 0}">
	      		<td style="color: red;">탈퇴신청</td>
	      	</c:when>
	      	<c:otherwise>
	      		<td style="color: orange;">알 수 없음</td>
	      	</c:otherwise>
	      </c:choose>
	      <td>${user.roleName}</td>
	    </tr>
	  </c:forEach>
	</table>
</body>

</html>