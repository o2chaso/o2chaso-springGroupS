<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="${ctp}/resources/css/nav.css?ver=<%=System.currentTimeMillis()%>"/>
  <link rel="stylesheet" 
  	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css?ver=<%=System.currentTimeMillis()%>">
  <link rel="stylesheet" href="${ctp}/resources/css/dropdown.css?ver=<%=System.currentTimeMillis()%>"/>
  <title>관리자 전용</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<a href="${ctp}/">Home</a>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>