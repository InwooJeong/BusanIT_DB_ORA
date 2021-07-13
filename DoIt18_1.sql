SET SERVEROUTPUT ON;
--cursor : Ư�� ���� �����Ͽ� ó��
--�����(explicit)/������(implicit)
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT  DEPTNO, DNAME, LOC 
    INTO    V_DEPT_ROW
    FROM    DEPT
    WHERE   DEPTNO = 40;
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : '  || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : '    || V_DEPT_ROW.LOC);
END;
/
--1. �����(explicit) Ŀ��
-- Ŀ������ - Ŀ������ - Ŀ������ �о�� ������ ��� - Ŀ�� �ݱ�

--DECLARE
--    CURSOR Ŀ�� �̸� IS SQL��; --Ŀ�� ����(Declaration)
--BEGIN
--    OPEN Ŀ���̸�; --Ŀ�� ����(Open)
--    FETCH Ŀ���̸� INTO ���� --Ŀ���κ��� �о�� ������ ���(Fetch)
--    CLOSE Ŀ�� �̸�; --Ŀ�� �ݱ�(Close)
--END;
--/

--�ϳ��� �ุ ��ȸ
DECLARE
--Ŀ�� �����͸� �Է��� ���� ����
V_DEPT_ROW  DEPT%ROWTYPE; --Ŀ�� DEPT���̺� ��ȸ �����͸� ������ ����

--����� Ŀ�� ����(Declaration)
CURSOR c1 IS --����� SELECT���� ����, Ŀ���� �̸�(c1)�� ����
    SELECT  DEPTNO,DNAME,LOC
    FROM    DEPT
    WHERE   DEPTNO = 40;
    
BEGIN
--Ŀ�� ����(Open)
OPEN c1; --c1Ŀ���� ���� Active Set�� �ĺ�

--Ŀ���κ��� �о�� ������ ���(Fetch)
FETCH   c1  INTO    V_DEPT_ROW; --FETCH INTO���� ���, Active Set���� ��� ���� ����, INTO���� ����� V_DEPT_ROW ������ ����

    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO); --V_DEPT_ROW ������ ������ �����͸� ���(���)
    DBMS_OUTPUT.PUT_LINE('DNAME : '  || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : '    || V_DEPT_ROW.LOC);

--Ŀ�� �ݱ�(Close)
CLOSE c1; --Ŀ���� ������ SELECT�� ��� �� ó���� ��� ������ Ŀ���� ����. ���� �ʿ� �� �ٽ� ���� ��� ����
END;
/

--���� ���� ��ȸ�Ǵ� ��� (LOOP��)
DECLARE
--Ŀ�� �����͸� �Է��� ���� ����
V_DEPT_ROW DEPT%ROWTYPE; --Ŀ�� DEPT���̺� ��ȸ �����͸� ������ ���� ����

--����� Ŀ�� ����(Declaration)
CURSOR c1 IS --����� SELECT���� ����, Ŀ�� �̸� ����
    SELECT  DEPTNO,DNAME,LOC
    FROM    DEPT;
    
BEGIN
--Ŀ�� ����(Open)
OPEN c1; --Ŀ���� ���� Active Set �ĺ�

LOOP
    --Ŀ���κ��� �о�� ������ ���(Fetch)
    FETCH c1 INTO V_DEPT_ROW;
    
    --Ŀ�� ��� ���� �о���� ���� %NOTFOUND �Ӽ� ����
    EXIT WHEN c1%NOTFOUND; --Ŀ�� ��� ���� ����� �� LOOP���� ���������� ���� NOT FOUND �Ӽ� ����
    
DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                 || ', DNAME : ' || V_DEPT_ROW.DNAME
                 || ', LOC : ' || V_DEPT_ROW.LOC);
END LOOP;

--Ŀ�� �ݱ�(Close)
CLOSE c1;

END;
/

--Ŀ�� �̸�%�Ӽ�
--NOTFOUND : ����� FETCH���� ���� ����� ���� ������ false, ������ true�� ��ȯ
--FOUND    : ����� FETCH���� ���� ����� ���� ������ true, ������ false�� ��ȯ
--ROWCOUNT : ������� ����� �� ���� ��ȯ
--ISOPEN   : Ŀ���� ����(open)������ true, ����(close) ������ ��ȯ

--���� �� ���� ��ȸ�Ǵ� ���(FOR LOOP��)
--LOOP���� ����� Ŀ�� ó�� ����� Ŀ�� �Ӽ��� ���, �ݺ� ������ ����
--FOR ���� �ε��� �̸� IN Ŀ�� �̸� LOOP
--    ��� �ະ�� �ݺ� ������ �۾�;
--END LOOP;    
--.�� �̿��ؼ� ���� ex) c1_rec.DEPTNO
--OPEN, FETCH, CLOSE �� �ۼ� X (FOR LOOP�� ���� �� ������� �ڵ����� ����)    

DECLARE
    --����� Ŀ�� ����(Declaration)
    CURSOR c1 IS --����� SELECT���� ����, Ŀ�� �̸�(c1)�� ����
        SELECT  DEPTNO,DNAME,LOC
        FROM    DEPT;
BEGIN
    --Ŀ�� FOR LOOP ����(�ڵ� Open, Fetch, Close)
    FOR c1_rec IN c1 LOOP --Ŀ���� FOR LOOP���� ���� �ݺ� �۾� ����.
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                          ||',DNAME  : ' || c1_rec.DNAME
                          ||',LOC    : ' || c1_rec.LOC);
    END LOOP;
