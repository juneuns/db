-- day10

/*
    PL/SQL ( Procedual Language/Structured Query Language )
    ==> 자바의 프로그램처럼
        오라클에서 사용하는 질의명령을 여러개 모아서
        순차적으로 실행시키는 일종의 프로그램을 말한다.
        
    장점 ]
        1. 프로그램화 해서 다수의 SQL을 수행하게 함으로
            수행 속도를 향상 시킬 수 있다.
        
        2. 모듈화(부품화)가 가능해서 
            필요한 기능만 골라서
            여러개의 프로그램을 연결해서 사용할 수 있다.
            ==> 질의명령을 제작함에 있어서 편리하다.
            
        3. 동적 변수를 사용할 수 있기 때문에
            변경된 데이터를 이용해서
            질의 명령을 수행하도록 할 수 있다.
            ==> 동일한 질의 명령은 한번만 만든 후
                데이터만 바꿔서 실행할 수 있다.
                
        4. 예외처리가 가능해서
            문제가 발생할 경우 이것을 수정 처리할 수 있다.
            
            
            
            
    종류 ]
        
        1. 익명(무명) 프로시저
            ==> 프로그램을 제자가한 후(질의 명령을 모아놓은) 후 프로그램이 완료되면 
                즉시 실행할 수 있는 PL/SQL 을 말한다.
            
        2. 일반(저장) 프로시저
            ==> 프로시저에 이름을 부여한 것을 말하고
                필요할 때 선택해서 실행할 수 있는 PL/SQL 을 말한다.
                오라클에 개체로 저장된다.
        
        3. 함수(Function)
            ==> 우리가 알고있는 함수의 개념이다.
                사용자가 만든 사용자저의함수로 이야기하고
                나중에 질의 명령을 처리할 때 그 질의 명령에
                포함시켜서 사용하는 PL/SQL을 말한다.
        
        4. 기타 프로시저
            ==> 트리거, 시케줄러, ... 의 특별한 기능을 가진 PL/SQL을 말한다.
            
--------------------------------------------------------------------------------------------------------------------------------
    
    PL/SQL의 구조
      
      형식 ]  
        DECLARE
            선언부( 프로그램 필요한 변수, ... 을 선언하는 부분)
        BEGIN
            실행부(실제 필요한 질의 명령을 만들고 이것을 제어하는 부분)
        [ EXCEPTION
            예외처리부분 ]
        END;
        /
        
    
    1. 무명 프로시저
        
        형식 ]
            
            DECLARE
                변수 선언
            BEGIN
                실행부....
            END;
            /
            
            
        
*/


-- 1. 무명 프로시저
DECLARE
    -- 선언부
    x NUMBER;
BEGIN
    x := 1000; 
    DBMS_OUTPUT.PUT_LINE('결과 = '); 
    DBMS_OUTPUT.PUT_LINE(x);
END;
/ 
-- PL/SQL 대입연산사 - :=
-- DBMS_OUTUPT.PUT_LINE() : JAVA의 println() 과 같은 기능의 함수
-- 프로시저의 끝 부분에는 반드시 / 가 붙여져야 한다.


/*
    무명프로시저 사용방법
        1. 프로시저를 만들어서 파일에 저장해 놓는다.
            이때 확장자는 중요하지 않다.
        2. sqlplus 에서 실행한다.
            1. @파일경로
                ==> 실행결과만 출력해준다.
                예 ]
                    @D:\class\db\git\db\dbcls\sql\test_prog01.sql
            2. run 파일경로
                ==> 실행코드와 결과를 출력해준다.
                예 ]
                    run D:\class\db\git\db\dbcls\sql\test_prog01.sql
                
            3. get 파일경로
                ==> 실행코드만 보여준다.
                    get D:\class\db\git\db\dbcls\sql\test_prog01.sql
            
*/


