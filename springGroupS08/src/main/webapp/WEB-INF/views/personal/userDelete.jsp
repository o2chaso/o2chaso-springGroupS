<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<link rel="stylesheet" href="${ctp}/resources/css/userDelete.css"/>
	<title>회원탈퇴 서비스 안내</title>
	<script>
		'use strict'
		function openPasswordModal() {
	    if (!document.getElementById("agreeCheck").checked) {
	      alert("안내 사항에 동의해야 진행할 수 있습니다.");
	      return;
	    }
	    document.getElementById("passwordModal").classList.add("active");
	  }
	  function closePasswordModal() {
	    document.getElementById("passwordModal").classList.remove("active");
	  }
	  function userDelete() {
	    const pw = document.getElementById("confirmPassword").value.trim();
	    if (pw === "") {
	      alert("비밀번호를 입력해주세요.");
	      return;
	    }
	    $.ajax({
    	  type : 'post',
    	  url  : '${ctp}/personal/userDelete',
    	  data : { password : pw },
    	  success: function(res) {
    	    if(res === "success") {
    	      alert("탈퇴 요청이 접수되었습니다. 7일 후 완전히 삭제됩니다.");
    	      location.href = "${ctp}/";
    	    } else {
    	      alert("비밀번호가 일치하지 않습니다.");
    	    }
    	  },
    	  error: function() {
    	    alert("전송오류!!");
    	  }
    	});
	  }
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<!-- 회원탈퇴 안내 및 불이익 안내 -->
	<div class="delete-box">
		<h2>회원 탈퇴 안내</h2>
		<p style="text-align: center;" >
			${userVO.name} 회원님의 탈퇴 요청은 즉시 반영되며, <b><font color="red">7일</font> 후 완전 삭제</b>됩니다.<br>
			이 기간 동안 발생하는 문제나 불만, 건의사항은 반드시 처리해주시길 바랍니다.<br>
			탈퇴 후 회원님께서 보유하신 포인트는 모두 회수 처리될 예정이오니<br>
			환불정책에 따라주시길 바랍니다.<br>
			7일 이후에는 모든 정보가 삭제되어 복구가 불가능하며, 그에 따른 책임은 본인에게 있습니다.
		</p>
		<div class="agree-box">
			<input type="checkbox" id="agreeCheck">
			<label for="agreeCheck">안내 사항을 모두 확인하였으며, 이에 동의합니다.</label>
			<br>
			<button type="button" class="btn btn-danger" onclick="openPasswordModal()">확인</button>
			<a href="${ctp}/" class="btn btn-secondary ">취소</a>
		</div>
	</div>
	<!-- 모달 -->
	<div id="passwordModal" class="modal">
	  <div class="modal-content">
	    <div class="modal-header">비밀번호 확인</div>
	    <div class="modal-body">
	      <p>회원 탈퇴를 위해 비밀번호를 입력해주세요.</p>
	      <input type="password" name="password" id="confirmPassword" class="form-control" placeholder="비밀번호 입력">
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-secondary" onclick="closePasswordModal()">취소</button>
	      <button type="button" class="btn btn-danger" onclick="userDelete()">확인</button>
	    </div>
	  </div>
	</div>
	
</body>
</html>