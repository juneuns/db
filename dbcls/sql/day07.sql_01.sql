

CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT AVT_NO_PK PRIMARY KEY,
    aname VARCHAR2(30 CHAR)
        CONSTRAINT AVT_NAME_UK UNIQUE
        CONSTRAINT AVT_NAME_NN NOT NULL,
    afile VARCHAR2(50 CHAR)
        CONSTRAINT AVT_FILE_UK UNIQUE
        CONSTRAINT AVT_FILE_NN NOT NULL,
    dir VARCHAR2(50 CHAR)
        CONSTRAINT AVT_DIR_NN NOT NULL,
    len NUMBER
        CONSTRAINT AVT_LEN_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT AVT_GEN_NN NOT NULL
        CONSTRAINT AVT_GEN_CK CHECK(gen IN('M','F'))
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man1', 'img_avatar1.png', '/img/avatar/', 0, 'M'
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man2', 'img_avatar2.png', '/img/avatar/', 0, 'M'
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man3', 'img_avatar3.png', '/img/avatar/', 0, 'M'
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man4', 'img_avatar4.png', '/img/avatar/', 0, 'F'
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man5', 'img_avatar5.png', '/img/avatar/', 0, 'F'
);

INSERT INTO
    avatar
VALUES(
    (SELECT NVL(MAX(ano), 10) + 1 FROM avatar),
    'man6', 'img_avatar6.png', '/img/avatar/', 0, 'F'
);

SELECT * FROM avatar;

commit;

create table avc(
    no number(2),
    name varchar2(10 char)
);

desc avc;


insert into 
    avc
values(
    10, 'abc'
);

insert into 
    avc(no)
values(
    10
);

select * from avc;

/*
    이처럼 컬럼의 널값 입력 처리를 따로 설정하지 않으면 기본적으로
    null 데이터가 입력되는 것이 허용이 된다.
*/


drop table avc;

ALTER TABLE
    avt
MODIFY
    dir default '/img/avatar/'
;

INSERT INTO
    avt(ano, aname, afile, len, gen)
VALUES(
    10, 'man1', 'avt1.jpg', 0, 'M'
);

select * from avt;

-------------------------------------------------------------------------------------------------------------------------

/*
    참고 ]
        DDL 명령 - 데이터 정의 언어 : 데이터베이스의 개체 를 다루는 명령
    
    테이블 수정
        
        1. 컬럼 추가
            
            형식 ]
                ALTER TABLE 테이블이름
                ADD (
                    필드이름    데이터타입(길이)
                );
                
        2. 컬럼이름 변경
             형식 ]
                
                ALTER TABLE 테이블이름
                RENAME COLUMN   현재이름    TO      바뀔이름;
                
        3. 사이즈 변경
            
            형식 ]
                
                ALTER TABLE
                    테이블이름
                MODIFY 현재필드이름 데이터타입(길이);
                
        4. 필드(컬럼)삭제
            
            형식 ]
                
                ALTER TABLE
                    테이블이름
                DROP COLUMN 필드(컬럼)이름;
*/

ALTER TABLE
    avt
ADD(
    idate DATE,
    ddate DATE
);

ALTER TABLE
    avt
RENAME COLUMN   idate TO     insertDay;

desc avt;

ALTER TABLE
    AVT
MODIFY ano NUMBER(3);

ALTER TABLE
    avt
DROP COLUMN insertday;

ALTER TABLE
    avt
DROP COLUMN ddate;

desc avt;

-- 문제 ] ano의 길이를 숫자 2자리로 변경하세요.

TRUNCATE TABLE Avt;

ALTER TABLE
    AVT
MODIFY ano NUMBER(2);

-- 세자릿수로 사이즈를 늘려놓은 상태
-- 100, 101

------------------------------------------------------------------------------------------------------------
/*
    4. 테이블이름 변경
        
        형식 ]
            
            ALTER TABLE 테이블이름
            RENAME TO  바뀌테이블이름;
*/

-- AVT 테이블을 AVT01로 수정
ALTER TABLE avt
RENAME TO AVT01;

SELECT TNAME FROM tab;

/*
    테이블 삭제하기
    
    4. DROP
        
        형식 ]
            
            DROP 삭제할개체유형    개체이름;
        예 ]
            
            DROP TABLE AVT01;
            
        형식 2 ]
            
            DROP TABLE 테이블이름 purge; ==> 휴지통에 넣지말고 완전 삭제하세요.
*/

DROP TABLE AVT01;

-- user01 이라는 계정을 만들어보자.
CREATE USER user01 IDENTIFIED BY ABCD;

DROP USER user01;

CREATE USER user01 IDENTIFIED BY ABCD;

ALTER USER user01 IDENTIFIED BY user ACCOUNT UNLOCK;
/*
    IDENTIFIED BY - 비밀번호 적용하는 명령
    ACCOUNT UNLOKC - 계정 잠금 해제명령
*/


------------------------------------------------------------------------------------------------------------------------

/*
    참고 ]
        오라클은 10G 부터 휴지통 개념을 이용해서
        삭제된 테이블을 휴지통에 보관하도록 해 놓았다.
        
    휴지통 관리
    
        1. 휴지통에 있는 모든 테이블 완전 지우기
            
            purge recyclebin;
            
        2. 휴지통의 특정 테이블만 완전 삭제하기
            
            purge table 테이블이름;
            
        3. 휴지통 확인하기
            
            show RECYCLEBIN;
            
        4. 휴지통에 버린 테이블 복구하기
            
            FLASHBACK TABLE 테이블이름   TO BEFORE DROP;
*/
-- 1
purge recyclebin;

-- 2

-- avatar 테이블을 복사해서 avt01테이블을 만들고 바로 삭제한다.
CREATE TABLE
    avt01
AS
    SELECT * FROM avatar;
    
DROP TABLE avt01;
-- 휴지통에서 avt01테이블을 완전 삭제한다.
purge TABLE avt01;

-- 휴지통 보기
SHOW RECYCLEBIN;

-- 완전 삭제하기
PURGE TABLE AVT01;

-- 복구하기
CREATE TABLE
    avt01
AS
    SELECT * FROM avatar;
    
DROP TABLE avt01;

-- 복구
FLASHBACK TABLE AVT01 TO BEFORE DROP;