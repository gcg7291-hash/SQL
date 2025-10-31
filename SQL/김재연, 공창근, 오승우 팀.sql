CREATE database health;

Use health;

CREATE TABLE user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    role ENUM('MEMBER', 'COACH', 'ADMIN') NOT NULL DEFAULT 'MEMBER',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50)
);
CREATE TABLE class_schedule (
    id BIGINT NOT NULL AUTO_INCREMENT,
    coach_id BIGINT NOT NULL,
    title VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50),
    PRIMARY KEY (id),
    CONSTRAINT fk_class_coach FOREIGN KEY (coach_id) REFERENCES user(id)
);
CREATE TABLE reservation (
    id BIGINT NOT NULL AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    class_id BIGINT NOT NULL,
    status ENUM('RESERVED','CANCELLED','ATTENDED') NOT NULL DEFAULT 'RESERVED',
    reserved_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cancelled_at DATETIME,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50),
    PRIMARY KEY (id),
    CONSTRAINT fk_reservation_member FOREIGN KEY (member_id) REFERENCES user(id),
    CONSTRAINT fk_reservation_class FOREIGN KEY (class_id) REFERENCES class_schedule(id),
    UNIQUE (member_id, class_id)
);
CREATE TABLE waitlist (
    id BIGINT NOT NULL AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    class_id BIGINT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50),
    PRIMARY KEY (id),
    CONSTRAINT fk_waitlist_member FOREIGN KEY (member_id) REFERENCES user(id),
    CONSTRAINT fk_waitlist_class FOREIGN KEY (class_id) REFERENCES class_schedule(id),
    UNIQUE (member_id, class_id)
);
CREATE TABLE payment (
    id BIGINT NOT NULL AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK(amount > 0),
    method ENUM('CARD','CASH','BANK') NOT NULL,
    paid_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PAID','REFUNDED') NOT NULL DEFAULT 'PAID',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50),
    PRIMARY KEY (id),
    CONSTRAINT fk_payment_member FOREIGN KEY (member_id) REFERENCES user(id)
);
CREATE TABLE membership (
    id BIGINT NOT NULL AUTO_INCREMENT,
    member_id BIGINT NOT NULL,
    type ENUM('COUNT','PERIOD') NOT NULL,
    remaining_count INT CHECK(remaining_count >= 0),
    expire_date DATE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (id),
    CONSTRAINT fk_membership_member FOREIGN KEY (member_id) REFERENCES user(id)
);
CREATE TABLE attendance (
    id BIGINT NOT NULL AUTO_INCREMENT,
    reservation_id BIGINT NOT NULL,
    attended_at DATETIME,
    status ENUM('ATTENDED','ABSENT','LATE') NOT NULL DEFAULT 'ABSENT',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by varchar(50),
    updated_by varchar(50),
    PRIMARY KEY (id),
    CONSTRAINT fk_attendance_reservation FOREIGN KEY (reservation_id) REFERENCES reservation(id)
);

show tables;

