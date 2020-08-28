-- day05

/*
    JOIN(조인)
    ==> 두개 이상의 테이블에 있는 내용을 동시에 검색하는 방법
    
    참고 ]
        오라클은 ER(ENTITY RELATION) 형태의 데이터베이스라고도 한다.(관계형 데이터베이스)
        
        ER 형태란?
            엔티티끼리의 릴레이션십 관계를 이용해서 데이터를 관리한다.
            
        예를 들어 쇼핑몰에서 판매관리를 하고자 하면
        
            누가      -   이름, 주소, 전화번호
            언제      -   주문일자
            무엇을     - 상품이름, 가격, 제조회사,...
            몇개      
            
            전은석     서울시 관악구 010-3175-9042   20/08/27    에르메스 애플 스마트워치         1
            윤요셉     서울시 관악구 010-5569-8600   20/08/27    에르메스 애플 스마트워치         3
            이지우     인천시 부평구 010-3843-4798   20/08/27    LG 그램   LG  노트북             1
            전은석     서울시 관악구 010-3175-9042   20/08/26    LG 그램   LG  노트북             5
            
            원래는 이렇게 저장해 놓아야 하는데...
            중복 데이터는 다른 테이블로 보관하도록 한다.
            
            구매정보    ---------> 엔티티
                전은석     에르메스    1   20/08/27
                윤요셉     에르메스    3   20/08/27
                이지우     그램        1   20/08/27
                전은석     그램        5   20/08/26
                
                
            구매자정보
                전은석     서울시 관악구 010-3175-9042
                윤요셉     서울시 관악구 010-5569-8600
                이지우     인천시 부평구 010-3843-4798
                
                
            상품정보
                에르메스 애플 스마트워치
                LG 그램   LG  노트북
                
            의 형태로 분리해서 저장한다.
            
        참고 ]
            오라클은 처음부터 여러개의 테이블을 동시에 검색하는 기능은 이미 가지고 있다.
            ==> 이처럼 두개 이상의 테이블을 동시에 검색하면
                Cartesian Product 가 만들어지고 그 결과를 검색하게 된다.
                
        조인이란?
            Cartesian Product 에 의해서 탄생된 결과물 중에서
            원하는 결과물만 뽑아내는 기술
    
    1. Inner Join   --- cartesian product 의 결과 집합 안에서 데이터를 추출하는 조인
        ==> 가장 일반적인 조인 방식
            두개의 테이블 중에서 같은 데이터만 골라서 조회하는 조인
        
        형식 ]
            SELECT
                조회필드,....
            FROM
                테이블1, 테이블2, ...
            WHERE
                조인조건식
            ;
        
            
        1) Equi Join
            --> 동등비교 연산자로 데이터를 추출하는 조인
            
        2) Non-Equi Join
            --> 동등비교 연산자가 아닌 연산자로 데이터를 추출하는 조인
            
        
    2. Outer Join   --- cartesian product 의 결과 집합 안에 없는 데이터를 추출하는 조인
    
    3. SELF JOIN
        - 하나의 테이블을 여러번 나열해서 원하는 데이터를 조회하는 조인
*/


SELECT
    *
FROM
    emp, dept
;

select * from emp;

select
    *
from
    emp e, emp s
where
    e.mgr = s.empno

;

-- non-equi join

SELECT
    *
FROM
    emp, salgrade
WHERE
--    sal BETWEEN losal AND hisal
    sal >= losal
    AND sal <= hisal
;

-------------------------------------------------------------------------------------------------------
-- Equi Join
-- 사원의 이름, 직급, 급여, 부서번호, 부서이름을 조회하세요.
SELECT
    ename 이름, job 직급, sal 급여, emp.deptno 부서번호, dname 부서이름
FROM
    emp, dept
WHERE
    -- 조인조건
    emp.deptno = dept.deptno
;

-- Non-Equi Join
-- 사원의 사원번호, 사원이름, 사원직급, 사원급여, 급여등급 을 조회하세요.
SELECT
    empno 사원번호, ename 사원이름, job 사원직급, sal 사원급여, grade 급여등급
FROM
    emp, salgrade
WHERE
/*
    sal >= losal
    AND sal <= hisal
*/
    sal BETWEEN losal AND hisal
;

/*
    조인에서도 조인 조건이외의 일반조건을 얼마든지 사용할 수 있다.
*/

