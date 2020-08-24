# day02

/*
    특별한 조건 연산자
        
        1. BETWEEN ~ AND
            ==> 데이터가 특정 범위 안에 있는지를 확인하는 조건식
            
            형식 ]
                데이터(컬럼 | 필드) BETWEEN 데이터1 AND 데이터2;
                
            의미 ]
                필드의 내용이 데이터1과 데이터2 사이에 있는지를 검사한다.
                이때 데이터1, 데이터2도 포함이 된다.
                
            예 ]
                급여가 1300 ~ 3000 사이의 사원의 이름, 급여를 조회하세요.
                
        참고 ]
            이 연산자도 NOT 연산자를 사용할 수 있다.
            
            형식 ]
                데이터 NOT BETWEEN 데이터1 AND 데이터2
                
            의미 ]
                데이터가 데이터1 과 데이터2의 범위안에 포함되지 않을 경우...
*/
SELECT
    ename 사원이름, sal 사원급여
FROM
    emp
WHERE
    sal BETWEEN 1300 AND 3000
;

-- 급여가 1000 미만이거나 3000을 초과하는 사원의 이름, 급여를 조회하세요.
SELECT
    ename 사원이름, sal 사원급여
FROM
    emp
WHERE
    sal NOT BETWEEN 1000 AND 3000
/*    
    sal < 1000
    OR sal > 3000
*/
;

/*
    IN 연산자
    ==> 데이터가 주어진 여러개의 데이터중 하나라도 만족하는지를 알아보는 연산자
    
    형식 ]
        필드(데이터) IN(데이터1, 데이터2, 데이터3, ...)
    의미 ]
        필드의 내용이 데이터1, 데이터2, 데이터3, ... 중 하나라도 일치하느냐???
*/

-- 부서번호가 10과 30번인 사원의 사원이름, 부서번호를 조회하세요.
SELECT 
    ename 사원이름, deptno 사원번호
FROM
    emp
WHERE
    deptno = 10
    OR deptno = 30
;

SELECT 
    ename 사원이름, deptno 부서번호
FROM
    emp
WHERE
    deptno IN(10, 30)
;

-- 부서번호가 20번 30번이 아닌 사원의 사원번호, 사원이름, 부서번호를 조회하세요.
SELECT
    empno 사원번호, ename 사원이름, deptno 부서번호
FROM
    emp
WHERE
    deptno NOT IN(20, 30)
    /*
    deptno <> 20
    AND deptno <> 30
    */
;

-- 문제 ]
--      직급이 MANAGER, SALESMAN이 아닌 사원의 사원번호, 사원이름, 직급, 급여를 조회하세요.
SELECT
    empno 사원번호, ename 사원이름, job 사원직급, sal 사원급여
FROM
    emp
WHERE
    job NOT IN('MANAGER', 'SALESMAN')
;

-----------------------------------------------------------------------------------------------
/*
    ***
    LIKE 연산자
    ==> 문자열을 처리하는 경우에만 사용하는 방법
        문자열의 일부를 와일드카드 처리하여
        조건식을 제시하는 방법
        
        형식]
            필드이름(데이터) LIKE '와일드카드 포함 문자열'
        의미 ]
            필드의 데이터가 지정한 문잗열과 동일한지를 판단한다.
            
        참고 ]
            와일드카드
            
            _   :   문자 한개당 한글자만 와일드카드로 지정한 것
            %   :   글자수에 상관없이 모든 문자를 포함하는 와일드 카드
            
            
            예 ]
                'M_'    :   M으로 시작하는 두글자 문자열
                'M%'    :   M으로 시작하는 모든 문자열
                '%M'    :   M으로 끝나는 모든 문자열
                '%M%'   :   M이 포함된 모든 문자열
                '__%'   :   두자 이상으로 된 문자열
                '___'   :   세글자로 된 문자열
*/

-- 사원의 이름이 5글자인 사원의 이름, 직급, 사원번호를 조회하세요.
SELECT
    ename 사원이름, job 사원직급, empno 사원번호
FROM
    emp
WHERE
    ename LIKE '_____'