-- 1. user 테이블 데이터 (100명)
-- ADMIN 5명, COACH 15명, MEMBER 80명
INSERT INTO user (id, email, password, name, phone, role, created_by, updated_by) VALUES
(1, 'admin1@gym.com', '$2a$10$abcdefgh', '최고 관리자', '010-1111-0001', 'ADMIN', 'system', 'system'),
(2, 'admin2@gym.com', '$2a$10$abcdefgi', '재무 관리자', '010-1111-0002', 'ADMIN', 'system', 'system'),
(3, 'admin3@gym.com', '$2a$10$abcdefgj', '인사 관리자', '010-1111-0003', 'ADMIN', 'system', 'system'),
(4, 'admin4@gym.com', '$2a$10$abcdefgk', '마케팅 관리자', '010-1111-0004', 'ADMIN', 'system', 'system'),
(5, 'admin5@gym.com', '$2a$10$abcdefgl', 'IT 관리자', '010-1111-0005', 'ADMIN', 'system', 'system'),
-- COACH 15명 (ID: 6 ~ 20)
(6, 'coach_a@gym.com', '$2a$10$bcdefghm', '김 코치', '010-2222-0006', 'COACH', 'system', 'system'),
(7, 'coach_b@gym.com', '$2a$10$bcdefghn', '이 트레이너', '010-2222-0007', 'COACH', 'system', 'system'),
(8, 'coach_c@gym.com', '$2a$10$bcdefgho', '박 요가강사', '010-2222-0008', 'COACH', 'system', 'system'),
(9, 'coach_d@gym.com', '$2a$10$bcdefghp', '정 필라테스', '010-2222-0009', 'COACH', 'system', 'system'),
(10, 'coach_e@gym.com', '$2a$10$bcdefghq', '한 줌바강사', '010-2222-0010', 'COACH', 'system', 'system'),
(11, 'coach_f@gym.com', '$2a$10$bcdefghr', '최 퍼스널', '010-2222-0011', 'COACH', 'system', 'system'),
(12, 'coach_g@gym.com', '$2a$10$bcdefghs', '윤 그룹강사', '010-2222-0012', 'COACH', 'system', 'system'),
(13, 'coach_h@gym.com', '$2a$10$bcdefght', '조 웨이트', '010-2222-0013', 'COACH', 'system', 'system'),
(14, 'coach_i@gym.com', '$2a$10$bcdefghu', '서 크로스핏', '010-2222-0014', 'COACH', 'system', 'system'),
(15, 'coach_j@gym.com', '$2a$10$bcdefghv', '임 스트레칭', '010-2222-0015', 'COACH', 'system', 'system'),
(16, 'coach_k@gym.com', '$2a$10$bcdefghw', '오 달리기', '010-2222-0016', 'COACH', 'system', 'system'),
(17, 'coach_l@gym.com', '$2a$10$bcdefghx', '신 수영', '010-2222-0017', 'COACH', 'system', 'system'),
(18, 'coach_m@gym.com', '$2a$10$bcdefghy', '강 복싱', '010-2222-0018', 'COACH', 'system', 'system'),
(19, 'coach_n@gym.com', '$2a$10$bcdefghz', '문 사이클', '010-2222-0019', 'COACH', 'system', 'system'),
(20, 'coach_o@gym.com', '$2a$10$bcdefg01', '이 명상', '010-2222-0020', 'COACH', 'system', 'system'),
-- MEMBER 80명 (ID: 21 ~ 100)
(21, 'member_001@user.com', '$2a$10$cdefghij', '김민수', '010-3333-0021', 'MEMBER', 'system', 'system'),
(22, 'member_002@user.com', '$2a$10$cdefghik', '박은영', '010-3333-0022', 'MEMBER', 'system', 'system'),
(23, 'member_003@user.com', '$2a$10$cdefghil', '이준호', '010-3333-0023', 'MEMBER', 'system', 'system'),
(24, 'member_004@user.com', '$2a$10$cdefghim', '최수진', '010-3333-0024', 'MEMBER', 'system', 'system'),
(25, 'member_005@user.com', '$2a$10$cdefghin', '정재현', '010-3333-0025', 'MEMBER', 'system', 'system'),
(26, 'member_006@user.com', '$2a$10$cdefghio', '한지우', '010-3333-0026', 'MEMBER', 'system', 'system'),
(27, 'member_007@user.com', '$2a$10$cdefghip', '강현우', '010-3333-0027', 'MEMBER', 'system', 'system'),
(28, 'member_008@user.com', '$2a$10$cdefghiq', '윤채린', '010-3333-0028', 'MEMBER', 'system', 'system'),
(29, 'member_009@user.com', '$2a$10$cdefghir', '신민준', '010-3333-0029', 'MEMBER', 'system', 'system'),
(30, 'member_010@user.com', '$2a$10$cdefghis', '오예슬', '010-3333-0030', 'MEMBER', 'system', 'system'),
(31, 'member_011@user.com', '$2a$10$cdefghit', '고건우', '010-3333-0031', 'MEMBER', 'system', 'system'),
(32, 'member_012@user.com', '$2a$10$cdefghiu', '노서연', '010-3333-0032', 'MEMBER', 'system', 'system'),
(33, 'member_013@user.com', '$2a$10$cdefghiv', '류도윤', '010-3333-0033', 'MEMBER', 'system', 'system'),
(34, 'member_014@user.com', '$2a$10$cdefghiw', '문하윤', '010-3333-0034', 'MEMBER', 'system', 'system'),
(35, 'member_015@user.com', '$2a$10$cdefghix', '배지훈', '010-3333-0035', 'MEMBER', 'system', 'system'),
(36, 'member_016@user.com', '$2a$10$cdefghiy', '서지우', '010-3333-0036', 'MEMBER', 'system', 'system'),
(37, 'member_017@user.com', '$2a$10$cdefghiz', '손승현', '010-3333-0037', 'MEMBER', 'system', 'system'),
(38, 'member_018@user.com', '$2a$10$cdefghi0', '송예원', '010-3333-0038', 'MEMBER', 'system', 'system'),
(39, 'member_019@user.com', '$2a$10$cdefghi1', '양준혁', '010-3333-0039', 'MEMBER', 'system', 'system'),
(40, 'member_020@user.com', '$2a$10$cdefghi2', '염다은', '010-3333-0040', 'MEMBER', 'system', 'system'),
(41, 'member_021@user.com', '$2a$10$cdefghi3', '우성민', '010-3333-0041', 'MEMBER', 'system', 'system'),
(42, 'member_022@user.com', '$2a$10$cdefghi4', '유하늘', '010-3333-0042', 'MEMBER', 'system', 'system'),
(43, 'member_023@user.com', '$2a$10$cdefghi5', '장현서', '010-3333-0043', 'MEMBER', 'system', 'system'),
(44, 'member_024@user.com', '$2a$10$cdefghi6', '전가인', '010-3333-0044', 'MEMBER', 'system', 'system'),
(45, 'member_025@user.com', '$2a$10$cdefghi7', '조민우', '010-3333-0045', 'MEMBER', 'system', 'system'),
(46, 'member_026@user.com', '$2a$10$cdefghi8', '주은혜', '010-3333-0046', 'MEMBER', 'system', 'system'),
(47, 'member_027@user.com', '$2a$10$cdefghi9', '차동현', '010-3333-0047', 'MEMBER', 'system', 'system'),
(48, 'member_028@user.com', '$2a$10$cdefghia', '채수아', '010-3333-0048', 'MEMBER', 'system', 'system'),
(49, 'member_029@user.com', '$2a$10$cdefghib', '하태준', '010-3333-0049', 'MEMBER', 'system', 'system'),
(50, 'member_030@user.com', '$2a$10$cdefghic', '홍서진', '010-3333-0050', 'MEMBER', 'system', 'system'),
(51, 'member_031@user.com', '$2a$10$cdefghid', '권혁진', '010-3333-0051', 'MEMBER', 'system', 'system'),
(52, 'member_032@user.com', '$2a$10$cdefghie', '김나윤', '010-3333-0052', 'MEMBER', 'system', 'system'),
(53, 'member_033@user.com', '$2a$10$cdefghif', '나성호', '010-3333-0053', 'MEMBER', 'system', 'system'),
(54, 'member_034@user.com', '$2a$10$cdefghig', '도지원', '010-3333-0054', 'MEMBER', 'system', 'system'),
(55, 'member_035@user.com', '$2a$10$cdefghih', '라민경', '010-3333-0055', 'MEMBER', 'system', 'system'),
(56, 'member_036@user.com', '$2a$10$cdefghii', '마태희', '010-3333-0056', 'MEMBER', 'system', 'system'),
(57, 'member_037@user.com', '$2a$10$cdefghij', '배주은', '010-3333-0057', 'MEMBER', 'system', 'system'),
(58, 'member_038@user.com', '$2a$10$cdefghik', '송하준', '010-3333-0058', 'MEMBER', 'system', 'system'),
(59, 'member_039@user.com', '$2a$10$cdefghil', '안보람', '010-3333-0059', 'MEMBER', 'system', 'system'),
(60, 'member_040@user.com', '$2a$10$cdefghim', '엄재민', '010-3333-0060', 'MEMBER', 'system', 'system'),
(61, 'member_041@user.com', '$2a$10$cdefghin', '왕혜정', '010-3333-0061', 'MEMBER', 'system', 'system'),
(62, 'member_042@user.com', '$2a$10$cdefghio', '용우진', '010-3333-0062', 'MEMBER', 'system', 'system'),
(63, 'member_043@user.com', '$2a$10$cdefghip', '원서현', '010-3333-0063', 'MEMBER', 'system', 'system'),
(64, 'member_044@user.com', '$2a$10$cdefghiq', '위태영', '010-3333-0064', 'MEMBER', 'system', 'system'),
(65, 'member_045@user.com', '$2a$10$cdefghir', '유희선', '010-3333-0065', 'MEMBER', 'system', 'system'),
(66, 'member_046@user.com', '$2a$10$cdefghis', '이동건', '010-3333-0066', 'MEMBER', 'system', 'system'),
(67, 'member_047@user.com', '$2a$10$cdefghit', '이아름', '010-3333-0067', 'MEMBER', 'system', 'system'),
(68, 'member_048@user.com', '$2a$10$cdefghiu', '전준혁', '010-3333-0068', 'MEMBER', 'system', 'system'),
(69, 'member_049@user.com', '$2a$10$cdefghiv', '정서윤', '010-3333-0069', 'MEMBER', 'system', 'system'),
(70, 'member_050@user.com', '$2a$10$cdefghiw', '지영민', '010-3333-0070', 'MEMBER', 'system', 'system'),
(71, 'member_051@user.com', '$2a$10$cdefghix', '진수아', '010-3333-0071', 'MEMBER', 'system', 'system'),
(72, 'member_052@user.com', '$2a$10$cdefghiy', '천민서', '010-3333-0072', 'MEMBER', 'system', 'system'),
(73, 'member_053@user.com', '$2a$10$cdefghiz', '표재현', '010-3333-0073', 'MEMBER', 'system', 'system'),
(74, 'member_054@user.com', '$2a$10$cdefghi0', '하진우', '010-3333-0074', 'MEMBER', 'system', 'system'),
(75, 'member_055@user.com', '$2a$10$cdefghi1', '허예지', '010-3333-0075', 'MEMBER', 'system', 'system'),
(76, 'member_056@user.com', '$2a$10$cdefghi2', '현승민', '010-3333-0076', 'MEMBER', 'system', 'system'),
(77, 'member_057@user.com', '$2a$10$cdefghi3', '홍지수', '010-3333-0077', 'MEMBER', 'system', 'system'),
(78, 'member_058@user.com', '$2a$10$cdefghi4', '김준서', '010-3333-0078', 'MEMBER', 'system', 'system'),
(79, 'member_059@user.com', '$2a$10$cdefghi5', '박나래', '010-3333-0079', 'MEMBER', 'system', 'system'),
(80, 'member_060@user.com', '$2a$10$cdefghi6', '이도현', '010-3333-0080', 'MEMBER', 'system', 'system'),
(81, 'member_061@user.com', '$2a$10$cdefghi7', '최지민', '010-3333-0081', 'MEMBER', 'system', 'system'),
(82, 'member_062@user.com', '$2a$10$cdefghi8', '정민서', '010-3333-0082', 'MEMBER', 'system', 'system'),
(83, 'member_063@user.com', '$2a$10$cdefghi9', '한승우', '010-3333-0083', 'MEMBER', 'system', 'system'),
(84, 'member_064@user.com', '$2a$10$cdefghia', '강민지', '010-3333-0084', 'MEMBER', 'system', 'system'),
(85, 'member_065@user.com', '$2a$10$cdefghib', '윤도현', '010-3333-0085', 'MEMBER', 'system', 'system'),
(86, 'member_066@user.com', '$2a$10$cdefghic', '신예은', '010-3333-0086', 'MEMBER', 'system', 'system'),
(87, 'member_067@user.com', '$2a$10$cdefghid', '오준영', '010-3333-0087', 'MEMBER', 'system', 'system'),
(88, 'member_068@user.com', '$2a$10$cdefghie', '고은비', '010-3333-0088', 'MEMBER', 'system', 'system'),
(89, 'member_069@user.com', '$2a$10$cdefghif', '노성민', '010-3333-0089', 'MEMBER', 'system', 'system'),
(90, 'member_070@user.com', '$2a$10$cdefghig', '류다인', '010-3333-0090', 'MEMBER', 'system', 'system'),
(91, 'member_071@user.com', '$2a$10$cdefghih', '문지아', '010-3333-0091', 'MEMBER', 'system', 'system'),
(92, 'member_072@user.com', '$2a$10$cdefghii', '배태환', '010-3333-0092', 'MEMBER', 'system', 'system'),
(93, 'member_073@user.com', '$2a$10$cdefghij', '서준희', '010-3333-0093', 'MEMBER', 'system', 'system'),
(94, 'member_074@user.com', '$2a$10$cdefghik', '손유진', '010-3333-0094', 'MEMBER', 'system', 'system'),
(95, 'member_075@user.com', '$2a$10$cdefghil', '송민규', '010-3333-0095', 'MEMBER', 'system', 'system'),
(96, 'member_076@user.com', '$2a$10$cdefghim', '양서윤', '010-3333-0096', 'MEMBER', 'system', 'system'),
(97, 'member_077@user.com', '$2a$10$cdefghin', '염태웅', '010-3333-0097', 'MEMBER', 'system', 'system'),
(98, 'member_078@user.com', '$2a$10$cdefghio', '우지수', '010-3333-0098', 'MEMBER', 'system', 'system'),
(99, 'member_079@user.com', '$2a$10$cdefghip', '유승호', '010-3333-0099', 'MEMBER', 'system', 'system'),
(100, 'member_080@user.com', '$2a$10$cdefghiq', '장윤서', '010-3333-0100', 'MEMBER', 'system', 'system');

