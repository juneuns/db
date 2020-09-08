/*
    원격 수업 참여 실시 시간
        
        1. 9:30 ~ 12:30
        
        2. 13:30 ~ 16.30
        
        3. 16:30 ~ 18:30
*/

-------------------------------------------------------------------------------------------------------------------------------

-- scott 계정이 가지고 있는 emp 테이블을 복사해서 tmp01 테이블을 만든다.
CREATE TABLE tmp01 
AS
    SELECT
        *
    FROM
        scott.emp
;

SELECT * FROM tmp01;

-- tmp01 의 데이터를 모두 삭제한다.
DELETE FROM tmp01;

rollback;

SELECT * FROM tmp01;

TRUNCATE TABLE tmp01;

SELECT * FROM tmp01;

rollback;

SELECT * FROM tmp01;

-------------------------------------------------------------------------------------------------------------------------------
/*
    DDL 명령
        
*/

-- 1. 테이블 만들기
/*
    형식 1 ] - 제약조건 없이 컬럼만 만드는 방법
        
        CREATE TABLE 테이블이름(
            필드이름    데이터타입(길이),
            필드이름    데이터타입(길이),
            ...
        );
        
    형식 2 ] - 제약조건을 추가해서 만드는 방법
    
        CREATE TABLE 테이블이름(
            필드이름    데이터타입(길이) [ DEFAULT 데이터 ]
                CONSTRAINT 제약조건이름   제약조건
                CONSTRAINT 제약조건이름   제약조건,
            필드이름    데이터타입(길이)
                CONSTRAINT 제약조건이름   제약조건
                CONSTRAINT 제약조건이름   제약조건,
            ...
        );
        
*/


-- DEFAULT
drop table avt;
CREATE TABLE AVT
AS
    SELECT
        *
    FROM
        avatar
    WHERE
        1 = 2
;

    SELECT
        *
    FROM
        avatar
    WHERE
        1 = 2 ;



