/*
    sqldeveloper 에서 프로시저 실행화면을 보는 방법
        '보기' 메뉴에서 --> 'DBMS 출력' 을 선택 --> 'DBMS 출력' 창에서 '+'을 클릭해서 실행접속을 추가해준다.
        
    sqlplus 에서 프로시저 실행결과 보는 방법
        set serveroutput on
    을 실행해주면 된다.
*/

-- 파일에 저장된 무명 프로시저 실행하는 방법
-- @D:\class\db\git\db\dbcls\sql\test_prog01.sql


--------------------------------------------------------------------------------------------------------------------------------
/*
    2. 함수 만들기
        ==> 함수는 오라클 내부에 함수를 저장한 후
            다른 질의 명령을 사용할 때 부가적으로 사용하는 것.
            
        형식 ]
            
            CREATE OR REPLACE FUNCTION 함수이름
            RETURN 타입 
            AS
                변수선언
            BEGIN
                실행부
            END;
            /
            
        참고 ]
            자바와 마찬가지로 
            함수는 아무리 훌륭한 기능을 가지고 있어도
            호출하지 않으면 무용지물이다.
*/

-- 호출하면 999를 반환해주는 함수
CREATE OR REPLACE FUNCTION func01
RETURN NUMBER
AS
    x NUMBER;
BEGIN
    x := 999;
    RETURN x;
END;
/

SELECT func01() 숫자 FROM dual;

SELECT
    empno 사원번호, ename 사원이름, sal 사원급여, comm 사원커미션, NVL(comm, 0) + func01 희망고문
FROM
    emp
;

/*
    3. 일반(저장) 프로시저
        형식 ]
            
            CREATE OR REPLACE PROCEDURE 프로시저이름
            ( 변수 선언 )
            AS
            BEGIN
                실행부
            END;
            /
            
        ==> 컴파일 해주고
        
        실행은 함수처럼 호출해서 실행해야 한다.
        
        실행형식 ]
            
            execute 프로시저이름(파라미터);
            exec 프로시저이름(파라미터);
        
*/


-- 실습 준비 ] 이름, 나이를 저장한 PEOPLE 테이블을 만든다.
CREATE TABLE people(
    name VARCHAR2(10 CHAR),
    age NUMBER(3)
);

INSERT INTO people VALUES('둘리', 999);
INSERT INTO people VALUES('희동이', 3);

-- 나이를 입력 받아서 그 나이에 해당하는 사람의 나이를 10살로 수정하는 프로시저를 만들어보자.

CREATE OR REPLACE PROCEDURE proc01
( inage IN INTEGER)
AS
BEGIN
    UPDATE
        people
    SET
        age = 10
    WHERE
        age = inage
    ;
    
    DBMS_OUTPUT.PUT_LINE('*** 프로시저 실행 완료 ***');
END;
/

-- people 테이블 조회
select * from people;

exec proc01(999);

select * from people;

execute proc01(3);

-- 일반 프로시저를 만드는데 이름을 입력받아서 그 사람의 나이를 5로 변경하는 프로시저를 작성해서 실행하세요.
-- 프로시저 이름은 proc02 로 한다.

CREATE OR REPLACE PROCEDURE proc02(
    iname IN VARCHAR2
) AS
BEGIN
    UPDATE
        people
    SET
        age = 5
    WHERE
        name = iname
    ;
    
    DBMS_OUTPUT.PUT_LINE('***** [ ' || iname || ' ] 의 나이를 5세로 수정했습니다. *****');
END;
/

-- 실행
exec proc02('둘리');

select * from people;

exec proc02('희동이');

select * from people;

-- emp01 테이블의 데이터를 모두 지우고, emp테이블의 데이터로 대체하는 프로시저(reemp)를 제작해서 실행하세요.
CREATE OR REPLACE PROCEDURE reemp
IS
BEGIN
    DELETE FROM emp01;
    
    INSERT INTO
        emp01
    SELECT * FROM emp;
END;
/

exec reemp;

select * from emp01;

-------------------------------------------------------------------------------------------------------------------------------

