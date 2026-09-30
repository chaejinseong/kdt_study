--1. 상품의 평균 재고 수를 조회하세요.
select avg(product_stock) 
from products;

--2. 맥북을 구매한 주문의 수를 조회하세요.
select count(tor.product_id)
from (
	select id 
	from products 
	where product_name = '맥북'
) tpo
join orders tor 
on tpo.id = tor.product_id 
	
--3. 가장 많이 주문된 상품 1개의 정보를 조회하세요.

select tpo.product_name , tpo.product_price , tpo.product_stock 
from (
	select product_id 
	from orders 
	group by product_id 
	order by count(product_id) desc 
	limit 1
) tor
join products tpo 
on tor.product_id = tpo.id


--4. 주문 정보에서 공기청정기 주문 정보를 조회하세요.


select tor.*, tpo.product_name, tpo.product_price, tpo.product_stock
from (
	select id , product_name, product_price, product_stock
	from products 
	where product_name like '공기청정기'
) tpo
join orders tor 
on tpo.id = tor.product_id 

select id 
from products 
where product_name like '공기청정기'

--5. 평균 주문 개수 이상 주문된 상품의 이름, 가격, 재고를 조회하세요.
select *
from (
	select product_id 
	from orders
	group by product_id 
	having count(product_id) >= ( 
		select avg(order_count)
		from (
			select count(product_id) "order_count"
			from orders 
			group by product_id 
		)
	)
)tor
join products tpo
on tpo.id = tor.product_id
--6. 평균 재고 이상의 재고를 가진 상품 정보를 조회하세요.

select tor.*, tpo.product_name, tpo.product_price, tpo.product_stock
from (
	select *
	from products
	where product_stock >= (
		select avg(product_stock)
		from products p 
	)
) tpo
join orders tor 
on tpo.id = tor.product_id 

--7. 재고가 가장 적은 상품 1개의 이름과 재고를 조회하세요.

select product_name , product_stock 
from products 
order by product_stock 
limit 1

--8. 가격이 가장 비싼 상품의 이름을 조회하세요.

select product_name
from products p 
order by product_price desc 
limit 1


--9. 각 상품별 판매액과 전체 총판매액을 한 번에 조회하세요.
--판매액 : 주문 횟수 * 가격

select tpo.product_name "상품이름", sum(tpo.product_price) "상품별 판매",
(
	select sum(tpo.product_price)
	from orders tor
	join products tpo
	on  tor.product_id = tpo.id 
)
from orders tor
join products tpo 
on tor.product_id = tpo.id
group by product_name


--10. 판매 중인 상품의 평균 가격을 소수점 둘째 자리까지 조회하세요.

select round(avg(product_price),2)
from products p 


--11. 재고가 가장 적은 상품의 이름과 재고를 조회하세요.

select product_name, product_stock 
from products 
order by product_stock 
limit 1


--12. TV 주문 정보의 ORDER_ID만 조회하세요.


select tor.id
from (
	select *
	from products p 
	where product_name like 'TV'
) tpo
join orders tor
on tpo.id = tor.product_id

--13. 가격이 가장 비싼 상품의 이름과 가격을 조회하세요.

select product_name, product_price
from products p 
order by product_price desc 
limit 1



--14. 가장 인기 없는 상품의 이름을 조회하세요.

select tpo.product_name 
from (
	select product_id 
	from orders 
	group by product_id
	order by count(product_id) 
	limit 1
) tor
join products tpo
on tor.product_id = tpo.id


--
--1. 평균 주문 개수 이상 주문된 상품의 이름, 가격, 재고를 조회하세요.

select tpo.product_name , tpo,product_price, tpo,product_stock
from (
	select product_id 
	from orders 
	group by product_id 
	having count(product_id) >= 
	(
		select avg(order_count) 
		from (
			select count(product_id) "order_count"
			from orders o 
			group by product_id 
		)
	) 
) tor
join products tpo
on tor.product_id = tpo.id



) 
--2. 각 상품별 판매액과 전체 총판매액을 한 번에 조회하세요.
--   - 판매액 = 상품 가격 × 주문 횟수

select sum(tpo.product_price),
	(
		select sum(product_price)
		from orders tor
		join products tpo
		on tor.product_id = tpo.id
	)
from orders tor
join products tpo
on tor.product_id = tpo.id 
group by tpo.product_name 




















