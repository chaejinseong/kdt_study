-- 회원테이블tbl_user)
-- 이메일(user_email), 비밀번(user_password),
-- 이름(user_name), 성별(user_gender), 폰(user_phone)
-- 주석: Ctrl + /
-- 여러 줄 주석: Ctrl + Shift + /
-- 한 줄 이동: Ctrl + Shift + ↑ or ↓
-- 한 줄 삭제: Ctrl + D
-- 한 줄 복사: Ctrl + Alt + + ↑ or ↓
-- 한 줄 실행: Ctrl + Enter


create table tbl_user(
	id bigint primary key,
	user_email text,
	user_password text,
	user_name text,
	user_gender char(10),
	user_phone text
)

ALTER TABLE tbl_user
RENAME COLUMN if TO id;

drop table tbl_user ;\


create table car(
	id bigint primary key,
	car_number text,
	car_brand char(10),
	car_date Date,
	car_color text,
	car_price bigint
)

drop table car;

create table tbl_car(
	id bigint primary key,
	car_number text,
	car_brand text,
	car_created_at date,
	car_color text,
	car_price bigint
);

drop table tbl_car;



--제약조건 추가


--회사테이
--이름, 전화번호, 주소, 업종
-- "": alias 테이블들을 별칭으로 붙일 때 사용하는 문자열 값
-- '': 값
create table companies(
	id bigint generated always as identity primary key,
	company_name text not null unique,
	company_call text not null default '010-1234-1234',
	company_address text not null,
	company_type text not null,
	company_created_at date default now()
);

--now(): 현재 날짜와 시간을 모 가져오는 함



-- 동물 테이블 생성
-- 나이
-- 먹이
-- 취미
-- 종류
create table animals (
	id bigint generated always as identity primary key,
	animal_age integer not null,
	animal_food text not null,
	animal_hobby text null default '숨쉬기',
	animal_type text not null
);
-- 상품 테이블 생성
-- 이름
-- 가격
-- 브랜드
-- 제조일


/*
   요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.
*/

--create table childrens(
--	id bigint generated always as identity primary key,
--	child_name text not null,
--	child_age integer not null,
--	child_gender char(10) not null
--)
--create table parents(
--	id bigint generated always as identity primary key,
--	parent_name text not null,
--	parent_age integer not null,
--	parent_address text not null,
--	parent_phone text not null default '010-1234-1234,'
--	parent_gender char(10) not null
--)
--create table speacial_class (
--	id bigint generated always as identity primary key,
--	class_name text not null unique,
--	class_type text not null
--)
--
--create table class_image(
--	id bigint generated always as identity primary key,	
--	class_id bigint not null references special_class(id),
--	image_address text not null unique
--)
--
--create table relationship(
--	id bigint generated always as identity primary key,
--	chile_id bigint not null references childrens(id),
--	parent_id bigint not null references parents(id),
--	relationship text not null
--)
--
--create table apply(
--	id bigint generated always as identity primary key,
--	class_id bigint not null references special_class(id),
--	child_id bigint not null references childrens(id)
--)




/*
   요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.
*/

-- 아이(children) 1
-- 이름(name), 나이(age), 성별(gender)
create table children(
   id bigint generated always as identity primary key,
   children_name text not null,
   children_age smallint default 0,
   children_gender char(10)
);

-- 부모(parents) 1
-- 이름(name), 나이(age), 주소(address), 전화번호(콜), 성별(gender)
create table parents(
   id bigint generated always as identity primary key,
   parents_name text not null,
   parents_age smallint default 0,
   parents_address text,
   parents_phone text,
   parents_gender char(10)
);

-- 체험학습(field_trips) 1
-- 제목(title), 내용(content)
create table field_trips(
   id bigint generated always as identity primary key,
   field_trip_title text not null,
   field_trip_content text not null
);

-- 체험학습 이미지(field_trips_images)
-- 이름(name), 경로(path)
-- fk 1개(체험학습)
create table field_trips_images(
   id bigint generated always as identity primary key,
   field_trips_image_name text not null,
   field_trips_image_path text not null,
   field_trips_id bigint,
   constraint fk_field_trips_images_field_trips foreign key(field_trips_id)
   references field_trips(id)
);

-- 신청(apply)
-- 신청일(created_at)
-- fk 2개(아이, 체험학습)
create table apply(
   id bigint generated always as identity primary key,
   apply_created_at timestamp default now(),
   children_id bigint,
   field_trips_id bigint,
   constraint fk_apply_children foreign key(children_id)
   references children(id),
   constraint fk_apply_field_trips foreign key(field_trips_id)
   references field_trips(id)
);

-- 자식관계(relationships)
-- fk 2개(부모, 아이)

create table relationships(
   id bigint generated always as identity primary key,
   children_id bigint,
   parents_id bigint,
   constraint fk_relationships_children foreign key(children_id)
   references children(id),
   constraint fk_relationships_parents foreign key(parents_id)
   references parents(id)
);