/*
    위 세가지를 혼합해서 사용할 수 있다.
    
    1. 무명 프로시저 내부에 함수를 포함해서 만드는 방법
    
    2. 무명 프로시저 내부에 일반 프로시저를 포함해서 만드는 방법
    
    3. 무명 프로시저 내부에 무명 프로시저를 포함해서 만드는 방법
    
*/

set serveroutput on

-- 1. 무명 프로시저 내부에 함수를 포함해서 만드는 방법
@D:\class\db\git\db\dbcls\sql\test01.sql
-- run D:\class\db\git\db\dbcls\sql\test01.sql

-- 2. 무명 프로시저 내부에 일반 프로시저를 포함해서 만드는 방법
@D:\class\db\git\db\dbcls\sql\test02.sql

-- 3. 무명 프로시저 내부에 무명 프로시저를 포함해서 만드는 방법
@D:\class\db\git\db\dbcls\sql\test03.sql

-------------------------------------------------------------------------------------------------------------------------------
/*
    일반(저장) 프로시저 만드는 방법
    ==> 장점 ]
            한번만 만들면 필요할 때 언제든지 그 이름을 이용해서 사용할 수 있다.
            
    형식 ]
        
        CREATE OR REPLACE PROCEDURE 프로시저이름(
            파라미터변수 선언
        )
        IS
            프로시저 내부에서 사용할 변수 선언
        BEGIN
            -- 실행부 : 처리 내용을 기술하는 부분
        [ EXCEPTION
            예외처리 ]
        END;
        /
            
        참고 ]
            
            파라미터 변수
                형식 ]
                    
                    변수이름 IN 또는 OUT 또는 IN OUT 변수타입;
                
                의미 ]
                    이 프로시저를 실행할 때 전달되어지는 값이나(IN)
                    이 프로시저의 결과를 알려줄때 사용할 변수(OUT) 선언하는 의미
                    
                예 ]
                    
                    exec test(100);
                    ==> 이처럼 프로시저를 실행하는 순간 
                        데이터를 전달 할 수 있으며
                        이 데이터를 기억할 변수를 파라미터 변수 라고 이야기 한다.
                        
        참고 ]
            
            내부 변수 선언
            ==> 프로시저를 실행할 때 내부적으로 필요한 변수를 선언하는 부분
            
                형식 1 ] -- 선언만 하는 방법
                    변수이름    변수타입;
                    예 ]
                        
                        age NUMBER;
                        
                형식 2 ] -- 선언과 동시에 초기화까지 하는 방법
                    
                    변수이름    변수타입    :=  데이터;
                    
                    예 ]
                        name VARCHAR2(10 CHAR) := '홍길동';
                        
                형식 3 ]
                    
                    변수이름    변수타입    NOT NULL := 데이터 ;
                    
                    ==> 일반변수는 값을 기억하지 않으면 NULL 값을 가지게 되는데
                        이 변수는 NULL 을 허용하지 않는 변수로
                        반드시 초기화가 되어야 하는 변수임을 밝히는 것이다.
                        (초기화를 강제로하면  NOT NULL을 쓰지 않아도 되지만 가독성을 위한 것이다.)
                        
                형식 4 ]
                    
                    변수이름    CONSTNT     변수타입    :=  값;
                    
                    ==> 자바에서의 FINAL 벼눗에 해당하는 것으로
                        데이터를 바꿀 수 없는 변수.
                    
        참고 ]
            변수타입은 오라클 변수 타입도 사용할 수 있고
            ANSI 타입도 사용할 수 있다.
            
            예 ]
                BOOLEAN, INTEGER, ...
        
*/

-- emp01 의 사원중 급여가 입력되는 급여 미만 사원은 급여를 10% 인상처리하는 프로시저를 작성하세요.

-- 프로시저 작성 sal_up
CREATE OR REPLACE PROCEDURE sal_up(
    vsal IN NUMBER
    -- 이 프로시저를 실행할 때 입력되는 급여를 기억할 변수를 선언하는 부분
)
IS
    -- 이 프로시저 내부에서 사용할 목적으로 만드는 변수를 선언하는 부분
    -- 내용이 없으면 아무것도 안써도 무방하다.
    -- 단, IS 는 반드시 기술해야 한다.
