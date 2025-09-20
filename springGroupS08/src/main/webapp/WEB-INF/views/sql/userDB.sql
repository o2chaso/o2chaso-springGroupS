SHOW TABLES;
CREATE TABLE userDB (
	idx     		  BIGINT AUTO_INCREMENT PRIMARY KEY, 	-- 유저 고유 ID(BIGINT: 8Byte)
	mid    			  VARCHAR(50)  NOT NULL UNIQUE,       -- 로그인 ID
	password      VARCHAR(255) NOT NULL,             	-- 비밀번호(암호화 저장)
	email         VARCHAR(100) NOT NULL UNIQUE,      	-- 이메일
	name          VARCHAR(50)  NOT NULL,              -- 이름
	nickname      VARCHAR(50),                       	-- 닉네임
	birth_date    DATE,                              	-- 생년월일
	gender        ENUM('M','F','O') DEFAULT 'O',     	-- 성별 (M:남 F:여 O:기타)
	phone_number  VARCHAR(20),                       	-- 전화번호
	address       VARCHAR(255),                      	-- 주소
	reg_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,-- 가입일
	mod_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 레코드가 수정될 때마다 자동으로 갱신되는 날짜
	              ON UPDATE CURRENT_TIMESTAMP,       	
	status        TINYINT DEFAULT 1                  	-- 상태 (1=활성, 0=비활성, 나중에 -1=영구정지 같은 값도 가능)
);
UPDATE userDB SET status = 1 WHERE idx = 0;					-- 절대 비활성화 되지 않도록 하기위한 설정(admin / 1234)
ALTER TABLE userDB ADD COLUMN profileImage VARCHAR(255) null;
ALTER TABLE userDB ADD COLUMN delete_request_date DATETIME NULL COMMENT 'DB 이벤트 스케줄러를 사용하기 위한 컬럼 생성';
ALTER TABLE userDB CHANGE birthDate birth_date DATE;

CREATE EVENT IF NOT EXISTS ev_delete_user 
ON SCHEDULE EVERY 1 DAY 
STARTS CURRENT_TIMESTAMP
DO 
	DELETE FROM userDB
	WHERE status = 0
	  AND delete_request_data IS NOT NULL
		AND delete_request_data <= NOW() - INTERVAL 7 DAY;
-- 1. 컨트롤러 → requestUserDelete(idx) 실행 → DB에 delete_request_data = NOW() 저장
-- 2. MySQL 이벤트 스케쥴러가 매일 돌면서(EVERY 1 DAY) status 확인 → status가 0이면 delete_request_data가 7일 지난 유저를 자동 삭제


CREATE TABLE roles (
  roleId 			INT AUTO_INCREMENT PRIMARY KEY COMMENT '권한 고유 ID',
  roleName 		VARCHAR(50) UNIQUE NOT NULL 	 COMMENT 'ROLE_USER, ROLE_ADMIN 등',
  description VARCHAR(100)									 COMMENT '권한 설명'
) COMMENT = '시스템에서 사용 가능한 권한(Role) 정의';

CREATE TABLE userRoles (
	userId BIGINT NOT NULL 				COMMENT '유저 ID (userDB.idx 참조)',
	roleId INT	  NOT NULL 				COMMENT '권한 ID (roles.roleId 참조)',
	PRIMARY KEY(userId, roleId), 	-- '복합 PK: 같은 유저에게 동일 권한 중복 부여 방지'
	--	유저 삭제 시 연결된 권한 매핑도 자동 삭제 (고아 레코드 방지)
	FOREIGN KEY(userId) REFERENCES userDB(idx) ON DELETE CASCADE,
	--	권한 삭제 시 해당 권한을 가진 모든 매핑도 자동 삭제 (무결성 유지)
	FOREIGN KEY(roleId) REFERENCES roles(roleId) ON DELETE CASCADE
	-- REFERENCES = “이 컬럼은 다른 테이블 값과 반드시 연결돼야 한다.”
	-- ON DELETE CASCADE = “그 연결된 원본이 지워지면, 나도 같이 지워진다.”
) COMMENT = '유저와 권한을 연결하는 매핑 테이블 (1명의 유저 → 여러 권한 가능)';

INSERT INTO roles (roleName, description) VALUES
	('ROLE_ADMIN',			'시스템 운영자(최고 권한)'),
	('ROLE_MANAGER',		'시스템 매니저 (홈페이지/내부 관리자)'),
	('ROLE_SUB_MANAGER','서브 매니저(관리자 권한 일부 위임)'),
	('ROLE_HR',					'HR 최고 권한(인사/급여 전반 권한 부여 및 회수 가능'),
	('ROLE_HR_MANAGER',	'HR 실무자 권한 (권한 부여 요청 및 회수 담당)'),
	('ROLE_PAYROLL',      '급여 담당자 (Payroll / C&B 담당)'),
	('ROLE_FINANCE',      '재무 담당자 (Financial Planning & Analysis)'),
	('ROLE_ACCOUNTING',   '회계 담당자 (Accounting)'),
	('ROLE_USER',         '일반 사용자 (기본 가입자)');

SELECT u.idx, u.mid, r.roleName FROM userDB u
JOIN userRoles ur ON u.idx = ur.userId
JOIN roles r			ON ur.roleId = r.roleId
ORDER BY u.idx;
--	admin / 1234 (프로젝트 공통)
INSERT INTO userRoles (userId, roleId) VALUES (0, 1); -- ROLE_ADMIN
INSERT INTO userRoles (userId, roleId) VALUES (0, 9); -- ROLE_USER / USER 이상 사용 가능을 전제로 설계 시 필요
--	o2chaso / 1234(My)
INSERT INTO userRoles (userId, roleId) VALUES (9, 2); 
INSERT INTO userRoles (userId, roleId) VALUES (9, 9); 

DELETE FROM userRoles WHERE userId = 1 AND roleId = 2;

DESC userDB;
SHOW VARIABLES LIKE 'event%';
SET GLOBAL event_scheduler = ON;
SELECT mid, profileImage FROM userDB;
SELECT * FROM userDB;
SELECT * FROM roles;
SELECT * FROM userRoles;