--    length(ename) = 5 -- 문자열의 길이를 반환해주는 함수
;

-- 입사일이 1월인 사원의 사원번호, 사원이름, 입사일을 조회하세요.
SELECT
    empno 사원번호, ename 사원이름, hiredate "입 사 일"
FROM
    emp
WHERE
    hiredate LIKE '__/01/__'
;

-- 문제 1] 직급이 MANAGER가 아닌 사원들의 이름, 직급, 입사일을 조회하세요.
SELECT
    ename 사원이름, job 사원직급, hiredate 입사일
FROM
    emp
WHERE
--    NOT job = 'MANAGER'
--    job <> 'MANAGER'
--    job != 'MANAGER'
    job NOT IN('MANAGER')
;
-- 문제 2] 사원이름이 'C'로 시작하는 것보다 크고
--          'M'으로 시작하는 것 보다 작은 사원만 이름, 직급, 급여를 조회하세요.
--          단, BETWEEN 연산자를 사용하세요.
SELECT
    ename 사원이름, job 사원직급, sal 사원급여
FROM
    emp
WHERE
    ename BETWEEN 'D' AND 'LZZZZZZZZZZZZZZZ'
;
/*
    문제 3 ] 
        급여자 800, 950이 아닌 사원의 
        이름, 직급, 급여를 조회하세요.
        단, IN 연산자를 사용해서 처리하세요.
*/
SELECT
    ename 이름, job 직급, sal 급여
FROM
    emp
WHERE
    sal NOT IN(800, 1000 - 50)
;
-- 문제 4] 이름이 'S'로 시작하고 글자수가 5글자인 사원의 이름, 직급을 조회하세요.
SELECT
    ename 이름, job 직급
FROM
    emp
WHERE
    ename LIKE 'S____'
/*
    SUBSTR(ename, 1, 1) = 'S'
    AND LENGTH(ename) = 5
*/
;
-- 문제 5] 사원의 이름이 4글자이거나 5글자인 사원의 이름, 직급을 조회하세요.
SELECT
    ename 이름, job 직급
FROM
    emp
WHERE
/*
    ename LIKE '____'
    OR ename LIKE '_____'
*/
    LENGTH(ename) IN(4, 5)
;
-- 문제 6] 사원의 이름이 'S'로 끝나는 사원의
--          이름, 급여, 커미션을 조회하세요.
--          단,  커미션은 현재 커미션의 100을 증가시켜서 조회하고
--          커미션이 없는 사원은 100을 주도록 조회하세요.
SELECT
    ename 이름, sal 급여, comm 커미션, (NVL(comm, 0) + 100) 인상커미션
FROM
    emp
WHERE
    ename LIKE '%S'
;

-- 보너스 ] 급여가 세자리 수인 사원의 이름, 직급, 급여를 조회하세요.
--      참고 ] 숫자를 문자로 바꿔주는 형변환 함수  TO_CHAR(숫자)
SELECT
    ename, job, sal
FROM
    emp
WHERE
--    TO_CHAR(sal) LIKE '___' -- ==> 5.5
    sal BETWEEN 100 AND 1000
    AND SAL NOT IN(1000)
;

----------------------------------------------------------------------------------------------

/*
    NULL 검색
        ==> NULL 데이터는 모든 연산에서 제외가 된다.
            따라서 조건식의 조건연산도 제외가가 된다.
            
        NULL 검색 이란?
            NULL 데이터를 찾아보는 조건 명령
            
        형식 ]
            필드이름 IS NULL
            ==> 필드값이 NULL인 데이터만 조회하라.
            
            필드이름 IS NOT NULL
            ==> 필드의 값이 NULL이 아닌 데이터만 조회
*/

-- 문제 ] 커미션이 NULL 인 사원의 사원이름, 급여, 커미션을 조회하세요.

SELECT
    ename, sal, comm
FROM
    emp
WHERE
    comm IS NULL
;

-- 상사가 없는 사원의 사원번호, 사원이름, 상사번호, 급여를 조회하세요.
SELECT
    empno 사원번호, ename 사원이름, '사장', mgr 상사번호, sal 급여
