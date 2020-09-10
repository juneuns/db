-- day09

/*
    INDEX(인덱스)
    ==> 검색 속도를 빠르게 하기위해서 B-Tree 기법으로
        색인을 만들어서 SELECT 조회질의명령을 빠른 속도로 처리할 수 있도록 하는 것.
        
    참고 ]
        인덱스를 만들면 안되는 경우
            1. 데이터의 양이 적은 경우는 오히려 속도가 떨어진다.
                시스템에 따라 달라지지만
                최소한 몇십만개의 행이 있는 테이블의 경우에만 속도가 빨라진다.
                
            2. 데이터의 입출력이 빈번한 경우는 오히려 속도가 떨어진다.
                왜냐하면 데이터가 입력될 때 마다
                계속해서 색인(인덱스)를 수정해야 하므로 오히려 불편해진다.
                
    참고 ]
        인덱스를 만들면 효과가 좋아지는 경우
            1. JOIN 등에 많이 사용되는 필드가 존재하는 경우
            2. NULL 값이 많이 존재하는 경우
            3. WHERE 조건절에 많이 사용되는 필드가 존재하는 경우
            
            
    참고 ]
        무결성검사를 할 때 PK(기본키제약조건) 등록을 하면
        자동적으로 인덱스가 만들어진다.
        
--------------------------------------------------------------------------------------------------------------------------------
    
    인덱스 만들기
        
        형식 1] --> 일반적인 인덱스 만들기( NON UNIQUE 인덱스 )
            
            CREATE INDEX 인덱스이름
            ON
                테이블이름(인덱스에 사용할 필드이름);
                
            예 ]
                EMP 테이블의 ENAME을 이용해서 인덱스를 만드세요.
                ==>
                CREATE INDEX enameIdx
                ON
                    emp(ename);
                    
            참고 ]
                일반 인덱스는 데이터가 중복되어도 상관없다.
                
                
        형식 2 ]  --> UNIQUE 인덱스 만들기
            ==> 인덱스용 데이터가 반드시 UNIQUE 하다는 보장이 있을때 만드는 방법
            
            CREATE UNIQUE INDEX 인덱스이름
            ON
                테이블이름(필드이름);
                
            참고 ]
                필드이름은 반드시 필드의 내용이 유일하다는 보장이 있어야 한다.
                
            장점 ]
                일반 인덱스보다 처리속도가 빠르다.
                <== 이진검색을 사용하기 때문에......
                
        형식 3 ] --> 결합 인덱스
            ==> 여러개의 필드를 결합해서 하나의 인덱스를 만드는 방법
                이때도 전제조건이 
                여러개의 필드의 조합이 유일해야 한다.
                
                즉 하나의 필드만 가지고는 유니크 인덱스를 만들지 못하는 경우
                여러개의 필드를 합쳐서 유니크 인덱스를 만들어서 사용하는 방법
                
                
            CREATE UNIQUE INDEX 인덱스이름
            ON
                테이블이름(필드이름, 필드이름, 필드이름, ...)
                
        형식 4 ] --> 비트 인덱스
            ==> 주로 필드의 데이터의 갯수가 정해진 경우에 사용하는 방법
                예 ]
                    GEN 필드의 경우 도메인이 'M', 'F' 만 입력해야 한다.
                    
                예 ]
                    EMP 테이블의 DEPTNO 의 경우는 10, 20, 30, 40 만 입력할 수 있다.
                    
            이 경우 내부적으로 데이터를 이용해서 인덱스를 만들어서 사용하는 방법
            
            CREATE BITMAP INDEX 인덱스이름
            ON
                테이블이름(필드이름)
            
*/

INSERT INTO
    emp(empno, ename, deptno)
VALUES(
    9000, 'dooly', 50
);

SELECT * FROM DEPT;

--------------------------------------------------------------------------------------------------------------------------------

-- EMP 테이블을 복사해서 EMP00 이라는 테이블을 만들자.
CREATE TABLE emp00
AS
    SELECT * FROM emp
;

desc emp;

ALTER TABLE emp00
MODIFY
    empno NUMBER(6)
;

-- 사원번호와 부서번호에 제약조건을 추가하세요.
ALTER TABLE emp00
ADD CONSTRAINT E00_NO_PK PRIMARY KEY(empno);

ALTER TABLE emp00
ADD CONSTRAINT E00_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno);

-- 시퀀스를 만든다. 시작값은 8000, 증가값은 1씩 증가하고 최대값은 999999, 반복과 캐쉬기능은 허용하지 않는다.

