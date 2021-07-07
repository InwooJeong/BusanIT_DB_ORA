set serveroutput on;

DECLARE
    V_NUM NUMBER := 0;
    V_TOT_NUM NUMBER :=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('LOOP ���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        V_TOT_NUM := V_TOT_NUM + 1;
        EXIT WHEN V_NUM > 4; --NUM�� 4���� ũ�� �ݺ� ����
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_TOT_NUM || '���� LOOP');
END;
/

DECLARE
    V_NUM NUMBER := 0;
    V_TOT_NUM NUMBER :=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('���� IF V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        V_TOT_NUM := V_TOT_NUM + 1;
        IF V_NUM > 4 THEN --NUM�� 4���� ũ�� �ݺ� ����
            EXIT;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_TOT_NUM || '���� LOOP');
END;
/

DECLARE
    V_NUM NUMBER := 0;
    V_TOT_NUM NUMBER :=0;
BEGIN
    WHILE V_NUM < 4 LOOP --NUM�� 4���� ���� �� ���� -> 4�� �Ǹ� ����
        DBMS_OUTPUT.PUT_LINE('WHILE ���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        V_TOT_NUM := V_TOT_NUM + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_TOT_NUM || '���� LOOP');
END;
/

CL SCR

BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
        DBMS_OUTPUT.PUT_LINE('i LOOP');
    END LOOP;
END;
/

BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..4 LOOP
        IF MOD(i,2)=0 THEN
            DBMS_OUTPUT.PUT_LINE(i||'�� ¦��!');
        ELSE
            DBMS_OUTPUT.PUT_LINE(i||'�� Ȧ��!');
        END IF;
    END LOOP;
END;
/

BEGIN
    FOR NUM_LIST IN
    (
        SELECT 1 AS NUM FROM DUAL
        UNION ALL
        SELECT 2 AS NUM FROM DUAL
        UNION ALL
        SELECT 3 AS NUM FROM DUAL
        UNION ALL
        SELECT 4 AS NUM FROM DUAL
     )
     LOOP
        IF MOD(NUM_LIST.NUM,2)=0 THEN
            DBMS_OUTPUT.PUT_LINE(NUM_LIST.NUM||'�� ¦��!');
        ELSE
            DBMS_OUTPUT.PUT_LINE(NUM_LIST.NUM||'�� Ȧ��!');
        END IF;
     END LOOP;
END;
/

BEGIN
    FOR i IN 0..4 LOOP
        CONTINUE WHEN MOD(i,2) = 1; --ī���Ͱ� Ȧ���̸� ���� ��ɹ� ����X, ���� �ݺ� �ֱ��
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
    END LOOP;
END;
/

DECLARE
    VN_BASE_NUM NUMBER := 3;
BEGIN
    FOR i IN 1..9 LOOP
        CONTINUE WHEN i=5; --ī���Ͱ� 5�̸� ��ɹ� ����X
        DBMS_OUTPUT.PUT_LINE (VN_BASE_NUM || '*' || i || '=' || VN_BASE_NUM*i);
    END LOOP;
END;
/

CL SCR

DECLARE
    NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('Inside loop : NUM = ' || NUM);
        NUM := NUM+1;
        IF NUM < 3 THEN
            CONTINUE;
        END IF;
--        Ȥ��
--        CONTINUE WHEN NUM < 3;
        DBMS_OUTPUT.PUT_LINE('Inside loop, after CONTINUE : NUM = ' || NUM);
        EXIT WHEN NUM = 5;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('After loop : NUM = ' || NUM);
END;
/

DECLARE
    TOT NUMBER := 0;
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE('i : '||i);
        TOT := TOT + 1;
        DBMS_OUTPUT.PUT_LINE('TOT : ' || TOT);
        CONTINUE WHEN i > 5; -- i�� 5���� ũ�ٸ� �ٷ� ���� ����
        --�Ʒ� ����X
        TOT := TOT + 1;
        DBMS_OUTPUT.PUT_LINE('TOT WITH CONTINUE : ' || TOT);
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..10 LOOP
        CONTINUE WHEN MOD(i,2)=0; --i�� ¦���� �ȳ������� �ݺ� ���� �ֱ�� �ø�
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
    END LOOP;
END;
/

CL SCR

DESC DEPT

SELECT      DEPTNO, DNAME
FROM        DEPT;

DECLARE
    V_DEPT_NO DEPT.DEPTNO%TYPE := 10;
BEGIN
    CASE V_DEPT_NO
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ACCOUNTING');
        WHEN 20 THEN DBMS_OUTPUT.PUT_LINE('DNAME : RESEARCH');
        WHEN 30 THEN DBMS_OUTPUT.PUT_LINE('DNAME : SALES');
        WHEN 40 THEN DBMS_OUTPUT.PUT_LINE('DNAME : OPERATIONS');
        ELSE DBMS_OUTPUT.PUT_LINE('DNAME : NA');
    END CASE;
END;
/    