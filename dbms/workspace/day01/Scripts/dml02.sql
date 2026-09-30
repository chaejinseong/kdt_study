-- JSONB: {}, []
create table users(
   id bigint generated always as identity primary key,
   user_info jsonb default '{}'::jsonb,
   user_hobbies text[]
);

insert into users(user_info, user_hobbies)
values (
   '{
      "name": "홍길동",
      "age": 20,
      "address": "서울시 강남구"
   }',
   ARRAY['축구', '야구', '농구']
),
(
   '{
      "name": "장보고",
      "age": 30,
      "address": "서울시 종로구"
   }',
   ARRAY['축구', '배구', '피구']
),
(
   '{
      "name": "이순신",
      "age": 40,
      "address": "서울시 송파구"
   }',
   ARRAY['배구', '피구', '코딩']
);

select *
from users;

-- json 조회 
-- user_info ->> 'name' == user_info.name
select user_info ->> 'name'
from users;

select (user_info ->> 'age')::int + 20
from users;

-- 유저의 주소가 강남에 살고 있는 유저를 조회
select *
from users
where user_info ->> 'address' like '%강남%';

-- @>: GIN연산자 포함여부를 확인
select *
from users
where user_info @> '{"name": "장보고"}';

-- = any(배열)
select *
from users 
where '축구' = any(user_hobbies);

-- 축구 and 피구를 취미로 가지고 있는 사용자 조회 
select *
from users
where user_hobbies @> array['축구', '피구'];

--cardinality: 배열의 길이
select user_hobbies, cardinality(user_hobbies)
from users;

-- 인덱스 1부터: 인덱싱
select user_hobbies[1], user_hobbies[2], user_hobbies[3]
from users;

-- 슬라이싱[시작값:종료값] - (마지막 값을 포함)
select user_hobbies[1:2]
from users;

select user_hobbies[2:]
from users;

select user_hobbies[:2]
from users;

select *
from users
where user_hobbies[1] = '축구';

-- 있으면 수정
update users
set user_info = jsonb_set(
   user_info, 
   '{"name"}', '"홍길동"'
)
where id = 1;

-- 키가 없으면 추가
-- jsonb_set(객체, "key", "value")
update users
set user_info = jsonb_set(
   user_info, 
   '{"test"}', '"test"'
)
where id = 1;

select *
from users;

-- ||(연결): 문자열 || 문자열
select user_info || '{"phone": "010-1234-1234"}'
from users;

update users
set user_info = user_info || '{"phone": "010-1234-1234"}'
where id = 1;

select *
from users;


-- 배열의 수정
select id, user_hobbies[1]
from users
order by id;

update users
set user_hobbies[1] = '코딩'
where id = 1;

select id, user_hobbies
from users
order by id;

-- 범위 수정
update users
set user_hobbies[1:2] = array['요리', '영화']
where id = 1;

-- 전체 수정 
update users
set user_hobbies = array['요리', '영화']
where id = 1;

select id, user_hobbies
from users
order by id;

-- 배열의 맨 앞에 값을 추가(array_prepend)
-- 배열의 맨 뒤에 값을 추가(array_append)
update users
set user_hobbies = array_prepend('청소', user_hobbies)
where id = 1;

update users
set user_hobbies = array_append(user_hobbies, '축구')
where id = 1;

select id, user_hobbies
from users
order by id;

-- 배열과 배열 연결
-- 2번을 제거
select 
   user_hobbies,
   user_hobbies[1] || user_hobbies[3:]
from users

-- 배열의 값을 제거: array_remove()
select array_remove(user_hobbies, '축구')
from users

-- json key 제거: -
select user_info - 'address'
from users;