CREATE SEQUENCE e_seq
    START WITH 8000
    MAXVALUE 999999
    NOCYCLE
    NOCACHE
;

INSERT INTO emp00
SELECT e_seq.nextval, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp00
;

select * from emp00;

-- 인덱스 만들기 전 조회시간을 체크한다.
SELECT 
    empno, ename
FROM
    emp00
WHERE
    ename = 'SMITH'
; -- 0.006


-- 이름을 이용해서 인덱스를 만들어보자.
CREATE INDEX ename_idx01
ON
    emp00(ename);

SELECT 
    empno, ename
FROM
    emp00
WHERE
    ename = 'SMITH'
; -- 00:00:08.07

SELECT 
    empno, ename
FROM
    emp01
WHERE
    ename = 'SMITH'
; -- 00:00:08.91


-- EMP00 을 복사해서 EMP01 테이블을 만든다.
CREATE TABLE emp01
AS
    SELECT
        *
    FROM
        emp00
;


/*
    sqlplus 접속 방법
    
        방법 1 ] --> 로컬에 오라클이 설치되어있는 경우
        sqlplus 계정이름/비번
        
        방법 2 ] --> 다른 컴퓨터에 오라클이 설치되어있는 경우
            
            sqlplus 계정이름/비번@DB서버주소:포트번호/SID
        
*/


INSERT INTO emp01
SELECT e_seq.nextval, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp01
; -- 26.xx 

INSERT INTO emp00
SELECT e_seq.nextval, ename, job, mgr, hiredate, sal, comm, deptno초
FROM emp00
; -- 40.33 초 <== 인덱스를 수정하는 작업이 추가되서 느려졌다.


SELECT * FROM EMP01 ORDER BY EMPNO DESC;


CREATE BITMAP INDEX dno_idx01
ON
    emp00(deptno);
    
SELECT DISTINCT deptno 부서번호 FROM emp00; -- 0.024초

SELECT DISTINCT deptno 부서번호 FROM emp01; -- 0.055초

-------------------------------------------------------------------------------------------------------------------------------

