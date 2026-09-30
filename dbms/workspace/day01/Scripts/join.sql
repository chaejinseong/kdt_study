create table users(
	id bigint generated always as identity primary key,
	user_name text not null,
	user_age smallint not null,
	user_address text
);

create table posts(
	id bigint generated always as identity primary key,
	post_title text not null,
	post_content text not null,
	user_id bigint,
	constraint fk_post_user foreign key(user_id)
	references users(id)
);
alter table posts 
rename column post_ittle to post_title;

alter table posts 
rename column post_context to post_content;

insert into users(user_name, user_age, user_address)
values
   ('김철수', 20, '서울시 강남구'),
   ('김영희', 30, '서울시 종로구'),
   ('홍길동', 40, '경기도 수원시'),
   ('장보고', 30, '서울시 마포구'),
   ('이순신', 20, '서울시 마포구'),
   ('신짱구', 40, '서울시 강남구'),
   ('유리', 20, '서울시 동작구'),
   ('맹구', 10, '서울시 성북구'),
   ('훈이', 10, '서울시 성북구'),
   ('흰둥이', 50, '서울시 중랑구'),
   ('짱아', 10, '서울시 종로구'),
   ('신형만', 50, '서울시 강남구'),
   ('권지용', 40, '서울시 광진구'),
   ('권지옹', 50, '서울시 광진구');
   
insert into posts(post_title, post_content, user_id)
values 
   ('대 AI 시대에 살아남는 개발자가 되려면?', '열심히 코딩하면 됨!', 1),
   ('당근 동네걷기 위에서 동시에 쏟아짐', '당근당근', 2),
   ('낙서 같은 손스케치가 진짜 화면', '손낙서 굿', 3),
   ('GPT-6 Astra vs Fable 5.1', '이제 개발자 끝났다!', 1),
   ('빅분기 12회 필기 기출', '쉽지 않네..!', 3),
   ('첫 동아리 프로젝트', '프로젝트 하깅!', 5),
   ('나는 ‘바이브 코딩만’을 열심히 함', '바이브 잘 탐', 3),
   ('컴퓨터 특성화고 2학년이 생각한 AI ', '졸업 부터!', 7),
   ('컴퓨터는 0과 1밖에 모르는데', '나는 아무것도 모르는데~', 8),
   ('AI 직원들 채용해서 회사 하나 만들어?', '망함..', 10),
   ('간장게장 해동방법 총정리', '전자레인지', 2),
   ('조교 2년 하고 나니 부트캠프 운영진이 되었따', '교수님의 노예..', 1),
   ('게임 개발과에서', '열심히 코딩하면 됨!', 1),
   ('심층학습 공부 소감', '열심히 코딩하면 됨!', 11),
   ('SQL Injection 공격', '당해보면 열받음!', 8),
   ('[Claude Code] 내 세션이 점점 무거워 져..', 'clear하면', 13),
   ('내 노트북 속에 회사가 하나 있었다', '퇴사하면 반납해야됨', 12),
   ('[Codex] 병렬·클라우드 운영', '원래 가능', 10),
   ('AI의 대한 나의 생각', '무섭당', 4),
   ('React Hook', 'Next 안쓰면 취업못함 ㅎㅎ', 5),
   ('호텔 행사 회고록', '호텔 델루나', 11),
   ('MyBatis 공부 정리', '마바 트랜잭션처리', 11),
   ('iOS프로그래밍 기초 1주차', '넘나 쉽당!', 3),
   ('코딩테스트 폐지', '되기 힘들듯..!', 8),
   ('UX/UI 디자인 사례', '디자인 예쁘지롱', 8),
   ('자소서 틀', '다 걸림..', 9);
  
 select *
 from users u;	

-- 테이블 알리아스(별칭, table alias) :
-- 기본적인 default 
 select po.*, us.*
 from posts po
 join users us
 on po.user_id = us.id; 
 
 select po.*,
 		us.user_name, us.user_age, us.user_address
 from posts po
 join users us
 on po.user_id = us.id; 
 

 select po.*, us.*
 from users us
 join posts po
 on us.id = po.user_id;  
  
  
select
	us.id, us.user_name,
	po.post_title
from users us
join posts po
on us.id = po.user_id;

--게시판을 가장 많이 작성한 유저의 이름

select us.user_name
from posts po
join users us
on po.user_id = us.id
where po.user_id in (
	select user_id 
	from posts 
	group by user_id  
	order by count(*) desc  
	limit 1
)

select user_name
from users
where id in (
   select user_id
   from posts
   group by user_id
   having count(user_id) = (
      select count(user_id)
      from posts
      group by user_id
      order by count(user_id) desc 
      limit 1
   )
);

-- 서울시 강남구에 살고 있는 사용자들이 작성한 게시글 전체 조회
-- 게시글 전체 조회 - post_title, post_content
  
select
	po.post_title, po.post_content,
	us.user_name
from posts po
join users us
on po.user_id = us.id
where user_address ='서울시 강남구';  
  
  
--게시글 제목에 'AI'가 포함된 글을 작성한 사용자의 이름을 조회하세요. 단, WHERE절에 서브쿼리를 사용하세요.

