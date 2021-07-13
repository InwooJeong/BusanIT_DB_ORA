SET SERVEROUTPUT ON;
--오류 -> SQL 또는 PL/SQL이 정상 수행되지 못함
--COMPLIE/SYNTAX VS RUNTIME/EXECUTE
--후자, 즉 프로그램이 실행되는 도중 발생하는 오류 -> 예외 (exception)

--예외가 발생하는 PL/SQL
DECLARE
    v_wrong NUMBER; --숫자 데이터를 저장하는 v_wrong변수 선언
BEGIN
    SELECT      DNAME --SELECT INTO문을 통해 DEPT DANME열 값을 v_wrong변수에 대입 -> VARCHAR2 자료형을 NUMBER 자료형에 => Exception!
    INTO        v_wrong
    FROM        DEPT
    WHERE       DEPTNO = 10;
END;
/

--예외를 처리하는 PL/SQL
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT      DNAME 
    INTO        v_wrong
    FROM        DEPT
    WHERE       DEPTNO = 10;
    
EXCEPTION --예외 처리부/예외 처리절 예외 코드 이후 내용은 실행되지 않음
    WHEN    VALUE_ERROR THEN 
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
END;
/

--예외 발생 후 코드 실행 여부
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT  DNAME
    INTO    v_wrong
    FROM    DEPT
    WHERE   DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.'); --발생한 예외를 EXCEPTION 작성을 통해 처리해도 이미 예외가 발생한 코드 이후 내용은 실행되지 않는다.
EXCEPTION
    WHEN    VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생!');
END;
/

CL SCR

--예외 처리부 작성
--WHEN - 예외 핸들러(exception handler) : 발생한 예외 이름과 일치하는 WHEN절의 명령어를 수행
--IF-THEN 뭉처럼 여러 예외 핸들러 중 일치하는 하나의 예외 핸들러 명령어만 수행
--OTHERS는 먼저 작성한 어느 예외와도 일치하는 예외가 없을 경우 처리할 내용(IF 조건문의 ELSE와 유사)
--EXCEPTION
--    WHEN 예외 이름1 [OR 예외 이름 2 - ] THEN
--        예외 처리에 사용할 명령어;
--    WHEN 예외 이름3 [OR 예외 이름 4 - ] THEN
--        예외 처리에 사용할 명령어;
--    ...
--    WHEN OTHERS THEN
--        예외 처리에 사용할 명령어;

--사전에 정의된 예외 사용
--발생할 수 있는 예외를 명시
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT  DNAME
    INTO    v_wrong
    FROM    DEPT
    WHERE   DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 요구보다 많은 행 추출 오류 발생!');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생!');
    WHEN OTHERS THEN        
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생!');
END;
/

--이름 없는 (내부) 예외 사용
--이름을 직접 지정 : 선언부에서 오라클 예외 번호와 함께 이름 부여
--DECLARE
--    예외 이름1 EXCEPTION;
--    PRAGMA EXCEPTION_INIT(예외 이름1, 예외 번호);
--.
--.
--.
--EXCEPTION
--    WHEN 예외 이름1 THEN
--        예외 처리에 사용할 명령어;
--    ...
--END;    

--사용자 정의 예외 사용
--오라클에 정의되어 있지 않은 특정 상황을 직접 오류로 정의
--예외 이름을 정해 주고 실행부에서 직접 정의한 오류 상황이 생겼을 때 RAISE 키워드를 사용, 예외를 직접 만든다.
--DECLARE
--    사용자 예외 이름 EXCEPTION;
--    ...
--BEGIN
--    IF 사용자 예외를 발생시킬 조건 THEN
--        RAISE 사용자 예외 이름
--    ...
--    END IF;
--EXCEPTION
--    WHEN 사용자 예외 이름 THEN
--        예외 처리에 사용할 명령어;
--    ...
--END;    

--오류 코드와 오류 메세지 사용
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT  DNAME
    INTO    v_wrong
    FROM    DEPT
    WHERE   DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE)); --오류 번호를 반환하는 함수
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM); --오류 메세지를 반환하는 함수
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
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류가 발생하였습니다.' || TO_CHAR(SYSDATE, '[YYYY"년" MM"월" DD"일" HH24"시" MM"분" SS"초"]'));
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/