BEGIN
    -- 실행부 - 실제 실행할 질의명령이 기술되는 부분
    UPDATE
        emp01
    SET
        sal = sal * 1.1
    WHERE
        sal < vsal
    ;
    
    -- 위의 업데이트 구문이 실행된 상태로 이 프로시저가 종료가 되면
    -- 트랜젝션 처리는 되지 않고 실행이 끝나버린다.
    -- 따라서 필요하다면 트랜젝션을 강제로 일으켜야 한다.
    commit;
    -- 이렇게 처리하면 이 프로시저가 실행되면 바로 데이터베이스에 적용까지 시켜버리는 결과가 된다.
    
    -- 메세지 출력
    DBMS_OUTPUT.PUT_LINE('★★★★★ [ ' || vsal || ' ] 미만 사원의 급여를 10% 인상했습니다. ★★★★★');
END;
/
    
-- sal_up 프로시저 호출
exec sal_up(1000);

select * from emp01;

-- 사원 번호를 알려주면 그 사원의 이름과 직급, 급여를 출력하는 프로시져(e_info01)를 작성하세요.
CREATE OR REPLACE PROCEDURE e_info01(
    -- 입력 데이터를 기억할 변수를 선언
    no IN NUMBER
)
IS
    -- 출력에 사용할 변수를 준비
    vname VARCHAR2(10 CHAR);
    vjob VARCHAR2(10 CHAR);
    vsal NUMBER;
BEGIN
    -- 결과를 출력하기 위해서는 SQLPLUS가 출력 가능 상태가 되어야 한다.
    -- 출력가능 상태로 만드는 명령이 필요하다.
    -- 즉, 이 프로시저에서 출력 가능하도록 하기 위한 조치
    DBMS_OUTPUT.ENABLE;
    SELECT
        ename, job, sal
    INTO
        vname, vjob, vsal
    FROM
        emp01
    WHERE
        empno = no
    ;
    -- 출력한다.
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || no);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || vname);
    DBMS_OUTPUT.PUT_LINE('사원직급 : ' || vjob);
    DBMS_OUTPUT.PUT_LINE('사원급여 : ' || vsal);
END;
/

-- 프로시저 실행
exec e_info01(7499);

/*
    문제 1 ]
        emp01 테이블에서 이름이 특정 글자수인 사람들의 급여를 20% 인상하는 프로시저(sal_up02)를 작성해서 실행하세요.
*/
CREATE OR REPLACE PROCEDURE sal_up02(
    inlen NUMBER
)
IS
    cnt NUMBER;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        count(*)
    INTO
        cnt
    FROM
        emp01
    WHERE
        length(ename) = inlen
    ;
    
    UPDATE
        emp01
    SET
        sal = sal * 1.2
    WHERE
        LENGTH(ename) = inlen
    ;
    
    DBMS_OUTPUT.PUT_LINE('이름이 ' || inlen || ' 글자인 사원 ' || cnt ||' 명의 급여를 20% 인상했습니다.');
END;
/

exec sal_up02(5);

select * from emp01;

/*
    문제 2 ]
        사원번호를 입력하면 사원의 이름, 직급, 부서이름, 부서위치를 출력해주는 프로시저(e_info02)를 작성해서 실행하세요.
*/

