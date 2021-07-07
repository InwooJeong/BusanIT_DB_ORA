SELECT  *   
FROM    CUSTOMER;

SELECT  *
FROM    ORDERS;

SELECT  *
FROM    BOOK;

SELECT  *
FROM    imported_book;

SELECT  c.custid 고객번호, c.name 고객이름, c.address 고객주소, c.phone 연락처, o.orderid 주문번호,
        b.bookid 도서번호, o.saleprice 구매가격, b.price 판매가격, o.orderdate 주문일, b.bookname 도서명, b.publisher 출판사
FROM    customer c, orders o, book b
WHERE   c.custid = o.custid
AND     b.bookid = o.bookid
ORDER BY    c.custid, o.saleprice;

SELECT      rownum, bookid, bookname, publisher, price
FROM        book
--WHERE       rownum <=5
ORDER BY    bookname;

SELECT      rownum, bookid, bookname, publisher, price
FROM        (SELECT     *
             FROM       book
             ORDER BY   bookname)
WHERE       rownum <=5
;

SELECT      rownum, bookid, bookname, publisher, price
FROM        (SELECT     *
             FROM       book
             WHERE      ROWNUM <= 5
             ORDER BY   bookname)
;