/*
    뷰(View)
    ==> 질의 명령의 결과를 하나의 창문으로 바라볼 수 있는 창문을 의미한다.
    
        예 ]
            SELECT * FROM AVATAR;
            ==> 이 질의명령을 실행하면 결과가 나오는데 이 결과중에서 일부분만 볼 수 있는 창문을 만들어서 사용하는 것.
            
        ==> 자주 사용하는 복잡한 질의명령을 따로 저장해 놓고
            이 질의 명령의 결과를 손쉽게 처리할 수 있도록 하는 것.
            
        뷰의 종류
            1. 단순 뷰
                ==> 하나의 테이블만을 이용해서 만들어진 뷰
                    따라서 모든 DML 명령이 가능하다.
                    
                    참고 ]
                        단순 뷰라도 그룹함수로 만들어진 뷰는 select 명령이외의 DML 명령은 사용 불가하다.
            
            2. 복합 뷰
                ==> 두개 이상의 테이블을 이용해서(조인해서) 만들어진 뷰
                    **
                    select 만 가능하고 다른 DML 명령은 사용이 불가능하다.
-------------------------------------------------------------------------------------------------------------------------
    참고 ]
        원칙적으로 사용자 계정은 관리자가 허락한 일만 할 수 있다.
        즉, 관리자는 각각의 계정마다 그 계정의 권한에 따라서 사용할 수 있는 명령을 지정할 수 있다.
        
        현재 SCOTT 계정은 SELECT, UPDATE, DELETE, INSERT, CREAT TABLE, SELECT ANY TABLE, ALTER TABLE, DROP TABLE,...
        허락된 상태이다.
        
        문제는 뷰를 만드는 명령은 현재 SCOTT, HELLO 계정에 허락된 상태가 아니다.
        
        ***
        따라서
        관리자 계정에서 특정 계정이 사용할 수 있는 명령의 권한을 부여해줘야 한다.
        
        권한 부여 방법
            
            형식 1 ]
                
                GRANT 권한, 권한, ... TO 계정이름;
                
                
        --> SYSTEM 계정으로 접속해서
            
            GRANT CREATE VIEW TO scott;
            
            GRANT CREATE VIEW TO hello;
            
            GRANT CREATE VIEW TO free;


*/

select ano, aname from avatar WHERE gen = 'M';

SELECT * FROM hello.avatar;

--> SYSTEM 계정으로 접속해서
            
GRANT CREATE VIEW TO scott;

GRANT CREATE VIEW TO hello;

GRANT CREATE VIEW TO free;

/*
    뷰 만드는 방법
        
        형식 1 ]
            
            CREATE VIEW 뷰이름
            AS
                뷰에서 사용할 데이터를 가져올 질의명령
            ;
*/

-- SCOTT 계정의 EMP테이블에서 사원번호, 사원이름, 급여만 보는 뷰를 만들어 보자.

CREATE VIEW esal
AS
    SELECT
        EMPNO, ENAME, SAL
    FROM
        SCOTT.EMP
;

SELECT
    *
FROM
    ESAL
;

-- 사원들의 부서별 부서최대급여, 부서최소급여, 부서평균급여, 부서급여합계, 부서원수, 부서번호 를 볼수 있는 뷰를 만들어보자.

CREATE VIEW dsal
AS
    SELECT
        deptno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
    FROM
        scott.emp
    GROUP BY
        deptno
;

SELECT 
    *
FROM
    dsal;
    
INSERT INTO
    esal
VALUES(
    9000, 'DOOLY', 20
);

CREATE TABLE emp
AS
    SELECT
        *
    FROM
        scott.emp
;

DROP VIEW esal;

CREATE VIEW esal
AS
    SELECT
        empno, ename, sal
    FROM
        emp
;

INSERT INTO 
    esal
VALUES(
    8000, 'dooly', 50
);

select * from esal;
select * from emp;

rollback;

select * from emp;

drop view dsal;

CREATE VIEW dsal
AS
    SELECT
        deptno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
    FROM
        emp
    GROUP BY
        deptno
;

-- scott.dept 테이블을 복사
CREATE TABLE dept
AS
    SELECT
        *
    FROM
        scott.dept
;

CREATE TABLE salgrade
AS
    SELECT
        *
    FROM
        scott.salgrade
;

-- EMP, DEPT 테이블을 사용해서
-- 사원번호, 사원이름, 급여, 부서번호, 부서이름, 부서위치를 볼수있는 뷰를 만드세요.
CREATE VIEW temp01
AS
    SELECT
        empno, ename, sal, e.deptno, dname, loc
    FROM
        emp e, dept d
    WHERE
        e.deptno = d.deptno
