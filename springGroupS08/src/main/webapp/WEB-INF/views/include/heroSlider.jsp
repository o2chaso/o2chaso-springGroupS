<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<c:set var="offset" value="${empty param.offset ? 0 : param.offset}" />
<c:set var="interval" value="${empty param.interval ? 2000 : param.interval}" />

<!-- 전면 배너 슬라이더 (PX 레이아웃, 부트스트랩 비의존) -->
<section id="hero-slider" class="hero-slider" data-interval="${interval}" style="--header-offset:${offset}px">
  <div class="hero-track">
    <div class="slide" style="background-image:url('${ctp}/resources/img/home1.png')"></div>
    <div class="slide" style="background-image:url('${ctp}/resources/img/home2.png')"></div>
    <div class="slide" style="background-image:url('${ctp}/resources/img/Lara.jpg')"></div>
  </div>
</section>
<!-- 
화면 세로 1080px (FHD 모니터) → 80vh = 864px → 864 - 100 = 764px
👉 슬라이드 크기 = 가로 1920px × 세로 764px

화면 세로 1440px (QHD 모니터) → 80vh = 1152px → 1152 - 100 = 1052px
👉 슬라이드 크기 = 가로 2560px × 세로 1052px

화면 세로 2160px (4K 모니터) → 80vh = 1728px → 1728 - 100 = 1628px
👉 슬라이드 크기 = 가로 3840px × 세로 1628px
 -->
<style>
/* ===== Slider Base ===== */
#hero-slider{px
  width:100%;
  height:calc(80vh - var(--header-offset, 0px));
  position:relative;
  overflow:hidden;
  background:#000; /* 로딩 전 백업색 */
}
#hero-slider .hero-track{
  position:absolute; top:0; left:0;
  height:100%;
  will-change:transform;
  transition:transform .6s ease;
}
#hero-slider .slide{
  position:absolute; top:0;
  width:100%; height:100%;
  background-size:cover;      /* 이미지 작아도 꽉 채움 */
  background-position:center; /* 가운데 기준 */
  background-repeat:no-repeat;
  user-select:none;
  -webkit-user-drag:none;
}
</style>

<script>
(() => {
  const root  = document.getElementById('hero-slider');
  if (!root) return;

  const track  = root.querySelector('.hero-track');
  const slides = Array.from(root.querySelectorAll('.slide'));
  const N = slides.length;
  if (N <= 1) return;

  const interval = Number(root.dataset.interval || 2000);
  let idx = 0;
  let W = 0, H = 0;
  let timer = null;

  function layout() {
    // 컨테이너 실측
    W = root.clientWidth;
    H = root.clientHeight;

    // 각 슬라이드를 가로로 절대 위치 배치 (px 기준)
    slides.forEach((s, i) => {
      s.style.left   = (i * W) + 'px';
      s.style.width  = W + 'px';
      s.style.height = H + 'px';
    });

    // 트랙 총폭
    track.style.width = (N * W) + 'px';

    // 현재 위치 재적용(리사이즈 시 튐 방지)
    const old = track.style.transition;
    track.style.transition = 'none';
    go(idx);
    requestAnimationFrame(() => { track.style.transition = old || 'transform .6s ease'; });
  }

  function go(i) {
    track.style.transform = 'translateX(' + (-i * W) + 'px)';
  }

  function start() {
    stop();
    timer = setInterval(() => {
      idx = (idx + 1) % N;
      go(idx);
    }, interval);
  }
  function stop() { if (timer) { clearInterval(timer); timer = null; } }

  // 초기화
  window.addEventListener('load', layout);
  window.addEventListener('resize', layout);
  document.addEventListener('visibilitychange', () => (document.hidden ? stop() : start()));

  layout();
  start();
})();
</script>