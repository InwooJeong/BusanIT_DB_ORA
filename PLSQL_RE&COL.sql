SET SERVEROUTPUT ON;

DECLARE
    TYPE REC_DEPT IS RECORD(
    DEPTNO NUMBER(2) NOT NULL := 99,
    DNAME  DEPT.DNAME%TYPE,
    LOC    DEPT.LOC%TYPE
    ); --������ ���ڵ� ����
    DEPT_REC REC_DEPT; --���ڵ��� ���� ����, ���� ���ڵ������� ���� ���� �� ���� ����
BEGIN
    DEPT_REC.DEPTNO := 99;
    DEPT_REC.DNAME  := 'DATABASE';
    DEPT_REC.LOC    := 'SEOUL'; --���ڵ��� ���� �� ���Ե� ������ ���� ����
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC); --����� �� ��� �� ���ڵ��� ���� �̸��� ��ħǥ(.)
END;
/

--������ DEPT_RECORD ���̺� ����
CREATE TABLE    DEPT_RECORD
AS  SELECT      *
    FROM        DEPT;

SELECT  *
FROM    DEPT_RECORD;

DECLARE
    TYPE REC_DEPT IS RECORD(
    deptno NUMBER(2) NOT NULL := 99,
    dname  DEPT.DNAME%TYPE,
    loc    DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 99;
    dept_rec.dname  := 'DATABASE';
    dept_rec.loc    := 'SEOUL';
    
INSERT INTO     DEPT_RECORD
VALUES          dept_rec;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
     deptno NUMBER(2) NOT NULL := 99,
     dname  DEPT.DNAME%TYPE,
     loc    DEPT.LOC%TYPE
      );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 50;
    dept_rec.dname  := 'DB';
    dept_rec.loc    := 'SEOUL';
    
    UPDATE      DEPT_RECORD
    SET         ROW = dept_rec
    WHERE       DEPTNO = 99;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        dname  DEPT.DNAME%TYPE,
        loc    DEPT.LOC%TYPE
        );
    TYPE REC_EMP IS RECORD(
        empno EMP.EMPNO%TYPE,
        ename EMP.ENAME%TYPE,
        dinfo REC_DEPT
        );
        emp_rec REC_EMP;
BEGIN
    SELECT      E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
    
        INTO    emp_rec.empno, emp_rec.ename,
                emp_rec.dinfo.deptno,
                emp_rec.dinfo.dname,
                emp_rec.dinfo.loc
    FROM    EMP E, DEPT D
    WHERE   E.DEPTNO = D.DEPTNO
    AND     E.EMPNO  = 7902;
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || emp_rec.dinfo.loc);
END;
/


