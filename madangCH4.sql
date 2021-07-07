SELECT      ABS(-7), ABS(+78)
FROM        DUAL;

SELECT      ROUND(4.875, 1)
FROM        DUAL;

SELECT      custid as "����ȣ", ROUND(SUM(saleprice)/COUNT(*),-2) as "��ձݾ�"
FROM        orders
GROUP BY    custid;

SELECT      bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM        book;

SELECT      bookname as "����", LENGTH(bookname) as "���ڼ�", LENGTHB(bookname) as "����Ʈ��" --VSIZE
FROM        book
WHERE       publisher = '�½�����';

SELECT      SUBSTR(name, 1, 1) as "��", COUNT(*) as "�ο�"
FROM        customer
GROUP BY    SUBSTR(name, 1, 1);

SELECT      orderid as "�ֹ���ȣ", orderdate as "�ֹ���", orderdate+10 as "Ȯ��"
FROM        orders;

SELECT      orderid as "�ֹ���ȣ", TO_CHAR(orderdate, 'yyyy-mm-dd dy') as "�ֹ���",
            custid as "����ȣ", bookid "������ȣ"
FROM        orders
WHERE       orderdate=TO_DATE('20140707', 'yyyymmdd');

SELECT      SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') as "SYSDATE_1"
FROM        DUAL;

SELECT      ABS(-15)
FROM        DUAL;

SELECT      CEIL(15.7)
FROM        DUAL;

SELECT      COS(3.14159)
FROM        DUAL;

SELECT      FLOOR(15.7)
FROM        DUAL;

SELECT      LOG(10,100)
FROM        DUAL;

SELECT      MOD(11,4)
FROM        DUAL;

SELECT      POWER(3,2)
FROM        DUAL;

SELECT      ROUND(15.7)
FROM        DUAL;

SELECT      SIGN(-15)
FROM        DUAL;

SELECT      TRUNC(15.7)
FROM        DUAL;

SELECT      CHR(67)
FROM        DUAL;

SELECT      CONCAT('HAPPY','Birthday')
FROM        DUAL;

SELECT      LOWER('BIRTHDAY')
FROM        DUAL;

SELECT      LPAD('Page 1', 15, '*.')
FROM        DUAL;

SELECT      LTRIM('Page 1','Pag')
FROM        DUAL;

SELECT      REPLACE('JACK','J','BL')
FROM        DUAL;

SELECT      RPAD('Page 1',15,'*.')
FROM        DUAL;

SELECT      RTRIM('Page 1','e 1')
FROM        DUAL;

SELECT      SUBSTR('ABCDEFG',3,4)
FROM        DUAL;

SELECT      TRIM(LEADING 0 FROM '00AA00')
FROM        DUAL;

SELECT      TRIM(TRAILING 0 FROM '00AA00')
FROM        DUAL;

SELECT      TRIM(BOTH 0 FROM '00AA00')
FROM        DUAL;

SELECT      UPPER('birthday')
FROM        DUAL;

SELECT      ASCII('A')
FROM        DUAL;

SELECT      INSTR('CORPORATE FLOOR','OR',3,2)
FROM        DUAL;

SELECT      LENGTH('Birthday')
FROM        DUAL;

SELECT      ADD_MONTHS('14/05/21',1)
FROM        DUAL;

SELECT      LAST_DAY(SYSDATE)
FROM        DUAL;

SELECT      LAST_DAY(SYSDATE)
FROM        DUAL;

SELECT      ROUND(SYSDATE)
FROM        DUAL;

SELECT      SYSDATE
FROM        DUAL;

SELECT      TO_CHAR(SYSDATE)
FROM        DUAL;

SELECT      TO_CHAR(123)
FROM        DUAL;

SELECT      TO_DATE('12 05 2014', 'DD MM YYYY')
FROM        DUAL;

SELECT      TO_NUMBER('12.3')
FROM        DUAL;

SELECT      DECODE(1,1,'aa','bb')
FROM        DUAL;

SELECT      NULLIF(123,345)
FROM        DUAL;

SELECT      NVL(NULL, 123)
FROM        DUAL;

SELECT      name as "�̸�", NVL(phone, '����ó����') as "��ȭ��ȣ"
FROM        customer;

SELECT      ROWNUM as "����", custid, name, phone
FROM        customer
WHERE       ROWNUM <= 2;

