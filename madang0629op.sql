SELECT  *   
FROM    CUSTOMER;

SELECT  *
FROM    ORDERS;

SELECT  *
FROM    BOOK;

SELECT  *
FROM    imported_book;

SELECT  c.custid ����ȣ, c.name ���̸�, c.address ���ּ�, c.phone ����ó, o.orderid �ֹ���ȣ,
        b.bookid ������ȣ, o.saleprice ���Ű���, b.price �ǸŰ���, o.orderdate �ֹ���, b.bookname ������, b.publisher ���ǻ�
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