-- 2. class_schedule 데이터 (30개) - location 컬럼 제거됨
INSERT INTO class_schedule (id, coach_id, title, start_time, end_time, capacity, created_by, updated_by) VALUES
(1, 6, '파워 웨이트 트레이닝', '2025-10-27 19:00:00', '2025-10-27 20:00:00', 20, 'system', 'system'),
(2, 7, '기초 요가 (초급)', '2025-10-28 10:00:00', '2025-10-28 11:30:00', 15, 'system', 'system'),
(3, 8, '크로스핏 부트캠프', '2025-10-29 07:00:00', '2025-10-29 08:00:00', 10, 'system', 'system'),
(4, 9, '코어 필라테스', '2025-10-29 18:30:00', '2025-10-29 19:30:00', 25, 'system', 'system'),
(5, 10, '아침 줌바 댄스', '2025-10-30 08:30:00', '2025-10-30 09:30:00', 30, 'system', 'system'),
(6, 11, '전신 순환 운동', '2025-10-30 19:30:00', '2025-10-30 20:30:00', 20, 'system', 'system'),
(7, 12, '수영 강습 (초급)', '2025-10-31 11:00:00', '2025-10-31 12:00:00', 15, 'system', 'system'),
(8, 13, '복싱 다이어트', '2025-10-31 20:00:00', '2025-10-31 21:00:00', 10, 'system', 'system'),
(9, 14, '인터벌 달리기', '2025-11-01 06:30:00', '2025-11-01 07:30:00', 25, 'system', 'system'),
(10, 15, '릴렉스 명상', '2025-11-01 17:00:00', '2025-11-01 18:00:00', 30, 'system', 'system'),
(11, 16, '고강도 타바타', '2025-11-02 10:00:00', '2025-11-02 11:00:00', 20, 'system', 'system'),
(12, 17, '아쿠아로빅', '2025-11-02 14:00:00', '2025-11-02 15:00:00', 15, 'system', 'system'),
(13, 18, '바디 쉐이핑', '2025-11-03 19:00:00', '2025-11-03 20:30:00', 10, 'system', 'system'),
(14, 19, '스피닝 사이클', '2025-11-04 06:00:00', '2025-11-04 07:00:00', 25, 'system', 'system'),
(15, 20, '저녁 스트레칭', '2025-11-04 21:00:00', '2025-11-04 22:00:00', 30, 'system', 'system'),
(16, 6, '파워 웨이트 (중급)', '2025-11-05 19:00:00', '2025-11-05 20:00:00', 20, 'system', 'system'),
(17, 7, '심화 요가 (고급)', '2025-11-06 10:00:00', '2025-11-06 11:30:00', 15, 'system', 'system'),
(18, 8, '크로스핏 (중급)', '2025-11-07 07:00:00', '2025-11-07 08:00:00', 10, 'system', 'system'),
(19, 9, '임산부 필라테스', '2025-11-07 18:30:00', '2025-11-07 19:30:00', 25, 'system', 'system'),
(20, 10, '오후 줌바 댄스', '2025-11-08 14:30:00', '2025-11-08 15:30:00', 30, 'system', 'system'),
(21, 11, '하체 근력 집중', '2025-11-09 19:30:00', '2025-11-09 20:30:00', 20, 'system', 'system'),
(22, 12, '수영 강습 (자유형)', '2025-11-10 11:00:00', '2025-11-10 12:00:00', 15, 'system', 'system'),
(23, 13, '키즈 복싱', '2025-11-11 20:00:00', '2025-11-11 21:00:00', 10, 'system', 'system'),
(24, 14, '마라톤 훈련', '2025-11-12 06:30:00', '2025-11-12 07:30:00', 25, 'system', 'system'),
(25, 15, '깊은 수면 명상', '2025-11-12 17:00:00', '2025-11-12 18:00:00', 30, 'system', 'system'),
(26, 16, '점심 타바타', '2025-11-13 12:00:00', '2025-11-13 13:00:00', 20, 'system', 'system'),
(27, 17, '어르신 아쿠아', '2025-11-13 14:00:00', '2025-11-13 15:00:00', 15, 'system', 'system'),
(28, 18, '균형 잡기', '2025-11-14 19:00:00', '2025-11-14 20:30:00', 10, 'system', 'system'),
(29, 19, '고강도 스피닝', '2025-11-15 06:00:00', '2025-11-15 07:00:00', 25, 'system', 'system'),
(30, 20, '모닝 스트레칭', '2025-11-15 09:00:00', '2025-11-15 10:00:00', 30, 'system', 'system');

