SET SERVEROUTPUT ON;
--���� -> SQL �Ǵ� PL/SQL�� ���� ������� ����
--COMPLIE/SYNTAX VS RUNTIME/EXECUTE
--����, �� ���α׷��� ����Ǵ� ���� �߻��ϴ� ���� -> ���� (exception)

--���ܰ� �߻��ϴ� PL/SQL
DECLARE
    v_wrong NUMBER; --���� �����͸� �����ϴ� v_wrong���� ����
BEGIN
    SELECT      DNAME --SELECT INTO���� ���� DEPT DANME�� ���� v_wrong������ ���� -> VARCHAR2 �ڷ����� NUMBER �ڷ����� => Exception!
    INTO        v_wrong
    FROM        DEPT
    WHERE       DEPTNO = 10;
END;
/

--���ܸ� ó���ϴ� PL/SQL
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT      DNAME 
    INTO        v_wrong
    FROM        DEPT
    WHERE       DEPTNO = 10;
    
EXCEPTION --���� ó����/���� ó���� ���� �ڵ� ���� ������ ������� ����
    WHEN    VALUE_ERROR THEN 
        DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�');
END;
/

--���� �߻� �� �ڵ� ���� ����
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT  DNAME
    INTO    v_wrong
    FROM    DEPT
    WHERE   DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.'); --�߻��� ���ܸ� EXCEPTION �ۼ��� ���� ó���ص� �̹� ���ܰ� �߻��� �ڵ� ���� ������ ������� �ʴ´�.
EXCEPTION
    WHEN    VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�!');
END;
/

CL SCR

--���� ó���� �ۼ�
--WHEN - ���� �ڵ鷯(exception handler) : �߻��� ���� �̸��� ��ġ�ϴ� WHEN���� ��ɾ ����
--IF-THEN ��ó�� ���� ���� �ڵ鷯 �� ��ġ�ϴ� �ϳ��� ���� �ڵ鷯 ��ɾ ����
--OTHERS�� ���� �ۼ��� ��� ���ܿ͵� ��ġ�ϴ� ���ܰ� ���� ��� ó���� ����(IF ���ǹ��� ELSE�� ����)
--EXCEPTION
--    WHEN ���� �̸�1 [OR ���� �̸� 2 - ] THEN
--        ���� ó���� ����� ��ɾ�;
--    WHEN ���� �̸�3 [OR ���� �̸� 4 - ] THEN
--        ���� ó���� ����� ��ɾ�;
--    ...
--    WHEN OTHERS THEN
--        ���� ó���� ����� ��ɾ�;

--������ ���ǵ� ���� ���
--�߻��� �� �ִ� ���ܸ� ���
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT  DNAME
    INTO    v_wrong
    FROM    DEPT
    WHERE   DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.');
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('���� ó�� : �䱸���� ���� �� ���� ���� �߻�!');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('���� ó�� : ��ġ �Ǵ� �� ���� �߻�!');
    WHEN OTHERS THEN        
        DBMS_OUTPUT.PUT_LINE('���� ó�� : ���� ���� �� ���� �߻�!');
END;
/

--�̸� ���� (����) ���� ���
--�̸��� ���� ���� : ����ο��� ����Ŭ ���� ��ȣ�� �Բ� �̸� �ο�
--DECLARE
--    ���� �̸�1 EXCEPTION;
--    PRAGMA EXCEPTION_INIT(���� �̸�1, ���� ��ȣ);
--.
--.
--.
--EXCEPTION
--    WHEN ���� �̸�1 THEN
--        ���� ó���� ����� ��ɾ�;
--    ...
--END;    

--����� ���� ���� ���
--����Ŭ�� ���ǵǾ� ���� ���� Ư�� ��Ȳ�� ���� ������ ����
--���� �̸��� ���� �ְ� ����ο��� ���� ������ ���� ��Ȳ�� ������ �� RAISE Ű���带 ���, ���ܸ� ���� �����.
--DECLARE
--    ����� ���� �̸� EXCEPTION;
--    ...
--BEGIN
--    IF ����� ���ܸ� �߻���ų ���� THEN
--        RAISE ����� ���� �̸�
--    ...
--    END IF;
--EXCEPTION
--    WHEN ����� ���� �̸� THEN
--        ���� ó���� ����� ��ɾ�;
--    ...
--END;    

--���� �ڵ�� ���� �޼��� ���
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT  DNAME
    INTO    v_wrong
    FROM    DEPT
    WHERE   DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���� ó�� : ���� ���� �� ���� �߻�');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE)); --���� ��ȣ�� ��ȯ�ϴ� �Լ�
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM); --���� �޼����� ��ȯ�ϴ� �Լ�
END;
/

--18_Q2
DECLARE
    v_wrong DATE;
BEGIN
    SELECT  ENAME
    INTO    v_wrong
    FROM    EMP
    WHERE   EMPNO = 7369;
    
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('������ �߻��Ͽ����ϴ�.' || TO_CHAR(SYSDATE, '[YYYY"��" MM"��" DD"��" HH24"��" MM"��" SS"��"]'));
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/
