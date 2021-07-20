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
CREATE OR REPLACE PROCEDURE ���ν��� �̸�
[(�Ķ���� �̸�1 [modes] �ڷ��� [ := | DEFAULT �⺻��],
  �Ķ���� �̸�2 [modes] �ڷ��� [ := | DEFAULT �⺻��],
  ....
  �Ķ���� �̸�4 [modes] �ڷ��� [ := | DEFAULT �⺻��]
)]
IS | AS
    �����
BEGIN
    �����
EXCEPTION
    ���� ó����
END [���ν��� �̸�];    