SELECT      (SELECT     name
             FROM       customer cs
             WHERE      cs.custid=od.custid) as "name", SUM(saleprice) as "total"
FROM         orders od
GROUP BY     od.custid;

UPDATE      orders
SET         bookname = (SELECT      bookname
                        FROM        book
                        WHERE       book.bookid = orders.bookid);
DESC ORDERS                        
--�ϴ� ORDERS�� BOOKNAME�� ��� �Ұ�                        
CL SCR                        

SELECT      cs.name, SUM(od.saleprice) as "total"
FROM        (SELECT     custid,name
             FROM       customer
             WHERE      custid <= 2) cs,
             orders od
WHERE       cs.custid=od.custid
GROUP BY    cs.name;

SELECT      orderid, saleprice
FROM        orders
WHERE       saleprice <= (SELECT    AVG(saleprice)
                          FROM      orders);
                          
SELECT      orderid, custid, saleprice
FROM        orders od
WHERE       saleprice > (SELECT     AVG(saleprice)
                         FROM       orders so
                         WHERE      od.custid = so.custid);
                         
SELECT      SUM(saleprice) as "total"
FROM        orders
WHERE       custid IN (SELECT       custid
                       FROM         customer
                       WHERE        address LIKE '%���ѹα�%');
                       
SELECT      orderid, saleprice
FROM        orders
WHERE       saleprice > ALL (SELECT     saleprice
                             FROM       orders
                             WHERE      custid = '3');
                             
SELECT      SUM(saleprice) as "total"
FROM        ORDERS od
WHERE       EXISTS (SELECT      *
                    FROM        customer cs
                    WHERE       address LIKE '%���ѹα�%' AND cs.custid=od.custid);
--4-1                    
SELECT      od.custid, (SELECT     address
                     FROM       customer cs
                     WHERE      cs.custid = od.custid) as "address",
                     SUM(saleprice) as "total"
FROM        orders od
GROUP BY    od.custid;
--�ֹ� ��Ȳ�� ��ID, ���ּҿ� �ֹ� �Ѿ�
--4-2
SELECT      cs.name, s
FROM        (SELECT     custid, AVG(saleprice) s
             FROM       orders
             GROUP BY   custid) od, customer cs
WHERE       cs.custid=od.custid;
--�ֹ� ��Ȳ�� �� �̸��� ��� ���űݾ�
--4-3
SELECT      SUM(saleprice) as "total"
FROM        orders od
WHERE       EXISTS(SELECT       *
                   FROM         customer cs
                   WHERE        custid <= 3 AND cs.custid=od.custid);
--�ֹ� ��Ȳ �� ��ID�� 3�� ������ ������ ���� �Ѿ�

CREATE VIEW     vw_customer
AS              SELECT      *
                FROM        customer
                WHERE       address LIKE '%���ѹα�%';

SELECT     *
FROM       vw_customer;

CREATE VIEW     vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS              SELECT  od.orderid, od.custid, cs.name,
                        od.bookid, bk.bookname, od.saleprice, od.orderdate
                FROM    orders od, customer cs, book bk
                WHERE   od.custid = cs.custid AND od.bookid = bk.bookid;
                
SELECT      orderid, bookname, saleprice
FROM        vw_orders
WHERE       name = '�迬��';

CREATE OR REPLACE VIEW    vw_customer(custid,name,address)
AS                        SELECT      custid,name,address
                          FROM        customer
                          WHERE       address LIKE '%����%';
                          
SELECT      *
FROM        vw_customer;

DROP VIEW       vw_customer;

CL SCR
--6-1
CREATE OR REPLACE VIEW      highorders(bookid, bookname, name, publisher, saleprice)
AS                          SELECT  b.bookid, b.bookname, c.name, b.publisher, o.saleprice
                            FROM    orders o, customer c, book b
                            WHERE   o.custid = c.custid
                            AND     o.bookid = b.bookid
                            AND     o.saleprice >= 20000;
--6-2/3                            
SELECT      bookname, name
FROM        highorders;
--6-3
CREATE OR REPLACE VIEW      highorders(bookid, bookname, name, publisher)
AS                          SELECT  b.bookid, b.bookname, c.name, b.publisher
                            FROM    orders o, customer c, book b
                            WHERE   o.custid = c.custid
                            AND     o.bookid = b.bookid
                            AND     o.saleprice >= 20000;
                            
                            