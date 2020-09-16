-- day13

/*
    예외처리
    ==> PL/SQL을 실행하는 도중 발생하는 런타임 오류를 예외라고 말한다.
        이것은 필요하면 자바와 동일하게 예외의 이유를 알아볼 수 있다.
        
        자바와의 차이점은
        예외가 발생하면 그 후의 모든 PL/SQL 명령은 실행되지 않는다.
        오직 예외의 정보를 파악하여 실행이 되지않는 원을 파악할 수 있을 뿐이다.
        
    PL/SQL에서의 예외의 종류
        
        1. 미리 정의된 예외
            ==> PL/SQL에서 자주 발생하는 20가지 정도의 예외에 대해서
                예외 코드값과 예외의 이름을 연결시켜 놓은 예외를 말한다.
                
                자동적으로 발생하기 때문에 굳이 특별한 조치를 하지 않아도 예외처리를 할 수 있다.
                
        2. 미리 정의되지 않은 예외
            ==> 자주 발생하지 않기 때문에 이름을 연결시켜 놓지는 않았지만
                PL/SQL 컴파일러가 알고 있는 예외를 말한다.
                
                미리 이름과 코드값을 개발자가 연결할 후( ==> 예외를 선언한 후 )
                사용해야 하는 예외이다.
        
        3. 사용자 예외
            ==> PL/SQL 컴파일러가 알지 못하는 예외를 말한다.
                자바에서의 사용자가 강제로 발생하는 예외와 동일한 것
                
                미리 이름을 강제로 부여하여 하나의 예외를 만들어 놓은 후
                                            +
                필요한 시점에 강제로 예외라고 인정해줘야 한다.( 강제로 예외를 발생시킨다. )
                
                
    예외 처리 문법 ]
        
        EXCEPTION
            WHEN    예외이름    THEN
                처리내용;
            WHEN    예외이름    THEN
                처리내용;
            ....
            WHEN    OTHERS      THEN
                처리내용;
                
    참고 ]
        EXCEPTION 절은 프로시저의 가장 마지막에 와야한다.
        다시말해
        예외처리 후 다른내용이 오면 안된다.
        
-----------------------------------------------------------------------------------------------------------
EXCEPTION명	            에러번호        설    명         
-----------------------------------------------------------------------------------------------------------
NO_DATA_FOUND	        ORA-01403       데이터를 반환하지 않은 SELECT문
TOO_MANY_ROWS	        ORA-01422       두 개 이상을 반환한 SELECT문
INVALID_CURSOR	        ORA-01001       잘못된 CURSOR 연산 발생
ZERO_DIVIDE	            ORA-01476       0으로 나누기
DUP_VAL_ON_INDEX	    ORA-00001       UNIQUE COLUMN에 중복된 값을 입력할 때
CURSOR_ALREADY_OPEN	    ORA-06511       이미 열러 있는 커서를 여는 경우
INVALID_NUMBER	        ORA-01722       문자열을 숫자로 전환하지 못한 경우
LOGIN_DENIED	        ORA-01017       유효하지 않은 사용자로 LOGON 시도
NOT_LOGGED_ON	        ORA-01012       PL/SQL 프로그램이 오라클에 연결되지 않은 상태에서 호출
PROGRAM_ERROR	        ORA-06501       PL/SQL 내부에 오류
STORAGE_ERROR	        ORA-06500       PL/SQL에 메모리 부족
TIMEOUT_ON_RESOURCE	    ORA-00051       오라클이 자원을 기다리는 동안 시간 초과 발생
VALUE_ERROR	            ORA-06502       산술, 절단 등에서 크기가 다른 오류 발생

-----------------------------------------------------------------------------------------------------------
*/

SELECT name FROM emp01;

/*
    1. 미리 정의된 예외
    
    문제 1 ]
        부서 번호를 입력받아서 해당 부서의 사원번호를 출력하는 프로시저를 작성하세요.
        단, 문제 발생하면 예외처리를 이용해서 문제의 원인을 출력하도록 하세요.
*/
CREATE OR REPLACE PROCEDURE proc21(
    dno IN emp01.deptno%TYPE
)
IS
    -- 내부변수 선언
    eno emp01.empno%TYPE;
BEGIN
    /*
        원래는 부서번호를 가지고 검색하면
        두줄이상의 결과가 나올 수 있다.
        FOR LOOP 명령으로 처리해서 사용해야 한다.
        지금은 일부러 에러를 발생시키기 우해서 한줄만 나오는 방식으로 처리할 예정이다.
    */
    SELECT
        empno
    INTO
        eno
    FROM
        emp01
    WHERE
        deptno = dno
    ;
    
    -- 출력한다.
    DBMS_OUTPUT.PUT_LINE(eno);
