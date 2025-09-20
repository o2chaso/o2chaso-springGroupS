<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fnc" uri="http://example.com/functions" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="${ctp}/resources/css/nav.css?ver=<%=System.currentTimeMillis()%>"/>
  <link rel="stylesheet" 
  	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css?ver=<%=System.currentTimeMillis()%>">
  <%-- <link rel="stylesheet" href="${ctp}/resources/css/nav.css"/> --%>
  <link rel="stylesheet" href="${ctp}/resources/css/dropdown.css?ver=<%=System.currentTimeMillis()%>"/>
  <title>nav.jsp</title>
</head>
<body>
	<header class="my-nav border-bottom bg-white">
		<nav class="nav">
		  <div class="nav__wrap">
			  <!-- 왼쪽: 로고 + 메뉴 -->
			  <div class="nav__left">
			    <a class="nav__brand" href="http://192.168.50.69:9090/springGroupS08/" style="text-decoration: none;">회사명</a>
			    <div class="nav__links">
			      <a class="nav__link" href="${ctp}/">Home</a>
			      <a class="nav__link" href="#">Menu</a>
			      <a class="nav__link" href="#">Category</a>
			      <a class="nav__link" href="${ctp}/test/testList">TEST LIST</a>
			    </div>
			  </div>
			
			  <!-- 가운데: 검색 -->
			  <div class="nav__center">
				  <form class="nav__search" method="get">
				    <input class="nav__input" name="q" placeholder="Search" />
				    <button type="submit" class="nav__btn">
				      <i class="fa fa-search"></i>
				    </button>
				  </form>
				</div>
			
			  <!-- 오른쪽: 로그인/회원가입 or 드롭다운 -->
			  <div class="nav__right">
			    <c:if test="${empty sessionScope.sLoginUser}">
			      <div class="nav__auth">
			        <a class="nav__link" href="${ctp}/personal/login">Login</a>
			        <a class="nav__link" href="${ctp}/personal/join">Sign up</a>
			      </div>
			    </c:if>
				  
			    <c:if test="${!empty sessionScope.sLoginUser}"> 
			    	<!-- 권한 뱃지 -->
				    <c:if test="${not empty sRoles}">
				      <c:set var="roleName" value="${fnc:getTopRoleName(sRoles)}" />
				      <span class="role-badge ${roleName}">${roleName}</span>
				    </c:if>
				    <!-- 드롭다운 -->
			      <div class="nav__dropdown">
			        <button class="nav__dropbtn">${sLoginUser.nickname} ▼</button>
			        <div class="nav__dropdown-content">
			          <a href="${ctp}/personal/profile">내 프로필</a>
			          <c:if test="${fn:contains(sRoles, 'ROLE_ADMIN')}">
				          <a href="${ctp}/personal/admin/adminMenu"
				           style="font-weight: bold;">관리자 메뉴</a>
			          </c:if>
			          <a href="${ctp}/personal/profile">#</a>
			          <a href="${ctp}/personal/profile">#</a>
			          <a href="${ctp}/personal/profile">#</a>
			          <a href="${ctp}/personal/logout">로그아웃</a>
			          <a href="${ctp}/personal/userDelete" style="color: red;">회원 탈퇴</a>
			        </div>
			      </div>
			    </c:if>
			    
			  </div>
			</div>
		</nav>
	</header>
</body>
</html>