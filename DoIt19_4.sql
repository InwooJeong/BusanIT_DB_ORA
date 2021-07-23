SET SERVEROUTPUT ON;
--��Ű�� ��
--��Ű���� ������ ����, ���, ����, Ŀ�� �׸��� PL/SQL ���� ���α׷��� �����ϴ� �뵵�� �ۼ�
--��Ű�� ���� ������ ���� ��ü�� ��Ű�� ���� �� �ƴ϶� �ܺο����� ���� ����
--CREATE [OR REPLACE] PACKAGE ��Ű�� �̸�
--IS | AS
--    �������α׷��� ������ �پ��� ��ü ����
--END [��Ű�� �̸�];

CREATE OR REPLACE PACKAGE pkg_example
IS
    spec_no NUMBER := 10;
    FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

--�̹� �����Ǿ� �ִ� ��Ű�� �� �ڵ带 Ȯ���ϰų� ������ �������α׷��� Ȯ��
--USER_SOURCE������ ������ ��ȸ�ϰų� DESC
SELECT      TEXT
FROM        USER_SOURCE
WHERE       TYPE = 'PACKAGE'
AND         NAME = 'PKG_EXAMPLE';

DESC PKG_EXAMPLE;

--��Ű�� ����
--��Ű�� ������ ������ �������α׷� �ڵ带 �ۼ�
--��Ű�� ���� �������� ���� ��ü�� �������α׷� ���ǵ� ���� -> ��Ű�� �������� �����ϴ� ���α׷��� ��Ű�� ���ο����� ��� ����
--��Ű�� ���� �̸��� ��Ű�� �� �̸��� ���� ����
--CREATE [OR REPLACE] PACKAGE BODY ��Ű�� �̸�
--IS | AS
--    ��Ű�� ������ ������ �������α׷��� ����, ���� ��ü�� ����
--    ��쿡 ���� ��Ű�� ���� �������� �ʴ� ��ü �� �������α׷��� ���� ����
--END [��Ű�� �̸�];    