END;
/
--Ŀ�� �� ���� c1_rec ���� �ε����� �����ϹǷ� ��� ���� �����ϴ� ���� ���� �ʿ�X

--Ŀ���� �Ķ���� ���
--CURSOR  Ŀ�� �̸�(�Ķ���� �̸� �ڷ���, ...) IS
--SELECT  ... 
--DEPT���̺� �μ� ��ȣ�� 10�� OR 20�� �� ��
DECLARE
    --Ŀ�� �����͸� �Է��� ���� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    --����� Ŀ�� ����(Declaration)
    CURSOR c1 (p_deptno DEPT.DEPTNO%TYPE) IS --Ŀ������ ����� �Ķ����(p_deptno)�� ����
        SELECT  DEPTNO,DNAME,LOC
        FROM    DEPT
        WHERE   DEPTNO = p_deptno; --������ �Ķ���� p_deptno�� Ŀ���� ������ SELECT�� WHERE������ DEPTNO���� �񱳰����� ���
BEGIN
    --10�� �μ� ó���� ���� Ŀ�� ���
    OPEN c1 (10); --c1Ŀ���� �Ķ���Ͱ� �����Ǿ����Ƿ� OPEN�� �� c1(10)�� ���� �ڷ����� ���߾� �Ķ���׾� �� ����.
        LOOP
            FETCH       c1 
            INTO        V_DEPT_ROW;
            EXIT WHEN   c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('10�� �μ� - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        ||', DNAME : '  || V_DEPT_ROW.DNAME
                                        ||', LOC : '    || V_DEPT_ROW.LOC);
        END LOOP;                                            
    CLOSE c1;
    --20�� �μ� ó���� ���� Ŀ�� ���
    OPEN c1 (20); --c1Ŀ���� �Ķ���Ͱ� �����Ǿ����Ƿ� OPEN�� �� c1(20)�� ���� �ڷ����� ���߾� �Ķ���׾� �� ����.
        LOOP
            FETCH       c1
            INTO        V_DEPT_ROW;
            EXIT WHEN   c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('20�� �μ� - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        ||', DNAME : '  || V_DEPT_ROW.DNAME
                                        ||', LOC : '    || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
END;
/

--&��ȣ�� ġȯ ����
DECLARE
    --����ڰ� �Է��� �μ� ��ȣ�� �����ϴ� ��������
    v_deptno    DEPT.DEPTNO%TYPE;
    --����� Ŀ�� ����(Declaration)
    CURSOR c1 (p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT      DEPTNO, DNAME, LOC
        FROM        DEPT
        WHERE       DEPTNO = p_deptno;
BEGIN
    --INPUT_DEPTNO�� �μ� ��ȣ �Է¹ް� v_deptno�� ����
    v_deptno := &INPUT_DEPTNO; --&�� ���, ����ڿ��� INPUT_DEPTNO�� �� �� �Է��� �䱸
    --Ŀ�� FOR LOOP ����. c1Ŀ���� v_deptno ����
    FOR c1_rec IN c1(v_deptno) LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                        || ', DNAME : '  || c1_rec.DNAME
                        || ', LOC : '    || c1_rec.LOC);
    END LOOP;                        
END;
/

--������(implicit) Ŀ��
--���ٸ� ���� ���� SQL���� ������� �� ����Ŭ���� �ڵ����� ����Ǵ� Ŀ�� (����ڰ� OPEN,FETCH,CLOSE�� ����X)
--PL/SQL�� ���� DML��ɾ SELECT INTO�� ���� ����� �� �ڵ����� ���� �� ó��
--Ŀ���� �ڵ����� �����ǹǷ� Ŀ�� �̸��� �������� �ʰ� SQLŰ����� �Ӽ��� ����
--SQL%NOTFOUND : ������ Ŀ�� �ȿ� ������ ���� ������ false, ������ true�� ��ȯ. DML ��ɾ�� ������ �޴� ���� ���� ��쿡�� true�� ��ȯ
--SQL%FOUND : ������ Ŀ�� �ȿ� ������ ���� ������ true, ������ false�� ��ȯ. DML ��ɾ�� ������ �޴� ���� �ִٸ� true�� ��ȯ
--SQL%ROWCOUNT : ������ Ŀ���� ������� ������ �� �� �Ǵ� DML ��ɾ�� ����޴� �� ���� ��ȯ
--SQL%ISOPEN : ������ Ŀ���� �ڵ����� SQL���� ������ �� CLOSE�ǹǷ� �� �Ӽ��� �׻� false�� ��ȯ

--������ Ŀ���� �Ӽ� ���
BEGIN
    UPDATE  DEPT --DML ���� -> ������ Ŀ���� �ڵ����� ���� �� ����
    SET     DNAME='DATABASE'
    WHERE   DEPTNO = 50; --50�� �μ� ���� -> ���� ���ŵǴ� ������X 
    
    DBMS_OUTPUT.PUT_LINE('���ŵ� ���� �� : ' || SQL%ROWCOUNT); --ROWCOUNTTHRTJD -> DML ����� �Ǵ� �� �� ��ȯ
    
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���� ���� : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���� ���� : false');
    END IF;
    
    IF (SQL%ISOPEN) THEN --������ Ŀ�� : �ڵ����� ���� �� CLOSE
        DBMS_OUTPUT.PUT_LINE('Ŀ�� OPEN ���� : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ�� OPEN ���� : false');
    END IF;
END;
/