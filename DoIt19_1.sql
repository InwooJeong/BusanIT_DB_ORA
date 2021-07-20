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
CREATE OR REPLACE PROCEDURE 프로시저 이름
[(파라미터 이름1 [modes] 자료형 [ := | DEFAULT 기본값],
  파라미터 이름2 [modes] 자료형 [ := | DEFAULT 기본값],
  ....
  파라미터 이름4 [modes] 자료형 [ := | DEFAULT 기본값]
)]
IS | AS
    선언부
BEGIN
    실행부
EXCEPTION
    예외 처리부
END [프로시저 이름];    