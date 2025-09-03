<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!-- 상단 헤더 (배경 이미지 적용) -->
<div class="text-white text-center sticky-top" style="z-index: 1031; background: url('${ctp}/css/sky1.jpg') no-repeat center center; background-size: cover; height: 150px;">
  <div class="d-flex align-items-center justify-content-center h-100">
    <h1 class="text-shadow">o2chaso</h1>
  </div>
</div>