select 
	us.user_name
from posts po
join users us
on po.user_id = us.id
where po.user_id in (
	select user_id 
	from posts p 
	where post_title like ('%AI%')
)

-- 20대 유저가 작성한 게시글 조회
-- 20대 유저
select *
from users
where user_age >= and user_age < 20;


select po.*, us.user_name
from (
	select *
	from users
	where user_age >= 20 and user_age < 29
) us
join posts po
on us.id = po.user_id;


--김철수가 작성한 모든 게시글 조회
-- 최종 : 게시글
-- 조건: 김철수가 작성한

select po.*
from posts po
join users us
on po.user_id = us.id 
where us.user_name = '김철수'

--게시글 작성자들의 평균 나이
--1. 조인을 먼저

select round(avg(user_age), 2)
from posts po
join users us
on po.user_id = us.id 


--2. 조건을 먼

select *
from posts 
where user_id in (
	select id
	from users 
)


select avg(us.user_age)
from (
	select *
	from posts 
	where user_id in (
		select id
		from users 
	)
)po
join users us
on po.user_id = us.id;

--게시판을 가장 많이 작성한 유저의 이름
-- 최종 : user_name
-- 조건 : 게시글 가장 많이 작성한

select user_id 
from posts
group by user_id
order by count(user_id) desc 
limit 1;

select user_name
from users us
join posts po
on us.id = po.user_id 
where user_id = (
	select user_id 
	from posts
	group by user_id
	order by count(user_id) desc 
	limit 1
);

--
--1. 게시글 제목에 AI단어가 들어간 게시글을 작성한 유저 정보 조회
-- 조건 : 게시글 제목에 AI가 들어간
-- 목적 : 유저정보 조회 ,user_name, user_age, user_address

select *
from posts
where post_title like ('%AI%')

select us.*, po.post_title
from (
	select *
	from posts
	where post_title like ('%AI%')
) po
join users us
on po.user_id = us.id;


-----------------------------------------
select us.id, us.user_name, user_age, user_address
from (
	select *
	from posts 
	where post_title like '%AI%'
)po
join users us
on po.user_id = us.id;

--2. 1, 13번과 15번 작성자가 작성한 게시글 조회
--조건 : 1번, 13번 15번 작성자가 작성한
--목적 : 게시글 조회 : post_title, post_content

select *
from posts 
where user_id in (1, 13, 15);

select po.*, us.user_name, us.user_age, us.user_address 
from (
	select *
	from posts 
	where user_id in (1, 13, 15)
) po
join users us
on po.user_id = us.id;

-----------------------------------------
select po.*
from(
	select *
	from users 
	where id in (1, 13, 15)
) us
join posts po
on us.id = po.user_id;

select po.*
from users us
join posts po
on us.id = po.user_id 
where us.id in (1, 13, 15);
--3. 서울에 살고있는 사용자가 작성한 게시글의 제목 조회
-- 조건 : 서울에 살고있는 사용자
-- 목적 : 게시글의 제목

select id
from users 
where user_address like ('%서울%')

select po.post_title
from (
	select id
	from users 
	where user_address like ('%서울%')
) us
join posts po
on po.user_id = us.id;


-----------------------------------------

select po.post_title
from posts po
join users us
on po.user_id = us.id
where user_address like '%서울%';

select po.post_title
from (
	select *
	from users 
	where user_address like '%서울%'
) us
join posts po
on us.id = po.user_id;

--4. 50대 사용자가 작성한 게시글 번호 조회(내림차순)
-- 조건 : 50대 사용자
-- 목적 : 게시글 번호 조회 내림차순

select id
from users 
where user_age = 50

select po.id
from(
	select id
	from users 
	where user_age = 50
) us
join posts po
on us.id = po.user_id


select id
from posts 
where user_id in (
	select id
	from users 
	where user_age = 50
)

-----------------------------------------

select *
from (
	select *
	from users 
	where user_age between 50 and 59
) us
join posts po
on us.id = po.user_id
order by po.user_id desc;


select po.id "50대가 작성한 게시글 번호"
from users us
join posts po 
on us.id = po.user_id
where us.user_age between 50 and 59
order by po.id desc;


/*
 * 서브 쿼리(SUB QUERY)
 * 
 * FROM절 : IN LINE VIEW
 * SELECT절 : SCALAR
 * WHERE절 : SUB QUERY
 * 
 * */

drop

create table products (
	id bigint generated always as identity primary key,
	product_name text not null,
	product_price bigint,
	product_stock smallint
);

create table orders(
   id bigint generated always as identity primary key,
   product_id bigint,
   constraint fk_order_product foreign key(product_id)
   references products(id)
);


insert  into products(product_name, product_price, product_stock)
values
	('맥북', 1500000, 20),
	('모니터', 242000, 10),
	('TV', 305000, 15),
	('공기청정기', 710033, 30);


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
	

--집계함수,조인, 서브쿼리
-- 1. 모든 테이블에 알리아스
-- 2. 평균값보다 이상, 이하조건일 때 floor로 내림처리
  