FROM
    emp
WHERE
    mgr IS NULL
;

--------------------------------------------------------------------------------
/*
    조회된 결과의 순서를 변경하는 방법
    (정렬하는 방법)
    ==> 원칙적으로 데이터베이스는 종류에 따라 나름의 기준을 가지고 있다.
        그 기준으로 조회된 데이터를 정렬해서 출력해준다.
        ==> 입력순서대로 출력되는 것은 아니다.
        
    따라서 항상 정확한 순서대로 출력을 하도록 하기 위해서는
    출력순서를 지정해야 한다.
    
    형식 ]
        
        SELECT
            필드이름, 필드이름,...
        FROM
            테이블 이름
        ORDER BY
            필드이름 [ASC] | DESC, 필드이름 [ASC] | DESC
        ;
        
        참고 ]
            ASC : 오름차순 정렬. 생략해도 기본정렬방식이 오름차순이므로 가능.
            DESC : 내림차순 정렬
        
        참고 ]
            먼저 정렬한 결과를 다시 정렬하고자 하면
            , 를 구분자로 나열하면 된다.
*/


SELECT
    empno eno, ename name, deptno dno
FROM
    emp
WHERE
    ename NOT LIKE 'J%'
ORDER BY
    dno DESC, name DESC
;

-- 사원의 이름, 직급, 입사일을 조회하세요.
-- 단, 입사일 기준으로 먼저 입사한 사람부터 조회되게 하세요.

SELECT
    ename, job, hiredate
FROM
    emp
ORDER BY
    hiredate ASC
;

-- 사원의 이름, 직급, 입사일을 조회하세요.
-- 단, 사원이름이 긴 사람부터 조회되게 조회를하고
--  같은 글자수면 이름순으로 오름차순으로 정렬되게 조회하세요.

SELECT
    ename, LENGTH(ename) 이름길이, job, hiredate
FROM
    emp
ORDER BY
    LENGTH(ename) DESC, ename ASC
;

-- 사원중 이름이 다섯글자인 사람들의 
-- 이름, 직급, 급여 를 조회하세요.
-- 정렬은 급여가 많은 사람부터 조회되게 하세요.
SELECT
    ename, job, sal
FROM
    emp
WHERE
--    ename LIKE '_____'
    LENGTH(ename) = 5
ORDER BY
    sal DESC
;
--------------------------------------------------------------------------------
/*
집합 연산자
==> 두개 이상의 SELECT 질의 명령을 이용해서
    그 결과의 집합을 얻어내는 명령
    
    형식 ]
        SELECT ... FROM... [] -- 질의명령1
            집합연산자
        SELECT ... FROM... [] -- 질의명령2
        
    종류 ]
        UNION       합집합의 개념으로 두가지 질의명령의 결과를
                    하나로 합쳐서 보여주는 연산자
        
        UNION ALL   위와 동일하다.
                    단, UNION은 중복데이터를 제거해서 조회하지만
                    UNION ALL은 중복 데이터도 여러번 추가한다.
                    
                    참고 ]
                        중복 데이터란
                        모든 필드의 내용이 같은 데이터를 말한다.
        
        INTERSECT   교집합의 개념
                    질의명령의 결과중 양쪽 모두 존재하는 것만 조회하는 명령
        
        MINUS       차집합의 개념
                    앞의 질의명령에서 뒤의 질의명령에 포함된 데이터를 빼서 
                    조회하는 명령
                    
    참고 ]
        공통적인 특징
            1. 두 질의 명령에서 나온 결과는
                필드의 갯수가 같아야 한다.
                
            2. 두 질의 명령에서 나온 결과는
                필드의 형태가 같아야 한다.
        
        
    참고 ]
        집합연산의 결과도 정렬해서 조회할 수 있다.
        이때는 반드시 ORDER BY 를 마지막 질의 뒤에 한번만 위치시켜야 한다.
*/


SELECT
    ename, mgr
FROM
    emp
union
SELECT
    job, sal
FROM
    emp
;

