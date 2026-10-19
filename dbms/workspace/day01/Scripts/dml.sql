create table parents(
	id bigint generated always as identity primary key,
	parent_name text not null,
	parent_age smallint,
	parent_address text,
	parent_phont text default '주소 없음',
	parent_phone text unique not null

);


--insert into parents(id, parent_age, parent_address, parent_phone)
--values(1, '홍길동', 20, '서울시 강남', '010-1234-1234''ads values

--
--insert inro parents 
--select * from parents
--
--
---- 부모 1명 데이터 추가하기
---- 이름, 나이, 전화번호만 추가
---- 이순신, 20, '010-3434-7676'
--insert into [테이블명] (컬럼명1, 컬럼명2)
--values(값)

insert into parents(parent_name, parent_age, parent_phone)
values('이순신', 20, '010-3434-7676')


insert into parents(parent_name, parent_age, parent_address, parent_phone)
values('김철수', 45, '서울시 강남', '010-4567-0481');
insert into parents(parent_name, parent_age, parent_address, parent_phone)
values('김영희', 35, '서울시 강남', '010-4527-6451');
insert into parents(parent_name, parent_age, parent_address, parent_phone)
values('한혜진', 22, '서울시 강남', '010-2458-1234');
insert into parents(parent_name, parent_age, parent_address, parent_phone)
values('이시우', 20, '서울시 강남', '010-1254-1384');
insert into parents(parent_name, parent_age, parent_address, parent_phone)
values('이예나', 20, '서울시 강남', '010-1470-1348');

select parent_name from parents;


--alias : 별칭
--컬럼명을 대신해서 보여주는것 == 별
select parent_name "이", parent_address "주소"
from parents;

select * 
from parents;

--select 1+1
--select 10 > 11;


select *
from parents 
where parent_name = '김영희';

--서울시 강남에 사는 사용자 모두 조회
select *
from parents 
where parent_address = '서울시 강남';

--20대 부모들의 정보를 모두 조회
select *
from parents 
where 20 <= parent_age and parent_age <= 29;



select *
from parents 
where parent_name like '이%';


select *
from parents 
where parent_name like '%신';


select *
from parents 
where parent_name like '_혜_';

--휴대폰 번호에 3이 들어가는 사용자 이름과 주소 조회


select parent_name, parent_address, parent_phone 
from parents 
where parent_phone like '%3%';

--서울에 살지 않는 부모의 이름 조회

select *
from parents 
where parent_address not like '%서울%';


-- sql에서의 null은 값이 없음을 의미하므로 비교할 수 없다.
-- null과 연산되면 모두 null
select null = null;

select *
from parents 
where parent_age is null;


select *
from parents 
where parent_age is null;

--주소 정보가 없거나 입력이 안된 부모의 데이터를 조회
--주소 정보가 없거나 입력이 안된 부모이면서 데이터가 하나라도 비어있는 부모 데이터를 조회

select *
from parents 
where parent_address is null or parent_address = '없음';

select *
from parents 
where parent_address is null or parent_address = '없음' and parent_name  is null or parent_age is null or parent_phont is null ;

select *
from parents 
where parent_address is null or parent_address = '없음' and (parent_name  is null or parent_age is null or parent_phont is null) ;




--null은 무시한
select avg(parent_age)
from parents;

select count(parent_age)
from parents
where id = 100;

--count(null) 또는 행이 없을때 0을 출력한다.

select count(null)
from parents
where id = 100;

select min(parent_age) 
from parents;
--20이 나옴 -> 값으로 봐야함

create table field_trips(
	id bigint generated always as identity primary key,
	field_trip_title text not null,
	field_trip_number smallint default 0


);

insert into field_trips(field_trip_title, field_trip_number)
values('송어가 송송 잡혀요', 100);
insert into field_trips(field_trip_title, field_trip_number)
values('딸기딸기 딸기 따', 20);
insert into field_trips(field_trip_title, field_trip_number)
values('화분에 더덕 키우기', 40);
insert into field_trips(field_trip_title, field_trip_number)
values('멧돌로 두부만들기', 30);
insert into field_trips(field_trip_title, field_trip_number)
values('뻘가서 뻘하게 조개 캐기', 80);
insert into field_trips(field_trip_title, field_trip_number)
values('감자 고구마 캐기', 100);
insert into field_trips(field_trip_title, field_trip_number)
values('한복입고 에절 교', 100);
insert into field_trips(field_trip_title, field_trip_number)
values('누에고치 키우기', 50);
insert into field_trips(field_trip_title, field_trip_number)
values('인절미 만들면서 절기', 80);













































