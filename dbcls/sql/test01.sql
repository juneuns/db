-- 1. 무명 프로시저 내부에 함수를 포함해서 만드는 방법
DECLARE 
    -- 선언부
    -- 변수와 함수를 선언한다.
    tmp NUMBER;
    
    FUNCTION test(
        b_ex IN boolean,
        t_num IN NUMBER,
        f_num IN NUMBER
    )
    RETURN NUMBER IS
    BEGIN
        IF b_ex THEN
            RETURN t_num;
        ELSIF not b_ex THEN
            RETURN f_num;
        ELSE
            RETURN null;
        END IF;
    END;
BEGIN -- 무명 프로시저 코딩부분
    -- 실행부
    -- 위에서 정의 해놓은 함수나 변수를 여기서 사용한다.
    DBMS_OUTPUT.PUT_LINE(test( 2 > 1, 1, 0)); -- 선언부의 함수 호출
    DBMS_OUTPUT.PUT_LINE(test(2 > 3, 1, 0));
    tmp := test(null, 1, 0);
    
    IF tmp IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('NULL');
    ELSE
        DBMS_OUTPUT.PUT_LINE(tmp);
    END IF;
END;
/