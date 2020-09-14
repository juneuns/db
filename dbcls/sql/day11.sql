-- day11

/*
    for 명령
        
        형식 1 ]
            
            FOR  변수이름 IN (질의명령) LOOP
                처리내용
                ...
            END LOOP;
            
            의미 ]
                질의 명령의 결과를 변수에 한줄씩 기억한 후
                원하는 내용을 처리하도록 한다.
        
        형식 2 ]
            
            FOR 변수이름 IN 시작값 .. 종료값 LOOP
                처리내용
                ...
            END LOOP;
            
            의미 ]
                시작값부터 종료값 까지 1씩 증가시켜서
                처리내용을 반복한다.
*/

-- 시원들의 이름을 출력하는 무명 프로시저를 작성하세요.
/*
DECLARE 
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR name IN (SELECT ename FROM emp) LOOP
        DBMS_OUTPUT.PUT_LINE(name);
    END LOOP;
END;
/

*/

-- 1 부터 10 까지 출력해주는 무명 프로시저를 작성하고 실행하세요.
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR no IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(no || ' 번째');
    END LOOP;
END;
/

/*
    WHILE 명령
        
        형식 1 ]
            
            WHILE 조건식 LOOP
                처리내용
            END LOOP;
            
            의미 ]
                조건식이 참인경우 처리내용을 반복해서 실행하세요.
            
        형식 2 ]
            
            WHILE 조건식1 LOOP
                처리내용
                
                EXIT WHEN 조건식2;
            END LOOP;
            
            의미 ]
                조건식1이 참이면 반복하지만
                만약 조건식2가 참이면 반복을 종료한다.
                즉, 자바의 break 와 같은 기능을 하는 명령이
                        EXIT WHEN 
                    구문이다.
                    
                    
    LOOP( DO ~ WHILE ) 명령
        형식 ]
            
            LOOP
                처리내용
                EXIT WHEN 조건식;
            END LOOP;
            
--------------------------------------------------------------------------------------------------------------------------------

    조건문
        
        IF 명령
            
            형식 1 ]
                
                IF 조건식 THEN
                    처리내용
                END IF;
                
            형식 2 ]
                
                IF 조건식 THEN
                    쳐리내용1
                ELSE
                    처리내용2
                END IF;
                
            형식 3 ]
                
                IF  조건식 THEN
                    처리내용1
                ELSIF 조건식 THEN
                    처리내용2
                ...
                ELSE
                    처리내용N
                END IF;
*/

-- 사원번호를 입력하면 사원이름, 부서번호, 직급을 조회하는 무명프로시저를 작성해서 실행하세요.
-- 단, 없는 번호를 입력하면 '존재하지 않는 사원입니다.' 라로 출력되게 하세요.
CREATE OR REPLACE PROCEDURE e_inof03(
    eno emp.empno%TYPE
)
IS
    cnt NUMBER;
    i_emp emp%ROWTYPE;
BEGIN
    SELECT 
        COUNT(*)
    INTO 
        cnt
    FROM
        emp01
    WHERE
        empno = eno
    ;
    
    IF cnt = 1 THEN
        SELECT
            *
        INTO
            i_emp
        FROM
            emp01
        WHERE
            empno = eno
        ;
        
        DBMS_OUTPUT.PUT_LINE(' 사원이름 | 부서번호 | 직급 ');
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 25, '-'));
        DBMS_OUTPUT.PUT_LINE(RPAD(i_emp.ename, 9, ' ') || '| ' || RPAD(i_emp.deptno, 9, ' ') || '| ' || i_emp.job);
    ELSE
        DBMS_OUTPUT.PUT_LINE(eno || ' 번 사원은 존재하지 않는 사원입니다.');
    END IF;
END;
/


exec e_inof03(7902);

exec e_inof03(8000);