;

select * from temp01;



-- emp, dept 테이블을 이용해서 
-- 부서번호, 부서최대급여, 부서최소급여, 부서급여합계, 부서평균급여, 부서원수, 부서이름, 부서위치
-- 를 볼수 있는 뷰를 만든다.

CREATE VIEW dptsal
AS
    SELECT
        deptno, max, min, avg, sum, cnt, dname, loc
    FROM
        (
            SELECT 
                deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
            FROM
                emp
            GROUP BY
                deptno
        ), 
        dept
    WHERE
        dno = deptno
;

/*
CREATE TABLE temp
AS
    SELECT 
        deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
    FROM
        emp
    GROUP BY
        deptno
;

SELECT
    deptno, max, min, avg, sum, cnt, dname, loc
FROM
    temp, dept
WHERE
    dno = deptno
;
*/

/*
    문제 1 ]
        emp 테이블의 사원중 부서번호가 10번인 사원들의정보만 볼 수 있는 뷰를 만드세요.
        
    문제 2 ]
        사원중 이름이 4글자인 사원들의 정보만 볼 수 있는 뷰를 만드세요.
*/

-- 문제 3 ] 뷰를 만들고 사용해서 사원중 부서 평균급여보다 많이 받는 사원의 사원번호, 사원이름, 부서번호, 부서이름을 조회하세요.

SELECT
    deptno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
FROM
    emp
GROUP BY
    deptno
;

--> 위의 결과를 뷰로 만들어보자.
CREATE OR REPLACE VIEW dsal
AS
    SELECT
        deptno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, SUM(sal) sum, COUNT(*) cnt
    FROM
        emp
    GROUP BY
        deptno
;

SELECT
    empno 사원번호, ename 사원이름, e.deptno 부서번호, dname 부서이름
FROM
    emp e, dept d, dsal ds
WHERE
    e.deptno = ds.deptno
    AND e.deptno = d.deptno
    AND sal > avg
;

/* -- 절대로 아니되옵니다.
select
    *
from
    emp
where
    deptno = 20
    AND sal > MAX(sal)
group by
    deptno
;
*/
/*
    형식  2 ]
        
        DML 명령으로 데이터를 변경할 때
        변경된 데이터는 기본 테이블만 변경이 되므로
        뷰 입장에서 보면 그 데이터를 실제로 사용할 수 없을 수 있다.
        
        ==> 이런 문제를 해결하기 위한 방법
            자신이 사용할 수 없는 데이터는 수정이 불가능하도록 할 수 있다.
            
        형식 ]
            
            CREATE VIEW 뷰이름
            AS
                질의명령
            WITH CHECK OPTION;
*/

-- 20 부서의 사원의 정보를 볼수있는 뷰 VIEW02를 만든다.
CREATE VIEW view02
AS
    SELECT
        *
    FROM
        emp
    WHERE
        deptno = 20
;

UPDATE
    view02
SET
    deptno = 40
WHERE
    deptno = 20
;

select * from view02;

rollback;

DROP VIEW VIEW02;

CREATE VIEW view02
AS
    SELECT
        *
    FROM
        emp
    WHERE
        deptno = 20
WITH CHECK OPTION
;

UPDATE
    view02
SET
    deptno = 40
WHERE
    deptno = 20
;

UPDATE
    emp
SET
    deptno = 40
WHERE
    deptno = 20
;

rollback;

-- 문제 3 ] 부서번호가 30번인 사원들의 사원이름, 직급, 부서번호를 볼 수 있는 뷰를 만드세요.
--          단, 뷰의 데이터가 하나도 없어지지 않도록 수정할 수 없게 하세요.
DROP VIEW view03;
CREATE VIEW view03
AS
    SELECT
        ename, job, deptno
    FROM
        emp
    WHERE
        deptno = 30
WITH CHECK OPTION
;

SELECT * FROM view03;

UPDATE
    view03
SET
    deptno = 40
;

/*
    참고 ]
        테이블도 마찬가지지만 이미 존재하는 뷰이름과 동일한 뷰이름으로는 뷰를 만들지 못한다.
        
        같은 이름의 뷰가 있어도 만들 수 있는 방법
            
            형식 ]
                
                CREATE OR REPLACE VIEW 뷰이름
                AS
                    질의명령
                    
                ;
*/

-- 문제 4 ] 부서번호가 10, 20번인 사원들의 사원이름, 직급, 부서번호를 볼 수 있는 뷰(VIEW03)를 만드세요.
--          단, 뷰의 데이터가 하나도 없어지지 않도록 수정할 수 없게 하세요.

