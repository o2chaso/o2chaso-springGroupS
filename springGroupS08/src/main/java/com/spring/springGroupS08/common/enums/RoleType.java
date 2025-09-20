package com.spring.springGroupS08.common.enums;

import java.util.Comparator;
import java.util.List;

import lombok.Getter;

@Getter
public enum RoleType {
	ROLE_ADMIN("운영자", 1),
  ROLE_MANAGER("운영진", 2),
  ROLE_SUB_MANAGER("매니저", 3),
  ROLE_HR("인사과", 4),
  ROLE_HR_MANAGER("HR관리자", 5),
  ROLE_PAYROLL("급여담당자", 6),
  ROLE_FINANCE("재무담당자", 7),
  ROLE_ACCOUNTING("회계담당자", 8),
  ROLE_USER("일반회원", 99);
	
	// 필드
	private String displayName;
	private int priority;
	// Getter : displayName: 한글 권한명 리턴 / priority: 우선순위 리턴(낮을 수록 우선순위가 높음)
	// 생성자
	RoleType(String displayName, int priority) {
		this.displayName = displayName;
		this.priority = priority;
	}
	
	// ===== 기능 메서드 =====
	// 문자열 코드 → Enum 변환(없으면 null)
	public static RoleType fromCode(String code) {
		try {
			return RoleType.valueOf(code);
		} catch (IllegalArgumentException e) {
			return null;
		}
	}
	/*
	  다수 권한 중 가장 높은 권한의 한글명 리턴
	  @param roles : 권한 코드 리스트(예: ["ROLE_USER", "ROLE_MANAGER"])
	  @return		   : 한글 권한명(예: 운영진)
	  
	  1) null 또는 빈 리스트일 경우 → ""반환(로그인 안했을 시, 홈페이지 첫 접속 시)
	  2) String 권한 코드들을 RoleType Enum으로 변환
	  3) null 아닌 값만 필터링
    4) priority 기준으로 정렬
    5) 가장 우선순위 높은 권한을 찾고 → displayName으로 변환
    6) 없으면 "권한없음" 반환
	 */
	// 다중 권한 중 최고 권한 이름 리턴
	public static String getTopRoleName(List<String> roles) {
		// 로그인 안한 상태일 때의 처리(없으면 500 - 내부 서버 오류)
		if(roles == null || roles.isEmpty()) {
			return "";
		}
		return roles.stream()
						.map(RoleType::fromCode) // String 권한 코드들을 RoleType Enum으로 변환
						.filter(r -> r != null)  // 람다식 변환: RoleType → r = ROLE_USER → true / r = null → false
						// .sorted(스트림 요소 정렬)후 Comparator 값 넘김
						// .Comparator.comparingInt(...) 인트 값 하나 뽑아와서 그 값 기준으로 정렬 / ()안에는 어떤 int를 뽑을 건지를 함수로 전달.
						.sorted(Comparator.comparingInt(RoleType::getPriority)) 
						.findFirst() // Stream의 터미널 연산 중 하나. 정렬된 스트림에서 첫번째 요소만 꺼내서 돌려줌(다수의 권한 중 1개의 최고 권한을 넘기기에 필요)
						.map(RoleType::getDisplayName) // Optional 안에 들어있는 RoleType 객체를 꺼내서, 그걸 한글 이름(String)으로 변환해주는 단계.
						.orElse("권한없음");
	}
}
/*
  ▶ 목적:
  - 시스템의 권한(사용자에게 부여해주는 권한)코드를 한글 표시명과 우선순위로 매핑하기 위해 사용.
  - DB/시큐리티 프레임워크에서 읽어온 "권한 코드 문자열"을 Enum으로 변환 후,
    뷰(JSP)에서 "사용자가 이해할 수 있는 한글 권한명"을 표시할 수 있도록 지원.
  - 다수의 권한을 동시에 가질 수 있는 경우, "우선순위"를 기준으로 가장 높은 권한만 뽑아냄.
  
  ▶ Enum을 사용한 이유:
  - Enum(열거형): 미리 정해놓은 상수 집합을 하나의 타입으로 정의함.
  - Enum은 타입 안정성을 제공, 오타/없는 권한을 컴파일 시점에서 걸러낼 수 있고, 새 권한 추가 시 한줄만 작성하여 해결 가능(JSP/service 수정 불필요)
 */
