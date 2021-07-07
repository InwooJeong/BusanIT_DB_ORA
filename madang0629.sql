SELECT  *   
FROM    CUSTOMER;

SELECT  *
FROM    ORDERS;

SELECT  *
FROM    BOOK;

SELECT  *
FROM    imported_book;

SELECT  *
FROM    customer c, orders o, book b
WHERE   c.custid = o.custid
AND     b.bookid = o.bookid
ORDER BY    c.custid;

SELECT  bookname, price
FROM    book;

SELECT  price, bookname
FROM    book;

SELECT  bookid, bookname, publisher, price
FROM    book;

SELECT  *
FROM    book;

SELECT  publisher
FROM    book;

SELECT  distinct publisher
FROM    book;

SELECT  *
FROM    book
WHERE   price < 20000;

SELECT  *
FROM    book
where   price between 10000 and 20000;

SELECT  *
FROM    book
WHERE   price >= 10000 and price <= 20000;

SELECT  *
FROM    book
WHERE   publisher in ('굿스포츠','대한미디어');

SELECT  *
FROM    book
WHERE   publisher not in ('굿스포츠','대한미디어');

SELECT  bookname, publisher
FROM    book
WHERE   bookname LIKE '축구의 역사';

SELECT  bookname, publisher
FROM    book
WHERE   bookname LIKE '%축구%';

SELECT  *
FROM    book
where   bookname like '_구%';

SELECT  *
FROM    book
WHERE   bookname like '%축구%' and price >= 20000;

SELECT  *
FROM    book
WHERE   publisher = '굿스포츠' OR publisher='대한미디어';

SELECT  *
FROM    book
ORDER BY    bookname;

SELECT  *
FROM    book
ORDER BY price, bookname;

SELECT  *
FROM    book
ORDER BY price desc, publisher asc;

SELECT  sum(saleprice)
FROM    orders;

SELECT  sum(saleprice) as 총매출
FROM    orders
where   custid = 2;

SELECT  sum(saleprice) Total,
        avg(saleprice) Average,
        min(saleprice) Minimum,
        max(saleprice) Maximum
FROM    orders;

SELECT  count(*)
FROM    orders;

SELECT  custid, count(*) 도서수량, sum(saleprice) 총액
FROM    orders
GROUP BY    custid;

SELECT  custid, count(*) 도서수량
FROM    orders
WHERE   saleprice >= 8000
GROUP BY custid
HAVING  count(*)>=2;
--1-1
SELECT  bookname
FROM    book
WHERE   bookid = 1;
--1-2
SELECT  bookname
FROM    book
WHERE   price >= 20000;
--1-3
SELECT  sum(saleprice)
FROM    orders
WHERE   custid = (SELECT custid
                  FROM   customer
                  WHERE  name like '박지성');
--1-4                  
SELECT  count(*)
FROM    orders
WHERE   custid = (SELECT custid
                  FROM   customer
                  WHERE  name like '박지성');
--2-1 
SELECT  count(*)
FROM    book;
--2-2
SELECT  count(distinct publisher)
FROM    book;
--2-3
SELECT  name, address
FROM    customer;
--2-4
SELECT  orderid
FROM    orders
WHERE   orderdate between '14/07/04' and '14/07/07';
--2-5
SELECT  orderid
FROM    orders
WHERE   orderdate not between '14/07/04' and '14/07/07';
--2-6
SELECT  name,address
FROM    customer
WHERE   name like '김%';
--2-7
SELECT  name,address
FROM    customer
WHERE   name like '김%아';

SELECT  *
FROM    customer c, orders o
WHERE   c.custid = o.custid;

SELECT  *
FROM    customer c, orders o
WHERE   c.custid = o.custid
ORDER BY    c.custid;

SELECT  name, saleprice
FROM    customer c, orders o
WHERE   c.custid = o.custid;

SELECT  name, sum(saleprice)
FROM    customer c, orders o
WHERE   c.custid = o.custid
GROUP BY    c.name
ORDER BY    c.name;

SELECT  c.name, b.bookname
FROM    customer c, orders o, book b
WHERE   c.custid = o.custid
AND     o.bookid = b.bookid;

SELECT  c.name, b.bookname
FROM    customer c, orders o, book b
WHERE   c.custid = o.custid and o.bookid = b.bookid
AND     b.price = 20000;

SELECT  c.name, saleprice
FROM    customer c LEFT OUTER JOIN
        orders o
ON      c.custid = o.custid;    

SELECT  c.name, saleprice
FROM    customer c, orders o
WHERE   c.custid = o.custid(+);