create table advertiser (
	 id bigint generated always as identity primary key,
	 advertiser_name text not null,
	 advertiser_address text not null,
	 advertiser_number text not null default '010-1234-1234',
	 advertiser_type text not null
);

--create table advertisement (
--	 id bigint generated always as identity primary key,
--	 ad_name text not null,
--	 ad_content text not null
--);
--
--
--create table big_category (
--	id bigint generated always as identity primary key,
--	name char(10) not null
--);
--
--create table middle_category (
--	id bigint generated always as identity primary key,
--	name char(10) not null,
--	
--	big_id bigint not null,
--	
--	constraint fk_bigcategory_ad foreign key(big_id)
--	references big_category(id)
--);
--
--create table small_category (
--	id bigint generated always as identity primary key,
--	name char(10) not null,
--	middle_id bigint not null,
--	
--	constraint fk_middlecategory_ad foreign key(middle_id)
--	references middle_category(id)
--);
--create table ad_apply (
--	 id bigint generated always as identity primary key,
--	 ad_id bigint not null,
--	 avertiser_id bigint not null,
--	 small_id bigint not null,
--	 
--	 constraint fk_apply_ad foreign key(ad_id)
--   	 references advertiement(id),
--   	 constraint fk_apply_advertiser foreign key(advertiser_id)
--   	 references advertiser(id),
--   	 constraint fk_smallcatevort foreign key(small_id)
--   	 references small_category(id)
--);
drop table relationships;
drop table children;
--광고회사 companies
--이름 company_name, 주소 company_address 대표번호 company_phone
--기업 종류 company_type
-- check('값1', '값2','값3' )
  create table companies (
 	id bigint generated always as identity primary key,
 	company_name text not null unique,
 	company_address text,
 	company_phont text not null,
 	company_type text,
 	constraint ban_type check(company_type in ('스타트업', '중소기업', '중견기업', '대기업'))
  );
--광고 ads
--광고제목 ad_title, 광고내용 ad_content	
 create table ads(
	id bigint generated always as identity primary key,
	ad_title text not null,
	ad_content text not null
 );

--신청apply fk 2개 광고 광고회
--신청내용 apply_content, 신청일 apply_created_at,
create table apply(
	id bigint generated always as identity primary key,
	apply_content text,
	apply_created_at timestamp default now(),
	company_id bigint not null,
	ad_id bigint not null,
	
	constraint fk_apply_company foreign key(company_id)
	references companies(id),
	constraint fk_apply_ad foreign key(ad_id)
	references ads(id)
);

--대카테고리 a_category
--대카테고리명 a_category_name
create table a_category(
	id bigint generated always as identity primary key,
	a_category_name text not null,
	ad_id bigint not null,
	constraint fk_a_category_ad foreign key(ad_id)
	references ads(id)
);
--중카테고리 b_category
--중카테고리명 b_category_name
create table b_category(
	id bigint generated always as identity primary key,
	b_category_name text not null,
	a_category_id bigint,
	constraint fk_b_category_a_category foreign key(a_category_id)
	references a_category(id)
);
--소카테고리 c_category
--소카테고리명 c_category_name
create table c_category(
	id bigint generated always as identity primary key,
	c_category_name text not null,
	b_category_id bigint,
	constraint fk_c_category_b_category foreign key(b_category_id)
	references b_category(id)
);
/*
요구사항
이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
기업의 정보는 기업 이름, 주소, 대표번호가 있고
사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.
*/


--create table enterprises(
--	id bigint generated always as identity primary key,
--	enterprise_name text not null,
--	enterprise_address text,
--	enterprise_phone text not null default'010-1234-1234'
--);
--
--create table users(
--	id bigint generated always as identity primary key,
--	user_name text not null,
--	user_address text not null,
--	user_phone text default '010-1234-1234'
--);
--
--create table cards(
--	id bigint generated always as identity primary key,
--	card_number varchar(20) not null,
--	card_company text not null,
--	user_id bigint not null,
--	
--	constraint fk_card_user foreign key (user_id)
--	references users(id)
--);
--create table products(
--	id bigint generated always as identity primary key,
--	product_name text not null,
--	product_price numeric not null,
--	product_stock integer not null,
--	enterprise_id bigint not null,
--	
--	constraint fk_priduct_enterprise foreign key(enterprise_id)
--	references enterprises(id)
--);
--create table purchases(
--	id bigint generated always as identity primary key,
--	user_id bigint not null,
--	enterprise_id bigint not null,
--	card_id bigint not null,
--	product_id bigint not null,
--	
--	constraint fk_purchase_user foreign key (user_id)
--	references users(id),
--	constraint fk_purchase_enterprise foreign key (enterprise_id)
--	references enterprises(id),
--	constraint fk_purchase_card foreign key (card_id)
--	references cards(id),
--	constraint fk_purchase_product foreign key (product_id)
--	references products(id)
--);
--
--*
/*
   요구사항
   이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
   기업의 정보는 기업 이름, 주소, 대표번호가 있고
   사용자 정보는 이름, 주소, 전화번호가 있습니다. 
   결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,상품의 정보도 필요합니다. 
   상품의 정보는 이름, 가격, 재고입니다.
   사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.
*/

