-- day06

/*
    DML(Data Manipulation Language) 명령
    ==> 데이터를 처리(조작)하는 명령
        이 명령 안에는 Insert, Update, Delete 명령도 포함되어 있다.
        
    1. INSERT 명령
        ==> 새로운 데이터를 입력하는 명령
        
        형식 1 ]  ---> 모든 필드의 데이터가 준비되어있는 경우
            INSERT INTO
                테이블
            VALUES(
                데이터1, 데이터2, ...
            );
            
        형식 2 ]  --> 일부만 데이터가 준비되어있는 경우
            INSERT INTO
                테이블이름(필드이름1, 필드이름2, ..)
            VALUES(
                데이터1, 데이터2...
            );
        
        의미 ]
            지정한 테이블의 지정한 필드에 데이터를 입력하세요.
            
        주의사항 ]
            필드의 갯수와 데이터의 갯수는 반드시 일치해야 한다.
            필드의 형태와 데이터의 형태도 반드시 일치해야 한다.
            
        실습준비 ]
            EMP 테이블을 구조만 복사해서 SAMPLE이라는 이름의 테이블을 만들고
            그 테이블에 데이터를 추가하고 수정하고 삭제하도록 한다.
            
            기존 테이블의 구조만 복사해서 테이블을 만드는 명령 ]
                
                CREATE TABLE 테이블이름
                AS
                    SELECT
                        *
                    FROM
                        복사해올테이블이름
                    WHERE
                        항상거짓인 조건식
                ;
*/

-- EMP 테이블의 구조만 복사해서 SAMPLE01 테이블을 만든다.
CREATE TABLE
    SAMPLE01
AS
    SELECT
        *
    FROM
        EMP
    WHERE
        1 = 2
;

DESC EMP;

SELECT
        *
    FROM
        EMP
    WHERE
        1 = 2
;

SELECT
    *
FROM
    sample01
;

/*
    INSERT 명령
        
        구조만 복사된 테이블 SAMPLE01에 사원한명의 데이터를 채워보자.
*/

INSERT INTO
    sample01
VALUES(
    1000, 'JOY', 'SINGER', 9999, SYSDATE, 100, 2000, 30
);

INSERT INTO
    sample01
VALUES(
    9999, 'EUNS', 'BOSS', NULL, TO_DATE('2020/08/27', 'YYYY/MM/DD'), 3000, 2000, 10
);

SELECT * FROM sample01;

COMMIT;

-- TRUNCATE TABLE SAMPLE01;

-- 오혜찬씨 입사...
INSERT INTO
    sample01(empno, ename, job, mgr, hiredate, deptno)
VALUES(
    1001, 'HYECHAN', 'MANAGER', 9999, SYSDATE, 30
);

SELECT * FROM SAMPLE01;

CREATE TABLE
    booseo
AS
    SELECT
        *
    FROM
        dept
    WHERE
        1 = 2
;