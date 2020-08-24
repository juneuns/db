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
            
            C) ROUND()  - 지정한 자릿수에서 반올림하는 함수
                형식 ]
                    ROUND(데이터 혹은 필드 [, 소수이하 자릿수])
                
                참고 ]
                    자리수를 음수로 표현하면 소수이상 자리수에서 반올림한다.
                    
            D) TRUNC()  - FLOOR() 와 마찬가지로 버림 함수. 추가적으로 자리수를 지정해 줄 수 있다.
                형식 ]
                    TRUNC(데이터 [, 자리수])
                    
            E) MOD()    - 나머지를 구하는 함수
                형식 ]
                    MOD(데이터1, 데이터2) ==> 자바의 데이터1 % 데이터2 와 같은 결과
                    
        참고 ]
            모든 함수는 출력에도 사용할 수 있고
            조건식에도 사용할 수 있다.
            
            
            
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


SELECT
    empno, sal, (sal * 1.15) 인상급여, FLOOR(sal * 1.15) 버림급여, ROUND(sal * 1.15, 1) 반올림급여
FROM
    emp
;

SELECT ROUND(45678, -2) FROM dual; -- 10의 자리에서 반올림

SELECT TRUNC(45.678, 2) FROM dual;  -- 소수 두째자리 까지만 보여주고 버림.

SELECT 10 %% 3 FROM dual;

-------------------------------------------------------------------------------------------------
/*

    참고 ]
        오라클에서 데이터 형변환
        ==> 원칙적으로 자동형변환은 허용하지 않는다.
            다만 함수가 호출되어서 형변환이 이뤄지는 경우는 있다.
            
        형변환 함수
            데이터의 타입을 변형시켜주는 함수
            아무때나 호출 할 수 있는 것은 아니고
            
            문자데이터는 날짜와 숫자 모두 변형이 가능하다.
            날짜데이터는 오직 문자데이터로만 변형이 가능하다.
            숫자데이터는 오직 문자데이터로만 변형이 가능하다.
            
                        <----- TO_DATE()                    ---------> TO_NUMBER()
            날짜데이터   <--------------->   문자데이터   <------------->     숫자데이터
                            -----> TO_CHAR()                <------ TO_CHAR()
                            
    참고 ]
        날짜데이터 필드에 문자데이터를 입력하는 경우 실행되는 경우는
        문자데이터가 입력이 되는 것이 아니고
        문자데이터를 변형시켜주는 형변환 함수가 자동호출되어서
        날짜데이터로 형변환이 되어서 실행되는 경우이다.
*/

INSERT INTO
    emp(empno, hiredate)
VALUES(
--    8000, '2020년 08월 24일' -------------- X
    8000, '2020/08/24'  --------------------- O
);
rollback;
----------------------------------------------------------------------------------------------
/*
    문자 함수
        
        1. LOWER
        2. UPPER
        3. INITCAP
        ==> 문자열을 소문자, 대문자, 첫글자만 대문자(나머지는 소문자)로 변환하는 함수
        
        형식 ]
            LOWER(데이터)
            
        참고 ]
            오라클은 명령어는 대소문자를 구분하지 않는다.
            하지만 데이터는 반드시 대소문자를 구분해야 한다.
            따라서 데이터베이스에 입력하는 사람이
            대문자로 입력했는지 아니면 소문자로 입력했는 구분해서 처리해야 한다.
            ==> 이런 경우 사용하는 함수
            
            
        4. LENGTH / LENGTHB
            ==> 문자열의 길이를 알아내는 함수
                LENGTHB : 바이트 수를 반환해주는 함수
                LENGTH : 문자갯수를 반환해주는 함수
                
            참고 ]
                문자열 함수 중에는 B로 끝나는 함수가 존재한다.
                B로 끝나는 함수는 처리를 바이트 단위로 하는 함수를 의미한다.
                B로 끝나지 않는 함수는 문자단위로 처리하는 함수를 의미한다.
                
        5. CONCAT
            ==> 두개의 문자열을 하나로 합치는 함수
                결합연산자 || 와 같은 기능
                
            형식 ]
                CONCAT(데이터1, 데이터2)
*/

-- INITCAP()
SELECT
    empno 사원번호, INITCAP(ename) 사원이름, LOWER(ename) 작은이름, UPPER(LOWER(ename)) 큰이름
FROM
    emp
;

-- account 부서의 부서번호를 조회하세요.
SELECT
    deptno 부서번호
FROM
    dept
WHERE
    LOWER(dname) LIKE '%account%'
;

SELECT
    '나두야 간다.' STR, LENGTH('나두야 간다.') LEN, LENGTHB('나두야 간다.') LENB
FROM
    dual
;

-- 사원번호, 사원이름을 조회하는데 사원이름은 앞에 'Mr.'을 붙여서 조회하세요.
SELECT
    empno 사원번호, CONCAT('Mr.', ename) 사원이름
FROM
    emp
;

SELECT
    empno 사원번호, CONCAT(CONCAT(empno, ' : '), ename) 사원이름
FROM
    emp
;

SELECT 
    empno 사원번호, empno || ' : ' || ename 사원이름
FROM
    emp