CREATE OR REPLACE VIEW view03
AS
    SELECT
        ename, job, deptno
    FROM
        emp
    WHERE
        deptno IN(10, 20)
        /*
        deptno = 10
        or deptno = 20
        */
WITH CHECK OPTION
;

/*
    뷰 삭제하기
        형식 ]
            DROP VIEW 뷰이름;
*/

DROP VIEW view03;



-- 문제 3 ] 뷰(view04)를 만들고 사용해서 사원중 부서최소급여를 받는 사원의 사원번호, 사원이름, 부서번호, 부서이름을 조회하세요.

--> 1. 서브질의로
SELECT
    empno 사원번호, ename 사원이름, e.deptno 부서번호, dname 부서이름
FROM
    emp e, dept d,
    (
        SELECT
            deptno dno, MIN(sal) min
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    e.deptno = d.deptno
    AND e.deptno = dno
    -- 여기까지가 조인조건
    AND sal = min
;

--> 2. 뷰를 사용해서


CREATE OR REPLACE VIEW view04
AS
    SELECT
        deptno dno, MIN(sal) min
    FROM
        emp
    GROUP BY
        deptno
;

SELECT
    empno 사원번호, ename 사원이름, e.deptno 부서번호, dname 부서이름
FROM
    emp e, dept d, view04
WHERE
    e.deptno = d.deptno
    AND e.deptno = dno
    -- 여기까지가 조인조건
    AND sal = min
;

-------------------------------------------------------------------------------------------------------------------------------
/*
    인라인 뷰(Inline View)
    ==> SELECT 질의 명령을 보내면 원하는 결과가 조회가 된다.
        이것을 인라인 뷰라고 이야기 한다.
        
        즉, 뷰는 인라인 뷰중에서 자주 사용하는 인라인 뷰를 기억시켜놓고 사용하는 개념이다.
        
        조회질의명령의 결과로 만들어지는 데이터 집합을 인라뷰라 이야기 한다.
        
        *
        인라인 뷰는 하나의 가상테이블이다.
        (테이블이란 필드와 레코드로 구성된 데이터를 입력하는 단위)
        따라서 인라인 뷰는 하나의 테이블로 다시 재사용이 가능하다.
        결국 테블을 사용해야 하는 곳에는 인라인 뷰를 사용해도 된다.
        
        예 ]
            SELECT
                EMPNO
            FROM
                (
                    SELECT
                        EMPNO, ENAME, DEPTNO
                    FROM
                        EMP
                )
            WHERE
                deptno = 10
            ;
            
            SELECT
                ename, sal
            FROM
                (
                    SELECT
                        empno, ename, job
                    FROM
                        emp
                )
            ; -->  이 경우는 에러가 난다. 왜냐하면 테이블의 내용에 sal  필드가 존재하지 않기 때문에...
            
-------------------------------------------------------------------------------------------------------------------------------
    인라인 뷰를 사용해야 하는 이유
        실제 테이블에 존재하지 않는 데이터를 추가적으로 사용해야 하는 경우에 
        특히 인라인 뷰를 사용한다.
        
-------------------------------------------------------------------------------------------------------------------------------

참고 ]
    ROWNUM
    ==> 실제로 물리적으로 존재하는 필드는 아니고
        오라클이 만들어주는 가상의 필드로
        데이터가 입력된 순서를 표시하는 필드이다.
        
        예 ]
            SELECT
                rownum, ename, job
            FROM
                emp
            ;
            
            
*/

SELECT
    EMPNO, ENAME
FROM
    (
        SELECT
            EMPNO, ENAME, DEPTNO
        FROM
            EMP
    )
WHERE
    deptno = 10
;

SELECT
    ename, sal
FROM
    (
        SELECT
            empno, ename, job
        FROM
            emp
    )
;


--> rownum
SELECT
    ROWNUM no, e.*
FROM
    (SELECT
        ename, job
    FROM
        emp
    order by
        ename) e
;

-- 문제 3 ] 사원들의 사원번호, 사원이름, 급여 를 조회하세요.
--  단, 조회된 사원들의 정보는 급여가 높은사람부터 1부터 넘버링이 되서 조회되게 하세요.
SELECT
    ROWNUM, empno, ename, sal
FROM
    (SELECT
        empno, ename, sal
    FROM
        emp
    ORDER BY
        sal DESC)
;

