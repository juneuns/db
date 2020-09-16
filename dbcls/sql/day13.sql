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

INSERT INTO

VALUES(

);

/*
    문제 5 ]
        부서 번호와 급여인상율(%)을 입력받아서
        소속 부서원의 급여를 인상시키는 프로시저를 작성하세요.
        단, 부서원수가 4명 미만인 경우는 예외처리를 하세요.
        커서와 WHERE CURRENT OF 를 사용해서 처리하세요.
*/

CREATE OR REPLACE PROCEDURE proc25(
    dno emp01.deptno%TYPE,
    per NUMBER
)
IS
    -- 사용할 커서 선언
    CURSOR sel_eno01 IS
        SELECT
            empno
        FROM
            emp01
        WHERE
            deptno = dno
        FOR UPDATE
    ;
        
    -- 예외 만들기
    edit_err01 EXCEPTION;
    cnt number;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    FOR data IN sel_eno01 LOOP
        cnt := sel_eno01%ROWCOUNT;
    END LOOP;
    
    dbms_output.put_line('*** 조회된 사원수 : ' || cnt);
    IF (cnt < 4) THEN
        RAISE edit_err01;
    END IF;
        
    FOR data IN sel_eno01 LOOP
        UPDATE
            emp01
        SET
            sal = sal * (per / 100 + 1)
        WHERE
            CURRENT OF sel_eno01
        ;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('*** ' || dno || ' 부서원 ' || cnt || ' 명 급여 ' || per || ' % 인상완료! ***');

EXCEPTION 
    WHEN edit_err01 THEN
        DBMS_OUTPUT.PUT_LINE('### EDIT ERR  - 부서원수가 부족합니다. ###');
        rollback;
END;
/

exec proc25(10, 20);

exec proc25(20, 10);

select empno, sal from emp01;

DECLARE
    ENO EMP01.EMPNO%TYPE;
BEGIN
    UPDATE
        EMP01
    SET
        SAL = 1000
    WHERE
        DEPTNO = 10
    ;
    
    DBMS_OUTPUT.PUT_LINE('RESULT : ' || SQL%ROWCOUNT);
END;
/

ROLLBACK;

SELECT * FROM EMP01;
TRUNCATE TABLE EMP01;

INSERT INTO EMP01
(SELECT
    *
    FROM EMP);

-----------------------------------------------------------------------------------------------------------------------

/*
    트리거
    ==> DML 질의 명령이 발생하면
        자동적으로 다른 처리를 하고자 할 경우에 사용하는 프로시저의 일종
        
        예를 들면
            회원 탈퇴의 탈퇴하고자 하는 회원의 정보를 보관해야 하는 경우
            회원테이블에서 데이터를 먼저 보관용 테이블에 저장해야 하는 작업이 선행되어야 한다.
            보관이 완료되면 회원테이블에서 해당 회원의 정보를 삭제해야 할 것이다.
            이런경우 사용하는 것이 트리거이다.
            
    형식 ]
        
        CREATE OR REPLACE TRIGGER 트리거이름
            BEFORE | AFTER      DML명령(DELETE | UPDATE | INSERT)
        ON
            테이블이름
        [ FOR EACH ROW 
            생략하면 DML 명령의 횟수에 따라서 트리거를 실행한다.
            즉, DML 명령이 한번이면 트리거도 한번만 실행한다.
            
            기술하게 되면
            변경되는 데이터의 갯수만큼 트리거가 실행된다.
        ]
        [ WHEN
            조건식
            -- 트리거가 발생해야 하는 조건식을 기술하는 부분
            예 ]
                WHEN
                    deptno = 10
            라고 하면 부서번호가 10번인 내용이 변경되면 그때만 트리거를 실행하세요...
        ]
        BEGIN
            트리거에 사용할 질의 명령
        END;
        /
        
    참고 ]
        트리거가 발생하면 자동적으로 변수 두개가 발생한다.
            :OLD    -   변경전 데이터
            :NEW    -   변경후 데이터
            
        이 두 변수는 ROWTYPE 변수로 해당 테이블의 필드를 멤버로 가지는 변수이다.
        예 ]
            :OLD.ename - 수정전 사원이름
            :NEW.ENAME - 수정후 사원이름
            
        참고 ]
            :new, :old 변수는
            FOR EACH ROW 를 생략하면 사용할 수 없다.
            <== 수정되는 데이터의 갯수가 여러개 일 수 있기 때문에...
            
            
    참고 ]
        트리거는 실행되는 DML 명령 종류에 따라서 다른 처리를 할 수 있다.
        
        형식 ]
            
            CREATE OR REPLACE TRIGGER 트리거이름
                BEFORE
                INSERT OR DELETE OR UPDATE
            ON
                테이블이름
                
            FOR EACH ROW
            BEGIN
                -- 이때 DML 명령의 종류에 따라 구분처리 해준다.
                IF INSERTING THEN
                    INSERT 명령 실행시 해야할 작업
                ELSIF DELETING THEN
                    DELETE 명령 실행시 해야할 작업
                ELSIF UPDATING THEN
                    UPDATE 명령 실행시 해야할 작업
                END IF;
            END;
            /
            
    참고 ]
        트리거에서 사용하는 DML 명령은 자동 커밋된다.
        따라서 COMMIT, ROLLBACK 을 사용할 수 없다.
*/

