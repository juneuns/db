DECLARE
    -- �����
    x NUMBER;
BEGIN
    x := 1000; -- PL/SQL ���Կ���� - :=
    DBMS_OUTPUT.PUT_LINE('��� = '); -- DBMS_OUTUPT.PUT_LINE() : JAVA�� println() �� ���� ����� �Լ�
    DBMS_OUTPUT.PUT_LINE(x);
END;
/