-- 위 문제에서 급여가 5번째에서 7번째로 많이 받는 사원만 조회하세요.
SELECT
    RNO, EMPNO, ENAME, SAL
FROM
    (SELECT
        rownum rno, empno, ename, sal
    FROM
        (
            SELECT
                empno, ename, sal
            FROM
                emp
            ORDER BY
                sal DESC
        )
    )
WHERE
    rno BETWEEN 5 AND 7
;

SELECT
        rownum rno, empno, ename, sal
    FROM
        (
            SELECT
                empno, ename, sal
            FROM
                emp
            ORDER BY
                sal DESC
        )
WHERE
    rownum BETWEEN 1 AND 3
;

-- 사원테이블에서 입사일이 7번째로 입사한 사원의 사원번호, 사원이름, 입사일을 조회하세요.

SELECT
    rno, empno, ename, hiredate
FROM
    (
        SELECT
            rownum rno, empno, ename, hiredate
        FROM
            (
                SELECT
                    EMPNO, ENAME, HIREDATE
                FROM
                    EMP
                ORDER BY
                    HIREDATE DESC
            )
    )
WHERE
    rno = 7
;


-------------------------------------------------------------------------------------------------------------------------------
/*
    시퀀스(SEQUENCE)
    ==> 테이블을 만들면 각 행을 구분해줄 PK가 필수적으로 존재해야 한다.
        
        예를 들어
            사원을 관리하는 테이블을 만들면
            각 사원을 구분할 수 있는 무엇인가가 있어야 한다는 말이다.
            따라서 우리는 가지고 있는 EMP 테이블에서는
            사원번호(EMPNO)를 이용해서 처리하고 있다.
            
        몇몇개의 테이블은 이것을 명확하게 구분하여 처리할 수 있지만 
        그렇지 못한 테이블도 존재한다.
        
        예를 들자면
            게시판 내용을 관리하는 테이블을 만든다면
            제목, 글쓴이, 작성일, 본문, ... 이 있지만
            이것 중에서 명확하게 그 행을 구분할 수 있는 역할을 하는 필드가 존재하지 않는다.
            
        이런 경우는 일련번호를 이용해서 이 역할을 하도록 하고 있다.
        
        따라서 그 일련번호는 절대로 중복되면 안되고( <== 기본키로 작동할 것이기 때문에... )
        그리고 절대로 생략되어서도 안된다.
        ==> 데이터베이스에 내용을 입력하는 사람이 문제가 발생할 수 있다.
        
        시퀀스는 이런 문제점을 해결하기 위해서 나타난 방법이다.
        자동적으로 일련번호를 만들어주는 역을 하는 도구이다.
        
        방법
            1. 시퀀스를 만들어 놓는다.
            2. 데이터베이스에 일련번호의 입력이 필요하면 만들어 놓은 시퀀스에게 번호를 만들어 달라고 요청한다.
                ==> 데이터를 insert 시킬때 일련번호부분은 시퀀스에게 부탁하면 된다.
                
                
                
    시퀀스 만드는 방법
        
        형식 ]
            
            CREATE SEQUENCE 시퀀스이름
                START WITH 번호
                ==> 발생할 일련번호의 시작값을 지정한다.
                    만약 생략되면 1부터 시작한다.
                INCREMENT BY 숫자
                ==> 발생할 번호들의 순차적 증가값을 지정
                    생략하면 1씩 증가
                MAXVALUE 숫자 [ 혹은 NOMAXVALUE ]
                MINVALUE 숫자 [ 혹은 NOMINVALUE ]
                ==> 발생할 일련번호의 최대 최소값을 지정한다.
                    생략하면 NO를 사용한다.
                CYCLE 또는 NOCYCLE
                ==> 발생한 일련번호가 최대값에 도달한이후 다시 처음부터 시작할지 여부를 설정
                    생략하면 NOCYCLE
                    
                CACHE 또는 NOCACHE
                ==> 일련번호 발생시 임시 메모리를 사용할지 여부를 지정한다.
                    (미리 세션이 열렸을때 몇개를 만들어서 메모리에 준비시켜놓을지 여부)
                    사용하면 속도는 빨라지지만 메모리가 줄고
                    안하면 속도는 느려지지만 메모리는 줄지 않는다.
            ;
                
            
    
*/

-------------------------------------------------------------------------------------------------------------------------------
-- EMP 테이블의 제약조건을 추가해주세요.
-- PK, FK 를 추가해주세요.

ALTER TABLE
    emp
ADD 
    CONSTRAINT EMP_NO_PK PRIMARY KEY(empno)
;

ALTER TABLE
    dept
