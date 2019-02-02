-- LABORATORY WORK 1
-- BY Kholin_Nikita
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create user kholin identified by kholin_password
default tablespace "users"
temporary tablespace "temp";
alter user kholin quota 100M on users;
grant "connect" to kholin;
grant drop any table to kholin;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина має лікарняну картку, що містить записи про історію хвороби.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

create table people
(
  person_id varchar2(10) not null,
  first_name varchar2(30) not null,
  last_name varchar2(30) not null,
  birthdate date not null,
  phone_number number(10) not null
);

create table cards
(
  card_id varchar2(10) not null,
  person_id varchar2(10) not null,
  created_at varchar2(30) not null
);

create table card_records
(
  card_record_id varchar2(10) not null,
  card_id varchar2(10) not null,
  doctor_id number(10) not null,
  visited_at date not null,
  notes varchar2(65535) not null
);

create table doctors
(
  doctor_id varchar2(10) not null,
  first_name varchar2(30) not null,
  last_name varchar2(30) not null,
  phone_number number(10) not null
);

ALTER TABLE people ADD CONSTRAINT PK_People PRIMARY KEY (person_id);
ALTER TABLE people ADD CONSTRAINT people_first_name_check CHECK (REGEXP_LIKE(first_name, '^[A-Z]{1,1}[a-z]{2,39}$'));
ALTER TABLE people ADD CONSTRAINT people_last_name_check CHECK (REGEXP_LIKE(last_name, '^[A-Z]{1,1}[a-z]{2,39}$'));
ALTER TABLE people ADD CONSTRAINT people_birthday_in_past_check CHECK (birthdate < (SELECT CURRENT_DATE FROM DUAL));
ALTER TABLE people ADD CONSTRAINT people_phone_number_check CHECK (REGEXP_LIKE(phone_number, '^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$'));

ALTER TABLE doctors ADD CONSTRAINT PK_Doctors PRIMARY KEY (doctor_id);
ALTER TABLE doctors ADD CONSTRAINT doctors_first_name_check CHECK (REGEXP_LIKE(first_name, '^[A-Z]{1,1}[a-z]{2,39}$'));
ALTER TABLE doctors ADD CONSTRAINT doctors_last_name_check CHECK (REGEXP_LIKE(last_name, '^[A-Z]{1,1}[a-z]{2,39}$'));
ALTER TABLE doctors ADD CONSTRAINT doctors_phone_number_check CHECK (REGEXP_LIKE(phone_number, '^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$'));

ALTER TABLE cards ADD CONSTRAINT PK_Cards PRIMARY KEY (card_id);
ALTER TABLE cards
ADD CONSTRAINT FK_Cards_People FOREIGN KEY (person_id) REFERENCES people (person_id);
ALTER TABLE cards ADD CONSTRAINT cards_created_at_in_past_check CHECK (created_at < (SELECT CURRENT_DATE FROM DUAL));

ALTER TABLE card_records ADD CONSTRAINT PK_Card_Records PRIMARY KEY (card_record_id);
ALTER TABLE card_records
ADD CONSTRAINT FK_Card_Records_Cards FOREIGN KEY (card_id) REFERENCES cards(card_id);
ALTER TABLE card_records
ADD CONSTRAINT FK_Card_Records_Doctors FOREIGN KEY (doctor_id) REFERENCES cards(doctor_id);
ALTER TABLE card_records ADD CONSTRAINT card_records_visited_at_in_past_check CHECK (visited_at < (SELECT CURRENT_DATE FROM DUAL));


CREATE SEQUENCE people_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE cards_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE card_records_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE doctors_seq START WITH 1 INCREMENT BY 1;


INSERT INTO people(person_id, first_name, last_name, birthdate, phone_number) VALUES (people_seq.nextval, 'Nikita', 'Kholin', '1998/04/18', '+380957055941');
INSERT INTO people(person_id, first_name, last_name, birthdate, phone_number) VALUES (people_seq.nextval, 'Larionova', 'Jul', '1998/07/17', '+380957055942');
INSERT INTO people(person_id, first_name, last_name, birthdate, phone_number) VALUES (people_seq.nextval, 'Someone', 'Else', '1998/04/18', '+380957055945');
  
INSERT INTO cards(card_id, person_id, created_at) VALUES (cards_seq.nextval, 1, '1998/04/18');
INSERT INTO cards(card_id, person_id, created_at) VALUES (cards_seq.nextval, 2, '1998/07/17');
INSERT INTO cards(card_id, person_id, created_at) VALUES (cards_seq.nextval, 3, '1998/04/18');

INSERT INTO doctors(doctor_id, first_name, last_name, phone_number) VALUES (doctors_seq.nextval, 'Some', 'Doc', '+380957055342');
INSERT INTO doctors(doctor_id, first_name, last_name, phone_number) VALUES (doctors_seq.nextval, 'Another', 'Doc', '+380957034642');
INSERT INTO doctors(doctor_id, first_name, last_name, phone_number) VALUES (doctors_seq.nextval, 'The', 'Doc', '+380933456432');

INSERT INTO card_records(card_record_id, card_id, doctor_id, visited_at, notes) VALUES (card_records_seq.nextval, 1, 3, '2017/04/18:13:37', 'Sick');
INSERT INTO card_records(card_record_id, card_id, doctor_id, visited_at, notes) VALUES (card_records_seq.nextval, 1, 2, '2017/04/18:14:48', 'Not sick');
INSERT INTO card_records(card_record_id, card_id, doctor_id, visited_at, notes) VALUES (card_records_seq.nextval, 1, 1, '2017/04/18:15:32', 'Free');

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

grant select any table to kholin;
grant create any table to kholin;
grant insert any table to kholin;

/*---------------------------------------------------------------------------
3.a. 
Як звуть постачальника, що продав найдорожчий товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

select vend_name from vendors
where (
  select count(*) from products
  where products.vend_id = vendors.vend_id 
  and prod_price = (select max(prod_price) from products)
  and (
    select count(*) from orderitems
    where orderitems.prod_id = products.prod_id
  ) > 0
) > 0;

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця з найдовшим іменем – поле назвати long_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select trim(cust_name) as long_name
from customers
where length(trim(cust_name)) = (
  select max(length(trim(cust_name))) from customers
);

/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

select lower(vend_name) from vendors
where (
  select count(*) from products
  where products.vend_id = vendors.vend_id
  and (
    select count(*) from orderitems
    where orderitems.prod_id = products.prod_id
  ) > 0
) > 0;
