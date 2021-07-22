SET SERVEROUTPUT ON;
--CREATE [OR REPLACE] FUNCTION 함수 이름
--[(파라미터 이름1 [IN] 자료형1, <-함수 실행에 사용할 파라미터 지정. 생략 가능하며 필요에 따라 여러 개 가능. IN 모드만 가능. :=, DEFAULT 옵션으로 기본값 지정 가능
--  파라미터 이름2 [IN] 자료형2,
-- ...
--  파라미터 이름N [IN] 자료형N
--)]
--RETURN 자료형 <- 실행 후 반환 값 자료형 정의
--IS | AS
--    선언부
--BEGIN
--    실행부
--    RETURN (반환 값); <- 반환 값 지정
--EXCEPTION
--    예외 처리부
--END [함수 이름];
--함수에 OUT, IN OUT 모드 파라미터 지정 가능하지만 지정 시 SQL문에서 사용 가능 -> 프로시저와 다를 바 없어진다.
--SQL문에 사용할 함수는 반환 값 자료형을 SQL문에서 사용할 수 없는 자료형으로 지정할 수 없으며 트랜잭션 제어 명령어, DML 명령어도 사용 불가

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
    aftertax NUMBER; --반환 값을 받기 위한 변수 선언
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