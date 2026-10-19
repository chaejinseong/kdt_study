create table products(
   id bigint generated always as identity primary key,
   product_name varchar(255) not null,
   product_price numeric default 0,
   product_stock numeric default 0
);

-- 2. 주문 테이블 생성
create table orders(
   id bigint generated always as identity primary key,
   product_id bigint,
   order_date timestamp default now(),
   constraint fk_order_product foreign key(product_id)
   references products(id)
);
 

-- 3. 상품 데이터 추가
insert into products(product_name, product_price, product_stock) 
values 
    ('맥북', 1505000, 20),
    ('모니터', 242000, 10),
    ('tv', 388000, 15),
    ('공기청정기', 710035, 30);

-- 4. 주문 데이터 추가
insert into orders(product_id) 
values
    (3),
    (1),
    (4),
    (1),
    (1),
    (2),
    (2),
    (3),
    (3),
    (3),
    (3),
    (3);
    
select * from orders;
  
select * from products;
  
 --------------------------------------------------------
   
   -- 5. 데이터 조회

select * from orders;


--[요구사항조건]
--모든 결과 테이블은 알리아스(ALIAS)를 명확히 사용한다.
--SQL문을 작성 후 실수 결과는 FLOOR로 내림 값을 기준으로 한다.
 

-- 1번) 상품의 평균 재고 수 조회

select floor(avg(product_stock)) "상품의 평균 재고 수"
from products p ;


-- 2번) 맥북을 구매한 주문의 개수 조회

select count(tor.product_id) "맥북을 구매한 주문의 개수"
from (
	select *
	from products 
	where product_name like '맥북'
) tpo
join orders tor
on tpo.id = tor.product_id ;

-- 3번) 가장 많이 주문한 상품 1개의 모든 정보 조회

select tor. id "주문id", tor.product_id "주문 상품 id", tor.order_date"주문 날짜", tpo.product_name "상품이름", tpo.product_price"상품가격" , tpo.product_stock"상품 재고" 
from (
	select product_id, id, order_date
	from orders 
	group by product_id ,id, order_date
	order by count(product_id) desc 
	limit 1
) tor
join products tpo
on tor.product_id = tpo.id;
-- 4번) 평균 재고 이상 재고를 가진 상품의 모든 정보 조회

select tor.id "상품 주문 id", tor.product_id"상품id", tor.order_date  "상품 주문 날짜",tpo.product_name "상품 이름", tpo.product_price"상품가격"
, tpo.product_stock "상품 재고"
from orders tor
join products tpo
on tor.product_id = tpo.id
where tor.id in (
	select id
	from products 
	where product_stock >= (
		select avg(product_stock) 
		from products p
	)
);

-- 5번) 각 상품별 판매액과 총 판매액 한번에 조회

select sum(tpo.product_price) "상품별 판매액",
	(
		select sum(tpo.product_price) "총판매액"
		from products tpo
		join orders tor
		on tpo.id = tor.product_id 
	)
from products tpo
join orders tor
on tpo.id = tor.product_id 
group by product_name ;

-- 6번) 판매중인 상품의 평균 가격을 소수점 2자리 수까지 조회

select round(avg(product_price), 2) "판매중인 상품의 평균 가"
from products p ;

-- 7번) 상품의 재고가 제일 작은 상품 이름과 재고 조회

select product_name "상품 이름",product_stock "상품 재고"
from products 
order by product_stock 
limit 1;

-- 8번) TV 주문 정보 ORDER_ID만 조회

select tor.id "TV주문 ORDER_ID"
from (
	select *
	from products p 
	where product_name like 'tv'
) tpo
join orders tor
on tpo.id = tor.product_id ;
-- 9번) 상품의 가격 중 제일 비싼 상품의 이름과 가격 조회

select product_name "상품 이름", product_price "상품 가격"
from products 
order by product_price desc 
limit 1;

-- 10번) 가장 인기 없는 상품의 이름 조회

select tpo.product_name "가장 인기없는 상품의 이름"
from (
	select product_id 
	from orders 
	group by product_id 
	order by count(product_id) 
	limit 1
) tor
join products tpo
on tor.product_id = tpo.id;


  --------------------------------------------------------
   
   
   
   
  --------------------------------------------------------
   
   
   
   
   
  --------------------------------------------------------
   
   
   
   
   
  --------------------------------------------------------
   
   
   
   
  --------------------------------------------------------
   
   
   
   
   
  --------------------------------------------------------
   
   
   
   
  --------------------------------------------------------
   
   
   
   
  --------------------------------------------------------
   
   
   
   
  --------------------------------------------------------
   
   
   
   
  --------------------------------------------------------
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   