-- 3. reservation 데이터 (50개)
INSERT INTO reservation (id, member_id, class_id, status, reserved_at, created_by, updated_by) VALUES
(1, 21, 1, 'ATTENDED', '2025-10-26 10:00:00', 'member_001', 'system'), -- 지난 수업 (출석)
(2, 22, 1, 'ATTENDED', '2025-10-26 11:00:00', 'member_002', 'system'),
(3, 23, 2, 'ATTENDED', '2025-10-27 12:00:00', 'member_003', 'system'),
(4, 24, 2, 'ATTENDED', '2025-10-27 13:00:00', 'member_004', 'system'),
(5, 25, 3, 'RESERVED', '2025-10-28 14:00:00', 'member_005', 'system'), -- 오늘 수업 (예약됨)
(6, 26, 3, 'RESERVED', '2025-10-28 15:00:00', 'member_006', 'system'),
(7, 27, 4, 'RESERVED', '2025-10-28 16:00:00', 'member_007', 'system'), -- 오늘 수업 (예약됨)
(8, 28, 5, 'RESERVED', '2025-10-28 17:00:00', 'member_008', 'system'),
(9, 29, 6, 'RESERVED', '2025-10-28 18:00:00', 'member_009', 'system'),
(10, 30, 7, 'RESERVED', '2025-10-28 19:00:00', 'member_010', 'system'),
(11, 31, 8, 'RESERVED', '2025-10-28 20:00:00', 'member_011', 'system'),
(12, 32, 9, 'RESERVED', '2025-10-28 21:00:00', 'member_012', 'system'),
(13, 33, 10, 'RESERVED', '2025-10-29 09:00:00', 'member_013', 'system'),
(14, 34, 11, 'RESERVED', '2025-10-29 10:00:00', 'member_014', 'system'),
(15, 35, 12, 'RESERVED', '2025-10-29 11:00:00', 'member_015', 'system'),
(16, 36, 1, 'CANCELLED', '2025-10-26 12:00:00', 'member_016', 'system'), -- 취소된 예약
(17, 37, 2, 'CANCELLED', '2025-10-27 14:00:00', 'member_017', 'system'),
(18, 38, 5, 'RESERVED', '2025-10-29 12:00:00', 'member_018', 'system'),
(19, 39, 6, 'RESERVED', '2025-10-29 13:00:00', 'member_019', 'system'),
(20, 40, 7, 'RESERVED', '2025-10-29 14:00:00', 'member_020', 'system'),
(21, 41, 8, 'RESERVED', '2025-10-29 15:00:00', 'member_021', 'system'),
(22, 42, 9, 'RESERVED', '2025-10-29 16:00:00', 'member_022', 'system'),
(23, 43, 10, 'RESERVED', '2025-10-29 17:00:00', 'member_023', 'system'),
(24, 44, 11, 'RESERVED', '2025-10-29 18:00:00', 'member_024', 'system'),
(25, 45, 12, 'RESERVED', '2025-10-29 19:00:00', 'member_025', 'system'),
(26, 46, 13, 'RESERVED', '2025-10-29 20:00:00', 'member_026', 'system'),
(27, 47, 14, 'RESERVED', '2025-10-29 21:00:00', 'member_027', 'system'),
(28, 48, 15, 'RESERVED', '2025-10-29 22:00:00', 'member_028', 'system'),
(29, 49, 16, 'RESERVED', '2025-10-29 23:00:00', 'member_029', 'system'),
(30, 50, 17, 'RESERVED', '2025-10-30 08:00:00', 'member_030', 'system'),
(31, 51, 18, 'RESERVED', '2025-10-30 09:00:00', 'member_031', 'system'),
(32, 52, 19, 'RESERVED', '2025-10-30 10:00:00', 'member_032', 'system'),
(33, 53, 20, 'RESERVED', '2025-10-30 11:00:00', 'member_033', 'system'),
(34, 54, 21, 'RESERVED', '2025-10-30 12:00:00', 'member_034', 'system'),
(35, 55, 22, 'RESERVED', '2025-10-30 13:00:00', 'member_035', 'system'),
(36, 56, 23, 'RESERVED', '2025-10-30 14:00:00', 'member_036', 'system'),
(37, 57, 24, 'RESERVED', '2025-10-30 15:00:00', 'member_037', 'system'),
(38, 58, 25, 'RESERVED', '2025-10-30 16:00:00', 'member_038', 'system'),
(39, 59, 26, 'RESERVED', '2025-10-30 17:00:00', 'member_039', 'system'),
(40, 60, 27, 'RESERVED', '2025-10-30 18:00:00', 'member_040', 'system'),
(41, 61, 28, 'RESERVED', '2025-10-30 19:00:00', 'member_041', 'system'),
(42, 62, 29, 'RESERVED', '2025-10-30 20:00:00', 'member_042', 'system'),
(43, 63, 30, 'RESERVED', '2025-10-30 21:00:00', 'member_043', 'system'),
(44, 64, 1, 'ATTENDED', '2025-10-26 13:00:00', 'member_044', 'system'),
(45, 65, 2, 'ATTENDED', '2025-10-27 15:00:00', 'member_045', 'system'),
(46, 66, 3, 'RESERVED', '2025-10-28 18:00:00', 'member_046', 'system'),
(47, 67, 4, 'RESERVED', '2025-10-28 19:00:00', 'member_047', 'system'),
(48, 68, 5, 'RESERVED', '2025-10-28 20:00:00', 'member_048', 'system'),
(49, 69, 6, 'RESERVED', '2025-10-28 21:00:00', 'member_049', 'system'),
(50, 70, 7, 'RESERVED', '2025-10-28 22:00:00', 'member_050', 'system');


