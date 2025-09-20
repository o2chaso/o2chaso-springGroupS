<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/resources/css/login.css?ver=<%=System.currentTimeMillis()%>"/>
	<title>로그인</title>
</head>

<body>
  <header class="nav-fixed">
    <jsp:include page="/WEB-INF/views/include/nav.jsp" />
  </header>

  <!-- 본문: 네비 높이만큼 띄우고, 가운데 정렬 컨테이너 -->
  <main class="page">
    <div class="login-wrap">
      <div class="login-html">
        <label for="tab-1" class="tab">로그인</label>
        <form class="login-form" method="post">
          <div class="group">
            <label for="user" class="label">Name</label>
            <input id="user" name="mid" type="text" class="input" required>
          </div>
          <div class="group">
            <label for="pass" class="label">Password</label>
            <input id="pass" name="password" type="password" class="input" data-type="password" required>
          </div>
          <div class="group inline">
            <input id="check" type="checkbox" class="check" checked>
            <label for="check"><span class="icon"></span> Keep me Signed in</label>
          </div>
          <div class="group">
		      	<button type="submit" class="button">login In</button>
          </div>
          <div class="hr"></div>
          <div class="foot-lnk">
            <a href="${ctp}/personal/join">회원가입</a><br/>
            <a href="#">아이디 / 비밀번호 찾기</a>
          </div>
        </form>
      </div>
    </div>
  </main>

</body>
</html>