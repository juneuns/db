DECLARE
    f_num NUMBER;
    s_num NUMBER;
    
    PROCEDURE swapping(
        num1 IN OUT NUMBER,
        num2 IN OUT NUMBER
    ) IS
        tmp NUMBER;
    BEGIN
        tmp := num1;
        num1 := num2;
        num2 := tmp;
    END; -- 일반 프로시저 종료
BEGIN
    -- 준비해둔 변수에 데이터 입력
    f_num := 10;
    s_num := 20;
    
    -- 프로시저 호출전에 각 변수의 내용 출력
    DBMS_OUTPUT.PUT_LINE('***** 프로시저 호출 전 ******');
    DBMS_OUTPUT.PUT_LINE('f_num : ' || TO_CHAR(f_num));
    DBMS_OUTPUT.PUT_LINE('s_num : ' || TO_CHAR(s_num));
    
    DBMS_OUTPUT.PUT_LINE(' ');
    -- 변수 치환 프로시저 호출
    swapping(f_num, s_num);
    
    -- 변수 출력
    DBMS_OUTPUT.PUT_LINE('***** 프로시저 호출 후 ******');
    DBMS_OUTPUT.PUT_LINE('f_num : ' || TO_CHAR(f_num));
    DBMS_OUTPUT.PUT_LINE('s_num : ' || TO_CHAR(s_num));
END;
/