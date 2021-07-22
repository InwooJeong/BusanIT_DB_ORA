SET SERVEROUTPUT ON;
--CREATE [OR REPLACE] FUNCTION �Լ� �̸�
--[(�Ķ���� �̸�1 [IN] �ڷ���1, <-�Լ� ���࿡ ����� �Ķ���� ����. ���� �����ϸ� �ʿ信 ���� ���� �� ����. IN ��常 ����. :=, DEFAULT �ɼ����� �⺻�� ���� ����
--  �Ķ���� �̸�2 [IN] �ڷ���2,
-- ...
--  �Ķ���� �̸�N [IN] �ڷ���N
--)]
--RETURN �ڷ��� <- ���� �� ��ȯ �� �ڷ��� ����
--IS | AS
--    �����
--BEGIN
--    �����
--    RETURN (��ȯ ��); <- ��ȯ �� ����
--EXCEPTION
--    ���� ó����
--END [�Լ� �̸�];
--�Լ��� OUT, IN OUT ��� �Ķ���� ���� ���������� ���� �� SQL������ ��� ���� -> ���ν����� �ٸ� �� ��������.
--SQL���� ����� �Լ��� ��ȯ �� �ڷ����� SQL������ ����� �� ���� �ڷ������� ������ �� ������ Ʈ����� ���� ��ɾ�, DML ��ɾ ��� �Ұ�

CREATE OR REPLACE FUNCTION func_aftertax(
    sal IN NUMBER
)
RETURN NUMBER
IS
    tax NUMBER := 0.05;
BEGIN
    RETURN (ROUND(sal-(sal*tax)));
END func_aftertax;
/

--PL/SQL
DECLARE
    aftertax NUMBER; --��ȯ ���� �ޱ� ���� ���� ����
BEGIN
    aftertax := func_aftertax(3000);
    DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
END;
/

--SQL
SELECT      func_aftertax(3000)
FROM        DUAL;

SELECT      EMPNO, ENAME, SAL, func_aftertax(SAL) AS AFTERTAX
FROM        EMP;