SELECT EMPNO FROM EMP
UNION
SELECT ENAME FROM EMP; -------------------- x

SELECT ename, sal FROM emp --  ORDER BY ENAME 붙이면 에러
UNION
SELECT ename, comm FROM emp 
ORDER BY ENAME
;

--------------------------------------------------------------------------------
/*
    오라클에서 지원하는 데이터 타입
        종류 ]
            
            CHAR        -  고정 길이형 문자데이터 타입  ( 2000 바이트)
            VARCHAR2    -  가변 길이형 문자데이터 타입  ( 4000 바이트)
            NUMBER      - 숫자 데이터 타입              ( 38자리 까지 저장)
            DATE        - 날짜 데이터 타입
            
            NVARCHAR2   - 국가별 문자 집합에 따른 사이즈를 지정, 
                        바이트 기반의 문자데이터 타입    ( 4000 바이트)
            CLOB        - 대용량 텍스트 데이터 저장 타입 (4GB)
            BLOB        - 대용량 바이너리 데이터 저장 타입(4GB)
            ROWD        - 데이블 내 행의 고유주소를 가지는 64진수 문자 타입
            TIMESTAMP   - DATE 의 확장 타입
            
-------------------------------------------------------------------------------
    산술 연산자
        
        +
        -
        * 
        /
            
    비교 연산자
        =
        <>, !=, ^=
        >
        <
        >=
        <=
        
        BETWEEN ~ AND
        IN()
        
        LIKE ''
          
    논리 연산자
        
        AND
        OR
        NOT
    
    
-------------------------------------------------------------------------------
    DUAL 테이블
        오라클이 제공하는 의사(가상)테이블
*/

SELECT DISTINCT 3 * 4 FROM emp;

SELECT 3 * 4 FROM dual;

SELECT
    rownum, empno, ename, mgr, level
FROM
    emp
START WITH
    mgr IS NULL
CONNECT BY
    PRIOR empno = mgr
;

--------------------------------------------------------------------------------
/*
    함수
    ==> 데이터를 가공하기 위해 오라클이 제공하는 명령들....
    
    참고 ]
        DBMS는 데이터베이스마다 다르다.
        특시 함수는 데이터베이스마다 모두 다르다.
        
    종류 ]
        
        1. 단일행 함수
            ==> 한행 한행마다 매번 명령이 실행되는 함수
                따라서 단일행 함수의 결과는 출력되는 데이터의 갯수와 동일하다.
        
        2. 그룹 함수
            ==> 여러줄의 모아서 한번만 실행되는 함수
                따라서 출력되는 개수는 오직 한개이다.
        
        *****
        주의사항 ]
            단일행 함수, 일반 필드와 그룹함수는 같이 사용할 수 없다.
*/

SELECT 
    JOB, COUNT(*) CNT
FROM
    EMP
GROUP BY
    JOB
ORDER BY
    COUNT(*)
;

-- 부서별 급여총액 
SELECT
    deptno, sum(sal)
FROM
    emp
-- WHERE
--     sum(sal) > 10000    
GROUP BY
    deptno
--HAVING
--    SUM(sal) > 10000
;

--------------------------------------------------------------------------------
/*
    1. 단일행 함수
        
        1) 숫자함수
            ==> 데이터가 숫자인 경우에만 사용할 수 있는 함수
            
            A) ABS()    - 절대값을 구하는 함수
                형식 ]
                     ABS(데이터 또는 필드)
                     
            B) FLOOR()  - 소수점 이하를 버리는 함수(정수로 만들어주는 함수)
                형식 ]
                    FLOOR(데이터 혹은 필드)
            
            C) ROUND()  - 
            D) TRUNC()
            E) MOD()
            
            
            
        2) 문자함수
        
        3) 날짜함수
*/

-- ABS()
SELECT ABS(10 * -1) FROM dual;

-- FLOOR() : 사원의 급여를 15% 인상한 금액으로 조회하세요.  단, 소수점 이하는 버림.

SELECT
    empno, sal, (sal * 1.15) 인상급여, FLOOR(sal * 1.15) 버림급여
FROM
    emp
;