SET SERVEROUTPUT ON;
--cursor : 특정 열을 선택하여 처리
--명시적(explicit)/묵시적(implicit)
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
--1. 명시적(explicit) 커서
-- 커서선언 - 커서열기 - 커서에서 읽어온 데이터 사용 - 커서 닫기

--DECLARE
--    CURSOR 커서 이름 IS SQL문; --커서 선언(Declaration)
--BEGIN
--    OPEN 커서이름; --커서 열기(Open)
--    FETCH 커서이름 INTO 변수 --커서로부터 읽어온 데이터 사용(Fetch)
--    CLOSE 커서 이름; --커서 닫기(Close)
--END;
--/

--하나의 행만 조회
DECLARE
--커서 데이터를 입력한 변수 선언
V_DEPT_ROW  DEPT%ROWTYPE; --커서 DEPT테이블 조회 데이터를 저장할 변수

--명시적 커서 선언(Declaration)
CURSOR c1 IS --사용할 SELECT문을 지정, 커서의 이름(c1)을 선언
    SELECT  DEPTNO,DNAME,LOC
    FROM    DEPT
    WHERE   DEPTNO = 40;
    
BEGIN
--커서 열기(Open)
OPEN c1; --c1커서를 열어 Active Set을 식별

--커서로부터 읽어온 데이터 사용(Fetch)
FETCH   c1  INTO    V_DEPT_ROW; --FETCH INTO문을 사용, Active Set에서 결과 행을 추출, INTO절에 명시한 V_DEPT_ROW 변수에 대입

    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO); --V_DEPT_ROW 변수에 저장한 데이터를 출력(사용)
    DBMS_OUTPUT.PUT_LINE('DNAME : '  || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : '    || V_DEPT_ROW.LOC);

--커서 닫기(Close)
CLOSE c1; --커서에 지정한 SELECT문 결과 행 처리가 모두 끝나면 커서를 닫음. 이후 필요 시 다시 열어 사용 가능
END;
/

--여러 행이 조회되는 경우 (LOOP문)
DECLARE
--커서 데이터를 입력할 변수 선언
V_DEPT_ROW DEPT%ROWTYPE; --커서 DEPT테이블 조회 데이터를 저장할 변수 선언

--명시적 커서 선언(Declaration)
CURSOR c1 IS --사용할 SELECT문을 지정, 커서 이름 선언
    SELECT  DEPTNO,DNAME,LOC
    FROM    DEPT;
    
BEGIN
--커서 열기(Open)
OPEN c1; --커서를 열어 Active Set 식별

LOOP
    --커서로부터 읽어온 데이터 사용(Fetch)
    FETCH c1 INTO V_DEPT_ROW;
    
    --커서 모든 행을 읽어오기 위해 %NOTFOUND 속성 지정
    EXIT WHEN c1%NOTFOUND; --커서 모든 행을 사용한 후 LOOP문을 빠져나오기 위해 NOT FOUND 속성 지정
    
DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
                 || ', DNAME : ' || V_DEPT_ROW.DNAME
                 || ', LOC : ' || V_DEPT_ROW.LOC);
END LOOP;

--커서 닫기(Close)
CLOSE c1;

END;
/

--커서 이름%속성
--NOTFOUND : 수행된 FETCH문을 통해 추출된 행이 있으면 false, 없으면 true를 반환
--FOUND    : 수행된 FETCH문을 통해 추출된 행이 있으면 true, 없으면 false를 반환
--ROWCOUNT : 현재까지 추출된 행 수를 반환
--ISOPEN   : 커서가 열려(open)있으면 true, 닫혀(close) 있으면 반환

--여려 개 행이 조회되는 경우(FOR LOOP문)
--LOOP문을 사용한 커서 처리 방식은 커서 속성을 사용, 반복 수행을 제어
--FOR 루프 인덱스 이름 IN 커서 이름 LOOP
--    결과 행별로 반복 수행할 작업;
--END LOOP;    
--.을 이용해서 접근 ex) c1_rec.DEPTNO
--OPEN, FETCH, CLOSE 문 작성 X (FOR LOOP를 통해 각 명령저를 자동으로 수행)    

DECLARE
    --명시적 커서 선언(Declaration)
    CURSOR c1 IS --사용할 SELECT문을 지정, 커서 이름(c1)을 선언
        SELECT  DEPTNO,DNAME,LOC
        FROM    DEPT;
BEGIN
    --커서 FOR LOOP 시작(자동 Open, Fetch, Close)
    FOR c1_rec IN c1 LOOP --커서에 FOR LOOP문을 통해 반복 작업 수행.
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                          ||',DNAME  : ' || c1_rec.DNAME
                          ||',LOC    : ' || c1_rec.LOC);
    END LOOP;