-- 4. waitlist 데이터 (10개)
-- 정원이 찬 인기 수업(ID 4)에 대기하는 멤버들 가정 (ID 27, 47번이 이미 예약했으므로 다른 멤버 사용)
INSERT INTO waitlist (id, member_id, class_id, created_at, created_by, updated_by) VALUES
(1, 71, 4, '2025-10-29 08:00:00', 'member_051', 'system'),
(2, 72, 4, '2025-10-29 08:10:00', 'member_052', 'system'),
(3, 73, 4, '2025-10-29 08:20:00', 'member_053', 'system'),
(4, 74, 4, '2025-10-29 08:30:00', 'member_054', 'system'),
(5, 75, 5, '2025-10-29 09:00:00', 'member_055', 'system'),
(6, 76, 5, '2025-10-29 09:10:00', 'member_056', 'system'),
(7, 77, 6, '2025-10-29 10:00:00', 'member_057', 'system'),
(8, 78, 6, '2025-10-29 10:10:00', 'member_058', 'system'),
(9, 79, 7, '2025-10-29 11:00:00', 'member_059', 'system'),
(10, 80, 7, '2025-10-29 11:10:00', 'member_060', 'system');

-- 5. payment 데이터 (30개)
INSERT INTO payment (id, member_id, amount, method, paid_at, status, created_by, updated_by) VALUES
(1, 21, 150000.00, 'CARD', '2025-10-01 10:00:00', 'PAID', 'member_001', 'system'),
(2, 22, 500000.00, 'BANK', '2025-10-02 11:00:00', 'PAID', 'member_002', 'system'),
(3, 23, 80000.00, 'CASH', '2025-10-03 12:00:00', 'PAID', 'member_003', 'system'),
(4, 24, 200000.00, 'CARD', '2025-10-04 13:00:00', 'PAID', 'member_004', 'system'),
(5, 25, 450000.00, 'BANK', '2025-10-05 14:00:00', 'PAID', 'member_005', 'system'),
(6, 26, 100000.00, 'CARD', '2025-10-06 15:00:00', 'PAID', 'member_006', 'system'),
(7, 27, 300000.00, 'CASH', '2025-10-07 16:00:00', 'PAID', 'member_007', 'system'),
(8, 28, 50000.00, 'CARD', '2025-10-08 17:00:00', 'PAID', 'member_008', 'system'),
(9, 29, 150000.00, 'BANK', '2025-10-09 18:00:00', 'PAID', 'member_009', 'system'),
(10, 30, 250000.00, 'CARD', '2025-10-10 19:00:00', 'PAID', 'member_010', 'system'),
(11, 31, 50000.00, 'CASH', '2025-10-11 10:30:00', 'PAID', 'member_011', 'system'),
(12, 32, 120000.00, 'CARD', '2025-10-12 11:30:00', 'PAID', 'member_012', 'system'),
(13, 33, 400000.00, 'BANK', '2025-10-13 12:30:00', 'PAID', 'member_013', 'system'),
(14, 34, 90000.00, 'CARD', '2025-10-14 13:30:00', 'PAID', 'member_014', 'system'),
(15, 35, 350000.00, 'CASH', '2025-10-15 14:30:00', 'PAID', 'member_015', 'system'),
(16, 36, 180000.00, 'CARD', '2025-10-16 15:30:00', 'PAID', 'member_016', 'system'),
(17, 37, 70000.00, 'BANK', '2025-10-17 16:30:00', 'PAID', 'member_017', 'system'),
(18, 38, 220000.00, 'CARD', '2025-10-18 17:30:00', 'PAID', 'member_018', 'system'),
(19, 39, 480000.00, 'CASH', '2025-10-19 18:30:00', 'PAID', 'member_019', 'system'),
(20, 40, 130000.00, 'CARD', '2025-10-20 19:30:00', 'PAID', 'member_020', 'system'),
(21, 41, 50000.00, 'CARD', '2025-10-21 10:00:00', 'PAID', 'member_021', 'system'),
(22, 42, 250000.00, 'BANK', '2025-10-22 11:00:00', 'PAID', 'member_022', 'system'),
(23, 43, 60000.00, 'CASH', '2025-10-23 12:00:00', 'PAID', 'member_023', 'system'),
(24, 44, 300000.00, 'CARD', '2025-10-24 13:00:00', 'PAID', 'member_024', 'system'),
(25, 45, 150000.00, 'BANK', '2025-10-25 14:00:00', 'PAID', 'member_025', 'system'),
(26, 46, 500000.00, 'CARD', '2025-10-26 15:00:00', 'PAID', 'member_026', 'system'),
(27, 47, 75000.00, 'CASH', '2025-10-27 16:00:00', 'PAID', 'member_027', 'system'),
(28, 48, 110000.00, 'CARD', '2025-10-28 17:00:00', 'PAID', 'member_028', 'system'),
(29, 49, 330000.00, 'BANK', '2025-10-29 09:00:00', 'PAID', 'member_029', 'system'),
(30, 50, 490000.00, 'CARD', '2025-10-29 10:00:00', 'PAID', 'member_030', 'system');


