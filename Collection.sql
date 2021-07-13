SET SERVEROUTPUT ON;
--���� �迭(Associative Array)
-- TYPE ����_�迭�� IS TABLE OF ����_�迭_��Ÿ�� INDEX BY �ε���Ÿ��;
DECLARE
    --����-���� ���� ���� �迭 ����
    TYPE av_type IS TABLE OF VARCHAR2(40)
        INDEX BY PLS_INTEGER;

    --���� �迭 ���� ����
    vav_test av_type;
BEGIN
    --���� �迭�� �� �Ҵ�
    vav_test(10) := '10�� ���� ��'; --Ű�� 10, ���� '10�� ���� ��'
    vav_test(20) := '20�� ���� ��'; --���(element)�� ����_�迭_������(�ε���) ���·� ��Ī
    
    --���� �迭 �� ���
    DBMS_OUTPUT.PUT_LINE(vav_test(10));--����
    DBMS_OUTPUT.PUT_LINE(vav_test(20));
END;
/

--���� ���� �迭(VARRAY)
--TYPE VARRAY�� IS VARRAY(�ִ� ũ��) OF ��Ұ�_Ÿ��;
DECLARE
    --5���� ������ ��(ũ��� 5)�� �̷���� VARRAY ����
    TYPE va_type IS VARRAY(5) OF VARCHAR2(20);
    
    --VARRAY ���� ����
    vva_test va_type;
    
    vn_cnt NUMBER := 0;
BEGIN    
    --�����ڸ� ���, �� �Ҵ� (�� 5������ ���� 3����) 4,5��°�� NULL
    vva_test := va_type('FIRST','SECOND','THIRD','','');
    
    LOOP
        vn_cnt := vn_cnt + 1;
        --ũ�Ⱑ 5�̹Ƿ� 5ȸ ������ ���� �� ��� ���� ���
            IF vn_cnt > 5 THEN
                EXIT;
            END IF;
            
        --VARRAY ��� �� ���
        DBMS_OUTPUT.PUT_LINE(vva_test(vn_cnt));
    END LOOP;
    
    --�� ����
    vva_test(2) := 'TEST';
    vva_test(4) := 'FOURTH';
    
    --�ٽ� ������ ���� �� ���
    vn_cnt := 0;
    LOOP
        vn_cnt := vn_cnt+1;
        --ũ�Ⱑ 5�̹Ƿ� ������ 5ȸ
        IF vn_cnt > 5 THEN
            EXIT;
        END IF;
        
        --VARRAY ��� �� ���
        DBMS_OUTPUT.PUT_LINE(vva_test(vn_cnt));
        
     END LOOP;
END;
/

--��ø ���̺�(Nested Table)
--TYPE ��ø_���̺�� IS TABLE OF ��Ÿ��;
--������ �����迭�� ���, �ε����� ������ �������̹Ƿ� ��ø ���̺��� �� Ÿ�Ը� ���
DECLARE
    --��ø ���̺� ����
    TYPE nt_typ IS TABLE OF VARCHAR2(10);
    
    --���� ����
    vnt_test nt_typ;
BEGIN
    --�����ڸ� ����� �� �Ҵ�
    vnt_test := nt_typ('FIRST','SECOND','THIRD','');
    
    --�� ���
    DBMS_OUTPUT.PUT_LINE(vnt_test(1));
    DBMS_OUTPUT.PUT_LINE(vnt_test(2));
    DBMS_OUTPUT.PUT_LINE(vnt_test(3));
END;
/