;
--------------------------------------------------------------------------------
/*
    6. SUBSTR / SUBSTRB
        ==> 문자열 중에서 특정 위치의 문자열만 추출해서 반환해주는 함수
        ***
        형식 ]
            SUBSTR(데이터, 시작위치, 꺼낼갯수)
            
        참고 ]
            자바는 위치르르 지정할 때 0부터 시작을 했지만
            데이터베이스에서는 위치의 시작값이 1부터 시작한다.
        
        참고 ]
            갯수는 생략할 수 있다.
            이때는 위치부터 마지막까지 꺼내온다.
*/

-- 'hong gil dong'에서 gil만 추출해보자.
SELECT
    SUBSTR('hong gil dong', 6, 3) gil
FROM
    dual
;

-- 'hong gil dong' 에서 'gil dong' 추출해보자.
SELECT
    'hong gil dong' name, SUBSTR('hong gil dong', 6) FIRST_NAME
FROM
    dual
;
--------------------------------------------------------------------------------
/*
    7. INSTR / INSTRB
    ==> 문자열 중에서 원하는 문자열이 몇번째 글자에 있는지를 반환해주는 함수
    
    형식]
        INSTR(데이터, 데이터2 [, 시작위치, 찾을 횟수])
        
     참고 ]
        시작위치는 음수로 사용할 수 있으며
        음수로 지정되면 뒤에서부터 시작위치를 지정하게 된다.
        찾는 방법도 뒤에서 부터 앞으로 진행하면서 찾게 된다.
        
    참고 ]
        만약 찾는 문자가 없으면 0을 반환해 준다.
*/

SELECT
    SUBSTR('hong gil dong', INSTR('hong gil dong','g', 1, 2)) NAME, INSTR('hong gil dong','g', 1, 2) IDX
FROM
    dual
;

SELECT
    INSTR('abcdcdecd', 'cd', -1)
FROM
    dual
;

-- 사원이름중 M이 포함된 사람의 정보를 조회하세요.
SELECT
    empno, ename, job
FROM
    emp
WHERE
--    INSTR(ename, 'M', 1) ^= 0
--    INSTR(ename, 'M', 1) != 0
    INSTR(ename, 'M', 1) <> 0
;
--------------------------------------------------------------------------------

/*
    8. LPAD / RPAD
    ==> 문자열의 길이를 지정한 후
        남는 공간은 지정한 문자로 채워주는 함수
        예 ]
            'HONG' 이라는 문자열을 10글자로 만들고 남는 부분은 앞에 #으로 채워주세요.
            ==> ######HONG
            
    형식 ]
        LPAD(데이터, 길이, 채울문자)
        
    참고 ]
        만약 데이터가 지정한 길이보다 크면 지정한 길이만 표현한다.
            
*/

SELECT
    LPAD('HONG', 10, '#') 이름, RPAD('HONG', 10, '#') 이름#
FROM
    dual
;

SELECT
    RPAD('hong gil dong' , 10, '#') 이름
FROM
    dual
;
--------------------------------------------------------------------------------
/*
    9. REPLACE
        ==> 문자열의 특정 부분을 다른 문자열로 대치하는 함수
        
        형식 ]
            REPLACE(데이터, 원본문자, 대치문자)
*/

SELECT
    REPLACE('hong gil dong', 'g', 'G') 이름
FROM
    dual
;
--------------------------------------------------------------------------------
/*
    10. TRIM
        ==> 문자열중에서 앞 혹은 뒤에 있는 지정한 문자를 삭제하는 함수
        
        참고 ]
            중간에 있는 문자는 삭제하지 못한다.
            
        형식 ]
            TRIM([삭제할문자 FROM ]데이터)
            
        10.1 LTRIM
        
        10.2 RTRIM
            형식 ]
                
                LTRIM(데이터, 삭제할 문자)
    
*/

SELECT
--    TRIM(' ' FROM '   abc def ghi   ') 글자
    TRIM('   abc def ghi   ') 글자
FROM
    dual
;

SELECT
    RTRIM(LTRIM('_____abc_def__ghi______', '_'), '_') 글자
    /*
        LTRIM('_____abc_def__ghi______', '_') ==> 'abc_def__ghi______'
    */
FROM
    dual
;
--------------------------------------------------------------------------------
/*
    11. ASCII
        ==> 문자에 해당하는 ASCII 코드값을 반환해주는 함수
        
        형식 ]
            ASCII(데이터)
            
        참고 ]
            데이터가 두글자 이상이면
            첫번째 글자만 처리를 한다.

*/

SELECT
    ASCII('Aa') -------> 첫문자 A 의 아스키 코드값을 반환해준다.
FROM
    dual
;
--------------------------------------------------------------------------------

/*
    12. CHR
        ==> ASCII 코드를 알려주면 그 코드에 해당하는 문자를 알려주는 함수
        
        형식 ]
            
            CHR(숫자)
*/

SELECT CHR(67) FROM dual;
--------------------------------------------------------------------------------

/*
    13. TRANSLATE
        ==> REPLACE와 마찬가지로 문자열중 지정한 부분을 다른 문자열로 교체하는 함수
        
            차이점 ]
                REPLACE 는 바꿀 문자를 전체를 바꾸는데 비해서
                이 함수는 문자 단위로 처리한다.
*/

SELECT
    TRANSLATE('ABCDCDCDECF', 'CDE', '123') 문자
FROM
    dual
;

--------------------------------------------------------------------------------