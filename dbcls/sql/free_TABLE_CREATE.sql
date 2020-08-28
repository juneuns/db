
/*
    테이블 생성 명령
        형식 1]
        CREATE TABLE 테이블이름(
            컬럼이름    데이터타입[(길이)]     [ DEFAULT 데이터 ],
            컬럼이름    데이터타입[(길이)]     [ DEFAULT 데이터 ],
            컬럼이름    데이터타입[(길이)]     [ DEFAULT 데이터 ],
            컬럼이름    데이터타입[(길이)]     [ DEFAULT 데이터 ]
        );
        
        형식 2]
        CREATE TABLE 테이블이름(
            컬럼이름    데이터타입[(길이)]     [ DEFAULT 데이터 ]
                CONSTRAINT  제약조건이름  제약조건구문,
            컬럼이름    데이터타입[(길이)]     [ DEFAULT 데이터 ]
                CONSTRAINT  제약조건이름  제약조건구문,
            ...
        );
        
        제약조건
            PRIMARY KEY
            ==> CONSTRAINT 제약조건이름 PRIMARY KEY,
        
*/
-- dept 테이블 생성
CREATE TABLE dept(
    deptno NUMBER(2)
        CONSTRAINT DPT_NO_PK PRIMARY KEY,
    dname VARCHAR2(10 CHAR)
        CONSTRAINT DPT_NAME_NN NOT NULL,
    loc VARCHAR2(15 CHAR)
        CONSTRAINT DPT_LOC_NN NOT NULL
);

-- emp 테이블 생성
CREATE TABLE emp(
    empno NUMBER(4)
        CONSTRAINT EMP_ENO_PK PRIMARY KEY,
    ename VARCHAR2(10 CHAR)
        CONSTRAINT EMP_NAME_NN NOT NULL,
    job VARCHAR2(15 CHAR)
        CONSTRAINT EMP_JOB_NN NOT NULL,
    mgr NUMBER(4),
    hiredate DATE
        CONSTRAINT EMP_DAY_NN NOT NULL,
    sal NUMBER(8) DEFAULT 3000000
        CONSTRAINT EMP_SAL_NN NOT NULL,
    comm NUMBER(8),
    deptno NUMBER(2)
        CONSTRAINT EMP_DNO_FK REFERENCES dept(deptno)
);

--  salgrade 테이블 생성
CREATE TABLE salgrade(
    grade NUMBER(2)
        CONSTRAINT SGRD_GRD_PK PRIMARY KEY,
    losal NUMBER(8)
        CONSTRAINT SGRD_LSAL_NN NOT NULL,
    hisal NUMBER(8)
        CONSTRAINT SGRD_HSAL_NN NOT NULL
);


-- 부서정보테이블 데이터 입력
/*
    dept 테이블에 데이터를 추가하는데
    10 - 기획부    - 수원
    20 - 인사부    - 여의도
    30 - 개발부    - 구로
    40 - 회계부    - 강남
    
    추가해주세요.
*/
INSERT INTO
    dept
VALUES(
    10, '기획부', '수원'
);

INSERT INTO
    dept
VALUES(
    20, '인사부', '여의도'
);

INSERT INTO
    dept
VALUES(
    30, '개발부', '구로'
);

INSERT INTO
    dept
VALUES(
    40, '회계부', '강남'
);

commit;

-- 사원정보 테이블 데이터 입력
INSERT INTO
    emp(empno, ename, job, mgr, hiredate, comm, deptno)
VALUES(
    1000, '전은석', '보쓰', NULL, TO_DATE('2020/07/16', 'yyyy/mm/dd'), null, 10
);

SELECT * FROM emp;

INSERT INTO
    emp(empno, ename, job, mgr, hiredate, comm, deptno)
VALUES(
    1001, '김주영', '반장', 1000, '2020/07/22', 500, 40
)
;

SELECT * FROM emp;

-- 보쓰의 급여를 기존급여의 400% 인상해서 수정하세요.
UPDATE 
    emp
SET
    sal = sal * 4
WHERE
    mgr IS NULL
;

INSERT INTO
    emp
VALUES(
    (SELECT NVL(MAX(empno) + 1, 1000) FROM emp),
    '이지우', '학술부장', 1001, SYSDATE, 5000000, 450, 30
);


--------------------------------------------------------------------------------------------------------------------------------
/*
    휴일 과제 ]
        
        게시판 테이블을 구현하세요.
        게시판은 댓글은 없는 기능으로 구현하기로 한다.
        
        작성테이블 ]
            회원테이블
            아바타테이블
            게시판테이블
            
        작성 문서 ]
            ER MODEL
            ERD
            테이블 명세서
            DDL 명령 SQL 파일
            데이터 입력 DML 명령 SQL 파일
*/

 CREATE TABLE avatar(
    ano NUMBER(2)
        CONSTRAINT AVT_NO_PK PRIMARY KEY,
    aname VARCHAR2(30 CHAR)
        CONSTRAINT AVT_NAME_UK UNIQUE
        CONSTRAINT AVT_NAME_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT AVT_GEN_CK CHECK(gen IN ('M', 'F'))
        CONSTRAINT AVT_GEN_NN NOT NULL
 );
 
INSERT INTO
    avatar
VALUES(
    11, 'avatar01.jpg', 'M'
);

SELECT * FROM avatar;