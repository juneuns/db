-- day12

/*
    커서(Cursor)
    ==> 실제로 실행되는 질의 명령을 기억하는 변수
        
        자주 사용하는 질의명령을 한번만 만든 후
        이 질의명령을 변수에 기억해서 
        마치 변수를 사용하듯이 질의명령을 실행하는 것.
    
    종류 ]
        1. 묵시적(암시적) 커서
            ==> 오라클에서 미리 만들어 놓고 제공해주는 커서를 말한다.
                우리가 지금까지 사용했듯이 
                직접 만들어서 실행된 질의 명령 자체를 의미
                
            참고 ]
                커서에는 내부 변수(멤버변수)가 존재한다.
                
                SQL%ROWCOUNT
                ==> 실행결과 나타난 레코드(행, ROW)의 개수를 기억하는 변수
                
                SQL%FOUND
                ==> 실행결과가 존재하는지 여부를 기억하는 변수
                
                SQL%NOTFOUND
                ==> 실행결과가 존재하지 않는지 여부를 기억하는 변수
                
                SQL%ISOPEN
                ==> 커서가 만들어졌는지 여부를 기억하는 변수
                
            
        2. 명시적 커서
        
*/

/*
    묵시적 커서 예제 ]
        
        사원번호를 입력하면
        그 사원의 이름을 알려주는 프로시저를 작성하세요.
        단, 사원번호가 잘못 입력되면 '해당사원은 없는 사원입니다.' 가 출력되게 하세요.
*/

-- 이전 방법 ( : COUNT(*) 호출해서 처리하는 방법 )
CREATE OR REPLACE PROCEDURE proc11(
    eno emp01.empno%TYPE
)
IS
    -- 이름 기억할 변수
    name emp01.ename%TYPE;
    
    -- 카운트 기억할 변수
    cnt NUMBER;
BEGIN
    -- 사원의 카운트 조회
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM
        emp01
    WHERE
        empno = eno
    ;
    
    -- 카운트에 따른 조건처리
    IF cnt >= 1 THEN
        
        SELECT
            ename
        INTO
            name
        FROM
            emp01
        WHERE
            empno = eno
        ;
        
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || eno);
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || name);
    ELSE
        DBMS_OUTPUT.PUT_LINE(eno || ' ] 번 사원은 없는 사원입니다.');
    END IF;
END;
/


execute proc11(7839);
execute proc11(8000);

-- 묵시적 커서를 사용하는 방법
CREATE OR REPLACE PROCEDURE proc11(
    eno emp01.empno%TYPE
)
IS
    name emp01.ename%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;

    SELECT
        ename
    INTO
        name
    FROM
        emp01
    WHERE
        empno = eno
    ;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || eno);
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || name);
    END IF;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('[ ' || eno || ' ] 번 사원은 없는 사원입니다.');
END;
/

execute proc11(7839);
execute proc11(8000);

/*
    예제 ]
        부서번호를 입력하면 해당 부서의 사원들의 급여를 10% 인상하는 프로시저를 작성하세요.
        그리고 인상된 사원이 모두 몇명인지 출력하세요.
*/

CREATE OR REPLACE PROCEDURE proc12(
    dno emp01.deptno%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    UPDATE
        emp01
    SET
        sal = sal * 1.1
    WHERE
        deptno = dno
    ; -- 이 질의명령이 실행되는 순간 묵시적 커서가 생겨난다.
--    commit;
    DBMS_OUTPUT.PUT_LINE(dno || ' 번 부서 ' || SQL%ROWCOUNT ||' 명 급여 10% 인상 완료');
END;
/

execute proc12(10);

rollback;

select * from emp01;

-------------------------------------------------------------------------------------------------------------
/*
    명시적 커서
    ==> 원래 커서의 의미처럼
        자주사용하는 질의명령을 미리 만든후
        필요하면 질의 명령을 변수를 이용해서 실행하도록 하는 것.
        
        명시적 커서의 처리 순서
            
            1. 명시적 커서를 만든다.
                ( ==> 명시적 커서를 정의한다. )
                
                형식 ] -- IS 절에 기술
                    CURSOR 커서이름 IS
                        필요한 질의명령
                        
            2. 반드시 커서를 프로시저에서 실행가능하도록 조치한다.
                (커서를 오픈시킨다.)
                
                형식 ]
                    OPEN 커서이름; -- BEGIN 절에 기술
                    
            3. 질의명령을 실행한다. ( 커서를 FETCH 시킨다. )
                
                형식 ]
                    FETCH   커서이름;
                    
            4. 사용이 끝난 커서는 회수한다. (커서를 CLOSE 시킨다. )
                
                형식 ]
                     CLOSE 커서이름;
                     
        참고 ]
            만약 커서가 FOR LOOP 명령 안에서 사용되면
            자동 OPEN, FETCH, CLOSE 가 된다.
            
        참고 ]
            명시적 커서에도 멤버변수를 사용할 수 있다.
            멤버변수는 암시적(묵시적) 커서와 동일하다.
                SQL%ROWCOUNT, SQL%FOUND, SQL%NOTFOUND, SQL%ISOPEN,...
                
        참고 ]
            커서도 필요하면 파라미터를 받아서 사용할 수 있다.
            (파라미터 변수를 선언할 수 있다.)
            
            형식 ]
                
                CURSOR 커서이름(파라미터변수리스트 ...) IS
                    질의명령
                ;
                
                
        참고 ]
            WHERE CURRENT OF 절
            ==> 커서를 이용해서 다른 질의명령을 실행하기 위한 방법
                이를테면 서브질의처럼
                하나의 질의명령을 실행할 때 필요한 서브질의를
                커서를 이용해서 사용하는 방법
            
*/

/*
    CURSOR 예제 ]
        부서번호를 입력하면
            부서이름, 평균급여, 사원수
        를 출력하는 프로시저를 작성하세요.
        단, 질의명령을 커서를 이용해서 처리하세요.
*/

-- 10번 부서의 부서이름, 평균급여, 사원수 조회
SELECT
    dname 부서이름, avg 평균급여, cnt 사원수
FROM
    dept,
    (
        SELECT
            deptno dno, AVG(sal) avg, COUNT(*) cnt
        FROM
            emp01
        GROUP BY
            deptno
    )
WHERE
    deptno = dno -- join 조건
    AND dno = 10
;


CREATE OR REPLACE PROCEDURE proc13(
    idno dept.deptno%TYPE
)
IS
    -- 1. 커서선언
    CURSOR cur01 IS
        SELECT
            dname, avg, cnt
        FROM
            dept,
            (
                SELECT
                    deptno dno, AVG(sal) avg, COUNT(*) cnt
                FROM
                    emp01
                GROUP BY
                    deptno
            )
        WHERE
            deptno = dno -- join 조건
            AND dno = idno
    ;
    
    -- 출력에 사용할 변수 선언
    buseo dept.dname%TYPE;
    pavt    NUMBER;
    pcnt    NUMBER;
BEGIN
    -- 2. 커서사용가능하도록 오픈하고
    OPEN cur01;
    -- 3. 질의명령 실행(커서를 fetch 시킨다.)
    FETCH 
        cur01 
    INTO 
        buseo, pavt, pcnt;
        
    -- 출력한다.
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || idno);
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || buseo);
    DBMS_OUTPUT.PUT_LINE('평균급여 : ' || ROUND(pavt, 2));
    DBMS_OUTPUT.PUT_LINE('부서원수 : ' || pcnt);
    -- 4. 사용이 끝난 커서 회수
    CLOSE cur01;
END;
/

exec proc13(20);