-- 81년에 입사한 사람의 사원이름, 직급, 부서번호, 부서위치 를 조회하세요.
SELECT
    ename 사원이름, job 사원직급, hiredate 입사일, e.deptno 부서번호, loc 부서위치
FROM
    emp e, dept d
WHERE
    e.deptno = d.deptno
    AND TO_CHAR(hiredate, 'YY') = '81'
;

-- SELF JOIN
--  사원의 사원번호, 사원이름, 사원직급, 부서번호, 상사이름 을 조회하세요.
SELECT
    e.empno 사원번호, e.ename 사원이름, e.job 사원직급, e.deptno 부서번호, s.ename 상사이름
FROM
    emp e,  -- 사원정보테이블
    emp s   -- 상사정보테이블
WHERE
    e.mgr = s.empno
;

/*
    Outer Join
        ==> 조회할 데이터가 Cartesian Product 내에 없는 데이터를 조회하는 조인
        
        형식 ]
            SELECT
                조회할 필드
            FROM
                테이블1, 테이블2
            WHERE
                테이블1.필드(+) = 테이블2.필드(+)
            ;
            
            주의사항 ]
                (+) 기호는 NULL 로 표시되어야 할 데이터 쪽에 붙여준다.
*/

SELECT
    *
FROM
    emp e, emp s
where
    e.mgr = s.empno(+)
;

/*
    참고 ]
        테이블이 여러개 FROM 절에 나열이 되면
        대부분 추가된 테이블 갯수만큼 조인 조건이 부여되어야 한다.
        이때 논리연산자는 AND로 연결하면 된다.
*/

-- 사원의 사원이름, 입사일, 급여, 급여등급, 부서번호, 부서이름을 조회하세요.

SELECT
    ename 사원이름, hiredate 입사일, sal 급여, grade 급여등급, e.deptno, dname 부서이름
FROM
    emp e, dept d, salgrade
WHERE
    -- 부서테이블과 사원테이블 조인
    e.deptno = d.deptno
    -- 사원테이블과 급여등급테이블 조인
    AND sal BETWEEN losal AND hisal
;

-- 문제 ] 사원의 사원번호, 사원이름, 직급, 급여, 급여등급, 상사번호, 상사이름, 부서번호, 부서위치 를 조회하세요.
SELECT
    e.empno 사원번호, e.ename 사원이름, 
    e.job 직급, e.sal 급여, grade 급여등급, 
    e.mgr 상사번호, NVL(s.ename, '보  쓰') 상사이름, 
    e.deptno 부서번호, loc 부서위치
FROM
    emp e, emp s, dept d, salgrade
WHERE
    e.mgr = s.empno(+)
    AND e.sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
;

--------------------------------------------------------------------------------------------------------------------
/*
    문제 1 ]
        직급이 'MANAGER'인 사원의
        이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/

/*
    문제 2]
        급여가 가장 적은 사원의
        이름, 직급, 입사일, 급여, 부서이름, 부서위치를 조회하세요.
*/

/*
    문제 3 ]
        사원이름이 5글자인 사원의 
        이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/

/*
    문제 4 ]
        입사일이 81년이면서 직급이 CLERK 인 사원의
        이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/

/*
    문제 5 ]
        사원의 이름, 직급, 급여, 상사이름, 급여등급을 조회하세요.
*/

/*
    문제 6 ]
        사원의
        이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급을 조회하세요.
*/

/*
    문제 7 ]
        사원의
        이름, 직급, 급여, 상사이름, 부서이름, 부서위치, 급여등급을 조회하는데
        회사 평균급여보다 급여가 높은 사원만 조회하세요.
*/
SELECT 
    e.ename, e.job, e.sal, s.ename, dname, loc, grade
FROM
    emp e, emp s, salgrade, dept d
WHERE
    e.mgr = s.empno
    AND e.deptno = d.deptno
    AND e.sal BETWEEN losal AND hisal
    AND e.sal > (
                SELECT
                    AVG(sal)
                FROM
                    emp
            )
;
/*
    문제 8 ]
        사원의 이름, 직급, 급여, 부서번호, 부서이름, 부서위치를 조회하세요.
        단, 사원이 없는 부서도 같이 조회하세요.
*/
SELECT
    ename, job, sal, d.deptno, dname, loc
FROM
    emp e, dept d
WHERE
    e.deptno(+) = d.deptno
;