-- 6. membership 데이터 (30개)
INSERT INTO membership (id, member_id, type, remaining_count, expire_date, is_active, created_by, updated_by) VALUES
(1, 21, 'PERIOD', NULL, '2026-04-01', TRUE, 'system', 'system'), -- 기간제 (6개월)
(2, 22, 'COUNT', 50, NULL, TRUE, 'system', 'system'), -- 횟수제 (50회)
(3, 23, 'COUNT', 8, NULL, TRUE, 'system', 'system'),
(4, 24, 'PERIOD', NULL, '2025-11-04', TRUE, 'system', 'system'), -- 곧 만료
(5, 25, 'PERIOD', NULL, '2026-10-05', TRUE, 'system', 'system'),
(6, 26, 'COUNT', 10, NULL, TRUE, 'system', 'system'),
(7, 27, 'PERIOD', NULL, '2026-01-07', TRUE, 'system', 'system'),
(8, 28, 'COUNT', 0, NULL, FALSE, 'system', 'system'), -- 만료된 횟수제
(9, 29, 'PERIOD', NULL, '2025-12-09', TRUE, 'system', 'system'),
(10, 30, 'COUNT', 30, NULL, TRUE, 'system', 'system'),
(11, 31, 'PERIOD', NULL, '2026-03-11', TRUE, 'system', 'system'),
(12, 32, 'COUNT', 12, NULL, TRUE, 'system', 'system'),
(13, 33, 'PERIOD', NULL, '2026-07-13', TRUE, 'system', 'system'),
(14, 34, 'COUNT', 9, NULL, TRUE, 'system', 'system'),
(15, 35, 'PERIOD', NULL, '2026-05-15', TRUE, 'system', 'system'),
(16, 36, 'COUNT', 18, NULL, TRUE, 'system', 'system'),
(17, 37, 'PERIOD', NULL, '2026-01-17', TRUE, 'system', 'system'),
(18, 38, 'COUNT', 22, NULL, TRUE, 'system', 'system'),
(19, 39, 'PERIOD', NULL, '2026-08-19', TRUE, 'system', 'system'),
(20, 40, 'COUNT', 13, NULL, TRUE, 'system', 'system'),
(21, 41, 'PERIOD', NULL, '2026-02-21', TRUE, 'system', 'system'),
(22, 42, 'COUNT', 25, NULL, TRUE, 'system', 'system'),
(23, 43, 'PERIOD', NULL, '2026-05-23', TRUE, 'system', 'system'),
(24, 44, 'COUNT', 30, NULL, TRUE, 'system', 'system'),
(25, 45, 'PERIOD', NULL, '2026-03-25', TRUE, 'system', 'system'),
(26, 46, 'COUNT', 5, NULL, TRUE, 'system', 'system'),
(27, 47, 'PERIOD', NULL, '2026-06-27', TRUE, 'system', 'system'),
(28, 48, 'COUNT', 11, NULL, TRUE, 'system', 'system'),
(29, 49, 'PERIOD', NULL, '2026-04-29', TRUE, 'system', 'system'),
(30, 50, 'COUNT', 40, NULL, TRUE, 'system', 'system');


