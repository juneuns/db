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

















