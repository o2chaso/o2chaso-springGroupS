<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/resources/css/join.css?v=20250913">
	<title>회원가입</title>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		'use strict';
		const regMid = /^[a-zA-Z0-9_]{4,20}$/;
		const regNick = /^[가-힣0-9a-zA-Z_]+$/;
		const regName = /^[가-힣]+$/;
		const regEmail=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
		function fCheck() {
			const id 		= document.getElementById('mid').value.trim();
			const pw 		= document.getElementById('password').value.trim();
			const pw2 	= document.getElementById('password2').value.trim();
			const email = document.getElementById('email').value.trim();
			const name 	= document.getElementById('name').value.trim();
			const nick 	= document.getElementById('nickname').value.trim();
			
			if(!regMid.test(id)){ alert('아이디 형식이 틀렸습니다.(4~20자 영/숫자/밑줄)'); return false; }
		  if(pw.length < 8){ alert('비밀번호 8자 이상으로 작성해주세요'); return false; }
		  if(pw !== pw2){ alert('비밀번호가 일치하지 않습니다.'); return false; }
		  if(!regEmail.test(email)){ alert('이메일 형식을 확인해 주세요'); return false; }
		  if(!regName.test(name)){ alert('이름은 한글로 작성할 수 있습니다.'); return false; }
		  if(nick && !regNick.test(nick)){ alert('닉네임 형식을 확인해주세요'); return false; }
		  
		  const parts = [
		    document.getElementById('postcode').value.trim(),
		    document.getElementById('address').value.trim(),
		    document.getElementById('detailAddress').value.trim(),
		    document.getElementById('extraAddress').value.trim()
		  ].filter(Boolean); // 비어있으면 제외
		  document.getElementById('fullAddress').value = parts.join(' / ');
		  
		  return true;
		}
		function execDaumPostcode() {
    	new daum.Postcode({
      	oncomplete: function(data) {
	      	addresshide(data);
	        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
1	        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	        var addr = ''; // 주소 변수
	        var extraAddr = ''; // 참고항목 변수
	        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	            addr = data.roadAddress;
	        } 
	        else {
	        	// 사용자가 지번 주소를 선택했을 경우(J)
	        	addr = data.jibunAddress;
	        }
	        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	        if(data.userSelectedType === 'R'){
		        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		        	extraAddr += data.bname;
		        }
		        // 건물명이 있고, 공동주택일 경우 추가한다.
		        if(data.buildingName !== '' && data.apartment === 'Y'){
		        	extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		        }
		        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		        if(extraAddr !== ''){
		        	extraAddr = ' (' + extraAddr + ')';
		        }
		        // 조합된 참고항목을 해당 필드에 넣는다.
		        document.getElementById("extraAddress").value = extraAddr;
        	}
	        else {
	        	document.getElementById("extraAddress").value = '';
	        }
         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('postcode').value = data.zonecode;
         document.getElementById("address").value = addr;
         // 커서를 상세주소 필드로 이동한다.
         document.getElementById("detailAddress").focus();
      	}
    	}).open();
	  }
		function addresshide(data) {
		  const postcodeEl = document.getElementById("postcode");
		  const addressEl  = document.getElementById("address");
		  const detailEl   = document.getElementById("detailAddress");
		  const extraEl    = document.getElementById("extraAddress");
			// 공통: 우편번호
			postcodeEl.value = data.zonecode || "";
		  // userSelectedType : 카카오 API 조건 키
		  if (data.userSelectedType === 'R') {
		    // 도로명
		    addressEl.value = data.roadAddress || "";
		    // 참고항목 구성(있을 때만 보이기)
		    let extra = "";
		    if (data.bname && /[동|로|가]$/.test(data.bname)) extra += data.bname;
		    if (data.buildingName && data.apartment === 'Y') extra += (extra ? ", " : "") + data.buildingName;
		    extraEl.value = extra;
		    extraEl.style.display = extra ? "block" : "none";
		    // 참고주소는 사용자가 입력해야 하므로 항상 보여줌(도로명일 때)
		    detailEl.value = "";
		    detailEl.style.display = "block";
		    detailEl.focus();
		  } 
		  else {
		    // 지번
		    addressEl.value = data.jibunAddress || "";
		    // 상세주소 숨김
		    extraEl.value = "";
		    extraEl.style.display = "none";
		  }
		  // 주소 영역 열기
		  document.getElementById("addresshide").style.display = "block";
		}
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="sign-up-htm">
		<label for="tab-1" class="tab">회원가입</label>
	  <form name="myform" action="${ctp}/personal/join" method="post" onsubmit="return fCheck()">
	  	<c:if test="${not empty _csrf}">
	  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  	</c:if>
	  
	    <div class="group">
	      <label for="mid" class="label">User ID</label>
	      <input id="mid" name="mid" type="text" class="input" required>
	      <div id="idMsg" class="form-msg"></div>
	    </div>
	    
	    <div class="group">
	      <label for="password" class="label">Password</label>
	      <input id="password" name="password" type="password" class="input" required>
	    </div>
	    
	    <div class="group">
	      <label for="password2" class="label">Repeat Password</label>
	      <input name="passwordConfirm" id="password2" type="password" class="input" required>
	    </div>
	    
	    <div class="group">
	      <label for="email" class="label">Email Address</label>
	      <input id="email" name="email" type="email" class="input" required>
	    </div>
	    
	    <div class="group">
	      <label for="name" class="label">Name</label>
	      <input id="name" name="name" type="text" class="input" required>
	    </div>
	    
	    <div class="group">
	      <label for="nickname" class="label">Nickname</label>
	      <input id="nickname" name="nickname" type="text" class="input" required>
	      <div id="nickMsg" class="form-msg"></div>
	    </div>
	    
	    <div class="group">
	      <label for="birthDate" class="label">Birth Date</label>
	      <input id="birthDate" name="birthDate" type="date" class="input" required>
	    </div>
	    
	    <div class="group">
	      <label class="label">Gender</label>
	      <select name="gender" class="input">
	        <option value="M">남자</option>
	        <option value="F">여자</option>
	        <option value="O" selected>기타</option>
	      </select>
	    </div>
	    
	    <div class="group">
			  <label for="address" class="label">Address</label>
			  <div style="display: flex; gap: 8px; margin-bottom: 10px;">
			  	<!-- 버튼 크기 조절 : style="flex:0 0 60%;" -->	
			    <input type="text" name="postcode" id="postcode" class="input" placeholder="우편번호" style="flex:0 0 70%;" required>
			    <input type="button" onclick="execDaumPostcode()" class="button" value="우편번호 찾기" style="flex:1;">
			  </div>
			  <!-- 우편번호 입력 시 Show -->
				<div id="addresshide" style="display:none; margin-top:10px;">
				  <input type="text" name="addr1" 		 id="address"			  class="input" placeholder="주소"    style="margin-top:10px;">
				  <input type="text" name="addrExtra"  id="extraAddress"  class="input" placeholder="상세주소" style="margin-top:10px; display:none;">
				  <input type="text" name="addrDetail" id="detailAddress" class="input" placeholder="참고항목" style="margin-top:10px;">
				</div>
				<!-- 최종 서버로 보낼 hidden -->
				<input type="hidden" id="fullAddress" name="address">
			</div>
				    
	    <div class="group">
	    	<button type="submit" class="button">Sign Up</button>
	    </div>
	  </form>
	  <div class="hr"></div>
	</div>
</body>
</html>