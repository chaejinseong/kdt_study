-- 주석: Ctrl + /
-- 여러 줄 주석: Ctrl + Shift + /
-- 한 줄 이동: Ctrl + Shift + ↑ or ↓
-- 한 줄 삭제: Ctrl + D
-- 한 줄 복사: Ctrl + Alt + + ↑ or ↓
-- 한 줄 실행: Ctrl + Enter

-- 테이블 생성(create)
create table [테이블명](
   컬럼명1 타입,
   컬럼명2 타입,
   컬럼명3 타입
);

-- 회원테이블(users)
-- 이메일(user_email), 비밀번호(user_password), 
-- 이름(user_name), 성별(user_gender), 폰(user_phone)
create table users(
   id bigint primary key,
   user_email text,
   user_password text,
   user_name text,
   user_gender char(10),
   user_phone text
);

drop table users;

-- 자동차 테이블(cars)
-- 번호(car_number), 브랜드(car_brand), 
-- 출시날짜(car_created_at), 색상(car_color), 가격(car_price)
create table cars(
   id bigint primary key,
   car_number text,
   car_brand text,
   car_created_at date,
   car_color text,
   car_price bigint
);

drop table cars;

-- 제약조건 추가
-- 회사 테이블(companies)
-- 이름(company_name), not null, unique, 
-- 전화번호(company_call), not null, default
-- 주소(company_address), not null
-- 업종(company_type), not null

-- "": alias 테이블의 컬럼들 별칭으로 붙일 때 사용하는 문자열 값
-- '': 값
create table companies(
   --   고정: id를 postgresQL에서 자동으로 1씩 증가
   id bigint generated always as identity primary key,
   company_name text not null unique,
   company_call text not null default '010-1234-1234',
   company_address text not null,
   company_type text not null,
   company_created_at date default now()
);

--now(): 현재 날짜와 시간을 모두 가져오는 함수

-- 동물 테이블(animals) 생성
-- id(bigint)
-- 나이(animal_age)
-- 먹이(animal_feed)
-- 취미(animal_hobby)
-- 종류(animal_species)
create table animal(
   id bigint generated always as identity primary key,
   animal_age smallint default 1,
   animal_feed text,
   animal_hobby text,
   animal_species text
);

-- 상품 테이블 생성(products)
-- id(bigint)
-- 이름(product_name)
-- 가격(product_price)
-- 브랜드(product_brand)
-- 제조일(product_created_at)
create table products(
   id bigint generated always as identity primary key,
   product_name text,
   product_price bigint,
   product_brand text,
   product_created_at timestamp default now() 
);

drop table products;

--- CREATE : 생성
--- ALTER  : 구조 변경
--- DROP   : 삭제
--- TRUNCATE : 데이터만 삭제
--- RENAME : 이름 변경
--- COMMENT : 설명 추가

-- create
-- create database [데이터베이스이름];

create table products(
   id bigint generated always as identity primary key,
   product_name text,
   product_stock smallint,
   product_price bigint
);

-- alter: 수정
-- 1. 테이블을 수정
-- 테이블 이름 변경
alter table products rename to productts;
alter table productts rename to products;

-- 2. 테이블 안에 컬럼을 수정

-- 1) 컬럼 추가
alter table products add column product_company text;

-- 2) 컬럼 수정
-- 타입 변경
alter table products alter column product_company type char(10);

-- 컬럼 이름 변경
alter table products rename column product_company to product_com;

-- 컬럼 삭제
alter table products drop column product_com;


-- 테이블 삭제
drop table products;

-- 데이터만 삭제
truncate table products;

-- 테이블 앞에 값을 조회하는 SQL
select * from products;

























