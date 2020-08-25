SELECT
    empno 사원번호, 
    CONCAT(
        RPAD(
            SUBSTR(ename, 1, 1),
            LENGTH(ename) - 1, '*'),
        SUBSTR(ename, -1)
    ) 사원이름
FROM
    emp
;

-- 이름의 세번째 문자만 출력하고 나머지 문자들은 * 로 각각 대체해서 조회하세요.
SELECT
    empno,
    RPAD(-- 3. 전체 길이만큼 만들어주고 채운문자는 오른쪽에 * 로 채워준다.
        LPAD(-- 2. 꺼낸문자의 왼쪽에 * 를 채워준다.
            SUBSTR(ename, 3, 1), -- 1. 세번째 문자만 꺼낸다.
            3, '*'),
        LENGTH(ename), '*') 이름
FROM
    emp
;

/*
    세번째 날...
    
    날짜 함수
        
        **
        참고 ]
            sysdate     -   시스템의 현재 날짜/시간을 알려주는 예약어
        참고 ]
            TO_CHAR(날짜데이터, 형식문자)    --> 날짜데이터를 문자열로 변환해주는 함수
            
            형식문자
                YYYY
                YY
                MM
                MON
                DD
                DAY
                
                AM | PM
                HH | HH12   -   시간을 0 ~ 12 까지 표현
                HH24        -   시간을 0 ~ 23 까지 표현
                MI          -   분(0 ~ 59)
                SS          -   초(0 ~ 59)
            
        참고 ]
            TO_DATE(날짜형식 문자열, 형식 문자열)   --->    문자데이터를 날짜데이터로 변환해주는 함수
            
            주의사항 ]
                날짜데이터를 만들때 시간을 정하지 않으면 0시0분0초로 셋팅이 된다.
                
------------------------------------------------------------------------------------------------
    참고 ]
        날짜 - 날짜의 연산식을 허락한다.
        <=== 날짜 연번끼리 - 연산을 한다.
        
    참고 ]
        오라클에서 날짜를 기억하는 방법
        1970년 1월 1일 0시 0분 0초에서
        지정한 날짜까지의 날짜연번을 이용해서 기억한다.
        
        날짜연번이란
        날수.시간 의 형태로 숫자로 표현된 것.
        
    참고 ]
        날짜 - 날짜 는 허락하지만 
        날짜 +( *, /) 날짜 는 허락하지 않는다.
        
    참고 ]
        날짜 + 숫자 의 연산은 허락한다.
        ==> 날짜 연번은 숫자이므로
            결국 날짜에서 원하는 숫자만큼 이동된 날짜를 표시한다.
        

*/

-- sysdate
SELECT to_char(sysdate, 'yyyy/MM/dd DAY HH:mi:ss') 오늘날짜 FROM dual;

SELECT TO_DATE('2020/08/25 09:30:00', 'YYYY/MM/DD HH24:MI:SS') 수업시작시간 FROM dual;

SELECT
    TO_CHAR(
        TO_DATE('2020/08/25', 'YYYY/MM/DD'),
        'YYYY/MM/DD HH24:MI:SS'
    ) 오늘시작시간
FROM
    dual
;

-- 사원의 이름, 사원의 근무 일수를 계산해서 조회하세요.
SELECT
    ename 사원이름, hiredate 입사일,
    CONCAT(FLOOR(sysdate - hiredate), ' 일')  근무일수
    -- 이 경우 FLOOR(sysdate - hiredate) 는 숫자데이터이고 형변환함수(TO_CHAR())가 자동 호출되어서 처리된다.
FROM
    emp
;


-- 문제 ] 개강일부터 오늘까지 날수를 조회하세요.
SELECT
    FLOOR(SYSDATE - TO_DATE('2020/07/15', 'YYYY/MM/DD')) 개강이후날수
FROM
    dual
;


SELECT
    TO_CHAR(SYSDATE + 7, 'YYYY/MM/DD HH24:MI:SS') 일주일후
FROM
    dual
;

/*
--------------------------------------------------------------------------------
    
    날짜함수
        
        1. ADD_MONTHS
            ==> 날짜데이터에 지정한 달 수를 더하거나 뺀 날짜를 알려준다.
            형식 ]
                ADD_MONTHS(날짜데이터, 개월수)
                
            참고 ]
                더할 개월수가 음수이면 뺀 날짜를 알려준다.
*/

-- 오늘 날짜에서 3개월 후의 날짜를 조회하세요.
SELECT ADD_MONTHS(SYSDATE, 3) FROM dual;

-- 사원의 이름, 입사일에서 2개월 이전은 몇일인지 조회하세요.
SELECT ename 사원이름, hiredate 입사일, ADD_MONTHS(hiredate, -2) 입사2개월전 FROM emp;

/*
    2. MONTHS_BETWEEN
        ==> 두 날짜 사이의 간격을 월 단위로 알려주는 함수
        
        형식 ]
            MONTHS_BETWEEN(날짜, 날짜)
*/
-- 자신이 태어난 날 부터 몇개월이 됬는지 조회하세요.
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('1971/12/26', 'YYYY/MM/DD'))) 개월수 FROM dual;

-- 문제 ] 사원의 입사일은 몇개월전인지 조회하세요.
SELECT ename 사원이름, hiredate 입사일, FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) 개월수 FROM emp;

/*
    3. 
*/