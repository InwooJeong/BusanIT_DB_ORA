SET SERVEROUTPUT ON;
--연관 배열(Associative Array)
-- TYPE 연관_배열명 IS TABLE OF 연관_배열_값타입 INDEX BY 인덱스타입;
DECLARE
    --숫자-문자 쌍의 연관 배열 선언
    TYPE av_type IS TABLE OF VARCHAR2(40)
        INDEX BY PLS_INTEGER;

    --연관 배열 변수 선언
    vav_test av_type;
BEGIN
    --연관 배열에 값 할당
    vav_test(10) := '10에 대한 값'; --키는 10, 값은 '10에 대한 값'
    vav_test(20) := '20에 대한 값'; --요소(element)를 연관_배열_변수명(인덱스) 형태로 매칭
    
    --연관 배열 값 출력
    DBMS_OUTPUT.PUT_LINE(vav_test(10));--접근
    DBMS_OUTPUT.PUT_LINE(vav_test(20));
END;
/

--가변 길이 배열(VARRAY)
--TYPE VARRAY명 IS VARRAY(최대 크기) OF 요소값_타입;
DECLARE
    --5개의 문자형 값(크기는 5)로 이루어진 VARRAY 선언
    TYPE va_type IS VARRAY(5) OF VARCHAR2(20);
    
    --VARRAY 변수 선언
    vva_test va_type;
    
    vn_cnt NUMBER := 0;
BEGIN    
    --생성자를 사용, 값 할당 (총 5개지만 최초 3개만) 4,5번째는 NULL
    vva_test := va_type('FIRST','SECOND','THIRD','','');
    
    LOOP
        vn_cnt := vn_cnt + 1;
        --크기가 5이므로 5회 루프를 돌며 각 요소 값을 출력
            IF vn_cnt > 5 THEN
                EXIT;
            END IF;
            
        --VARRAY 요소 값 출력
        DBMS_OUTPUT.PUT_LINE(vva_test(vn_cnt));
    END LOOP;
    
    --값 변경
    vva_test(2) := 'TEST';
    vva_test(4) := 'FOURTH';
    
    --다시 루프를 돌려 값 출력
    vn_cnt := 0;
    LOOP
        vn_cnt := vn_cnt+1;
        --크기가 5이므로 루프를 5회
        IF vn_cnt > 5 THEN
            EXIT;
        END IF;
        
        --VARRAY 요소 값 출력
        DBMS_OUTPUT.PUT_LINE(vva_test(vn_cnt));
        
     END LOOP;
END;
/

--중첩 테이블(Nested Table)
--TYPE 중첩_테이블명 IS TABLE OF 값타입;
--구문은 연관배열과 흡사, 인덱스는 무조건 숫자형이므로 중첩 테이블의 값 타입만 명시
DECLARE
    --중첩 테이블 선언
    TYPE nt_typ IS TABLE OF VARCHAR2(10);
    
    --변수 선언
    vnt_test nt_typ;
BEGIN
    --생성자를 사용해 값 할당
    vnt_test := nt_typ('FIRST','SECOND','THIRD','');
    
    --값 출력
    DBMS_OUTPUT.PUT_LINE(vnt_test(1));
    DBMS_OUTPUT.PUT_LINE(vnt_test(2));
    DBMS_OUTPUT.PUT_LINE(vnt_test(3));
END;
/