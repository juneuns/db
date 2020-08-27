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










