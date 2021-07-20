SET SERVEROUTPUT ON;
--파라미터를 사용하지 않는 프로시저
--CREAT [OR REPLACE] PROCEDURE 프로시저 이름 --뷰 처럼 존재시 대체(덮어 쓴다), 프로시저 이름은 같은 시키마 내에서 중복 불가
--IS || AS --DECLARE 사용X. 선언부가 없더라도 반드시 명시
--    선언부
--BEGIN
--    실행부
--EXCEPTION --생략 가능
--    예외 처리부
--END [프로시저 이름]; --생성 종료. 이름은 생략 가능    

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

EXECUTE     pro_noparam; --SQL*PLUS에서 바로 사용 가능

BEGIN --익명 블록(anonymous block)
    pro_noparam;
END;
/

--이미 저장되어 있는 프로시저나 서브프로그램 소스 코드 내용을 확인하려면 USER_SOURCE 데이터 사전에서 조회
SELECT      * 
FROM        USER_SOURCE
WHERE       NAME = 'PRO_NOPARAM';

SELECT      TEXT
FROM        USER_SOURCE
WHERE       NAME = 'PRO_NOPARAM';

--삭제
DROP PROCEDURE  PRO_NOPARAM;

CL SCR

--파라미터를 사용하는 프로시저
--CREATE OR REPLACE PROCEDURE 프로시저 이름
--[(파라미터 이름1 [modes] 자료형 [ := | DEFAULT 기본값],
--  파라미터 이름2 [modes] 자료형 [ := | DEFAULT 기본값],
--  ....
--  파라미터 이름4 [modes] 자료형 [ := | DEFAULT 기본값] --파라미터 정의. 파라미터는 ,로 구분하여 여러개 지정 가능. 기본값과 모드는 생략 가능. 자료형은 자릿수 지정 및 NOT NULL 제약 조건 사용 불가
--)]
--IS | AS
--    선언부
--BEGIN
--    실행부
--EXCEPTION
--    예외 처리부
--END [프로시저 이름];    

--IN 모드 파라미터 : 지정하지 않으면 기본값으로 프로시저를 호출할 때 값을 입력받음. IN은 기본 값이라 생략 가능
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

--실행 개수 확인!
BEGIN
    pro_param_in(1);
END;
/

--파라미터 이름 활용
EXECUTE pro_param_in(param1 => 10, param2 => 20);

--위치 지정 : 지정한 파라미터 순서대로 값을 지정
--이름 지정 : => 연산자로 파라미터 이름을 명시하여 값을 지정
--혼합 지정 : 일부 파라미터는 순서대로 값만 지정하고 일부 파라미터는 => 연산자로 값 지정

--OUT 모드 파라미터 : 프로시저 실행 후 호출한 프로그램으로 값을 반환 : 호출할 때 값 반환
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

--IN OUT 모드 파라미터