<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/5/w3.css">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>xmlMenu.jsp</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2>XML을 통한 값 주입연습</h2>
		<hr/>
		<div>
			<a href="xmlTest1" class="btn btn-success">성적자료주입</a>
			<a href="xmlTest2" class="btn btn-primary">성적자료계산</a>
			<a href="xmlTest3" class="btn btn-secondary">Site JDBC1 정보</a>
			<a href="xmlTest4" class="btn btn-info">Site JDBC2 정보</a>
		</div>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>