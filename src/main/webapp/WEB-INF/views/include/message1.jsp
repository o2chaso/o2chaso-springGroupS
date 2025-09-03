<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- mid 유무에 따라 goUrl 생성 -->
<c:choose>
  <c:when test="${not empty mid}">
    <c:url value="${url}" var="goUrl">
      <c:param name="mid" value="${mid}" />
    </c:url>
  </c:when>
  <c:otherwise>
    <c:url value="${url}" var="goUrl" />
  </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <title>message.jsp</title>
  <!-- 1.3초 후 자동 이동 -->
  <meta http-equiv="refresh" content="1.3;url=${goUrl}" />
	<style>
		.msg-box {
		  max-width: 500px;
		  margin: 100px auto;
		  padding: 30px;
		  border: 1px solid #ddd;
		  border-radius: 8px;
		  text-align: center;
		  background-color: #f8f9fa;
		  box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		.msg-box h4 {
		  margin-bottom: 20px;
		}
	</style>
	<script>
		'use strict'
		
	</script>
</head>
<body>
	<div class="msg-box">
  <h4>${message}</h4>
  <a href="${goUrl}" class="btn btn-primary">즉시 이동</a>
	</div>
</body>
</html>