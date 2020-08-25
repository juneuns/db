SELECT
    empno �����ȣ, 
    CONCAT(
        RPAD(
            SUBSTR(ename, 1, 1),
            LENGTH(ename) - 1, '*'),
        SUBSTR(ename, -1)
    ) ����̸�
FROM
    emp
;

-- �̸��� ����° ���ڸ� ����ϰ� ������ ���ڵ��� * �� ���� ��ü�ؼ� ��ȸ�ϼ���.
SELECT
    empno,
    RPAD(-- 3. ��ü ���̸�ŭ ������ְ� ä��ڴ� �����ʿ� * �� ä���ش�.
        LPAD(-- 2. ���������� ���ʿ� * �� ä���ش�.
            SUBSTR(ename, 3, 1), -- 1. ����° ���ڸ� ������.
            3, '*'),
        LENGTH(ename), '*') �̸�
FROM
    emp
;

/*
    ����° ��...
    
    ��¥ �Լ�
        
        **
        ���� ]
            sysdate     -   �ý����� ���� ��¥/�ð��� �˷��ִ� �����
        ���� ]
            TO_CHAR(��¥������, ���Ĺ���)    --> ��¥�����͸� ���ڿ��� ��ȯ���ִ� �Լ�
            
            ���Ĺ���
                YYYY
                YY
                MM
                MON
                DD
                DAY
                
                AM | PM
                HH | HH12   -   �ð��� 0 ~ 12 ���� ǥ��
                HH24        -   �ð��� 0 ~ 23 ���� ǥ��
                MI          -   ��(0 ~ 59)
                SS          -   ��(0 ~ 59)
            
        ���� ]
            TO_DATE(��¥���� ���ڿ�, ���� ���ڿ�)   --->    ���ڵ����͸� ��¥�����ͷ� ��ȯ���ִ� �Լ�
            
            ���ǻ��� ]
                ��¥�����͸� ���鶧 �ð��� ������ ������ 0��0��0�ʷ� ������ �ȴ�.
                
------------------------------------------------------------------------------------------------
    ���� ]
        ��¥ - ��¥�� ������� ����Ѵ�.
        <=== ��¥ �������� - ������ �Ѵ�.
        
    ���� ]
        ����Ŭ���� ��¥�� ����ϴ� ���
        1970�� 1�� 1�� 0�� 0�� 0�ʿ���
        ������ ��¥������ ��¥������ �̿��ؼ� ����Ѵ�.
        
        ��¥�����̶�
        ����.�ð� �� ���·� ���ڷ� ǥ���� ��.
        
    ���� ]
        ��¥ - ��¥ �� ��������� 
        ��¥ +( *, /) ��¥ �� ������� �ʴ´�.
        
    ���� ]
        ��¥ + ���� �� ������ ����Ѵ�.
        ==> ��¥ ������ �����̹Ƿ�
            �ᱹ ��¥���� ���ϴ� ���ڸ�ŭ �̵��� ��¥�� ǥ���Ѵ�.
        

*/

-- sysdate
SELECT to_char(sysdate, 'yyyy/MM/dd DAY HH:mi:ss') ���ó�¥ FROM dual;

SELECT TO_DATE('2020/08/25 09:30:00', 'YYYY/MM/DD HH24:MI:SS') �������۽ð� FROM dual;

SELECT
    TO_CHAR(
        TO_DATE('2020/08/25', 'YYYY/MM/DD'),
        'YYYY/MM/DD HH24:MI:SS'
    ) ���ý��۽ð�
FROM
    dual
;

-- ����� �̸�, ����� �ٹ� �ϼ��� ����ؼ� ��ȸ�ϼ���.
SELECT
    ename ����̸�, hiredate �Ի���,
    CONCAT(FLOOR(sysdate - hiredate), ' ��')  �ٹ��ϼ�
    -- �� ��� FLOOR(sysdate - hiredate) �� ���ڵ������̰� ����ȯ�Լ�(TO_CHAR())�� �ڵ� ȣ��Ǿ ó���ȴ�.
FROM
    emp
;


-- ���� ] �����Ϻ��� ���ñ��� ������ ��ȸ�ϼ���.
SELECT
    FLOOR(SYSDATE - TO_DATE('2020/07/15', 'YYYY/MM/DD')) �������ĳ���
FROM
    dual
;


SELECT
    TO_CHAR(SYSDATE + 7, 'YYYY/MM/DD HH24:MI:SS') ��������
FROM
    dual
;

/*
--------------------------------------------------------------------------------
    
    ��¥�Լ�
        
        1. ADD_MONTHS
            ==> ��¥�����Ϳ� ������ �� ���� ���ϰų� �� ��¥�� �˷��ش�.
            ���� ]
                ADD_MONTHS(��¥������, ������)
                
            ���� ]
                ���� �������� �����̸� �� ��¥�� �˷��ش�.
*/

-- ���� ��¥���� 3���� ���� ��¥�� ��ȸ�ϼ���.
SELECT ADD_MONTHS(SYSDATE, 3) FROM dual;

-- ����� �̸�, �Ի��Ͽ��� 2���� ������ �������� ��ȸ�ϼ���.
SELECT ename ����̸�, hiredate �Ի���, ADD_MONTHS(hiredate, -2) �Ի�2������ FROM emp;

/*
    2. MONTHS_BETWEEN
        ==> �� ��¥ ������ ������ �� ������ �˷��ִ� �Լ�
        
        ���� ]
            MONTHS_BETWEEN(��¥, ��¥)
*/
-- �ڽ��� �¾ �� ���� ����� ����� ��ȸ�ϼ���.
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('1971/12/26', 'YYYY/MM/DD'))) ������ FROM dual;

-- ���� ] ����� �Ի����� ��������� ��ȸ�ϼ���.
SELECT ename ����̸�, hiredate �Ի���, FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) ������ FROM emp;

/*
    3. 
*/