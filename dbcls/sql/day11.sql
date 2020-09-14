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
                
            참고 ]
                FOR 명령에서 사용할 변수는 미리 만들지 않아도 된다.
                이 변수는 자동적으로 %ROWTYPE 변수가 된다.
                %ROWTYPE 변수는 묵시적으로 멤버변수를 가지게 된다.
                
                예 ]
                    
                    FOR e IN (SELECT * FROM emp) LOOP
                        처리내용
                    END LOOP;
                    ==> 이때 변수 e 는 자동적으로  %ROWTYPE 변수가 된고
                        e에는 멤버변수 empno, ename, sal, mgr, .... 을 가지게 된다.
                        따라서 꺼낼때는 
                            e.empno, e.ename, e.sal,....
                        의 형식으로 꺼내서 사용해야 한다.
        
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

DECLARE
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR data IN (SELECT rownum rno, ename, 100 num FROM emp) LOOP
        DBMS_OUTPUT.PUT_LINE(data.rno || ' 번째 사원 ] ' || data.ename || ' - ' || (data.num + data.rno));
    END LOOP;
END;
/


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


/*
    문제 1 ]
        FOR ~ LOOP 문을 사용해서 구구단 5단을 출력하세요.
        
        심화 ]
            구구단을 출력하세요.
*/
DECLARE
    dan NUMBER := 5; -- 내부변수 선언 및 초기화
BEGIN
    FOR gop IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(dan || ' x ' || gop || ' = ' || (dan * gop));
    END LOOP;
END;
/

DECLARE
BEGIN
    FOR dan IN 2 .. 9 LOOP
        FOR gop IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(dan || ' x ' || gop || ' = ' || (dan * gop));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
/*
    문제 2 ]
        
        IF ~ ELSIF 구문을 사용해서
            emp01 테이블의 사원의 정보를 조회하는데
            사원번호, 사원이름, 부서번호, 부서이름
            의 형식으로 조회하고
            부서번호가 10 이면 '회계부'
                        20 - 개발부
                        30 - 영업부
                        40 - 운영부
            로 출력하세요.
*/

DECLARE
    part VARCHAR2(20 CHAR);
BEGIN
    DBMS_OUTPUT.PUT_LINE(LPAD('=', 45, '='));
    DBMS_OUTPUT.PUT_LINE(' 사원번호 | 사원이름 | ' || RPAD(LPAD('부서번호', 10, ' '), 12, ' ') || ' | 부서이름 ');
    DBMS_OUTPUT.PUT_LINE(LPAD('-', 45, '-'));
    FOR e IN (SELECT empno eno, ename name, deptno dno FROM emp01) LOOP
        IF (e.dno = 10) THEN
            part := '회계부';
        ELSIF (e.dno = 20) THEN
            part := '개발부';
        ELSIF (e.dno = 30) THEN
            part := '영업부';
        ELSE
            part := '운영부';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(e.eno), 9, ' ') || ' | '|| RPAD(e.name, 8, ' ') ||
                                    ' | '|| RPAD(e.dno, 12, ' ') || ' | ' || RPAD(part, 8, ' '));
        DBMS_OUTPUT.PUT_LINE(LPAD('-', 45, '-'));
    END LOOP;
END;
/

-- 입사 년도를 입력하면 행당 해에 입사한 사원들의 사원번호, 사원이름, 입사일 을 출력하는 
--  저장프로시저(proc01)을 제작하고 실행하세요.









