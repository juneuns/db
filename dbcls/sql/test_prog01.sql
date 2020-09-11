DECLARE
    -- 선언부
    x NUMBER;
BEGIN
    x := 1000; -- PL/SQL 대입연산사 - :=
    DBMS_OUTPUT.PUT_LINE('결과 = '); -- DBMS_OUTUPT.PUT_LINE() : JAVA의 println() 과 같은 기능의 함수
    DBMS_OUTPUT.PUT_LINE(x);
END;
/