-- 기업(companies) - 1
-- 이름(company_name), 주소(company_address), 대표번호(company_phone)
create table companies(
   id bigint generated always as identity primary key,
   company_name text not null,
   company_address text,
   company_phone text not null
);

-- 사용자(users) - 1
-- 이름(user_name), 주소(user_address), 전화번호(user_phone)
create table users(
   id bigint generated always as identity primary key,
   user_name text not null,
   user_address text not null,
   user_phone text not null
);

-- 카드(cards) - 사용자 fk
-- 카드번호(card_number), 카드사(card_company)
create table cards(
   id bigint generated always as identity primary key,
   card_number text not null,
   card_company text,
   user_id bigint,
   constraint fk_card_user foreign key(user_id)
   references users(id)
);

-- 상품(products) - 회사 fk
-- 이름(product_name), 가격(product_price), 재고(product_stock)
create table products(
   id bigint generated always as identity primary key,
   product_name text not null,
   product_price bigint default 0,
   product_stock smallint default 999,
   company_id bigint,
   constraint fk_product_company foreign key(company_id)
   references companies(id)
);

-- 결제(payments) - 카드, 상품 fk
-- 결제 시간(payment_created_at) - timestamp
create table payments(
   id bigint generated always as identity primary key,
   payment_created_at timestamp default now(),
   card_id bigint,
   product_id bigint,
   constraint fk_payment_card foreign key(card_id)
   references cards(id),
   constraint fk_payment_product foreign key(product_id)
   references products(id)
);
--create table soft_drinks(
--	id bigint generated always as identity primary key,
--	soft_drink_name text not null
--);
--
--create table winners(
--	id bigint generated always as identity primary key,
--	winner_name text not null,
--	winner_address text not null
--);
--create table prizes(
--	id bigint generated always as identity primary key,
--	prize_name text not null
--	
--);
--create table win_numbers(
--	id bigint generated always as identity primary key,
--	soft_drink_id bigint not null unique,
--	win_number bigint not null unique,
--	win_prize bigint not null,
--	winner_id bigint null,
--	
--	constraint fk_winnumber_soft_drink foreign key (soft_drink_id)
--	references soft_drinks(id),
--	constraint fk_winnumber_winner foreign key (winner_id)
--	references winners(id),
--	constraint fk_winnumber_win_prize foreign key (win_prize)
--	references prizes(id)
--);
--
--create table win_states(
--	id bigint generated always as identity primary key,
--	win_number_id text not null unique,
--	win_state text not null
--	state varchar(10) not null, default '배송중'
--	constraint ck_win_state check (state in ('배송중', '배송완료'))
--	
--	constraint fk_win_state_win_number foreign key(win_number_id)
--	references win_numbers(id)
--);


/*
   요구사항
   음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
   음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
   당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.
*/

-- 음료수판매회사(companies) - 1
create table companies(
   id bigint generated always as identity primary key,
   company_name text not null,
   company_address text,
   company_phone text not null
);

-- 당첨 상품(products) - 1
create table products(
   id bigint generated always as identity primary key,
   product_name text not null,
   product_price bigint default 0,
   product_stock smallint default 999
);

-- 당첨자(winners) - 1
create table winners(
   id bigint generated always as identity primary key,
   winner_name text not null,
   winner_phone text not null,
   winner_address text not null
);

-- 당첨 번호(winning_codes) -> 당첨 상품(products) fk
create table winning_codes(
   id bigint generated always as identity primary key,
   winning_code_number text,
   product_id bigint,
   constraint fk_winning_code_product foreign key(product_id)
   references products(id)
);

-- 음료수(drinks) - 판매회사(companies) fk, 당첨 번호(winning_codes) fk
create table drinks(
   id bigint generated always as identity primary key,
   drink_name text not null,
   drink_volume numeric,
   company_id bigint,
   winning_code_id bigint,
   constraint fk_drink_company foreign key(company_id)
   references companies(id),
   constraint fk_drink_winning_code foreign key(winning_code_id)
   references winning_codes(id)
);

-- 배송(deliveries) - 당첨자(winners) fk, 당첨 번호(winning_codes) fk
create table deliveries(
   id bigint generated always as identity primary key,
   delivery_content text,
   delivery_status text default '배송 준비',
   winner_id bigint,
   winning_code_id bigint,
   constraint check_delivery_status 
      check(delivery_status in ('배송 준비', '배송중', '배송완료')),
   constraint fk_delivery_winner foreign key(winner_id)
      references winners(id),
   constraint fk_delivery_winning_code foreign key(winning_code_id)
      references winning_codes(id)
);




















































