-- 1) 상품의 평균 재고 수
  
 select floor(avg(product_stock)) "상품의 평균 재고 수"
 from products;

--------------------------------------------------------------

-- 2) 맥북을 구매한 주문의 수
--조건 : 맥북
--목적 : 주문의 

select count(o.product_id) "맥북 주문의 수"
from(
	select id
	from products
	where product_name = '맥북'
) pro
join orders o
on pro.id = o.product_id ;

---

select count(tpo.id) ||'개' "맥북을 구매한 주문의 수"
from orders tor
join products tpo 
on tor.product_id = tpo.id 
where tpo.product_name = '맥북';

--------------------------------------------------------------

-- 3) 가장 많이 주문한 상품 1개 가져오기 
-- 조건: 가장 많이 주문한
-- 목적 : 상품 정보

select tpo.product_name "가장 많이 주문한 상품 이름"
from (
	select product_id 
	from orders
	group by product_id 
	order by count(product_id) desc
	limit 1
) tor
join products tpo 
on tor.product_id = tpo.id;

--
select * 
from products 
where id = (
   select product_id
   from orders
   group by product_id
   having count(product_id) = (
      select max(product_count)
      from (
         select count(product_id) "product_count"
         from orders
         group by product_id
      )
   )
);

--------------------------------------------------------------

-- 4) 주문 정보에서 공기청정기 주문 정보 가져오기

select *
from orders tor
join products tpo 
on tor.product_id = tpo.id 
where tpo.product_name = '공기청정기'


--------------------------------------------------------------

--5)평균 주문 개수 이상 주문된 상품 정보 중 이름 가격 재고만 가져오기
--조건 : 평균 주문 개수 이상 주문
-- 목적 : 이름가격 재고
-- 평균 주문 개수구하기 , 비교, 

select tpo.product_name , tpo.product_price, tpo.product_stock 
from (
	select product_id 
	from orders 
	group by product_id 
	having count(product_id) >= (
		select avg(order_count)
			from (
				select count(product_id) as "order_count"
				from orders 
				group by product_id 
		)
	)
) tor
join products tpo 
on tor.product_id = tpo.id

---
select tpo.product_name, tpo.product_price ,tpo.product_stock 
from (
	select product_id 
	from orders 
	group by product_id
	having count(product_id) >= (
		select avg(count_order) 
		from (
			select count(product_id) as "count_order"
			from orders  
			group by product_id 
		)
	)
)tor
join products tpo 
on tor.product_id = tpo.id 

--1. 그룹화 -> 카운트 -> 이름붙이
--2. 이름 붙인걸로 평균
--3. 다시 그룹화 해서 having으로 가져와서 개수 센것과 평균값비교
--4. 조인해서 평균값 이상인 것들의 id를 받아와서 해당것 조회

	--------------------------------------------------------------

-- 6) 평균 재고 이상의 재고를 가진 상품 가져오기 
-- 조건 : 평균 재고 이
-- 상품정보
select *
from products 
where product_stock >= (
	select avg(product_stock) 
	from products 
)


--------------------------------------------------------------

-- 7) 상품의 재고가 제일 작은 상품 1개의 이름과 재고 가져오기 

select product_name , product_stock 
from products p 
order by product_stock
limit 1


--------------------------------------------------------------
-- 8) 상품의 가격 중 제일 비싼 상품의 이름 가져오기

select product_name
from products p 
order by product_price desc 
limit 1

--------------------------------------------------------------

-- 9) 각 상품별 판매액과 총 판매액 한 번에 조회
--조건 : 각 상품별 판매액 : 상품가격 * 주문 횟수, 

select tpo.product_name "상품별 판매액",sum(tpo.product_price),
(
	select sum(tpo.product_price)
	from products tpo
	join orders tor 
	on tpo.id = tor.product_id 
)
from products tpo
join orders tor
on tpo.id = tpo.id
group by product_name 


--------------------------------------------------------------

-- 10) 판매중인 상품의 평균 가격을 소수점 2자리 수 까지 조회

select round(avg(product_price),2)
from products 


--------------------------------------------------------------

-- 11) 상품의 재고가 제일 작은 상품 이름과 재고 조회

select product_name "이름", product_stock "재고"
from products 
order by product_stock 
limit 1

--------------------------------------------------------------

-- 12) TV 주문 정보 ORDER_ID만 조회

select tor.id
from products tpo
join orders tor 
on tpo.id = tor.product_id 
where tpo.product_name like 'TV'

--------------------------------------------------------------

-- 13) 상품의 가격 중 제일 비싼 상품의 이름과 가격 조회

select product_name "이름", product_price "가격"
from products
order by product_price desc 
limit 1

--------------------------------------------------------------

-- 14) 가장 인기 없는 상품의 이름 조회
-- 인기없다 = 주문횟수가 제일 적
select tpo.product_name
from (
	select product_id  
	from orders 
	group by product_id 
	order by product_id desc
	limit 1
) tor
join products tpo 
on tor.product_id = tpo.id



  