-- EMP01 정보를 벡업용으로 저장할 테이블을 만든다.
CREATE TABLE E_BACKUP
AS
    SELECT
        *
    FROM
        emp01
    WHERE
        1 = 2
;

-- 조회
SELECT * FROM e_backup;

alter table e_backup
rename column hiredate to firedate;
SELECT * FROM e_backup;

-- 사원이 탈퇴하면 보관테이블에 데이터가 백업된후 데이터를 삭제하는 프로시저를 작성하세요.

CREATE OR REPLACE TRIGGER backup_trg01
    BEFORE DELETE
ON
    emp01
FOR EACH ROW
BEGIN
    INSERT INTO
        e_backup
    VALUES(
        :old.empno, :old.ename, :old.job, :old.mgr, sysdate, :old.sal, :old.comm, :old.deptno
    );
    
    DBMS_OUTPUT.PUT_LINE(:OLD.ename || ' 사원이 퇴사했습니다.');
END;
/

DELETE FROM emp01 WHERE deptno = 10;

SELECT * FROM emp01;
SELECT * FROM e_backup;

rollback;


drop table e_backup;

CREATE TABLE E_BACKUP
AS
    SELECT
        *
    FROM
        emp01
    WHERE
        1 = 2
;

-- 퇴사일 추가
ALTER TABLE e_backup
ADD 
    firedate DATE DEFAULT SYSDATE
        CONSTRAINT EBACK_FDATE_NN NOT NULL
;
        

CREATE OR REPLACE TRIGGER backup_trg01
    BEFORE DELETE
ON
    emp01
FOR EACH ROW
BEGIN
    INSERT INTO
        e_backup
    VALUES(
        :old.empno, :old.ename, :old.job, :old.mgr, :OLD.hiredate, :old.sal, :old.comm, :old.deptno, sysdate
    );
    
    DBMS_OUTPUT.PUT_LINE(:OLD.ename || ' 사원이 퇴사했습니다.');
END;
/


DELETE FROM emp01 WHERE deptno = 10;

SELECT * FROM emp01;
SELECT * FROM e_backup;

rollback;

/*
    문제 ]
        8000 번 사원이 입사하면
        '8000 번 사원 xxxx 가 입사했습니다.'
        라는 메세지를 출력하는 트리거를 작성하세요.
*/


CREATE OR REPLACE TRIGGER add_emp
    AFTER INSERT
ON
    emp01
FOR EACH ROW
WHEN(
    new.empno = 8000
)
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('8000 번째 ' || :NEW.ENAME || ' 사원이 입사했습니다.');
END;
/

DELETE FROM EMP01 WHERE EMPNO = 8000;

insert into emp01(empno, ename, deptno)
values(
    8000, 'dooly', 40
);


-------------------------------------------------------------------------------------------------------------------
/*
    스케줄러
    ==> 특정 시간이 되면 원하는 질의명령이 실행되도록 하는 기능을 말한다.
        즉, 오라클에게 스케줄을 알려주어서 그 스케줄대로 작업을 실해한다고 해서
        스케줄러 라 부른다.
        
    작업 순서 ]
        
        1. 실행할 질의명령을 포함하는 프로시저를 만들어 놓는다.
        2. 프로그램을 등록
            ==> 스케줄로 실행할 프로그램(1번에 만든 프로시저)을 등록해 놓아야 한다.
            
        3. 스케줄을 등록
            ==> 언제 프로시저가 실행될지를 지정하는 내용을 만들어 놓는 것.
            
        4. 잡 등록
            ==> 2번의 내용과 3번 내용을 합쳐서 하나의 스케줄 작업을 완성하는 단계
        
*/

-- 1분에 한번씩 자동적으로 데이터가 입력되도록 해보자.

