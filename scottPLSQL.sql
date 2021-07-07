set serveroutput on;

DECLARE
    V_NUM NUMBER := 0;
    V_TOT_NUM NUMBER :=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('LOOP 현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        V_TOT_NUM := V_TOT_NUM + 1;
        EXIT WHEN V_NUM > 4; --NUM이 4보다 크면 반복 종료
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_TOT_NUM || '번의 LOOP');
END;
/

DECLARE
    V_NUM NUMBER := 0;
    V_TOT_NUM NUMBER :=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 IF V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        V_TOT_NUM := V_TOT_NUM + 1;
        IF V_NUM > 4 THEN --NUM이 4보다 크면 반복 종료
            EXIT;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_TOT_NUM || '번의 LOOP');
END;
/

DECLARE
    V_NUM NUMBER := 0;
    V_TOT_NUM NUMBER :=0;
BEGIN
    WHILE V_NUM < 4 LOOP --NUM이 4보다 작을 때 까지 -> 4가 되면 종료
        DBMS_OUTPUT.PUT_LINE('WHILE 현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        V_TOT_NUM := V_TOT_NUM + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_TOT_NUM || '번의 LOOP');
END;
/

CL SCR

BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : ' || i);
        DBMS_OUTPUT.PUT_LINE('i LOOP');
    END LOOP;
END;
/

BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : ' || i);
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..4 LOOP
        IF MOD(i,2)=0 THEN
            DBMS_OUTPUT.PUT_LINE(i||'는 짝수!');
        ELSE
            DBMS_OUTPUT.PUT_LINE(i||'는 홀수!');
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
            DBMS_OUTPUT.PUT_LINE(NUM_LIST.NUM||'는 짝수!');
        ELSE
            DBMS_OUTPUT.PUT_LINE(NUM_LIST.NUM||'는 홀수!');
        END IF;
     END LOOP;
END;
/

BEGIN
    FOR i IN 0..4 LOOP
        CONTINUE WHEN MOD(i,2) = 1; --카운터가 홀수이면 남은 명령문 수행X, 다음 반복 주기로
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : ' || i);
    END LOOP;
END;
/

DECLARE
    VN_BASE_NUM NUMBER := 3;
BEGIN
    FOR i IN 1..9 LOOP
        CONTINUE WHEN i=5; --카운터가 5이면 명령뭉 수행X
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
--        혹은
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
        CONTINUE WHEN i > 5; -- i가 5보다 크다면 바로 다음 차수
        --아래 수행X
        TOT := TOT + 1;
        DBMS_OUTPUT.PUT_LINE('TOT WITH CONTINUE : ' || TOT);
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..10 LOOP
        CONTINUE WHEN MOD(i,2)=0; --i가 짝수면 안내려가고 반복 다음 주기로 올림
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : ' || i);
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