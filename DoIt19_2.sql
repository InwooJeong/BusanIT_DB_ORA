SET SERVEROUTPUT ON;
--�Ķ���͸� ������� �ʴ� ���ν���
--CREAT [OR REPLACE] PROCEDURE ���ν��� �̸� --�� ó�� ����� ��ü(���� ����), ���ν��� �̸��� ���� ��Ű�� ������ �ߺ� �Ұ�
--IS || AS --DECLARE ���X. ����ΰ� ������ �ݵ�� ���
--    �����
--BEGIN
--    �����
--EXCEPTION --���� ����
--    ���� ó����
--END [���ν��� �̸�]; --���� ����. �̸��� ���� ����    

SELECT  *
FROM    EMP;

CREATE OR REPLACE PROCEDURE     pro_noparam
IS
    V_EMPNO NUMBER(4) := 7839;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'KING';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/

EXECUTE     pro_noparam; --SQL*PLUS���� �ٷ� ��� ����

BEGIN --�͸� ���(anonymous block)
    pro_noparam;
END;
/

--�̹� ����Ǿ� �ִ� ���ν����� �������α׷� �ҽ� �ڵ� ������ Ȯ���Ϸ��� USER_SOURCE ������ �������� ��ȸ
SELECT      * 
FROM        USER_SOURCE
WHERE       NAME = 'PRO_NOPARAM';

SELECT      TEXT
FROM        USER_SOURCE
WHERE       NAME = 'PRO_NOPARAM';

--����
DROP PROCEDURE  PRO_NOPARAM;

CL SCR

--�Ķ���͸� ����ϴ� ���ν���
--CREATE OR REPLACE PROCEDURE ���ν��� �̸�
--[(�Ķ���� �̸�1 [modes] �ڷ��� [ := | DEFAULT �⺻��],
--  �Ķ���� �̸�2 [modes] �ڷ��� [ := | DEFAULT �⺻��],
--  ....
--  �Ķ���� �̸�4 [modes] �ڷ��� [ := | DEFAULT �⺻��] --�Ķ���� ����. �Ķ���ʹ� ,�� �����Ͽ� ������ ���� ����. �⺻���� ���� ���� ����. �ڷ����� �ڸ��� ���� �� NOT NULL ���� ���� ��� �Ұ�
--)]
--IS | AS
--    �����
--BEGIN
--    �����
--EXCEPTION
--    ���� ó����
--END [���ν��� �̸�];    

--IN ��� �Ķ���� : �������� ������ �⺻������ ���ν����� ȣ���� �� ���� �Է¹���. IN�� �⺻ ���̶� ���� ����
CREATE OR REPLACE PROCEDURE pro_param_in
(
    param1 IN NUMBER,
    param2 NUMBER,
    param3 NUMBER := 3,
    param4 NUMBER DEFAULT 4
)
IS

BEGIN
    DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
    DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
    DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
    DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;
/

EXECUTE pro_param_in(1,2,9,8);

EXECUTE pro_param_in(1,2);

--���� ���� Ȯ��!
BEGIN
    pro_param_in(1);
END;
/

--�Ķ���� �̸� Ȱ��
EXECUTE pro_param_in(param1 => 10, param2 => 20);

--��ġ ���� : ������ �Ķ���� ������� ���� ����
--�̸� ���� : => �����ڷ� �Ķ���� �̸��� ����Ͽ� ���� ����
--ȥ�� ���� : �Ϻ� �Ķ���ʹ� ������� ���� �����ϰ� �Ϻ� �Ķ���ʹ� => �����ڷ� �� ����

--OUT ��� �Ķ���� : ���ν��� ���� �� ȣ���� ���α׷����� ���� ��ȯ : ȣ���� �� �� ��ȯ
CREATE OR REPLACE PROCEDURE     pro_param_out
(
    in_empno    IN   EMP.EMPNO%TYPE,
    out_ename   OUT  EMP.ENAME%TYPE,
    out_sal     OUT  EMP.SAL%TYPE
)
IS

BEGIN
    SELECT      ENAME, SAL  INTO    out_ename, out_sal
    FROM        EMP
    WHERE       EMPNO = in_empno;
END  pro_param_out;
/

DECLARE
    v_ename     EMP.ENAME%TYPE;
    v_sal       EMP.SAL%TYPE;
BEGIN
    pro_param_out(7839, v_ename, v_sal);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('SAL : '   || v_sal);
END;
/

--IN OUT ��� �Ķ����