ADD
    CONSTRAINT DEPT_NO_PK PRIMARY KEY(deptno)
;


ALTER TABLE
    emp
ADD
    CONSTRAINT EMP_NO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno)
;

-------------------------------------------------------------------------------------------------------------------------------

-- 문제 ] 1부터 1씩 증가하는 시퀀스 SEQ1 을 하나 만들어보자. 단, 최대값을 100으로 한다.

CREATE SEQUENCE seq01
    NOCYCLE
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100
    NOCACHE
;

-------------------------------------------------------------------------------------------------------------------------------

/*
    시퀀스 사용방법
        ==> 데이터를 입력할 때 자동으로 일련번호를 발생하기 위해서 만든것.
            따라서 INSERT 명령에 사용하며
                
                시퀀스이름.NEXTVAL
            을 사용하면 된다.
            
    참고 ]
        시퀀스가 가지는 변수
            
            NEXTVAL     - 시퀀스로 만들어진 최후 번호 다음번호를 만든다.
            CURRVAL     - 시퀀스가 지금까지 최종적으로 만든 번호를 기억하는 변수
                            *****
                            CURRVAL은 세션이 열리면 비워져있다.
                            CURRVAL은 NEXTVAL로 만들어진 번호를 기억하는 변수이다.
*/

SELECT seq01.currval from dual;

SELECT seq01.nextval from dual;

SELECT seq01.currval FROM dual;

SELECT seq01.currval cur, seq01.NEXTVAL next FROM dual;

-- 임시로 데이터를 입력할 테이블을 하나 만든다.
CREATE TABLE tmp01(
    no NUMBER(3)
        CONSTRAINT TMP01_NO_PK PRIMARY KEY,
    name VARCHAR2(10 CHAR) DEFAULT 'DOOLY'
        CONSTRAINT TMP01_NAME_NN NOT NULL
);

-- 데이터를 채워본다.
INSERT INTO
    tmp01(no)
VALUES(
    seq01.currval
);

INSERT INTO
    tmp01
VALUES(
    seq01.nextval, '마이콜'
);

INSERT INTO
    tmp01
VALUES(
    seq01.nextval, '또치'
);

SELECT * FROM tmp01;


INSERT INTO
    tmp01
VALUES(
    seq01.nextval, 'aaaaaaaaaaa'
);


INSERT INTO
    tmp01
VALUES(
    seq01.nextval, '도우너'
);

SELECT * FROM tmp01;

commit;

/*
    시퀀스의 문제점
        ==> 시퀀스는 테이블에 종속되지 않고 독립적으로 작동한다.
            즉, 한번 만든 시퀀스는 여러 테이블에서 사용할 수 있다.
            이때 어떤 테이블에서 시퀀스를 사용하던지 간에
            nextval은 항상 다음번호를 만들어준다.
            
            그리고
            입력에 실패하더라도 nextval을 호출하면
            입력에 실패할 때 만든 번호의 다음번호를 만들게 된다.
            
            따라서 시퀀스를 사용하게되면 중간에 누락된 번호가 생길 수 있다.
            
            
    시퀀스 수정하기
       ==> 시퀀스도 개체이기 때문에 수정할 때는 DDL 명령을 사용해서 수정을 해야 한다.
       
        형식 ]
            ALTER SEQUENCE 시퀀스이름
                INCREMENT BY    숫자
                MAXVALUE    숫자
                MINVALUE    숫자
                CYCLE 또는 NOCYCLE
                CACHE 또는 NOCACHE
             ;   
        
        참고 ]
            시퀀스를 수정할 때는 시작번호는 수정할 수 없다.
            왜냐하면 이미 발생한 번호가 있기 때문에...
            시작번호는 이전에 만들어놓은 시작번호가 자동으로 시작번호가 된다.
            
    --------------------------------------------------------------------------------------------------------------------------
    시퀀스 삭제하기
        형식 ]
            DROP SEQUENCE 시퀀스이름;
*/

-- SEQ01의 증가값을 3으로 수정해보자.
ALTER SEQUENCE seq01
    INCREMENT BY 3
;

SELECT seq01.currval FROM DUAL;

SELECT seq01.nextval FROM dual;

-- seq01 을 삭제
DROP SEQUENCE seq01;

-- 회원의 일련번호를 만들어주는 시퀀스를 만드세요.
-- 단, 시작값은 1000, 최대값은 9999로 하고 최대값에 도달했을때 다시 반복하지 않도록하고, 
-- 캐쉬기능 사용하지 않는 것으로 1씩 증가하게 만든다.

