-- 7. attendance 데이터 (10개)
INSERT INTO attendance (id, reservation_id, attended_at, status, created_by, updated_by) VALUES
(1, 1, '2025-10-27 19:02:00', 'LATE', 'system', 'system'), -- 지각
(2, 2, '2025-10-27 18:55:00', 'ATTENDED', 'system', 'system'),
(3, 3, '2025-10-28 10:05:00', 'LATE', 'system', 'system'),
(4, 4, '2025-10-28 09:50:00', 'ATTENDED', 'system', 'system'),
(5, 44, '2025-10-27 19:10:00', 'LATE', 'system', 'system'),
(6, 45, NULL, 'ABSENT', 'system', 'system'), -- 결석
(7, 5, NULL, 'ABSENT', 'system', 'system'), -- 오늘 수업 중 결석 처리 (시연용)
(8, 6, '2025-10-29 07:00:00', 'ATTENDED', 'system', 'system'), -- 오늘 수업 중 출석 처리 (시연용)
(9, 7, '2025-10-29 18:30:00', 'ATTENDED', 'system', 'system'), -- 미래 수업 출석 (시연용)
(10, 8, NULL, 'ABSENT', 'system', 'system');

SELECT id, name, email, phone FROM user WHERE role = 'COACH';
SELECT title, start_time, end_time, capacity FROM class_schedule WHERE coach_id = 6 AND start_time > NOW() ORDER BY start_time;
SELECT t1.name, t2.status, t2.attended_at FROM user t1 JOIN reservation t3 ON t1.id = t3.member_id JOIN attendance t2 ON t3.id = t2.reservation_id WHERE t3.class_id = 1;
SELECT t1.name, t2.status, t2.attended_at FROM user t1 JOIN reservation t3 ON t1.id = t3.member_id JOIN attendance t2 ON t3.id = t2.reservation_id WHERE t3.class_id = 1;
SELECT COUNT(t2.id) FROM reservation t1 JOIN attendance t2 ON t1.id = t2.reservation_id WHERE t1.member_id = 21 AND t2.status = 'LATE';
SELECT t1.name, t2.remaining_count FROM user t1 JOIN membership t2 ON t1.id = t2.member_id WHERE t2.type = 'COUNT' AND t2.remaining_count < 5 AND t2.is_active = TRUE;
SELECT SUM(amount) FROM payment WHERE member_id = 22 AND status = 'PAID';