CREATE OR REPLACE PROCEDURE e_info02(
    ino NUMBER
)
IS
    name VARCHAR2(10 CHAR);
    jikgb VARCHAR2(10 CHAR);
    buseo VARCHAR2(20 CHAR);
    weechi VARCHAR2(20 CHAR);
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        ename, job, dname, loc
    INTO
        name, jikgb, buseo, weechi
    FROM
        emp e, dept d
    WHERE
        e.deptno = d.deptno
        AND empno = ino
    ;
    
    -- 출력한다.
    DBMS_OUTPUT.PUT_LINE(LPAD('=', 42, '='));
    DBMS_OUTPUT.PUT_LINE(' 사원번호 | 사원이름 | ' || RPAD(LPAD('부서이름', 10, ' '), 12, ' ') || ' | 부서위치 ');
    DBMS_OUTPUT.PUT_LINE(LPAD('-', 45, '-'));
    DBMS_OUTPUT.PUT_LINE(RPAD(TO_CHAR(ino), 9, ' ') || ' | '|| RPAD(name, 8, ' ') ||' | '|| RPAD(buseo, 12, ' ') || ' | ' || RPAD(weechi, 8, ' '));
END;
/

-- 실행
exec e_info02(7839);

----------------------------------------------------------------------------------------------------------------------------------
/*
    INTO
        ==> SELECT 된 결과를 출력하기 위해서는 변수에 기억시켜야 하는데
            조회된 결과를 변수에 옮기기 위한 예약어가 INTO 이다.
            
            규칙 ]
                SELECT 절의 필드의 개수, 순서, 타입이 동일해야 한다.
                
---------------------------------------------------------------------------------------------------------------------------------
    
    %TYPE에 의한 변수 선언
        ==> 변수를 선언할 때 질의의 결과와 연관된 변수가 존재한다.
            이때 크기가 다르면 문제 발생할 수 있다.
            그리고 이 문제는 데이터베이스가 변경이 되면 이미 작성해둔 프로시저의 변수들도 수정해야 한다.
            
            이런 경우를 대비해서 테이블의 필드의 타입과 길이를 자동으로 지정해서 변수를 선언하는 방법이
                %TYPE 
            에 의한 변수 선언이다.
            
            이것은 이미 만들어진 타입을 그대로 복사해서 
            동일한 타입의 변수로 만드는 방법이다.
            
            1. 이미 만들어진 변수와 동일한 타입으로 만드는 방법
                
                나중변수    이전변수%TYPE;
                
                예 ]
                    ino NUMBER(3);
                    vno     ino%TYPE; -- ino 와 동일한 타입과 길이로 변수 vno를 만든다.
                    
            2. 데이터베이스에 정의된 필드와 동일한 타입으로 만드는 방법
                
                형식 ]
                    변수이름    테이블이름.필드이름%TYPE;
                    
                예 ]
                    buseo   dept.dname%TYPE;
                    --> buseo 변수를 dept테이블의 dname과 같은 타입, 크기로 변수를 만드세요.
*/


/*
    문제 2 - 1 ]
        사원번호를 입력하면 사원의 이름, 직급, 부서이름, 부서위치를 출력해주는 프로시저(e_info021)를 작성해서 실행하세요.
*/

CREATE OR REPLACE PROCEDURE e_info021(
    -- 입력받을 사원번호 기억할 변수
    ino IN emp.empno%TYPE
)
IS
    -- 출력에 사용할 변수 선언
    name emp.ename%TYPE;
    jikgb emp.job%TYPE;
    buseo dept.dname%TYPE;
    weechi dept.loc%TYPE;
BEGIN
    -- dbms 출력 활성화
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        ename, job, dname, loc
    INTO
        name, jikgb, buseo, weechi
    FROM
        emp e, dept d
    WHERE
        e.deptno = d.deptno
        AND empno = ino
    ;
    
    -- 출력한다.
    DBMS_OUTPUT.PUT_LINE(LPAD('=', 47, '='));
    DBMS_OUTPUT.PUT_LINE(' 사원번호 | 사원이름 | ' || RPAD(LPAD('부서이름', 10, ' '), 12, ' ') || ' | 부서위치 ');
    DBMS_OUTPUT.PUT_LINE(LPAD('-', 47, '-'));
    DBMS_OUTPUT.PUT_LINE(LPAD(RPAD(TO_CHAR(ino), 6, ' '), 9, ' ') || ' | '|| RPAD(name, 8, ' ') || 
                                ' | '|| LPAD(RPAD(buseo, 11, ' '), 12, ' ') || ' | ' || RPAD(weechi, 8, ' '));
    
    DBMS_OUTPUT.PUT_LINE(LPAD('#', 47, '#'));