/*
    사용자 관리(계정 & 권한)
    ==> 관리자 모드에서 사용자에게 권한을 설정하는 방법
    
        계정이란?
        ==> 은행의 통장과 같은 개념이다.
            하나의 통장은 한사람이 사용할 수 있듯이
            계정은 한사람이 사용할 수 있는 가장 작은 단위의 데이터베이스이다.
            
            오라클의 경우
                데이터베이스  -------------------------------------- db2
                    |
                    |
            -----------------
            |       |       |
            계정     계정   계정
            |
        --------
        |   |   |
    테이블 테이블
    
------------------------------------------------------------------------------------------------------------------------------
    
                MYSQL 의 경우
                
                ------------            ------------------------
                |   |   |   |           |       |       |       |
                계정  계정              DB      DB      DB      DB
                                        |
                                -----------------
                                |       |       |
                                table   table   table

-------------------------------------------------------------------------------------------------------------------------------

            1. 사용자 계정 만들기
                
                1. 관리자 계정으로 접속한다.
                    
                    1) sqlplus 의 경우
                        
                        a) sqlplus system/비번
                        b) sqlplus / as sysdba
                        
                                sqlplus hello/hello@localhost:1521/orcl
                                sql> conn system/increpas@localhost:1521/orcl as sysdba
                                
                    2) sqldeveloper 의 경우
                        system 계정으로 접속한다.
                                
                2. 사용자 만든다.
                    
                    CREATE USER 계정이름 IDENTIFIED BY 비밀번호;
                    
                    예]
                        CREATE USER test01 IDENTIFIED BY increpas;
                    
                    참고 ]
                         현재 접속한 계정이름을 알아보는 명령
                         
                            show user;
                            
                    참고 ]
                        계정은 만들어 두면 
                        만든 계정은 아무권한도 가지고 있지 않은 상태가 된다.
                        따라서 오라클에 접속할 수 있는 권한 마저도 가지고 있지 않게 된다.
                        오라클에 접속할수 있는 권한은
                            CREATE SESSION
                        이라는 권한이다.
                        
                        
        2. 권한 부여하기
            
            형식 ]
                
                GRANT 권한이름, 권한이름, .... TO 계정이름;
                
                예 ]
                    
                    GRANT CREATE SESSION TO test01;
                        
            참고 ]
                sqlplus 접속 계정을 바꾸는 명령
                    
                    connect 계정이름/비밀번호;
                    
                    conn 계정이름/비밀번호;
            참고 ]
                계정이 가지고 있는 테이블 리스트 조회하기
                    
                    SELECT tname FROM tab;
                    
                    
            참고 ]
                
                SESSION
                ==> 오라클에 접속하면 오라클이 제공하는 권리를 이야기 하며
                    오라클의 가격이 달라지는 것은 바로 세션의 갯수에 따라서 가격이 달라진다.
                    
                    
            참고 ]
                오라클에서는 계정을 만들더라도
                데이터베이스에 접속할 수 있는 권한이 없는 상태로 계정이 만들어지기 때문에
                계정을 만든 직후에 따로 세션을 만들수 있는 권한을 부여받지 않으면
                오라클에 접속할 수 없는 상태이다.
                따라서 계정을 만들면 접속할 수 있는 권한을 반드시 부여해줘야 한다.
                
                
-------------------------------------------------------------------------------------------------------------------------------

    참고 ]
        권한을 부여할 때 사용되는 옵션
            
            1. WITH ADMIN OPTION
                ==> 관리자 권한을 위임 받을 수 있도록 하는 옵션
                
                예 ]
                    test01 계정에게 테이블을 만들 수 있는 권한을 부여하고
                    +
                    관리자 권한도 부여해보자.
                    
                    GRANT create table TO test01 WITH ADMIN OPTION;
                    
            2. WITH GRANT OPTION
                ==> 관리자에게 부여받은 권한을 다른 계정에게 전파할 수 있는 권한
                
    ---------------------------------------------------------------------------------------------------------------------------
    
        다른 계정의 테이블 사용하기
            ==> 원칙적으로 하나의 계정은 자신의 계정에 있는 테이블만 사용할 수 있다.
                
                하지만 여러계정들이 다른 계정의 테이블을 공동으로 사용할 수 있다.
                
                이때 사용할 수 있는 권한을 설정해 줘야 한다.
                
                방법
                    
                    GRANT SELECT ON 계정.테이블이름 TO 계정;
                    
                    예 ]
                        
                        --> SELECT ANY TABLE 권한을 TEST01에게서 회수하고
                        --> SCOTT계정이 가지고 있는 EMP테이블을 조회할 수 있는 권한을 TEST01 계정에게 부여해보자.
                        
                        REVOKE SELECT ANY TABLE FROM TEST01;
                        
                        GRANT SELECT ON scott.emp TO test01;
                        
    ----------------------------------------------------------------------------------------------------------------------
    
    권한 회수하기
        
        형식 ]
            
            REVOKE 권한이름 FROM 계정이름;
            
---------------------------------------------------------------------------------------------------------------------------
    계정 삭제 하기
        형식 ]
            
            DROP USER 계정이름 CASCADE;
    
*/




/*

SQL> grant SELECT ON scott.emp TO test01 WITH ADMIN OPTION;
grant SELECT ON scott.emp TO test01 WITH ADMIN OPTION
                                         *
1행에 오류:
ORA-00993: GRANT 키워드가 없습니다


SQL> grant SELECT ON scott.emp TO test01 WITH GRANT OPTION;

권한이 부여되었습니다.

SQL> conn test01/increpas
연결되었습니다.
SQL> grant select on scott.emp to test02;

권한이 부여되었습니다.

SQL> CONN SYS/INCREPAS AS SYSDBA
연결되었습니다.
SQL> DROP USER test03;

사용자가 삭제되었습니다.

SQL> GRANT CREATE TABLE TO test02;

권한이 부여되었습니다.

SQL> conn test02/increpas
연결되었습니다.
SQL> create table test(
  2     no number(2)
  3  );

테이블이 생성되었습니다.

SQL> insert into test values( 11 );
insert into test values( 11 )
            *
1행에 오류:
ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.


SQL>
SQL> conn sys/increpas as sysdba
연결되었습니다.
SQL> grant resource to test02;

권한이 부여되었습니다.

SQL> conn test02/increpas
연결되었습니다.
SQL> insert into test values( 11 );

1 개의 행이 만들어졌습니다.

SQL> insert into test values( 12 );

1 개의 행이 만들어졌습니다.

SQL> commit
  2  ;

커밋이 완료되었습니다.

SQL> conn sys/increpas as sysdba;
연결되었습니다.
SQL>
SQL> drop user test02;
drop user test02
*
1행에 오류:
ORA-01922: 'TEST02'(을)를 삭제하려면 CASCADE를 지정하여야 합니다


SQL> drop user test02 cascade;

사용자가 삭제되었습니다.



*/