-- 테이블 준비
CREATE TABLE test01(
    no NUMBER(3),
    wdate Date
);

-- 스케줄러 작업을 한다.

-- 1. 프로시저를 작성한다.
CREATE OR REPLACE PROCEDURE proc31
IS
BEGIN
    INSERT INTO
        test01
    VALUES(
        (
            SELECT
                NVL(MAX(no) + 1, 100)
            FROM
                test01
        ),
        sysdate
    );
END;
/

-- 2. 프로그램 등록
/*
    형식 ]
        BEGIN
            DBMS_SCHEDULER.CREATE_PROGRAM(
                program_name    => '적당한이름',
                program_action  => '사용할 프로시저이름',
                -- 프로시저를 이용하지 않고
                -- 직접 질의명령을 만들어도 상관이 없다.
                program_type => 'STORED_PROCEDURE',
                -- 만약 위(program_action)에서 질의명령을 직접 작성했다면
                -- EXECUTABLE 이라고 기술하면 된다.
                comment     =>  '적당한 설명',
                enabled     => TRUE
                -- 만드는 순간 활성화 하세요. 라는 의미
            );
        END;
        /
*/

-- system 계정에서 작업한다.
grant create any procedure, create any job, execute any program to hello;

-- hello 계정에서 작업한다.
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        program_name => 'prog1',
        program_action => 'proc31',
        program_type => 'STORED_PROCEDURE',
        comments     => '테스트용스케줄러',
        enabled     => TRUE
    );
END;
/

/*
    3. 스케줄 등록
      ==> 언제 실행될지를 미리 지정하는 것.
        
        형식 ]
            BEGIN
                DBMS_SCHEDULER.CREATE_SCHEDULE(
                    schedule_name => '스케줄이름',
                    start_date => 시작날짜,
                    end_date => 종료일.
                    repeat_interval => '반복주기',
                    comments => '적당한설명'
                );
            END;
            /
            
        참고 ]
            start_date, end_date 는 생략해도 상관없다.
            start_date 를 생략하면 만드는 순간부터 스케줄이 가동된다.
            end_date를 생략하면 무한정 반복한다.
            
            예 ]
                오늘밤 12시부터 스케줄을 가동하고 싶다면
                start_date => (TRUNC(SYSDATE) + 0 / 24) + 1,
                                0 - 시작 시간
                                1 - 오늘로부터 이후 날짜
                                
        참고 ]
            repeat_interval은 반복주기를 입력하는 부분
            repeat_interval => FREQ=#;INTERVAL=@ 의 형식으로 지정한다.
                #   - 간격을 의미한다.
                    예 ]
                        HOURLY      - 시간간격
                        MINUTELY    - 분간격
                        DAILY       - 일간격
                        
                @   - 간격주기
                
            예 ]
                repeat_interval => FREQ=MINUTELY;INTERVAL=1
            
*/

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        schedule_name => 'one_min_sch01',
        repeat_interval => 'FREQ=MINUTELY;INTERVAL=1',
        comments => 'every 1 min'
    );
END;
/

-- 4. 잡 등록 : 위에서 만든 두가지를 합쳐서 작업단위를 만든다.
/*
    형식 ]
        BEGIN
            DBMS_SCHEDULER.CREATE_JOB(
                job_name => '작업단위이름',
                program_name => '프로그램이름',
                schedule_name => '스케줄이름',
                comments => '적당한코멘트',
                enabled => TRUE
            );
        END;
        /
*/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name => 'test_job1',
        program_name => 'prog1',
        schedule_name => 'one_min_sch01',
        comments => 'test batch program',
        enabled => TRUE
    );
END;
/



SELECT no, to_char(wdate, 'yyyy/MM/dd HH24:mi:ss') 작성일 FROM test01 order by no;

/*
    스케줄러 삭제하기
        execute DBMS_SCHEDULER.DROP_JOB('test_job1', false);
        execute DBMS_SCHEDULER.DROP_PROGRAM('prog1', false);
        execute DBMS_SCHEDULER.DROP_SCHEDULE('one_min_sch01', false);
*/

execute DBMS_SCHEDULER.DROP_JOB('test_job1', false);
execute DBMS_SCHEDULER.DROP_PROGRAM('prog1', false);
execute DBMS_SCHEDULER.DROP_SCHEDULE('one_min_sch01', false);

delete from test01;


SELECT
    empno, ename, mgr, level
FROM
    emp01
START WITH
    mgr IS NULL
CONNECT BY
    PRIOR empno = mgr
ORDER SIBLINGS BY
    empno
;