END;
/
--커서 각 행을 c1_rec 루프 인덱스에 저장하므로 결과 행을 저장하는 변수 선언 필요X

--커서에 파라미터 사용
--CURSOR  커서 이름(파라미터 이름 자료형, ...) IS
--SELECT  ... 
--DEPT테이블 부서 번호가 10번 OR 20번 일 때
DECLARE
    --커서 데이터를 입력할 변수 선언
    V_DEPT_ROW DEPT%ROWTYPE;
    --명시적 커서 선언(Declaration)
    CURSOR c1 (p_deptno DEPT.DEPTNO%TYPE) IS --커서에서 사용할 파라미터(p_deptno)를 선언
        SELECT  DEPTNO,DNAME,LOC
        FROM    DEPT
        WHERE   DEPTNO = p_deptno; --선언한 파라미터 p_deptno는 커서에 지정한 SELECT문 WHERE절에서 DEPTNO열의 비교값으로 사용
BEGIN
    --10번 부서 처리를 위해 커서 사용
    OPEN c1 (10); --c1커서에 파라미터가 지정되었으므로 OPEN할 때 c1(10)과 같은 자료형을 맞추어 파라미테어 값 지정.
        LOOP
            FETCH       c1 
            INTO        V_DEPT_ROW;
            EXIT WHEN   c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('10번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        ||', DNAME : '  || V_DEPT_ROW.DNAME
                                        ||', LOC : '    || V_DEPT_ROW.LOC);
        END LOOP;                                            
    CLOSE c1;
    --20번 부서 처리를 위해 커서 사용
    OPEN c1 (20); --c1커서에 파라미터가 지정되었으므로 OPEN할 때 c1(20)과 같은 자료형을 맞추어 파라미테어 값 지정.
        LOOP
            FETCH       c1
            INTO        V_DEPT_ROW;
            EXIT WHEN   c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('20번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO
                                        ||', DNAME : '  || V_DEPT_ROW.DNAME
                                        ||', LOC : '    || V_DEPT_ROW.LOC);
        END LOOP;
    CLOSE c1;
END;
/

--&기호와 치환 변수
DECLARE
    --사용자가 입력한 부서 번호를 저장하는 변수선언
    v_deptno    DEPT.DEPTNO%TYPE;
    --명시적 커서 선언(Declaration)
    CURSOR c1 (p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT      DEPTNO, DNAME, LOC
        FROM        DEPT
        WHERE       DEPTNO = p_deptno;
BEGIN
    --INPUT_DEPTNO에 부서 번호 입력받고 v_deptno에 대입
    v_deptno := &INPUT_DEPTNO; --&를 사용, 사용자에게 INPUT_DEPTNO에 들어갈 값 입력을 요구
    --커서 FOR LOOP 시작. c1커서에 v_deptno 대입
    FOR c1_rec IN c1(v_deptno) LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
                        || ', DNAME : '  || c1_rec.DNAME
                        || ', LOC : '    || c1_rec.LOC);
    END LOOP;                        
END;
/

--묵시적(implicit) 커서
--별다른 선언 없이 SQL문을 사용했을 때 오라클에서 자동으로 선언되는 커서 (사용자가 OPEN,FETCH,CLOSE를 지정X)
--PL/SQL문 내부 DML명령어나 SELECT INTO문 등이 실행될 때 자동으로 생성 및 처리
--커서가 자동으로 생성되므로 커서 이름을 지정하지 않고 SQL키워드로 속성을 지정
--SQL%NOTFOUND : 묵시적 커서 안에 추출한 행이 있으면 false, 없으면 true를 반환. DML 명령어로 영향을 받는 행이 없을 경우에도 true를 반환
--SQL%FOUND : 묵시적 커서 안에 추출한 행이 있으면 true, 없으면 false를 반환. DML 명령어로 영향을 받는 행이 있다면 true를 반환
--SQL%ROWCOUNT : 묵시적 커서에 현재까지 추출한 행 수 또는 DML 명령어로 영향받는 행 수를 반환
--SQL%ISOPEN : 묵시적 커서는 자동으로 SQL문을 실행한 후 CLOSE되므로 이 속성은 항상 false를 반환

--묵시적 커서의 속성 사용
BEGIN
    UPDATE  DEPT --DML 실행 -> 묵시적 커서가 자동으로 생성 후 실행
    SET     DNAME='DATABASE'
    WHERE   DEPTNO = 50; --50번 부서 없음 -> 실제 갱신되는 데이터X 
    
    DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT); --ROWCOUNTTHRTJD -> DML 대상이 되는 행 수 반환
    
    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : false');
    END IF;
    
    IF (SQL%ISOPEN) THEN --묵시적 커서 : 자동으로 실행 후 CLOSE
        DBMS_OUTPUT.PUT_LINE('커서 OPEN 여부 : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서 OPEN 여부 : false');
    END IF;
END;
/