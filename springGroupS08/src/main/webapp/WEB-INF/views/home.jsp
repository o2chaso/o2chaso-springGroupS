<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<link rel="stylesheet" href="${ctp}/resources/css/card.css?ver=<%=System.currentTimeMillis()%>"/>
	<title>Home</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/heroSlider.jsp">
		<jsp:param name="offset" value="100"/>
	  <jsp:param name="interval" value="2000"/>
	</jsp:include>
	
	<!-- https://se-se.tistory.com/19 -->
	<section id="cardType" class="card__wrap nexon section">	<!-- 폰트 편하게 설정하기 위해 클래스 지정 -->
		<h2 style="text-align: center; font-size: 15em;" >About Us</h2>
		<p style="text-align: center; font-size: 100px;">회사소개</p>
		<div class="card__inner container">
			<!-- 카드 추가 시 복사 -->
			<article class="card">	<!-- 카드 영역을 표시하기 위해 article태스 사용 -->
				<figure class="card__header">	<!-- fiture 태그 사용하여 image 삽입. 이미지 삽입 시 정확한 경로가 중요 ! -->
					<img src="${ctp}/resources/img/home/01_Mouse_press_0904.png" alt="#">	<!-- alt는 이미지가 나오지 않았을 때 나오는 설명 -->
				</figure>
				<div class="card__body">
          <h3 class="tit">News</h3>
          <p class="desc">소개글</p>
          <a class="btn" href="/">더 자세히 보기</a>  <!-- 더 자세히 보기를 클릭했을 때 링크가 연결되어야 하므로 button태그가 아닌 a태그 사용 -->
        </div>
			</article>
			<!-- 카드 추가 시 복사 -->
			<article class="card">	
				<figure class="card__header">	
					<img src="${ctp}/resources/img/home/ambassador_2.png" alt="#">	
				</figure>
				<div class="card__body">
          <h3 class="tit">News</h3>
          <p class="desc">소개글</p>
          <a class="btn" href="/">더 자세히 보기</a> 
        </div>
			</article>
			<article class="card">	
				<figure class="card__header">	
					<img src="${ctp}/resources/img/home/sp_ma_01.png" alt="#">	
				</figure>
				<div class="card__body">
          <h3 class="tit">News</h3>
          <p class="desc">한국 최대급 VTuber 프로덕션 'StelLive'와 경영 통합</p>
          <a class="btn" href="https://stellive.me">・StelLive 공식 사이트：https://stellive.me</a> 
        </div>
			</article>
		</div>
		
	</section>
</body>
</html>