SELECT  bookname
FROM    book
WHERE   price = (SELECT max(price)
                 FROM   book);
                 
SELECT  name
FROM    customer
WHERE   custid IN(SELECT    custid
                  FROM      orders);
                  
SELECT  name
FROM    customer
WHERE   custid IN(SELECT    custid
                  FROM      orders
                  WHERE     bookid IN(SELECT bookid
                                      FROM   book
                                      WHERE  publisher='대한미디어'));
                                      
SELECT  b1.bookname
FROM    book b1
WHERE   b1.price > (SELECT  avg(b2.price)
                    FROM    book b2
                    WHERE   b2.publisher=b1.publisher);

SELECT      b1.*, pr.ob, pr.publisher
FROM        book b1, (SELECT      avg(b2.price) ob, b2.publisher
                      FROM        book b2
                      GROUP BY    b2.publisher) pr
WHERE       b1.publisher = pr.publisher
AND         b1.price > pr.ob;

SELECT      b1.bookname, avg(b2.price)
FROM        book b1, book b2
WHERE       b1.publisher = b2.publisher
GROUP BY    b1.bookname
HAVING      b1.price > avg(b2.price);

SELECT  name
FROM    customer
MINUS
SELECT  name
FROM    customer
WHERE   custid IN(SELECT custid
                  FROM   orders);
                  
SELECT  name, address
FROM    customer c
WHERE   EXISTS (SELECT  *
                FROM    orders o
                WHERE   c.custid = o.custid);
                
SELECT      distinct c.name, c.address
FROM        customer c, orders o
WHERE       c.custid = o.custid;
                
SELECT  name, address
FROM    customer c
WHERE   NOT EXISTS (SELECT  *
                FROM    orders o
                WHERE   c.custid = o.custid);

SELECT      c.name, c.address
FROM        customer c, orders o
WHERE       c.custid = o.custid(+)
AND         o.orderid is null;
                
--1-5                
SELECT  count(distinct publisher)
FROM    book
WHERE   bookid IN(SELECT bookid
                  FROM   orders
                  WHERE  custid = (SELECT custid
                                   FROM   customer
                                   where  name = '박지성'));
--1-6                                   
SELECT  b.bookname, b.price, b.price - o.saleprice
FROM    book b, orders o, customer c
WHERE   b.bookid = o.bookid
AND     c.custid = o.custid
AND     c.name = '박지성';
--1-7
SELECT  b.bookname
FROM    book b
WHERE   NOT EXISTS (SELECT  *
                    FROM    orders o
                    WHERE   b.bookid = o.bookid
                    AND     o.custid = (SELECT  c.custid
                                        FROM    customer c
                                        WHERE   name = '박지성'));

SELECT      bookname
FROM        book b1
WHERE       NOT EXISTS (SELECT      bookname
                        FROM        customer c,orders o
                        WHERE       c.custid = o.custid
--                        AND         o.bookid = b2.bookid
--                        AND         b1.bookid = b2.bookid
                        AND         o.bookid = b1.bookid
                        AND         c.name like '박지성');

SELECT      bookname
FROM        book
MINUS
SELECT      b.bookname
FROM        book b, orders o, customer c
WHERE       b.bookid = o.bookid
AND         c.custid = o.custid
AND         c.name like '박지성';

SELECT      bookname
FROM        book
WHERE       bookname not in (SELECT     bookname
                             FROM       customer c, orders o, book b
                             WHERE      c.custid = o.custid
                             AND        b.bookid = o.bookid
                             AND        c.name like '박지성');
--2-8
SELECT  c.name
FROM    customer c
MINUS
SELECT  distinct name
FROM    customer c, orders o, book b
WHERE   c.custid = o.custid
AND     b.bookid = o.bookid;
--2-8
SELECT  c.name
FROM    customer c
WHERE   NOT EXISTS(SELECT   o.custid
                   FROM     orders o
                   WHERE    o.custid =c.custid);
--2-8
SELECT  c.name
FROM    customer c, orders o
WHERE   c.custid = o.custid(+)
AND     orderid is null;
--2-9                   
SELECT  sum(saleprice), avg(saleprice)
FROM    orders;
--2-10
SELECT      c.name, sum(o.saleprice)
FROM        customer c, orders o
WHERE       c.custid = o.custid
GROUP BY    c.name;
--2-11
SELECT      c.name, b.bookname
FROM        customer c, orders o, book b
WHERE       c.custid = o.custid
AND         o.bookid = b.bookid
ORDER BY    c.name;
--2-12
SELECT  o.*, b.*, b.price - o.saleprice
FROM    orders o, book b
WHERE   o.bookid = b.bookid
AND     b.price - o.saleprice = (SELECT max(b.price - o.saleprice)
                                 FROM   orders o, book b
                                 WHERE  o.bookid = b.bookid);