END;
/

-- 실행
exec e_info021(7934);

/*
    문제 3 ]
            사원의 이름을 입력하면 사원번호, 사원이름, 직급, 급여, 급여등급을 출력해주는 
            프로시저(e_info03)를 작성하고 실행하세요.
*/
CREATE OR REPLACE PROCEDURE e_info03(
    name IN emp01.ename%TYPE
)
IS
    eno emp01.empno%TYPE;
    ejob emp01.job%TYPE;
    esal emp01.sal%TYPE;
    grd salgrade.grade%TYPE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        empno, job, sal, grade
    INTO
        eno, ejob, esal, grd
    FROM
        emp01, salgrade
    WHERE
        sal BETWEEN losal AND hisal
        AND ename = name
    ;
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || eno);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || name);
    DBMS_OUTPUT.PUT_LINE('사원직급 : ' || ejob);
    DBMS_OUTPUT.PUT_LINE('사원급여 : ' || esal);
    DBMS_OUTPUT.PUT_LINE('급여등급 : ' || grd);
END;
/

-- 실행
execute e_info03('SMITH');

/*
    문제 4 ]
            사원의 번호를 입력하면
            사원이름, 사원직급, 상사이름
            을 출력해주는 프로시저(e_info04)를 작성하고 실행하세요.
            
            힌트 ]
                OUTER JOIN 사용하세요.
*/

--------------------------------------------------------------------------------------------------------------------------------

/*
    %ROWTYPE을 이용한 변수선언
    ==> %TYPE에 의한 변수선언은 테이블의 필드와 동인한 타입의 변수를 만드는 방법이지만
        %ROWTYPE은 테이블 전체의 데이터 형태를 복사해서 사용하는 방법이다.
        
        형식 ]
            
            변수이름    테이블이름%ROWTYPE;
            
        ==> 이 변수는 자바의 클래스처럼 내부에 멤버 변수를 가지게 된다.
            따라서 변수를 사용할 때는
                변수이름.멤버변수
            의 형식으로 사용해야 한다.
*/



-- %ROWTYPE
CREATE OR REPLACE PROCEDURE e_info022(
    -- 입력받을 사원번호 기억할 변수
    ino IN emp.empno%TYPE
)
IS
    -- 출력에 사용할 변수 선언
    dmp emp%ROWTYPE;
    dpt dept%ROWTYPE;
BEGIN
    -- dbms 출력 활성화
    DBMS_OUTPUT.ENABLE;
    
    SELECT
        ename, job, dname, loc
    INTO
        dmp.ename, dmp.job, dpt.dname, dpt.loc
    FROM
        emp e, dept d
    WHERE
        e.deptno = d.deptno
        AND empno = ino
    ;
    
    -- 출력한다.
    DBMS_OUTPUT.PUT_LINE(LPAD('=', 47, '='));
    DBMS_OUTPUT.PUT_LINE(' 사원번호 | 사원이름 | ' || RPAD(LPAD('부서이름', 10, ' '), 12, ' ') || ' | 부서위치 ');
    DBMS_OUTPUT.PUT_LINE(LPAD('-', 47, '-'));
    DBMS_OUTPUT.PUT_LINE(LPAD(RPAD(TO_CHAR(ino), 6, ' '), 9, ' ') || ' | '|| RPAD(dmp.ename, 8, ' ') || 
                                ' | '|| LPAD(RPAD(dpt.dname, 11, ' '), 12, ' ') || ' | ' || RPAD(dpt.loc, 8, ' '));
    
    DBMS_OUTPUT.PUT_LINE(LPAD('#', 47, '#'));
END;
/

-- 실행
exec e_info022(7934);


-- 위의 문제들을 rowtype을 이용해서 처리하세요.


BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('프로시저 실행');
END;
/