-- 급여가 부서 평균급여보다 많은 사원의 
--      사원번호, 사원이름, 급여, 부서번호, 
--      부서평균급여, 부서사원수, 부서급여합계 를 조회하세요.
/*
    Inline View : 서브질의중 from 절에 위치하는 서브질의
    
    인라인 뷰도 조인에 사용할 수 있다.
*/

-- 10번 부서의 급여평균
SELECT
    avg(sal)
FROM
    emp
WHERE
    deptno = 30
;



SELECT
    empno, ename, sal, e.deptno,
    (
        SELECT
            ROUND(AVG(sal), 2)
        FROM
            emp
        WHERE
            deptno = e.deptno
    ) 부서평균급여,
    (
        SELECT
            COUNT(*)
        FROM
            emp
        WHERE
            deptno = e.deptno
    ) 부서사원수,
    (
        SELECT
            SUM(sal)
        FROM
            emp
        WHERE
            deptno = e.deptno
    ) 부서급여합계
FROM
    emp e
WHERE
    sal > (
                SELECT
                    AVG(sal)
                FROM
                    emp
                WHERE
                    deptno = e.deptno
            )
;


--      사원번호, 사원이름, 급여, 부서번호, 
--      부서평균급여, 부서사원수, 부서급여합계 를 조회하세요.
SELECT
    empno, ename, sal, deptno, ROUND(avg, 2), cnt, sum
FROM
    emp,
    (
        SELECT
            deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt, SUM(sal) sum
        FROM
            emp
        GROUP BY
            deptno
    )
WHERE
    deptno = dno
;

SELECT
    deptno dno, MAX(sal) max, MIN(sal) min, AVG(sal) avg, COUNT(*) cnt, SUM(sal) sum
FROM
    emp
GROUP BY
    deptno
;

-- 사원수가 가장 많은 부서의 부서번호, 부서급여합계, 부서원수 를 조회하세요.

SELECT
    deptno 부서번호, SUM(sal) 부서급여합계, COUNT(*) 부서원수
FROM
    emp
GROUP BY
    deptno
HAVING
    count(*) = (
                    SELECT
                        max(count(*))
                    FROM
                        emp
                    GROUP BY
                        deptno
                )
;

-- 사원의 사원이름, 부서번호, 부서이름, 부서위치를 조회하세요.(서브질의로 처리하세요.)
SELECT
    e.ename 사원이름, e.deptno 부서번호,
    (
        SELECT
            dname
        FROM
            dept
        WHERE
            deptno = e.deptno
    ) 부서이름,
    (
        SELECT
            loc
        FROM
            dept
        WHERE
            deptno = e.deptno
    ) 부서위치
FROM
    emp e
;

SELECT
    scott.emp.ename
FROM
    scott.emp
;

SELECT 
    *
FROM
    hr.employees
;

-- quiz first_name 의 두번째 글자가 'a' 인 사원의 정보를 조회하세요.
SELECT 
    *
FROM
    hr.employees
WHERE
--    first_name LIKE '_a%'
    SUBSTR(first_name, 2, 1) = 'a'
;



/*
    ANSI JOIN
    ==> 질의 명령은 데이터베이스(DBMS)에 따라서 문법이 달라진다.
        
        ANSI SQL 이란?
            미국의 ANSI 협회에서 공통적으로 실행가능한 질의명령을 만들어서 사용하도록 해놓은 것.
            
    1. CROSS JOIN
        ==> 오라클에서의 Cartesion Product 를 만들어내는 조인과 같은 조인
        
        형식 ]
            SELECT
                필드이름
            FROM
                테이블1    CROSS JOIN  테이블2
            ;
*/

-- oracle cross join
SELECT
    *
FROM
    emp, dept
;

-- Ansi Cross Join
SELECT
    *
FROM
    emp CROSS JOIN  dept
;

/*
    ANSI INNER JOIN
        1. EQUI JOIN
        
        2. NON-EQUI JOIN
        
        3. SELF JOIN
-----------------------------------------------------------------------------------------------        
       INNER JOIN
        
        형식 ]
            SELECT
                조회할 필드,...
            FROM
                테이블1 INNER JOIN  테이블2
            ON
                조인조건식
            ;
        
    참고 ]
        ANSI JOIN 에서는 
        JOIN 조건은 ON  절에 기술하고
        일반 조건은 WHERE 절에 기술하는 것을 원칙으로 한다.
            
*/

