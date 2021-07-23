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
CREATE OR REPLACE PACKAGE BODY pkg_example
IS
    body_no NUMBER := 10; --pkg_example �ȿ����� ��� ����
    
    FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER
        IS
            tax NUMBER := 0.05;
        BEGIN
            RETURN (ROUND(sal - ( sal *  tax)));
    END func_aftertax;
    
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
        IS
            out_ename EMP.ENAME%TYPE;
            out_sal EMP.SAL%TYPE;
        BEGIN
            SELECT      ENAME, SAL  INTO out_ename, out_sal
            FROM        EMP
            WHERE       EMPNO = in_empno;
            
            DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
            DBMS_OUTPUT.PUT_LINE('SAL : '   || out_sal);
   END pro_emp;
   
   PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
    IS
        out_dname   DEPT.DNAME%TYPE;
        out_loc     DEPT.LOC%TYPE;
    BEGIN
        SELECT      DNAME, LOC  INTO out_dname, out_loc
        FROM        DEPT
        WHERE       DEPTNO = in_deptno;
        
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || out_dname);
        DBMS_OUTPUT.PUT_LINE('LOC : '   || out_loc);
    END pro_dept;
END;
/