--2-13
SELECT      c.name
FROM        customer c, orders o
WHERE       c.custid = o.custid
GROUP BY    c.name
HAVING      avg(o.saleprice) > (SELECT  avg(saleprice)
                                FROM    orders);
                            
CREATE TABLE    NewBook(
        bookid      number,
        bookname    varchar2(20)    not null,
        publisher   varchar2(20)    unique,
        price       number  default 10000   check(price > 1000),
        primary key(bookname, publisher));
        
CREATE TABLE NewCustomer(
        custid      number  primary key,
        name        varchar2(40),
        address     varchar2(40),
        phone       varchar2(30));

CREATE TABLE NewOrders(
        orderid     number  primary key,
        custid      number  not null references NewCustomer(custid) on delete cascade,
        bookid      number  not null,
        saleprice   number,
        orderdate   date);
        
ALTER TABLE NewBook
ADD         isbn    varchar2(13);

ALTER TABLE NewBook
Modify      isbn    number;

ALTER TABLE newbook
DROP COLUMN isbn;

SELECT  *
FROM    newbook;

ALTER TABLE newbook
MODIFY      bookid  number not null;

ALTER TABLE newbook
ADD         primary key(bookid);

DROP TABLE  newbook;

DROP TABLE  newcustomer cascade constraints;

INSERT INTO book(bookid,bookname,publisher,price)
       VALUES   (11,'스포츠 의학','한솔의학서적',90000);

SELECT  *
FROM    book;

INSERT INTO book(bookid,bookname,publisher)
       VALUES   (14,'스포츠 의학','한솔의학서적');

INSERT INTO book(bookid,bookname,price,publisher)
       SELECT bookid,bookname,price,publisher
       FROM   Imported_book;

INSERT  INTO    customer(custid,name,address,phone)
        VALUES          (5,'박세리',null,null);

UPDATE  customer
SET     address='대학민국 부산'
WHERE   custid=5;

SELECT  *
FROM    customer;

UPDATE  customer
SET     address = (SELECT   address
                   FROM     customer
                   WHERE    name='김연아')
WHERE   name like '%박세리%';                   

DELETE FROM     customer
WHERE           custid=5;

DELETE FROM     customer;
--3-1
SELECT      c.name, b.publisher, b.bookname
FROM        customer c, book b, orders o
WHERE       b.bookid = o.bookid
AND         c.custid = o.custid
AND         c.name not like '%박지성%'
AND         b.publisher in(SELECT   b.publisher
                           FROM     book b, orders o
                           WHERE    b.bookid = o.bookid
                           AND      o.custid = (SELECT  distinct o.custid
                                                FROM    orders o, customer c
                                                WHERE   o.custid = c.custid
                                                AND     c.name like '%박지성%'));
--3-2
SELECT      c.name, count(distinct b.publisher)
FROM        customer c, book b, orders o
WHERE       b.bookid = o.bookid
AND         c.custid = o.custid
GROUP BY    c.name
HAVING      count(distinct b.publisher)>=2;
--3-2 상관쿼리
SELECT      name
FROM        customer c1
WHERE       2<=(SELECT     COUNT(DISTINCT publisher)
                FROM       customer, orders, book
                WHERE      customer.custid = orders.custid
                AND        book.bookid = orders.bookid
                AND        name like c1.name);
--3-3
SELECT      b.bookname
FROM        customer c, book b, orders o
WHERE       b.bookid = o.bookid
AND         c.custid = o.custid
GROUP BY    bookname
HAVING      count(name)>=(SELECT    count(c.name)*0.3
                          FROM      customer c);
--3-3 상관쿼리
SELECT      bookname
FROM        book b1
WHERE       (SELECT     COUNT(book.bookid)
             FROM       orders, book
             WHERE      orders.bookid = book.bookid
             AND        b1.bookid     = book.bookid)
                            >=(SELECT      COUNT(*)
                               FROM        customer)*0.3;
--4-1
INSERT INTO     book(bookid,bookname,price,publisher)  
       VALUES       (null,'스포츠 세계',10000,'대한미디어');
--bookid 제약 조건 - not null
DESC    book
--4-2
DELETE FROM     book
WHERE           publisher like '삼성당';
--4-3
DELETE FROM     book
WHERE           publisher like '이상미디어';
--child record found --이상미디어 관련 데이터가 다른 테이블에서 참조/사용 중
--4-4
UPDATE      book
SET         publisher = '대한출판사'
WHERE       publisher = '대한미디어';