-- 사원의 이름, 직급, 부서이름을 조회하세요.
SELECT
    ename 사원이름, job 직급, dname 부서이름
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
;

-- WARD 사원의 이름, 직급, 부서이름을 조회하세요.
SELECT
    ename 사원이름, job 직급, dname 부서이름
FROM
    emp e INNER JOIN dept d
ON
    e.deptno = d.deptno
WHERE
    ename = 'WARD'
;

/*
    ANSI OUTER JOIN
    ==> ORACLE OUTER JOIN고 같은 조인
        조인 조건식에 만족하는 데이터만 조회하고
        조인 조건식에 맞지 않는 데이터는 결과에서 제외한다.
        이런 경우 조인 조건식에 포함되지 않는 데이터도 
        조회에 포함되도록 하는 조건식이 OUTER JOIN 이다.
        
    형식 ]
        SELECT
        
        FROM
            테이블1 [ LEFT | RIGHT | FULL ] OUTER JOIN 테이블2
        ON
            조인조건식
        ;
        
        참고 ]
            LEFT | RIGHT : FULL 의 의미
            오라클 조인의 (+) 와 정반대의 사용법
            조건에 맞지 않아서 조회에서 제외된 데이터의 위치를 지정한다.
            즉 왼쪽테이블에 있는 데이터를 포함할지
                오른쪽테이블에 있는 데이터를 포함할지를 결정하는 것이다.
                
        참고 ]
            오라클 조인에서는 풀아우터 조인을 사용하지 못했지만
            ANSI JOIN 에서는 양쪽 모두 붙일 수 있도록 하고 있으며
            이때 FULL 이라고 쓰면 된다.
*/

-- 사원의 사원이름, 직급, 상사번호, 상사이름, 상사직급을 조회하세요.

SELECT
    e.ename 사원이름, e.job 사원직급, e.mgr 상사번호, s.ename 상사이름, s.job 상사직급
FROM
    emp e LEFT OUTER JOIN emp s
ON
    e.mgr = s.empno
;

-- 사원의 사원이름, 직급, 급여, 부서번호, 부서위치, 급여등급을 조회하세요.
SELECT
    ename, job, sal, e.deptno, loc, grade
FROM
    dept d
INNER JOIN 
    emp e 
ON
    e.deptno = d.deptno
INNER JOIN 
    salgrade
ON
    sal BETWEEN losal AND hisal
;

---------------------------------------------------------------------------------------------------------------
/*
    NATURAL JOIN
    ==> 자동조인으로 해석하면 된다.
        반드시 조인 조건식에 사용하는 필드의 이름이 동일하고
        반드시 동일할 필드가 한개인 경우에 한해서 사용할 수 있는 조인
        
        형식 ]
            SELECT
                필드이름,...
            FROM
                테이블1  NATURAL JOIN 테이블2
            ;
            
        참고 ]
            ON 이 없는 이유는?
            위에서 말한 전제조건 때문이다.
            즉, 두 테이블에 같은 이름의 필드가 딱 한개만 있다는 전제조건으로
            자동적으로 그 필드를 이용해서 조인하게 된다.
*/

-- 사원의 사원이름, 직급, 부서이름, 부서위치를 조회하세요.
SELECT
    ename 사원이름, job 직급, dname 부서이름, loc 부서위치
FROM
    emp
NATURAL JOIN
    dept
;


/*
    USING JOIN
        ==> 반드시 조인 조건식에 사용하는 필드의 이름이 동일한 경우
            같은 이름의 필드가 여러개 존재해도 무방하다.
            
        형식 ]
            SELECT
                조회필드, ...
            FROM
                테이블1 JOIN   테이블2
            USING
                (조인조건식에 사용할 필드이름)
            ;
*/

-- 사원의 사원이름, 직급, 부서번호, 부서이름, 부서위치를 조회하세요.
SELECT
    ename 사원이름, job 직급, deptno 부서번호, dname 부서이름, loc 부서위치
FROM
    emp JOIN dept
USING (deptno)
;

-- 사원수가 가장 많은 부서의 사원중 부서평균급여보다 많이 받는 사원들의
-- 사원이름, 직급, 급여, 부서번호, 부서평균급여, 부서원수 를 조회하세요.








SELECT
    *
FROM
    emp
INNER JOIN 
    salgrade
ON
    sal BETWEEN losal AND hisal
INNER JOIN
    dept
ON
    emp.deptno = dept.deptno
;