EXCEPTION 
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('### 에러 : 다중행이 조회되었습니다.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('### 에러 : 조회된 데이터가 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('### 에러 : 알 수 없는 오류입니다.');
END;
/

exec proc21(10);
exec proc21(40);
-----------------------------------------------------------------------------------------------------------
-- emp01에 기본키 제약조건 추가
ALTER TABLE 
    emp01
ADD CONSTRAINT
    E01_NO_PK PRIMARY KEY(empno)
;

-- emp01.deptno 에 참조키 제약조건 추가
ALTER TABLE
    emp01
ADD CONSTRAINT
    E01_DNO_FK FOREIGN KEY(deptno) REFERENCES dept(deptno)
;

/*
    -- 2. 미리 정의되지 않은 예외
    문제 2 ]
        emp01 테이블에 새로운 사원을 입력하는 프로시저를 작성하세요.
        단, 사원이름과 부서번호만 입력하도록 한다.
        ==> 사원번호가 입력되지 않으면 에러가 발생한다.
        
        ==> 예외를 정의해서 처리하도록 한다.
*/

INSERT INTO
    emp01(ename, deptno)
VALUES(
    'dooly', 40
);

CREATE OR REPLACE PROCEDURE proc22(
    name emp01.ename%TYPE,
    dno emp01.deptno%TYPE
)
IS
    -- 내부에 사용할 변수와 예외등은 이곳에서 정의를 한다.
    -- 이 문제의 경우 예외만들어서 처리해야 하기때문에
    -- 먼저 예외를 정의를 하고 사용한다.
    
    -- 예외 정의 방법
    -- 1. 예외에 사용할 이름을 정한다.
    --      형식 ]
    --              예외이름    EXCEPTION;
    pk_ecpt EXCEPTION;
    -- 2. 예외의 이름과 실제 발생할 코드를 연결한다.
    --      형식 ]
    --              PRAGMA  EXCEPTION_INIT(이름, 코드값);
    PRAGMA EXCEPTION_INIT(pk_ecpt, -1400);
BEGIN
    INSERT INTO
        emp01(ename, deptno)
    VALUES(
        name, dno
    );
EXCEPTION
    WHEN pk_ecpt THEN
        DBMS_OUTPUT.PUT_LINE('*** 에러 ] 사원번호는 필수 입력 사항입니다. ***');
END;
/

exec proc22('이지우', 10);

------------------------------------------------------------------------------------------------------------
/*
    3. 사용자 예외
    
    문제 3 ]
        부서번호를 입력받아서
        해당 부서에 속한 사원수를 출력하는 프로시저를 작성하세요.
        단, 사원수가 3명 이하면 사원수가 부족하다는 메세지를 출력하도록
        예외처리를 하세요.
*/

CREATE OR REPLACE PROCEDURE proc23(
    dno emp01.deptno%TYPE
)
IS
    -- 내부 출력용 변수 선언
    cnt NUMBER := 0;
    
    -- 예외 정의
    ecpt01  EXCEPTION;
BEGIN
    -- 질의명령
    SELECT
        COUNT(*)
    INTO
        cnt
    FROM
        emp01
    WHERE
        deptno = dno
    ;
    
    IF cnt <= 3 THEN
        -- 예외 강제 발생
        -- 문법상 전혀 문제가 되지 않지만 강제로 예외를 발생시켜줘야 한다.
        --  형식 ]
        --          RAISE   예외이름;
        /*
            참고 ]
                자바에서 강제로 예외 발생시키는 방법
                    throw new 예외();
        */
        RAISE ecpt01;
    END IF;
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE(dno || ' 번 부서의 사원수 : ' || cnt);
EXCEPTION
    WHEN ecpt01 THEN
        DBMS_OUTPUT.PUT_LINE('### 에러 ] ' || dno || ' 번 부서는 사원수가 부족한 부서입니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*** ERR ] 알 수 없는 에러입니다.');
END;
/

execute proc23(30);
execute proc23(10);

/*
    문제 4 ] -- 사용자 정의 예외
        emp01 테이블에 사원을 입력하는 프로시저를 작성하세요.
        입력 데이터는 사원번호, 사원이름, 부서번호 를 입력하도록하고
        사원번호가 4자리 미만인 경우는 예외처리를 하도록한다.
*/




