SELECT * FROM membership WHERE type = 'COUNT' AND remaining_count < 5 AND is_active = true;
SELECT t1.title FROM class_schedule t1 JOIN reservation t2 ON t1.id = t2.class_id WHERE t2.member_id = 25 AND t2.status = 'RESERVED';
select * from reservation;
use health;

-- 상황 1 [클래스 예약 (Booking a Class)]
-- 단계 1: 회원권 확인
SELECT id AS membership_id, type, remaining_count, expire_date
FROM membership
WHERE member_id = 21
  AND is_active = TRUE
  AND (
      (type = 'COUNT' AND remaining_count > 0)
      OR (type = 'PERIOD' AND (expire_date IS NULL OR expire_date >= CURRENT_DATE()))
  )
ORDER BY expire_date ASC, created_at ASC
LIMIT 1;

-- 단계 2: 클래스 정원 및 현재 예약 수 확인
SELECT cs.id AS class_id, cs.capacity, COUNT(r.id) AS reserved_count
FROM class_schedule cs
LEFT JOIN reservation r
    ON cs.id = r.class_id AND r.status = 'RESERVED'
WHERE cs.id = 4
GROUP BY cs.id;

-- 단계 3: 예약 진행 (정원 여유 시)
INSERT INTO reservation (member_id, class_id, status, created_at)
VALUES (10, 4, 'RESERVED', NOW());

-- 단계 4: 횟수제 회원권 차감 (COUNT형인 경우)
UPDATE membership
SET remaining_count = remaining_count - 1

WHERE id = 1; -- 1번은 단계1에서 조회된 membership_id
-- 단계 5: 정원 초과 시 대기자 등록
INSERT INTO waitlist (member_id, class_id, created_at)
VALUES (10, 101, NOW());
select * from reservation;

-- 상황 [예약 취소 및 횟수 복구 (Cancel Reservation & Restore Count)]
-- 추가할 설정: 회원번호 10번인 회원 membership 생성
INSERT INTO membership (member_id, type, expire_date)
values(
	10,
    'PERIOD',
    '2026-11-01'
);
-- 단계 1: 취소할 예약 정보 조회
SELECT r.id AS reservation_id, r.member_id, r.status, m.id AS membership_id, m.type
FROM reservation r
JOIN membership m
    ON r.member_id = m.member_id AND m.is_active = TRUE
WHERE r.id = 51
ORDER BY m.created_at DESC
LIMIT 1;

-- 단계 2: 예약 상태 변경 (RESERVED → CANCELLED)
UPDATE reservation
SET status = 'CANCELLED', cancelled_at = NOW()
WHERE id = 51
  AND status = 'RESERVED';
-- 단계 3: 횟수제 회원권 복구 (COUNT형인 경우)
UPDATE membership
SET remaining_count = remaining_count + 1
WHERE id = 31; -- 단계1에서 조회한 membership_id


