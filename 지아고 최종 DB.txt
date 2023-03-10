-- SQL 새로운 계정 생성 후 권한 부여
-- create user c##jiago identified by it;

-- grant connect, resource, dba to c##jiago;


drop table answer;
drop table notice;
drop table reply;
drop table q_board;
drop table user_donate;
drop table point;
drop table survey_question;
drop table survey_example;
drop table survey;
drop table question;
drop table survey_company;
drop table member;

drop sequence member_seq;
drop sequence survey_company_seq;
drop sequence survey_seq;
drop sequence q_board_seq;
drop sequence reply_seq;
drop sequence notice_seq;
drop sequence point_seq;
drop sequence user_donate_seq;
drop sequence answer_seq;
drop sequence question_seq;
drop sequence survey_question_seq;
drop sequence example_seq;

drop trigger question_trigger;
drop function check_question_function;
drop function get_seq;

create sequence member_seq
    start with 1
    maxvalue 999999999999
    increment by 1
    nocache
    nocycle;

create table member (
    user_idx        number          default member_seq.nextval primary key,
    user_id         varchar2(100)   not null unique,
    user_pw         varchar2(100)   not null,
    user_name       varchar2(100)   not null,
    user_birth      date            not null,    
    user_gender     varchar2(10)    not null check(user_gender in ('남성','여성')),
    user_address    varchar2(200)   not null,
    user_phone      varchar2(20)    ,
    user_email      varchar2(100)   ,
    user_job        varchar2(100)   not null,
    user_type       varchar(10)     default 'Member' check(user_type in ('Admin','Member')),
    user_joindate   Date            default sysdate,
    user_withdraw   varchar2(10)    default 'N' check(user_withdraw in ('Y','N')),
    user_agree      varchar2(10)    default 'Y' check(user_agree in ('Y','N')),
    user_grade      varchar2(50)    default '1단계'
);

create sequence survey_company_seq
  start with 1
  maxvalue 99999999
  INCREMENT by 1
  nocycle
  nocache;

create table survey_company (
   company_idx          number default    survey_company_seq.nextval primary key,
   company_id           varchar2(30)      not null unique,
   company_name         varchar2(100)     not null,
   company_num          varchar2(20)      not null,
   company_registnum    varchar2(50)      not null,
   company_address      varchar2(100)     not null,
   company_email        varchar2(100)     not null,
   company_delete       varchar2(10)      default 'N'
);


create sequence survey_seq 
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;


create table survey (
    survey_idx          number          default survey_seq.nextval primary key,
    company_idx         number          ,
    survey_title        varchar2(100)   not null,
    survey_date         varchar2(500)   not null,
    survey_point        number          default 0,
    survey_time         varchar2(100)   not null,
    survey_targetage    varchar2(100)   ,
    survey_targetgender varchar2(100)   ,
    survey_targetJob    varchar2(100)   ,
    survey_info         varchar2(3000)  not null,
    survey_delete       varchar2(10)    default 'N' check(survey_delete in ('Y','N')),
  
    constraint company_idx    -- 제약조건 이름
    foreign key(company_idx)      -- 컬럼 이름
    references survey_company(company_idx)      -- 참조 테이블 이름
    on delete set null            
);


create sequence q_board_seq
  start with 1
  maxvalue 9999999999
  INCREMENT by 1
  nocycle
  nocache;

create table q_board (
    qboard_idx      number default      q_board_seq.nextval primary key,
    user_idx        number              ,
    qboard_writer   varchar2(100)       not null,
    qboard_title    varchar2(100)       not null,
    qboard_content  varchar2(2000)      not null,
    qboard_date     Date                default sysdate,
    qboard_privacy  varchar2(30)        default 'N' check (qboard_privacy in ('Y', 'N')),
    qboard_view     number              default 0,
  
    constraint user_idx    -- 제약조건 이름
    foreign key(user_idx)      -- 컬럼 이름
    references member(user_idx)      -- 참조 테이블 이름
    on delete set null
);


create sequence reply_seq
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;

create table reply (
    reply_idx     number          default reply_seq.nextval primary key,
    qboard_idx    number          not null,
    user_idx      number          not null,
    admin_id      varchar2(200)   not null,
    reply_content varchar2(2000)  not null,
  
    constraint qboard_idx_reply         -- 제약조건 이름
    foreign key(qboard_idx)             -- 컬럼 이름
    references q_board(qboard_idx)      -- 참조 테이블 이름
    on delete set null,
    
    constraint user_idx_reply         -- 제약조건 이름
    foreign key(user_idx)             -- 컬럼 이름
    references member(user_idx)       -- 참조 테이블 이름
    on delete set null
);


create sequence notice_seq
  start with 1
  maxvalue 9999999999
  INCREMENT by 1
  nocycle
  nocache;

create table notice (
  notice_idx        number           default notice_seq.nextval primary key,
  notice_admin      varchar2(100)    not null,
  notice_name       varchar2(100)    not null,
  notice_content    varchar2(2000)   not null,
  notice_date       Date             default sysdate
);


create sequence point_seq
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;

create table point(
    point_idx     number      default  point_seq.nextval primary key,
    user_idx      number      not null,
    survey_idx    number      ,
    point         number      default 0,
    
    constraint user_idx_point        -- 제약조건 이름
    foreign key(user_idx)             -- 컬럼 이름
    references member(user_idx)      -- 참조 테이블 이름
    on delete set null, 
    
    constraint survey_idx_point        -- 제약조건 이름
    foreign key(survey_idx)             -- 컬럼 이름
    references survey(survey_idx)      -- 참조 테이블 이름
    on delete set null 
);


create sequence user_donate_seq
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;


create table  user_donate (
    total_idx       number      default user_donate_seq.nextval primary key,
    point_idx       number      ,
    user_idx        number      not null,
    survey_idx      number      ,
    total_donate    number      default 0,
    donate_date     date        default sysdate,
    
    constraint point_idx_userDonate        -- 제약조건 이름
    foreign key(point_idx)             -- 컬럼 이름
    references point(point_idx)      -- 참조 테이블 이름
    on delete set null,
    
    constraint user_idx_userDonate        -- 제약조건 이름
    foreign key(user_idx)             -- 컬럼 이름
    references member(user_idx)      -- 참조 테이블 이름
    on delete set null,
    
    constraint survey_idx_userDonate        -- 제약조건 이름
    foreign key(survey_idx)             -- 컬럼 이름
    references survey(survey_idx)      -- 참조 테이블 이름
    on delete set null
 
);

create sequence question_seq
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;


create table question (
  question_idx      number          default question_seq.nextval primary key,
  question_content  varchar2(200)   not null
);



create sequence survey_question_seq
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;

create table survey_question (
    survey_question_idx      number          default  survey_question_seq.nextval primary key,
    survey_idx              number   ,
    question_idx            number    ,
    question_content        varchar2(200)   ,
    
    constraint survey_idx_question        -- 제약조건 이름
    foreign key(survey_idx)             -- 컬럼 이름
    references survey(survey_idx)      -- 참조 테이블 이름
    on delete set null,
    
    constraint question_survey        -- 제약조건 이름
    foreign key(question_idx)             -- 컬럼 이름
    references question(question_idx)      -- 참조 테이블 이름
    on delete set null  
);


create sequence example_seq
  start with 1
  maxvalue 999999999
  INCREMENT by 1
  nocycle
  nocache;

create table survey_example (
    example_idx      number          default  example_seq.nextval primary key,
    survey_idx        number         ,
    question_idx      number         ,
    example_content  varchar2(200)   not null,
    
    constraint survey_idx_example        -- 제약조건 이름
    foreign key(survey_idx)             -- 컬럼 이름
    references survey(survey_idx)      -- 참조 테이블 이름
    on delete set null,
    
    constraint question_example        -- 제약조건 이름
    foreign key(question_idx)             -- 컬럼 이름
    references question(question_idx)      -- 참조 테이블 이름
    on delete set null  
);


create sequence answer_seq
  start with 1
  maxvalue 9999999999
  INCREMENT by 1
  nocycle
  nocache;

create table answer (
    answer_idx      number          default  answer_seq.nextval primary key,
    user_idx        number          not null,
    answer_content  varchar2(4000)   ,
    answer_date     Date            default sysdate,
    question_idx    number          ,
    survey_idx      number          ,
    
    constraint user_idx_answer        -- 제약조건 이름
    foreign key(user_idx)             -- 컬럼 이름
    references member(user_idx)      -- 참조 테이블 이름
    on delete set null,
    
    constraint survey_answer        -- 제약조건 이름
    foreign key(survey_idx)             -- 컬럼 이름
    references survey(survey_idx)      -- 참조 테이블 이름
    on delete set null
);


--------------------- 함수 ------------------------


-- sequesnce를 받아오는 함수
create or replace function get_seq(seq_name in varchar2 ) 
return 
  number 
is
  v_num number;
  sql_stmt varchar2(64);
begin
  sql_stmt := 'select ' || seq_name || '.nextval from dual';
  execute immediate sql_stmt into v_num;
  return v_num;
end;
/

-- question에 중복 질문이 있는지 확인하는 함수
CREATE OR REPLACE FUNCTION check_question_function (ck_question_content in varchar2) 
    RETURN number
IS 
    check_question_content number; 
    check_count number;
BEGIN 
    select count(*) into check_count from question 
        where question_content = ck_question_content;
        
    if check_count = 0 then
         check_question_content := 1;
        RETURN check_question_content; 
        
    else  check_question_content := 0;
        RETURN check_question_content; 
    END IF;
END;
/


-- survey_question에 question과 중복된 값이 없으면 question에도 자동 추가하는 trigger 
CREATE TRIGGER question_trigger 
before INSERT ON survey_question
FOR EACH ROW
DECLARE 
    q_content   varchar2(200) := :New.question_content;
BEGIN 
    if(check_question_function(q_content) = 1) then
        INSERT INTO question (question_idx, question_content) VALUES (:NEW.question_idx, :NEW.question_content);
    END IF;
END;
/


commit;


----------------------------------------------INSERT ---------------------------------------------------------------

--------------------------------- 멤버 -----------------------------------------
insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('admin', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '운영자', '9999-12-31', '남성', '부산 광역시', '010-1234-5678',
    'admin@naver.com', '웹 관리자', 'Admin');

insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('objade', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '유지은', '2002-04-23', '여성', '부산 광역시 수영구', '010-1111-1111',
    'objade@naver.com', '웹 개발자', 'Admin');

insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('jwsabout1', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '정운성', '1995-03-20', '남성', '부산 광역시 해운대구', '010-2222-2222',
    'jwsabout1@naver.com', '웹 개발자', 'Admin');
    
insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('ap9407', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '석진성', '1996-01-10', '남성', '부산 광역시', '010-3333-3333',
    'ap9407@naver.com', '웹 개발자', 'Member');
    
insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('checkmate147', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '김성수', '2000-01-10', '남성', '부산 광역시 동래구', '010-4444-4444',
    'checkmate147@naver.com', '웹 개발자', 'Member');

insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('babo12', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '정철현', '1995-12-31', '남성', '부산 광역시 어딘가', '010-5959-5959',
    'babo12@naver.com', '초보 개발자', 'Member');

    
insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('test', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '테스트', '1990-01-01', '남성', '부산 광역시 어딘가', '010-5555-5555',
    'test@gmail.com', '웹 개발자', 'Member');
    
insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('test1', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '테스트1', '1995-05-05', '여성', '부산 광역시 수영구', '010-6666-6666',
    'test1@gmail.com', '웹 개발자', 'Member');  
    
insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('test2', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '테스트2', '1994-02-02', '남성', '부산 광역시 남성구', '010-7777-7777',
    'test2@gmail.com', '웹 개발자', 'Member');    
    
    
    insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('test3', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '테스트3', '1970-12-31', '여성', '부산 광역시', '010-5555-5678',
    'admin@naver.com', '무직', 'Member');
    
    insert into member 
    (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone,
    user_email, user_job, user_type) 
    values ('test4', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '테스트4', '1960-12-31', '남성', '부산 광역시', '010-6666-5678',
    'admin@naver.com', '기타', 'Member');

insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mcholwell0', 'sJJZKoCXjK', 'Maison', '2020-05-26', '남성', '27473 Mallory Junction', '940-514-3604', 'mdring0@google.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmccorrie1', 'd02ceTw', 'Cchaddie', '2003-06-17', '남성', '8 Eastlawn Center', '902-790-7114', 'ctolomelli1@hugedomains.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ledwicke2', 'xfvDaf', 'Linc', '2021-12-01', '남성', '93850 Rutledge Court', '626-926-4367', 'lbissill2@salon.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ekarpenko3', 'qRs3vdqwNWn', 'Eloisa', '2011-04-06', '여성', '587 Northport Plaza', '106-477-5061', 'esergean3@wikimedia.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tcolton4', 'rKAgOvYy', 'Tandy', '2009-11-05', '여성', '6 Ramsey Alley', '105-871-0388', 'tthow4@macromedia.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmandres5', 'lOVo3sT', 'Claudie', '1991-09-30', '여성', '4380 Manufacturers Alley', '334-182-7370', 'callan5@last.fm', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gmannion6', '5KLlTvVWE7uS', 'Gerry', '2012-09-27', '여성', '12 4th Alley', '932-763-7190', 'gkonzelmann6@howstuffworks.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mmollene7', 'rd1Txg', 'Marrilee', '1995-03-12', '여성', '43709 Fuller Parkway', '496-605-5609', 'mlourens7@sfgate.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kbedin8', 'ABlp6BTiRFNJ', 'Kiley', '1992-08-30', '남성', '36229 3rd Trail', '331-943-7411', 'kgauche8@squarespace.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nlowe9', '7SPf80HUa', 'Nickolas', '2010-11-13', '남성', '50109 7th Avenue', '687-366-9532', 'nwoodfin9@army.mil', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('akinnarda', 'BOu4npf', 'Alick', '2017-06-28', '남성', '280 Londonderry Circle', '151-234-2590', 'adaingerfielda@ask.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cgolderb', 'xP4o2MzP', 'Cacilie', '1996-04-04', '여성', '1960 Dexter Avenue', '572-415-6373', 'cdurnob@netscape.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dgiacomozzoc', 'nMnPuh', 'Donica', '2011-04-19', '여성', '6410 Schlimgen Road', '833-677-6833', 'dglidec@stumbleupon.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dverheijdend', 'SVRBvAb', 'Dewie', '2011-01-02', '남성', '1166 Onsgard Place', '519-578-9086', 'dtallowd@mayoclinic.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gwatshame', '0fFhXSWrQMt', 'Glad', '2000-05-02', '여성', '76 Warner Lane', '389-553-0243', 'gmcroriee@chronoengine.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bpietraszekf', 'reUDV2', 'Briny', '2017-03-12', '여성', '10858 Stang Way', '974-481-1565', 'bwithefordf@telegraph.co.uk', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tteagueg', 'Fnl84wW7O360', 'Thornton', '2007-03-07', '남성', '55 Cambridge Street', '978-873-5586', 'tgiorgiellig@barnesandnoble.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hchippsh', 'hnzNm8WQy2J', 'Hallsy', '2000-07-10', '남성', '47 Sage Plaza', '889-503-0753', 'hmccuskerh@wunderground.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('igunnelli', 'PocipKha3T', 'Iggie', '2016-11-22', '남성', '6 Del Mar Pass', '906-188-9564', 'imuffitti@dailymotion.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kbeamentj', 'ynVeBdWl', 'Karyl', '1992-10-12', '여성', '6 Mosinee Road', '724-242-9668', 'kolczykj@zdnet.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gelcumk', 'yTtG7yMJqv', 'Gayle', '1993-07-29', '여성', '38570 Straubel Parkway', '978-909-9380', 'gmarjanskik@elegantthemes.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccislandl', 'K6qCmAo', 'Ciel', '2017-02-10', '여성', '10305 8th Drive', '836-588-5426', 'cwayel@telegraph.co.uk', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcalytonm', 'xuzd3gK', 'Dewitt', '1992-01-09', '남성', '227 Del Sol Parkway', '374-352-8745', 'dbuntm@eventbrite.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dkarolowskin', 'GP8sgn', 'Deeann', '1996-11-12', '여성', '81290 Goodland Terrace', '745-346-8336', 'ddyden@tinyurl.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mpolyeo', 'X8Vudrqo4p', 'Melina', '2022-05-08', '여성', '4390 Carpenter Pass', '161-787-6691', 'mliversidgeo@lycos.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ohearmonp', 'A2sa91awIR', 'Odele', '2004-07-12', '여성', '600 Barnett Pass', '346-547-5766', 'omaevelap@yolasite.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lharrildq', '0IUqHds6DAvf', 'Leon', '2006-01-12', '남성', '265 Derek Plaza', '353-607-2822', 'ltuffsq@ebay.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tlonghurstr', 'zNd5yYjXZ', 'Tine', '1992-04-21', '여성', '85901 Killdeer Point', '126-980-6466', 'tstatenr@fastcompany.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hparsonages', 'XAMhnS0i0k', 'Harwilll', '2009-08-09', '남성', '4583 Crownhardt Way', '517-651-9639', 'hgateleys@diigo.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lpetrushkat', 'x8QqeRQI', 'Letisha', '2019-11-29', '여성', '8 Forster Pass', '794-565-3614', 'lstevensont@meetup.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('svignalu', 'LbNWRx', 'Sabine', '2009-05-13', '여성', '1 Hansons Lane', '840-937-6371', 'sblewittu@privacy.gov.au', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('holnerv', 'Xz6meU', 'Hamil', '1991-11-06', '남성', '80164 Debra Road', '504-749-7089', 'hblewettv@addtoany.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('clicciardow', 'dq0c331b', 'Concettina', '2004-02-07', '여성', '206 Montana Lane', '129-683-6957', 'cronaldw@nature.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dmorradx', 'uD2g8bc2pI64', 'Dion', '2022-02-28', '여성', '38197 Donald Circle', '202-551-9147', 'dcluettx@moonfruit.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dburdgey', 'Bhk7GaoeG8ig', 'Dominique', '2000-02-18', '여성', '1 Hagan Court', '973-380-1370', 'dpaeckmeyery@china.com.cn', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('agowriez', '7HIpC8OBYA', 'Ayn', '2022-05-30', '여성', '44 Dryden Avenue', '263-923-9576', 'ablickz@miibeian.gov.cn', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nkleinhaut10', 'uprrRZYn8hV6', 'Natalee', '2001-12-01', '여성', '7 Towne Street', '760-487-6076', 'nweale10@unesco.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mdunge11', 'wFWDgqB', 'Mikaela', '2017-10-12', '여성', '59220 Bultman Center', '911-150-4641', 'medgcumbe11@va.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jhamblyn12', 'Qe2bjuEDW', 'Jade', '2007-05-09', '여성', '800 Twin Pines Park', '127-862-3644', 'jmacgibbon12@fema.gov', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('calbert13', 'eWO76W70zg', 'Cristen', '2012-02-15', '여성', '0173 Division Parkway', '310-913-2556', 'cleggen13@hc360.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bmarnane14', '91od32NHyfm', 'Bard', '2020-07-09', '남성', '457 Iowa Street', '777-770-0363', 'bskoughman14@mapquest.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fabrey15', 'hSBNtZfF9yPc', 'Frederica', '2017-05-08', '여성', '104 Melody Lane', '195-731-9030', 'fmanis15@qq.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dweal16', 'wP4NRJP6Wd', 'Dacie', '1995-12-31', '여성', '7649 Mallard Way', '310-492-5870', 'dbrack16@cnbc.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('stenbrug17', 'Xu4Cy4m', 'Sanderson', '1996-06-16', '남성', '61532 Hoepker Circle', '712-969-2968', 'smatys17@epa.gov', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jstudman18', 'zSIJZIAjcaqZ', 'Juliette', '2008-05-09', '여성', '52 Valley Edge Crossing', '859-548-8775', 'jbeards18@furl.net', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tlaunchbury19', 'QMZ79dbp', 'Taylor', '2005-12-13', '남성', '72896 Mesta Alley', '485-288-0783', 'tskiggs19@answers.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('blockart1a', '8uCsGe0f', 'Bride', '2008-05-26', '여성', '13 Cherokee Parkway', '507-888-7449', 'btreweke1a@patch.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ncaines1b', '6q4pdP8', 'Norbert', '2002-09-23', '남성', '5044 Swallow Point', '376-480-3448', 'ngorce1b@webs.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hpilmer1c', 'pUDjVu3HKln', 'Hope', '1999-08-07', '여성', '89 Mallard Place', '771-198-8822', 'hcharopen1c@nih.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dpillington1d', 'FpDN1o4xr', 'Donnie', '2009-05-10', '남성', '021 Melby Way', '811-905-0308', 'dginnally1d@linkedin.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pwalles1e', 'cO4dIXOKq4', 'Pansie', '1996-01-11', '여성', '496 Holy Cross Center', '912-332-0659', 'pfreeborn1e@vistaprint.com', 'Software 학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('msaffon1f', 'K3EoNGx', 'Mufi', '2010-08-19', '여성', '98847 Maryland Drive', '111-603-3460', 'mfidock1f@amazon.de', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vbarbisch1g', 'N3a25Ky', 'Valina', '2012-07-06', '여성', '6837 Burning Wood Plaza', '136-142-7500', 'vseward1g@linkedin.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('asattin1h', 'vS8lOXzx', 'Angeli', '1999-12-06', '남성', '499 Gulseth Parkway', '250-525-5633', 'adawson1h@wsj.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('alowerson1i', 'Myd2hpyrZ0', 'Aland', '2017-05-27', '남성', '65 Oak Circle', '942-436-9751', 'achestnut1i@twitter.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ibratt1j', 'yCvHIC7ic', 'Ines', '2016-09-23', '여성', '4 Morning Place', '666-664-4777', 'islocket1j@ustream.tv', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('alangeley1k', '8LAJ3ySw', 'Ashlie', '2000-04-13', '여성', '270 Monterey Road', '231-394-9170', 'amanifold1k@answers.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ghayhoe1l', 'GQndGBEW', 'Gardener', '1994-08-12', '남성', '70 Jay Trail', '501-284-8971', 'gsaunter1l@opera.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vissac1m', '2M1gx7', 'Vin', '2019-02-07', '여성', '48539 Arizona Plaza', '944-591-9744', 'vsiddle1m@google.fr', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('awarry1n', 'rzNSl96rFm', 'Antonina', '2001-11-07', '여성', '3475 Tony Avenue', '772-886-0402', 'abalsillie1n@discuz.net', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('btrownson1o', 'E3eH3wmCw5L', 'Bryna', '2011-10-23', '여성', '4 Fulton Terrace', '875-511-4299', 'bbonsall1o@huffingtonpost.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fgodard1p', 'Pq8rNNY', 'Frasquito', '1995-05-21', '남성', '2244 Village Green Point', '272-965-6429', 'fferraron1p@sourceforge.net', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('clintot1q', 'rhhyKt7', 'Cyrille', '2009-10-30', '남성', '208 Hermina Junction', '155-770-6035', 'csalt1q@oracle.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lbuttler1r', 'iceQGqqexf0', 'Lonnie', '2000-09-28', '남성', '05 Lerdahl Street', '691-462-9342', 'ldizlie1r@cdc.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('peberz1s', 'wwFW9tii', 'Parker', '2000-11-05', '남성', '9175 Dixon Court', '904-357-1538', 'pjellico1s@intel.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rgiorgini1t', '337Vqvfj', 'Ricky', '2014-12-01', '남성', '8530 Declaration Avenue', '184-127-9556', 'rhallad1t@webmd.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('davrashin1u', 'LcSRxYGYOL', 'Donall', '1990-11-15', '남성', '5900 Everett Park', '762-427-2221', 'ddudny1u@prlog.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mmatic1v', 'lGnL1auvQXP', 'Myrtia', '2021-10-14', '여성', '173 Annamark Plaza', '177-525-7296', 'mstutte1v@unicef.org', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kroaf1w', 'U7l7tifCWV', 'Kaylyn', '2008-09-03', '여성', '7737 Fordem Alley', '637-102-3270', 'kspillett1w@craigslist.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nillem1x', 'TKMEFF', 'Ned', '2002-08-09', '남성', '26 Marquette Drive', '961-225-9662', 'nelward1x@ebay.co.uk', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcapehorn1y', 'ce184cx', 'Rica', '2004-12-04', '여성', '7842 Heath Plaza', '495-311-3275', 'rhanbridge1y@quantcast.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amccreedy1z', '56NgF8', 'Anna-maria', '2010-02-13', '여성', '847 Village Point', '552-928-6755', 'asilversmid1z@chronoengine.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fbentzen20', 'eTnheaBmKHt', 'Freddy', '2009-09-18', '여성', '42 Anhalt Street', '591-774-6245', 'fraincin20@usa.gov', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmordacai21', 'Wq3kXLvnsS9', 'Christoffer', '1999-08-22', '남성', '67064 Maple Court', '128-707-1651', 'ckensy21@chronoengine.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('emaclachlan22', '2DeaAtaxqn', 'Eamon', '2008-05-26', '남성', '7463 Pleasure Terrace', '786-291-8204', 'etomblings22@vk.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amillan23', 'V2XLEnPDP', 'Andris', '2016-03-04', '남성', '2613 Meadow Vale Terrace', '789-658-0575', 'aseverwright23@free.fr', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rjansson24', 'XtphoPN1LI', 'Ransom', '2010-06-28', '남성', '2 Starling Crossing', '969-438-9065', 'rsommerscales24@about.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wrubenovic25', 'bKsPzPFX48j', 'Walt', '2006-03-30', '남성', '5 Harbort Terrace', '164-405-2323', 'wcook25@themeforest.net', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kgrand26', 'kmirZZXX', 'Kristopher', '1997-01-30', '남성', '9889 Little Fleur Way', '292-411-5580', 'kslay26@sakura.ne.jp', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ibourcq27', 'Xa95RwL', 'Isadore', '1991-04-20', '남성', '742 Randy Terrace', '178-835-6100', 'ikensington27@gov.uk', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('spidgen28', 'YBDJQ6TsasxL', 'Shaun', '2021-03-22', '여성', '74 Jenifer Pass', '970-283-3958', 'sgoodrick28@fc2.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kgeerits29', '3u8mcz', 'Kylie', '2019-10-08', '여성', '86 Emmet Alley', '114-721-9175', 'kyitzovicz29@nature.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rdesouza2a', 'sXB1Dlyi9', 'Romain', '2022-08-26', '남성', '9145 Merry Hill', '239-653-3398', 'rmathwen2a@mashable.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('alandy2b', 'OMRGFAI7Y4FB', 'Adoree', '1991-07-07', '여성', '43 Prentice Center', '573-715-6925', 'agoodisson2b@google.es', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rloftin2c', 'GBVTLDAMzd5', 'Roberta', '2010-02-02', '여성', '12543 Bonner Terrace', '655-293-3391', 'rtofful2c@livejournal.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('srugieri2d', 'NJS9uHyddL', 'Siouxie', '2008-03-05', '여성', '00 Algoma Park', '610-781-8469', 'sgammage2d@live.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('treddlesden2e', 'lFAoq8z', 'Trip', '2002-02-16', '남성', '33798 Chive Pass', '759-438-0292', 'tpetris2e@livejournal.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dclegg2f', 'rPTQ189x4', 'Dahlia', '1991-05-01', '여성', '9 North Crossing', '863-499-0947', 'dphelipeaux2f@bloglines.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('iangrick2g', 'FtIrIC7UWGY', 'Ileana', '2018-07-08', '여성', '5460 Carberry Terrace', '421-351-5335', 'ifolger2g@plala.or.jp', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kpatise2h', 'zB2WQPbddT6i', 'Kori', '1999-04-13', '여성', '7389 Bluestem Point', '806-744-2069', 'kwoolacott2h@godaddy.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('idevorill2i', 'zmr3Qpd', 'Idell', '2020-06-20', '여성', '7 Montana Road', '799-869-8858', 'igrassi2i@hexun.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aderyebarrett2j', 'CIWu1XN2gmT', 'Arin', '1991-06-28', '남성', '01 Glendale Junction', '888-775-4025', 'amiddup2j@dmoz.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mjosey2k', 'BYNMrzuib5Xv', 'Merrill', '2022-10-14', '여성', '8 Eliot Road', '912-703-9600', 'mbassford2k@tiny.cc', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gforestall2l', '7aLX8hTOTn', 'Gaspard', '1992-05-31', '남성', '56713 Coleman Park', '561-404-6469', 'gscrooby2l@addtoany.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bhuchot2m', 'Cs7Jgfe0csc', 'Barrie', '2017-01-16', '여성', '07 Pleasure Lane', '666-522-4356', 'bmilmo2m@feedburner.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tskinn2n', 'TDi9Z41MO', 'Tully', '1992-06-11', '남성', '0 Everett Street', '902-709-6902', 'tsket2n@mail.ru', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbauer2o', 'M4TnJJMs9Ba', 'Blondy', '2005-04-26', '여성', '4 Petterle Circle', '279-817-4461', 'bgander2o@newsvine.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('icapon2p', 'pITEjjn8EmPr', 'Iormina', '2014-09-06', '여성', '32 Pennsylvania Alley', '298-999-5617', 'ihargraves2p@bbc.co.uk', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fgrimshaw2q', '37wwkgeLo', 'Fidelio', '2009-03-05', '남성', '61307 Lighthouse Bay Center', '287-228-0274', 'fcheeke2q@netlog.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmcnaught2r', 'gNBlNDZ', 'Rogers', '2017-05-01', '남성', '000 Loftsgordon Way', '540-742-3613', 'rhamsher2r@last.fm', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nlonder2s', 'E22jRzP1', 'Nelia', '1994-11-15', '여성', '78769 Dwight Pass', '738-543-3356', 'nfranzel2s@google.co.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('chodgets2t', 'dSfKsd8Y', 'Chanda', '2004-12-12', '여성', '58 Delladonna Avenue', '766-476-7002', 'cdowsett2t@nytimes.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kgravener2u', '1MO7fgCJy7H', 'Kareem', '1997-01-17', '남성', '82790 Chive Hill', '356-821-3885', 'kokeaveny2u@chron.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dscading2v', 'AKZXKhU3', 'Dennet', '2022-03-16', '남성', '0 Badeau Drive', '496-459-7029', 'dmilella2v@e-recht24.de', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rharlett2w', 'PRev3WLubw8q', 'Rosemonde', '2018-07-08', '여성', '483 Sundown Junction', '203-454-1464', 'rhartopp2w@guardian.co.uk', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fkybert2x', 'uCbkNAP', 'Fabe', '2009-03-30', '남성', '5412 Birchwood Park', '433-193-6558', 'fspeachley2x@addtoany.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cayliff2y', '4hEU3BmqFJ', 'Celesta', '2013-06-25', '여성', '611 Vahlen Lane', '286-401-6083', 'cfoucar2y@multiply.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mmoakler2z', 'slQVUX5m0Tj', 'Margarete', '2004-11-01', '여성', '768 Nobel Court', '152-328-0117', 'mjeanneau2z@globo.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('emiguet30', 'eWaiH2', 'Eachelle', '1994-05-11', '여성', '76 Kingsford Road', '267-125-4310', 'elotze30@hud.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dtoffanini31', 'oNDNpQt', 'Danit', '2005-11-11', '여성', '1461 Loeprich Plaza', '628-280-0808', 'drodman31@icq.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fdoswell32', 'WFdBRzjn', 'Fidole', '1994-12-28', '남성', '57223 Blue Bill Park Street', '340-460-2027', 'ftreace32@so-net.ne.jp', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kmaccosto33', 'BHz4u1Nlg5ui', 'Kamilah', '2013-05-24', '여성', '610 Bartelt Point', '344-150-6824', 'kshallcross33@goodreads.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jpickle34', 'kwzYoY6c', 'Janean', '2005-12-13', '여성', '21 Crownhardt Point', '247-365-2870', 'jhawtry34@google.nl', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmorrall35', '35TkPthQW', 'Jarrett', '2000-09-19', '남성', '546 Maple Wood Drive', '837-833-5367', 'jbovaird35@sogou.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pborgars36', 'ds4qYs', 'Penni', '2022-11-03', '여성', '700 Arkansas Street', '402-169-7940', 'phenken36@t-online.de', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('smussard37', 'c9Sp1UPf9e6g', 'Stinky', '2006-09-10', '남성', '5 Pearson Court', '657-694-0080', 'slewtey37@is.gd', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ahutson38', 'u0qXJ72', 'Arly', '1991-12-21', '여성', '75811 Cottonwood Drive', '843-803-6054', 'arobion38@squarespace.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcouldwell39', 'DhWwQi5zr', 'Rikki', '2014-05-16', '여성', '8368 Oxford Crossing', '764-878-8792', 'rapplegate39@linkedin.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tmuldownie3a', 'ELnNOK1a8', 'Torrie', '1999-01-30', '여성', '220 Becker Plaza', '802-346-9490', 'thusselbee3a@youku.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('edunne3b', 'W7GIFk', 'Elysia', '2004-05-13', '여성', '59 John Wall Place', '469-816-8489', 'eledford3b@elegantthemes.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aegiloff3c', 'TVmln3Hg', 'Augustine', '2007-09-23', '남성', '58969 Clyde Gallagher Street', '476-567-7118', 'arowbottom3c@weibo.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kbolles3d', 'StMO8plaw', 'Kaela', '1998-05-06', '여성', '28 Kingsford Terrace', '120-735-8035', 'khollingsbee3d@printfriendly.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('frobson3e', 'aO7GLrQ6rW5v', 'Franz', '1992-06-17', '남성', '8177 Daystar Street', '368-756-3330', 'fgullane3e@moonfruit.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmacgeaney3f', 'mNmrcL6CJgw', 'Cicily', '1998-08-11', '여성', '1 Sullivan Center', '302-779-0120', 'cschultes3f@gravatar.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ddurno3g', 'XyHXhJdFX1', 'Doy', '1991-10-25', '남성', '885 Tennessee Road', '426-500-3214', 'dolenchikov3g@mayoclinic.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmacfadzean3h', 'EACEaKJ', 'Corette', '2014-02-04', '여성', '81726 Ludington Pass', '823-800-2461', 'cmeriel3h@examiner.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lharrinson3i', 'KXsfzTH', 'Lurlene', '1996-09-14', '여성', '2 Sloan Pass', '770-298-7380', 'lchad3i@example.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lkirby3j', 'xjrOLme', 'Luther', '1992-05-19', '남성', '9 Sloan Lane', '292-810-0168', 'lcookney3j@statcounter.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ayakubov3k', 'hEhTZCVHor5', 'Antoinette', '1996-12-26', '여성', '8 Eastlawn Plaza', '866-225-3109', 'ahamshaw3k@1und1.de', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kwevell3l', 'oU1EngE4noW', 'Kalli', '2001-04-29', '여성', '4898 Garrison Court', '326-481-9998', 'kkienzle3l@seattletimes.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mscay3m', 'bSVOPOmTTeLg', 'Marsha', '2007-04-06', '여성', '48 Towne Court', '412-379-1363', 'mdoberer3m@ycombinator.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mstrivens3n', 'REkUFD', 'Malina', '2015-06-24', '여성', '36767 Sauthoff Place', '552-569-5433', 'mfauning3n@lycos.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmcgilbon3o', 'nRE73z', 'Raoul', '2020-08-21', '남성', '03 Elka Avenue', '313-804-9019', 'rcreaser3o@mediafire.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dmeaker3p', 'DSeMwWlvB7', 'Dame', '2001-08-20', '남성', '09 Buhler Street', '456-881-5490', 'dvagg3p@cdc.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('meastmond3q', 'D9wNq8glyTOH', 'Marmaduke', '2016-07-17', '남성', '16204 Green Ridge Avenue', '521-342-9573', 'mhaukey3q@hubpages.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ldrakes3r', 'smysZa9Lf', 'Lina', '2015-01-07', '여성', '857 Hovde Center', '629-445-4669', 'lblackler3r@japanpost.jp', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lderington3s', '3acQsMrTnqr', 'Lavina', '2017-06-02', '여성', '775 Luster Drive', '975-291-1495', 'lcollinwood3s@howstuffworks.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('emcgloughlin3t', 'ZC2RNKS', 'Elene', '1994-01-16', '여성', '6 Nancy Center', '129-949-7862', 'ecrosby3t@bbc.co.uk', '자유직/프리랜서II', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('earbon3u', 'mO36ID9Rt', 'Etienne', '1998-09-19', '남성', '3524 Lakeland Pass', '231-224-4227', 'emcdonnell3u@woothemes.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmoxley3v', 'VByWVKz48', 'Johan', '2001-10-02', '남성', '83489 Reinke Alley', '727-366-5465', 'jdebeneditti3v@berkeley.edu', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('knorheny3w', 'ava50uulKoe', 'Katinka', '1991-08-21', '여성', '36 Cottonwood Road', '239-224-0729', 'kdeeves3w@omniture.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ktompkinson3x', 'XjNQmdgFrq5', 'Kippie', '2010-09-23', '남성', '80051 Mcguire Pass', '365-617-7263', 'ktouret3x@statcounter.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cscreeton3y', 'l5O1VQ6iVLC', 'Casey', '2015-09-10', '여성', '4998 Manitowish Parkway', '524-563-6547', 'cgiraux3y@etsy.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dtoun3z', 'Uozh36C', 'Dody', '2005-10-04', '여성', '0017 Brickson Park Junction', '615-210-2160', 'dlloydwilliams3z@exblog.jp', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlinke40', 'ep57AHjE7', 'Magnum', '2020-10-06', '남성', '03 Sutteridge Hill', '367-433-1618', 'mmeasures40@de.vu', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hsteckings41', 'yRc99URLp4uB', 'Helaine', '1993-02-26', '여성', '63 Esker Place', '368-917-2141', 'htitchard41@sohu.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ealeksandrev42', 'TPStGv9bR', 'Edward', '2009-10-21', '남성', '55 Warrior Road', '292-761-6803', 'eallright42@about.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hgamett43', 'z6yKinGIQHdv', 'Harrison', '1998-02-20', '남성', '2732 Killdeer Way', '876-150-8876', 'hluther43@alexa.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lwyness44', '22uTaxQknidR', 'Lizette', '2015-04-21', '여성', '1 Meadow Ridge Center', '581-131-8787', 'lsacaze44@google.es', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vlangtry45', 'UrKSWd1Rw', 'Van', '2015-11-26', '여성', '17176 Knutson Circle', '360-790-6432', 'vfuzzard45@un.org', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ymcguffie46', 'mzhsa7', 'Yehudit', '2021-12-31', '남성', '7 Hintze Point', '185-451-4487', 'yrodgerson46@google.com.hk', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dnudds47', 'T2ZgHZq', 'Durant', '1996-07-21', '남성', '7633 Sutteridge Hill', '489-478-1845', 'dnelius47@columbia.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tbrixham48', 'zXjg3tZeQb5S', 'Tally', '2017-08-11', '남성', '7 Homewood Hill', '561-801-5939', 'tmunks48@house.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bnottingham49', '8Ubwmv', 'Bondon', '2006-07-30', '남성', '051 7th Park', '366-616-9445', 'btrevena49@unicef.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('plambarth4a', '5I1olDx', 'Paddie', '2017-03-15', '남성', '2 8th Point', '514-863-8441', 'pmell4a@state.tx.us', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rbundock4b', 'VDEWEB1G5I', 'Reynard', '2002-09-11', '남성', '03 Bobwhite Pass', '981-387-5926', 'rmuscat4b@webmd.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kstrete4c', 'aUihbAMz8ImX', 'Karry', '1994-07-26', '여성', '6573 Corry Street', '383-196-3816', 'kmileham4c@admin.ch', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('galexis4d', 'cHg96wj312', 'Griffin', '1991-10-26', '남성', '260 Graceland Avenue', '598-860-5217', 'gboanas4d@elpais.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('twaldock4e', 'aRKH1KGWciK', 'Thaddus', '1992-02-04', '남성', '450 Gateway Hill', '435-414-9440', 'tfosdick4e@xing.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aenoksson4f', 'EdsKdF6l', 'Armin', '1992-05-29', '남성', '1 Merchant Place', '126-678-7671', 'acaron4f@prlog.org', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcottel4g', 'dKM5wOuCz1', 'Ronald', '2018-02-28', '남성', '6811 Quincy Lane', '890-416-1253', 'rhuws4g@myspace.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmcilreavy4h', 'DDsQfddIFN', 'Ranee', '2000-01-09', '여성', '195 Lakewood Gardens Place', '851-734-9043', 'rgodney4h@sakura.ne.jp', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sshickle4i', 'jwJ3v3QxSgs', 'Sigrid', '2012-07-14', '여성', '0830 Sunbrook Hill', '805-685-4019', 'sdoyley4i@storify.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rgommes4j', 'submmK2oFo', 'Rosita', '2006-01-21', '여성', '96987 Bowman Trail', '306-680-1862', 'rarens4j@washingtonpost.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jfilov4k', '0MpVX1xRi', 'John', '2011-12-30', '남성', '65 Spenser Plaza', '595-141-6488', 'jmadine4k@auda.org.au', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmelton4l', 'xtzIkDH', 'Juanita', '2006-11-30', '여성', '88 Merrick Lane', '340-848-8118', 'jcourson4l@ebay.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcoale4m', '2BA0zkdD', 'Dunstan', '1993-03-31', '남성', '543 Pennsylvania Alley', '517-466-0468', 'dmeneghelli4m@bing.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vbabbidge4n', 'vwMrC7uP8PpZ', 'Vasili', '2002-03-03', '남성', '9 Norway Maple Terrace', '334-899-5103', 'vmoncreiff4n@msu.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('agapper4o', 'qDAZbmr5', 'Annmarie', '1998-06-21', '여성', '5 Fremont Alley', '610-914-9893', 'alefridge4o@wix.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ncerie4p', 'gaySSU6QcDYH', 'Natalya', '2006-07-28', '여성', '1628 Buena Vista Terrace', '601-223-8237', 'nkaufman4p@blogs.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mbenn4q', 'c9osn0nwPo', 'Marybeth', '2021-04-30', '여성', '1833 Columbus Junction', '718-984-9293', 'mizatson4q@pen.io', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmacsharry4r', 'f0Vr4ThcM1', 'Jaquenette', '1999-02-23', '여성', '23 Talmadge Court', '999-161-0777', 'jmillar4r@hc360.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ghatchard4s', 'AHKpXnB', 'Gerrie', '2010-09-21', '남성', '499 Farmco Center', '260-276-5250', 'gmulderrig4s@storify.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('iferries4t', 'wdkn3Oz', 'Ikey', '2008-07-28', '남성', '54070 Linden Way', '957-266-3227', 'idigiorgio4t@pinterest.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hattrie4u', 'VpT69YaP1d', 'Hugh', '1998-02-19', '남성', '72 Homewood Street', '640-334-8773', 'hbaradel4u@ifeng.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('slenahan4v', 'IV8YXXMfjuNZ', 'Sula', '1998-11-08', '여성', '910 Grasskamp Court', '382-873-0350', 'smacguigan4v@indiegogo.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cpaulot4w', 'GrIysKHesD', 'Cammi', '2013-02-12', '여성', '2437 Namekagon Lane', '416-492-8066', 'clakeman4w@pagesperso-orange.fr', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cprinn4x', '2FS5aE', 'Candis', '2018-12-05', '여성', '01667 Kennedy Center', '722-957-7431', 'cwordesworth4x@people.com.cn', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('npaddell4y', 'L46Bf81cFoHP', 'Norbert', '1998-12-29', '남성', '342 Transport Court', '253-832-1511', 'nhobbing4y@example.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmcinnery4z', 'uhN3v1QbYL', 'Consuela', '2005-08-04', '여성', '40594 Corry Lane', '291-945-9067', 'cweatherhill4z@pinterest.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tjest50', 'X6ZJm1djU', 'Tobie', '2014-08-14', '남성', '973 Shelley Lane', '206-888-8422', 'tlaight50@mtv.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aconcannon51', 'XhD3Sm', 'Aubine', '2002-09-25', '여성', '3 Basil Pass', '466-226-5690', 'awanek51@cocolog-nifty.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcrews52', 'cHnwQOgLpWp', 'Randa', '2004-09-14', '여성', '6 Ruskin Lane', '919-736-0227', 'rshave52@networkadvertising.org', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bwetherby53', 'fr3Zh7fOP', 'Barbey', '1999-06-10', '여성', '9 Stone Corner Trail', '931-169-1317', 'bpragnell53@arstechnica.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dsabberton54', 'aSA0Pu4z', 'Demetris', '2021-12-03', '여성', '8452 Merchant Avenue', '817-165-2993', 'didney54@woothemes.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bblackly55', '27rDvN5skd1', 'Butch', '2003-06-05', '남성', '89470 Loomis Court', '551-723-3430', 'beglington55@google.ru', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('espanton56', 'GGix8Xstcwa5', 'Emery', '1996-09-28', '남성', '5 Donald Pass', '710-873-6168', 'epauncefort56@nps.gov', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tsnasdell57', '6uTBsGlzRf', 'Toby', '2010-01-24', '남성', '3 Pepper Wood Pass', '479-207-3554', 'tmcevoy57@squarespace.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ryanukhin58', '3wDGBi', 'Robbie', '2021-03-23', '남성', '99 Bay Junction', '259-895-8045', 'rheake58@mit.edu', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mrosenbush59', 'nMIhYjG', 'Minda', '2015-04-21', '여성', '243 Clemons Circle', '662-564-3687', 'mperulli59@google.com.hk', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pbeynon5a', 'UwK28n2v', 'Percival', '2010-05-06', '남성', '69 New Castle Parkway', '193-636-6608', 'pcage5a@rambler.ru', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('obranscombe5b', 'SYLhHL4W7P4', 'Obed', '2003-09-28', '남성', '450 Hallows Park', '913-123-2677', 'ogreep5b@ebay.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ktripney5c', 'b45y51U', 'Kelley', '1997-05-14', '여성', '21 Erie Alley', '607-122-4009', 'kgiffen5c@rakuten.co.jp', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('zhembrow5d', '0vXiaQydk', 'Zach', '2007-01-12', '남성', '066 Kedzie Pass', '403-917-9919', 'zmurtell5d@cdc.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecraythorne5e', 'b21wVJzgUc', 'Evelyn', '2009-09-17', '여성', '448 Pond Alley', '517-606-2963', 'eleupold5e@techcrunch.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ssaiger5f', 'fTa2y5D', 'Shanan', '2013-11-25', '남성', '68555 Oak Valley Junction', '707-739-5854', 'sollivier5f@domainmarket.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sstenyng5g', 'Z1PnkUj4bN', 'Sibel', '2013-06-23', '여성', '50 Village Avenue', '246-240-0388', 'spolk5g@1688.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jsmallacombe5h', 'bIN9ek5m9az', 'Jake', '2006-02-07', '남성', '3076 Heath Way', '902-579-1421', 'jsteer5h@opera.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bhaydon5i', '9XGWOZtYL', 'Birk', '2003-03-21', '남성', '3816 Sunnyside Terrace', '347-167-8643', 'bohartnedy5i@theglobeandmail.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gbritto5j', '2STz38W1ysm', 'Giustino', '2007-06-25', '남성', '51 Trailsway Hill', '575-397-3301', 'ggodden5j@etsy.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pfer5k', 'DBk4Uuy', 'Padraig', '2010-08-12', '남성', '62131 Rigney Parkway', '109-566-0151', 'pgiraudoux5k@mit.edu', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csavill5l', 'Qc0tVb', 'Cherilyn', '1992-09-09', '여성', '07267 Loomis Trail', '742-435-7957', 'cpapa5l@smh.com.au', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gpinkard5m', 'NNUNIN', 'Gizela', '2009-08-04', '여성', '8582 Truax Circle', '428-546-3372', 'ghighwood5m@slideshare.net', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pflook5n', 'aZmFngbUc', 'Prisca', '2014-08-06', '여성', '863 Petterle Pass', '596-972-2306', 'pmaccallester5n@delicious.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acragg5o', 'hM5YNkyZvH0', 'Arleyne', '2005-12-23', '여성', '9707 Ridge Oak Pass', '566-679-3904', 'amacaleese5o@geocities.jp', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ptwiddy5p', 'glAgLYofS6Pt', 'Peyton', '2012-05-01', '남성', '8 Monica Crossing', '638-469-2567', 'pruddlesden5p@rambler.ru', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hlongmire5q', 'gT7Z6on7Fm3', 'Hanson', '2007-07-03', '남성', '047 Main Alley', '844-747-0550', 'hwallentin5q@imdb.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('djesson5r', 'mUttEhGQMuM', 'Dalli', '1993-08-25', '남성', '5261 Randy Way', '154-120-7810', 'dtoke5r@mit.edu', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sstockney5s', '1d1SDhP', 'Skell', '2017-03-27', '남성', '8028 Pine View Way', '157-670-8460', 'sovington5s@wordpress.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccoll5t', 'ptgriduyat', 'Curr', '2001-01-03', '남성', '39913 Redwing Road', '378-696-3820', 'crogge5t@who.int', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('awallsworth5u', 'l80ixmRAW0', 'Avrit', '2010-04-19', '여성', '2147 Katie Park', '893-702-0875', 'abunney5u@omniture.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sdonald5v', 'oWFvnmf', 'Shara', '1991-08-04', '여성', '18 Bobwhite Terrace', '689-498-7772', 'schatt5v@economist.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tchazelas5w', 'MZxjFd9', 'Travers', '1998-11-22', '남성', '89 Sugar Parkway', '512-107-9013', 'thousbie5w@parallels.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sfidge5x', 'smVN63', 'Sharona', '2012-08-22', '여성', '7 Westend Circle', '488-107-2707', 'sgerraty5x@linkedin.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jharmant5y', 'xni46aNd4kF', 'Jessika', '2020-12-25', '여성', '91 Vahlen Road', '275-229-3246', 'jgonzalvo5y@wordpress.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jklageman5z', 'YK2XWO', 'Jo', '2002-08-14', '남성', '3507 Messerschmidt Avenue', '832-357-3091', 'jhatfield5z@cnn.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sbromby60', 'wLNnNJI', 'Sile', '2001-12-28', '여성', '1 Carey Point', '778-847-5919', 'strumper60@un.org', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vdobby61', 'ccwLGiv', 'Vilma', '2003-10-09', '여성', '705 Sheridan Plaza', '417-691-9652', 'vsevier61@newyorker.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fbalk62', '2PdzOPD', 'Francyne', '1992-12-25', '여성', '78 Melrose Way', '799-827-2426', 'fconneely62@arstechnica.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mhuchot63', 'DDc4Z97w', 'Maynard', '2008-06-19', '남성', '29 Portage Drive', '207-301-5763', 'mloveless63@ftc.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('avanshin64', '7veNQHCCvH', 'Andris', '2004-10-20', '남성', '70 Browning Junction', '223-136-0025', 'ahallgalley64@nsw.gov.au', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sspurnier65', 'lMREbYc5EJF', 'Sigismund', '1993-12-30', '남성', '7 Mosinee Lane', '790-393-6598', 'ssturley65@sitemeter.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lchidlow66', 'ZmVxQrea', 'Lionel', '2020-02-10', '남성', '4984 Old Gate Avenue', '262-277-2343', 'lghidotti66@diigo.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('akief67', '3aAZQFsAd6A', 'Augy', '2011-05-10', '남성', '3 Barnett Way', '152-946-3001', 'asargerson67@amazon.co.uk', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bmayhew68', 'hoNdTJQVXVD', 'Betsy', '2004-11-23', '여성', '94 Jenifer Alley', '820-812-8735', 'btythe68@youtu.be', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('atopper69', 'WsuT8RPF', 'Aaron', '1995-10-01', '남성', '0 Sutteridge Parkway', '770-894-6993', 'atupie69@cargocollective.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mdarville6a', 'ZW53vJRJX', 'Mendy', '1992-06-25', '남성', '542 Thierer Park', '595-874-9050', 'mkloster6a@xinhuanet.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ssworn6b', 'aTvY9O', 'Sigismondo', '2001-04-09', '남성', '40 Lillian Point', '792-821-3077', 'scracoe6b@example.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bsherington6c', '4lMuz95j', 'Bobinette', '2017-10-02', '여성', '73 Cambridge Way', '441-395-0366', 'blochrie6c@flickr.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bgerty6d', 'oijNqI', 'Brina', '2011-08-28', '여성', '876 Stone Corner Crossing', '486-374-2179', 'bbernade6d@about.me', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rkingswoode6e', 'AwfheOU', 'Rorke', '1995-12-19', '남성', '95 Colorado Way', '204-726-1599', 'rramsden6e@shareasale.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecurnnokk6f', 'tY8LTB', 'Elbert', '1995-06-07', '남성', '4 Vahlen Center', '984-429-3920', 'eeydel6f@google.it', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lurling6g', '0k8G9d24fPJ', 'Leann', '2018-08-10', '여성', '4159 Susan Parkway', '218-843-5836', 'lmacconaghy6g@photobucket.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lfeye6h', 'JIp87qgt', 'Lesley', '2015-04-27', '남성', '3630 Farwell Alley', '432-845-9309', 'lwhanstall6h@yolasite.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cughelli6i', 'C8jzYdrfrvX0', 'Curcio', '2000-07-10', '남성', '6 Maple Alley', '633-118-3382', 'cackland6i@bing.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acrosfield6j', 'tDFk26', 'Aleksandr', '2013-09-15', '남성', '811 Londonderry Plaza', '405-567-7141', 'amaccleod6j@github.io', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amacvay6k', '7kJWNPEk', 'Amelia', '2007-04-03', '여성', '6486 Sugar Alley', '141-789-8560', 'ahurche6k@spotify.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tpaget6l', 'yi83hq8uCWzE', 'Torrence', '1996-09-12', '남성', '0616 Columbus Junction', '806-474-5338', 'thellwing6l@issuu.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdaubney6m', 'kMEChNoM0nk0', 'Caitrin', '1994-05-31', '여성', '94755 Leroy Hill', '269-747-2027', 'ctabbitt6m@networkadvertising.org', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ddedam6n', 'hX1OOLbP', 'Donnell', '1995-01-05', '남성', '30690 Redwing Point', '307-565-3671', 'drhyme6n@huffingtonpost.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fsumers6o', 'QCnrYlCMds6m', 'Fidelity', '2019-11-25', '여성', '687 Anzinger Crossing', '959-247-3770', 'fhowford6o@woothemes.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lmulchrone6p', '5SMqN6B', 'Lynda', '1996-03-15', '여성', '386 Kipling Road', '274-193-6098', 'lmedeway6p@alexa.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aegell6q', 'oKX0z3X2tj7', 'Alexa', '2013-02-07', '여성', '30 Little Fleur Road', '484-455-2457', 'apasby6q@goo.gl', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ewinear6r', 'yiZQlnPF', 'Elijah', '2012-10-04', '남성', '7 Eagan Crossing', '826-341-4622', 'efryett6r@theguardian.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tthurlow6s', 'NDcOqBC', 'Tarra', '2021-11-23', '여성', '9225 Gale Lane', '942-186-6444', 'tchatband6s@adobe.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gevangelinos6t', 'gZP1H4q68Rwl', 'Garrott', '2022-03-09', '남성', '1 Anzinger Terrace', '616-634-9303', 'gkevane6t@arizona.edu', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fkleinsmuntz6u', 'vtvYFdzEwScW', 'Fay', '2010-04-21', '여성', '8 Lakeland Place', '971-358-6025', 'fhadwen6u@issuu.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pbardell6v', 'hijsYC187ve', 'Pavel', '1996-03-16', '남성', '21706 Farwell Terrace', '968-382-9395', 'pslorance6v@mapquest.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('glavelle6w', 'jUKuAbbVFtWa', 'Georgianna', '1995-11-17', '여성', '45 Bluejay Lane', '540-202-3114', 'gfominov6w@posterous.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kpointon6x', 'Y24HIMKdsN', 'Katine', '2021-03-25', '여성', '88 Warner Avenue', '496-240-3814', 'kpreddle6x@slashdot.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tcarse6y', 'p1iJP8', 'Tatum', '1991-10-21', '여성', '97597 Fisk Hill', '987-581-4897', 'thessenthaler6y@bloglovin.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mpetracco6z', 'SHvVhnNjpMyc', 'Marlena', '1993-07-15', '여성', '8 Redwing Street', '626-462-0130', 'mspringthorp6z@cnbc.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('doloman70', 'n8nVAr', 'Dyann', '2017-01-03', '여성', '9 Ronald Regan Drive', '500-624-7563', 'dalabastar70@usgs.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rbratchell71', 'MD0yEcqzelRU', 'Rayner', '2017-03-09', '남성', '7621 Mayer Center', '410-745-3970', 'rblampy71@earthlink.net', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fphelan72', 'AEixHjLX', 'Forbes', '2020-06-13', '남성', '97081 Northfield Terrace', '127-196-1870', 'fblakey72@icio.us', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbasnall73', 'QhgR8NwWUWi', 'Birdie', '2017-11-21', '여성', '5294 Portage Street', '278-463-0084', 'borigin73@stanford.edu', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bcullity74', 'PgdHLudls', 'Brandais', '2002-01-31', '여성', '53415 Roxbury Center', '622-969-4061', 'bvanderlinde74@usatoday.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kgrigs75', 'Ab0F4PU', 'Kasper', '2021-11-21', '남성', '23929 8th Alley', '845-387-0371', 'kassad75@w3.org', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dpfertner76', 'YIwYgzYsE', 'Doroteya', '1993-09-23', '여성', '3129 Moulton Parkway', '804-356-5417', 'dsmullin76@abc.net.au', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('elabbey77', '5ZZuSaY2GX', 'Essie', '1993-11-26', '여성', '0881 Melody Way', '517-798-6541', 'ehoofe77@mediafire.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cbohlin78', 'Shc3NdEJqC', 'Christian', '2005-08-15', '여성', '66056 Prairie Rose Center', '339-991-3658', 'cgoaley78@smh.com.au', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tlangan79', 'hetAA6IZLuUF', 'Tilly', '2003-12-12', '여성', '7559 Mifflin Court', '762-572-6341', 'tpurveys79@odnoklassniki.ru', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('abrideau7a', 'B3NvcbXK', 'Alysia', '2008-02-07', '여성', '80 Green Center', '875-914-2649', 'aetherington7a@msn.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lwild7b', 'QShPTWhyUEv6', 'Lesya', '2004-01-24', '여성', '6 Hintze Junction', '105-669-8355', 'lscanderet7b@wp.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ebackman7c', 'cQp9z8kpWYVO', 'Eugine', '2009-04-22', '여성', '32 Springs Junction', '343-186-3764', 'emaccorkell7c@sun.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hsambath7d', '8eD1xZF', 'Hilliard', '2017-05-13', '남성', '2 Sutteridge Lane', '103-446-4242', 'hhubane7d@comcast.net', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ajolliff7e', 'CzQcmYNSR', 'Alene', '1998-08-02', '여성', '3617 Claremont Lane', '678-356-6697', 'areadwin7e@alexa.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wmoulton7f', '7xsHywKW', 'Winfred', '1999-01-30', '남성', '3865 Commercial Court', '536-471-7174', 'wflorentine7f@twitter.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mgribbin7g', 'cTemzarEC9q', 'Melantha', '2006-05-15', '여성', '99 Monterey Pass', '888-224-5866', 'mfandrey7g@skype.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dmapplethorpe7h', 'NqmZXKEW', 'Deonne', '1998-02-22', '여성', '53 Saint Paul Alley', '344-663-0907', 'djime7h@sogou.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acorbould7i', 'QYHLfrwyfBO', 'Aretha', '2004-02-17', '여성', '8563 Delladonna Pass', '954-971-4930', 'ahartop7i@bloomberg.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('omaudlin7j', 'fEBUgfcGTTE', 'Orland', '1999-12-09', '남성', '01 Evergreen Alley', '367-285-5718', 'oturbitt7j@reference.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rromanetti7k', 'PXp8jn1ILZCE', 'Romonda', '1992-11-05', '여성', '39414 Jenna Crossing', '672-513-3437', 'rgolt7k@yandex.ru', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wlindblom7l', 'HhSZrsk9l0lc', 'Waylon', '2022-03-08', '남성', '94 Northridge Road', '760-538-9465', 'wnormadell7l@hc360.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('epressman7m', '86N1aG', 'Edwin', '2018-08-29', '남성', '06 Arizona Crossing', '592-968-3623', 'edehaven7m@theglobeandmail.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mharriman7n', 'yXjFWy', 'Myer', '2021-04-26', '남성', '85 Hansons Drive', '881-894-4632', 'mpettet7n@printfriendly.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mhandrick7o', 'yaSCfEtZ', 'Marie-ann', '2001-01-16', '여성', '0 Almo Street', '524-564-9942', 'measman7o@shutterfly.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aschneidar7p', '6E1DQd0FOxS', 'Anestassia', '1993-03-03', '여성', '5 Green Trail', '474-178-3312', 'astracey7p@prlog.org', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kpaudin7q', '1dqON467nhA', 'Kelcy', '2001-03-22', '여성', '49514 Ridge Oak Way', '508-428-3832', 'kgrzelczyk7q@hexun.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('xmcjury7r', 'hcIXTr', 'Xylia', '2004-07-10', '여성', '61345 Duke Road', '170-804-3001', 'xmoehler7r@hhs.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecastle7s', 'SXdPDKBXx', 'Egor', '2015-01-15', '남성', '549 Muir Parkway', '407-177-5879', 'edalgliesh7s@fastcompany.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gmunnings7t', 'oVNxqqdq', 'Gaelan', '1999-10-28', '남성', '05097 Gateway Circle', '961-963-3561', 'gmacelane7t@omniture.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mstanning7u', '2oyyB7OF', 'Micki', '2010-02-20', '여성', '0073 Monterey Park', '901-673-1184', 'mkettel7u@utexas.edu', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cscurr7v', 'k80BSb', 'Claudianus', '2009-03-24', '남성', '500 East Drive', '900-210-9266', 'cmaplestone7v@google.com.au', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acroom7w', 'vc664wFQ', 'Angus', '1993-05-22', '남성', '7 Pleasure Plaza', '559-678-8907', 'avittori7w@cdc.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pcastles7x', 'fA6Ppzk7L421', 'Palmer', '1990-09-21', '남성', '41 Eagan Trail', '774-403-1676', 'pepple7x@house.gov', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('radkins7y', '6s81xAe', 'Rosabelle', '1992-10-15', '여성', '949 Sullivan Terrace', '109-654-5536', 'riczokvitz7y@globo.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jblowers7z', '40tSoM', 'Joly', '2003-01-06', '여성', '141 Dahle Parkway', '470-470-1291', 'jodlin7z@dmoz.org', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hdance80', 'qqBaNhLItNQC', 'Henrik', '2009-10-07', '남성', '9 Lerdahl Circle', '196-695-2187', 'hivatt80@census.gov', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecraft81', 'DEo6TY4', 'Elsey', '2011-09-17', '여성', '958 6th Junction', '666-975-9270', 'elazarus81@theatlantic.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gsilverston82', 'ehy1gx2YL', 'Gonzales', '2012-10-07', '남성', '9801 Clyde Gallagher Junction', '441-222-1195', 'gkmieciak82@quantcast.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rconyer83', 'vqbe20zCDn8R', 'Rina', '2010-04-01', '여성', '6038 Milwaukee Park', '470-347-1406', 'rbossel83@narod.ru', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('afaunt84', 'OSbftDwk', 'Alicia', '1995-02-02', '여성', '25870 Forest Place', '105-678-0132', 'amcfie84@salon.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jsleite85', '35fS8Mz', 'Jae', '1990-10-25', '남성', '39 Prairie Rose Park', '441-632-1811', 'jjoron85@posterous.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fackermann86', 'h9tVyj', 'Ferris', '1993-03-01', '남성', '29 Green Pass', '770-184-0462', 'fgalton86@indiegogo.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('edello87', '1xFMCTRAo80d', 'Etheline', '2013-06-05', '여성', '1061 Brickson Park Parkway', '954-351-2648', 'espykings87@netscape.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cgehrels88', 'QjbnPJ', 'Christoffer', '2008-01-21', '남성', '9824 David Road', '745-365-7782', 'cbarbara88@msu.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wtrent89', 'ahriNVom', 'Wes', '2005-06-20', '남성', '746 Transport Junction', '799-679-7635', 'wtibb89@senate.gov', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('smoorcraft8a', 'qANZ1Hn', 'Sansone', '2008-11-03', '남성', '9 Hoard Parkway', '913-829-4484', 'sjelphs8a@ameblo.jp', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gmcclancy8b', 'LayHXcEoLm3', 'Gerianne', '2011-07-01', '여성', '5 Truax Crossing', '739-538-0620', 'gbacher8b@360.cn', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gpaffitt8c', 'veeZQf3K5', 'Gilbertina', '2008-07-08', '여성', '093 Birchwood Street', '222-499-9180', 'gridgway8c@psu.edu', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('chaldin8d', 'cmCuR10', 'Corey', '2010-03-24', '여성', '413 Schurz Crossing', '476-247-7474', 'croan8d@t.co', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jgofforth8e', 'Ic1WWpC7q', 'Josie', '1997-06-01', '여성', '0120 Dawn Place', '149-486-2917', 'jgooddy8e@alibaba.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cblackston8f', 'wtNSwugrG', 'Chlo', '1999-04-06', '여성', '45071 Larry Trail', '166-293-0042', 'cmayler8f@networksolutions.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('asainsbury8g', 'EsYDqsWiV8n', 'Anderea', '2011-04-04', '여성', '086 Morning Road', '822-742-3263', 'aupsale8g@sogou.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('esandy8h', 'opezUd', 'Ermina', '2004-03-25', '여성', '09271 Dapin Court', '656-668-9722', 'escathard8h@simplemachines.org', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acrickett8i', 'JdOI7T1Nr', 'Avram', '1995-08-27', '남성', '91906 Texas Court', '700-827-6065', 'amersh8i@nsw.gov.au', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vdalesio8j', 'V1F587KRagp', 'Vanny', '1997-08-28', '여성', '0104 Fairview Plaza', '159-536-8645', 'vrappaport8j@zimbio.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lkeyme8k', 'JxBD4eaeYY', 'Lee', '1997-07-03', '남성', '2 Red Cloud Parkway', '287-151-7364', 'lgarnsworthy8k@soundcloud.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tferraresi8l', 'BYeoo3MJ', 'Terrie', '2007-04-07', '여성', '45965 Grim Avenue', '195-705-5775', 'thastwell8l@hibu.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlindeboom8m', 'F89b339W', 'Maryellen', '2010-10-09', '여성', '0 Burrows Lane', '232-250-3179', 'mceschini8m@hostgator.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hchaudhry8n', 'ayBb8hUe5', 'Hadlee', '2020-10-27', '남성', '6 Hermina Center', '157-985-4304', 'hhaward8n@seattletimes.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('eboichat8o', '1nWfmVS', 'Elvera', '1998-02-07', '여성', '0413 Lakeland Parkway', '687-292-0300', 'eoverland8o@360.cn', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fniset8p', 'rr6jRa7V978', 'Franzen', '2014-06-26', '남성', '24165 Sage Circle', '778-371-7904', 'fheninghem8p@homestead.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pjeandot8q', 'TLUPeQ6LuQ', 'Price', '2002-05-23', '남성', '861 Duke Street', '974-409-1209', 'pclementucci8q@hexun.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pkilmurry8r', 'bFSJVgH', 'Pansie', '2014-03-09', '여성', '487 Ridgeway Park', '911-287-2439', 'pnathon8r@cloudflare.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mhammant8s', 'Lh2YzMuddI', 'Micheline', '1998-08-21', '여성', '563 Prairie Rose Plaza', '919-816-9118', 'mchastaing8s@wordpress.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tcasperri8t', 'V6jkyZGw', 'Tarrance', '2016-01-08', '남성', '0 School Park', '995-723-1715', 'tdimitrie8t@shareasale.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dneville8u', 'crxomdI', 'Donny', '1993-10-16', '남성', '405 Lukken Trail', '871-494-1184', 'dwinsor8u@google.com.hk', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hcantera8v', 'z3D83hdG', 'Hinze', '2017-07-04', '남성', '3 Barnett Terrace', '582-125-3475', 'hgurnell8v@va.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ldanielot8w', 'YamyjS2o6M8V', 'Lynnea', '1998-02-17', '여성', '1124 Hudson Center', '504-847-2996', 'lgoodred8w@alexa.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aruselin8x', 'C07dYT', 'Arlyn', '2022-04-08', '여성', '00713 Crest Line Road', '728-844-7217', 'ahumpherston8x@fastcompany.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wmonument8y', '9GnDcLCoIZK', 'Willow', '2020-05-09', '여성', '414 Pepper Wood Pass', '773-413-8939', 'wmatieu8y@tinyurl.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kamey8z', 'o2OvSbMtbVbY', 'Keriann', '1990-11-08', '여성', '65466 Park Meadow Crossing', '358-768-2687', 'kbowlands8z@fda.gov', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aserridge90', 'sXWyTBdIN', 'Anders', '2007-06-05', '남성', '9 Muir Trail', '630-314-0706', 'athouless90@woothemes.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mstork91', 'oTgnmkUs', 'Maighdiln', '2008-09-18', '여성', '196 Loeprich Way', '465-179-7516', 'mfleckness91@indiegogo.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lreedy92', 'ymFYSQSdR', 'Lorry', '2005-03-21', '남성', '00 Orin Court', '768-973-7504', 'lcockran92@ftc.gov', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rriseley93', 'FJ6v61coIT', 'Raynell', '2011-04-16', '여성', '9 Di Loreto Way', '990-142-9827', 'rjewis93@pcworld.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wholdall94', 'UBJUfALf', 'Westleigh', '2019-07-10', '남성', '44 Vera Hill', '197-393-3892', 'wdods94@goodreads.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jbullivant95', '75Zr2RFrjbWk', 'Jodi', '1999-09-16', '남성', '49 Dryden Terrace', '912-297-9346', 'jdreng95@hhs.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gstiegars96', 'yoGMgh11630R', 'Gregorio', '2000-03-23', '남성', '9728 Weeping Birch Street', '113-461-8730', 'gschade96@com.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mcoping97', 'ymgaN0W4D', 'Marcelline', '2004-09-13', '여성', '747 Old Shore Street', '385-302-3963', 'mwhiteway97@pagesperso-orange.fr', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dreavell98', 'nw6eOun5', 'Delmer', '2008-05-08', '남성', '2 Rusk Terrace', '514-903-0280', 'dkinavan98@nhs.uk', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lsivell99', 'sEwYdSU', 'Lynne', '2006-03-21', '여성', '70073 Montana Place', '743-989-8547', 'lwrightham99@miitbeian.gov.cn', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('eweddeburnscrimgeour9a', 'nvmPe88Vb2', 'Eal', '1993-06-03', '남성', '06 Merry Point', '417-500-6373', 'elukehurst9a@bing.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcuerdale9b', 'n4qYYBSl14', 'Roth', '1998-03-26', '남성', '02044 Delladonna Pass', '580-623-4353', 'rirving9b@sina.com.cn', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jcuddon9c', 'oS14eQaL', 'Jecho', '2003-11-06', '남성', '359 Comanche Street', '923-874-1641', 'jarnault9c@hibu.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bglasard9d', 'jgeD379CKuW', 'Beaufort', '2013-11-16', '남성', '67330 Crowley Avenue', '115-374-4726', 'bmccrum9d@virginia.edu', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dkinset9e', 'owYaMbkB', 'Dayle', '2015-09-14', '여성', '41 American Hill', '285-150-0220', 'dbraidman9e@linkedin.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hgovinlock9f', 'maz4fNhwMjy', 'Hobart', '2006-08-19', '남성', '191 Mariners Cove Junction', '413-612-3925', 'hmushet9f@digg.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('thurley9g', 'AINxKYER', 'Tully', '2008-02-17', '남성', '17 Valley Edge Place', '832-961-5488', 'tkovacs9g@princeton.edu', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbresnahan9h', 'lGoAuW', 'Bink', '1994-07-31', '남성', '08061 Twin Pines Pass', '556-692-6437', 'bbench9h@ameblo.jp', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rpile9i', '1pVaP7E', 'Rafaelita', '1997-08-04', '여성', '08321 Scott Court', '311-583-0510', 'rdegiovanni9i@uiuc.edu', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dlapping9j', 'WuDjMq8y3', 'Dede', '2018-03-01', '여성', '8322 Golf Circle', '120-390-1314', 'dtimmes9j@de.vu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('emacmickan9k', 'KOfwHcn7v', 'Ethyl', '2014-05-10', '여성', '4 Crescent Oaks Way', '886-341-6328', 'ebarwick9k@unesco.org', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('egippes9l', 'VVnRYWMt4bLT', 'Ervin', '2012-07-18', '남성', '22665 Namekagon Avenue', '322-923-6939', 'ekacheler9l@indiegogo.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('stownby9m', 'LOyxDyA1', 'Shanna', '2018-02-23', '여성', '3 6th Avenue', '644-649-9727', 'smaccole9m@google.com.au', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gpflieger9n', '4FsBlPHvL', 'Gratia', '2013-12-29', '여성', '730 Florence Road', '729-531-6528', 'gouthwaite9n@amazon.de', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gmonshall9o', 'lLrr9xVS2', 'Gilburt', '2003-05-17', '남성', '40060 Twin Pines Road', '904-974-0535', 'gclemmett9o@acquirethisname.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kburker9p', 'eDeEKb', 'Kacie', '2015-05-08', '여성', '20 Oak Hill', '464-364-7099', 'kpavlenkov9p@webs.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mouslem9q', '06L440p6GiI3', 'Mariel', '2006-11-16', '여성', '81 Trailsway Hill', '651-132-7671', 'mcaldero9q@smugmug.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pfidele9r', 'gzvMb17tq8K', 'Pavel', '1992-06-01', '남성', '77 Upham Street', '747-589-1708', 'psiddell9r@icq.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdahlman9s', '1A6P0O6fEE6', 'Clarissa', '2010-11-21', '여성', '875 Burrows Court', '666-659-1909', 'cbigrigg9s@techcrunch.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dpresser9t', 'KXFPg2Lf14LY', 'Darleen', '2014-01-16', '여성', '25790 Northridge Lane', '834-751-7758', 'dcarlone9t@dot.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('brydings9u', 'tNIb4bz', 'Berty', '2002-03-08', '남성', '6306 Porter Plaza', '224-861-6373', 'bmilkins9u@plala.or.jp', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dricks9v', 'na59tAM6POAs', 'Davis', '2015-10-25', '남성', '7916 Clarendon Pass', '170-782-1065', 'dgheorghe9v@google.de', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lvannar9w', 'Hxih8HE0', 'Lloyd', '1999-03-12', '남성', '06254 Graceland Crossing', '101-573-5028', 'lcrumby9w@un.org', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('stine9x', 'FweS8hK3', 'Stacia', '2002-02-10', '여성', '7 Ridge Oak Road', '857-379-2559', 'sprophet9x@nba.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mcino9y', '6O9k11yL0T2', 'Maddalena', '2006-02-23', '여성', '6 Center Plaza', '809-185-4081', 'mrosenau9y@wsj.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hscown9z', 'Gmn2mTvW0', 'Haydon', '2003-02-28', '남성', '5 Coolidge Avenue', '309-493-1148', 'harkle9z@hugedomains.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lscorthornea0', 'q2fgTzYLk', 'Lyn', '1993-10-18', '여성', '6 Prairieview Plaza', '207-262-4520', 'lpaunsforda0@howstuffworks.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cstycha1', '0JTPhjpYoRj', 'Cynthia', '2018-10-27', '여성', '68737 Harper Way', '474-588-3384', 'cmorforda1@cnet.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ajakubowicza2', 'wt7j0h7N3G0g', 'Amory', '2002-06-02', '남성', '1425 Fairview Drive', '195-234-8556', 'aampsa2@china.com.cn', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csmethursta3', 'clfdI05I6KA', 'Ceciley', '1994-04-20', '여성', '1184 Bellgrove Hill', '832-359-5890', 'ccullivana3@google.it', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rtitleya4', '9CDvWM', 'Roxane', '2018-08-27', '여성', '6785 Crowley Road', '486-620-1919', 'rwilhelmya4@live.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hpetrica5', '3HHLfxybXBnv', 'Hermie', '1993-11-11', '남성', '7251 Cody Hill', '822-866-6366', 'hfeldsteina5@google.co.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aashleea6', 'rXLUaIytOPAX', 'Ansley', '2017-09-09', '여성', '2 Sommers Terrace', '907-244-0751', 'ashepperda6@wisc.edu', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hcutmarea7', 'zcNAuup7', 'Hoyt', '1999-04-08', '남성', '32 Hauk Drive', '500-729-3451', 'hpilsburya7@cpanel.net', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mtrevaskisa8', 'k1DRWal', 'Melli', '2007-05-11', '여성', '30926 Pawling Terrace', '603-307-1209', 'mshernocka8@networksolutions.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cshawa9', 'XGYqmWSUN9', 'Colas', '2001-02-17', '남성', '4691 Dexter Place', '917-208-0368', 'cgoodbana9@twitpic.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('odiesaa', 'khWRGtB', 'Odelle', '2002-12-21', '여성', '16152 Melvin Hill', '698-295-0865', 'oclemensenaa@icq.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mvernyab', 'jpE10Yyb9', 'Mona', '2021-01-14', '여성', '07 Mesta Place', '344-199-0918', 'mschopsab@ask.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dedlingac', 'RP9okvaelv', 'Dallas', '2018-07-21', '남성', '087 Portage Place', '536-848-1910', 'dbroaderac@flavors.me', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tkilbanad', 'aeNwybD', 'Tarra', '2003-11-18', '여성', '526 Colorado Point', '178-679-4807', 'ttrathenad@chicagotribune.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('llakeae', 'Pv1bIgh', 'Lavina', '1990-08-01', '여성', '3 Weeping Birch Circle', '198-706-7616', 'lbartlomiejae@wunderground.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kmaskallaf', 'SbFcKuFn5e', 'Kalie', '2015-02-18', '여성', '3 Springs Alley', '168-572-2595', 'kcluittaf@opera.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mclemettsag', 'WGhhvpfiJ', 'Maureen', '2014-11-14', '여성', '58429 Judy Trail', '962-393-6696', 'mabdenag@slashdot.org', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fcoppenah', 'odGpW09fkLR', 'Frants', '2011-10-26', '남성', '13266 Cardinal Street', '873-956-7999', 'fvassarah@techcrunch.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amaturaai', 'x2Tdf9W2', 'Angela', '1999-07-19', '여성', '076 Ilene Pass', '784-422-5179', 'ahugganai@ox.ac.uk', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('khinscheaj', '1gH8mAvz1bO', 'Korrie', '1998-07-28', '여성', '87196 Morningstar Pass', '959-398-4611', 'kswaloweaj@diigo.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fpowrieak', 'ndtyOqy414', 'Fraser', '2016-12-01', '남성', '79 Blue Bill Park Parkway', '693-146-5314', 'fdemcikak@cnn.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmillbankal', 'QaxxjQHD', 'Jacky', '2017-10-28', '남성', '82 Grasskamp Court', '609-899-9936', 'jmansoural@t-online.de', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bpiggfordam', 'ogbuUU', 'Banky', '2022-05-10', '남성', '1 Loftsgordon Road', '155-537-7609', 'bserginsonam@hostgator.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('noleszcukan', 'lUyZSVxaIh', 'Nevil', '2022-06-18', '남성', '260 Dexter Center', '696-252-2488', 'nkaasmannan@themeforest.net', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ldenmeadao', 'BCrSc5V', 'Legra', '1999-09-14', '여성', '4 Eggendart Terrace', '415-565-3283', 'larkwrightao@mapquest.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amcclenanap', 'X3yIR6QvXck', 'Aime', '1998-07-21', '여성', '8 Sunfield Center', '854-686-4833', 'acompstonap@answers.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pyakuntzovaq', 'BwVDKUduF', 'Puff', '2017-03-26', '남성', '92562 Merry Pass', '847-632-6587', 'ptompkissaq@ning.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tarbonar', '1K5muB4NJk', 'Torin', '2005-05-14', '남성', '651 Moose Way', '924-791-7160', 'tlimbertar@hugedomains.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tilyuninas', 'GVZ6ISJl', 'Tova', '2013-09-06', '여성', '1 Melody Road', '815-903-9993', 'tjohanchonas@w3.org', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ftattersfieldat', 'oMFQRN85RG', 'Fawne', '2020-01-17', '여성', '7958 Beilfuss Road', '368-150-7224', 'fgrimat@hud.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mrogeonau', 'hkHbCig', 'Malory', '2018-03-13', '여성', '994 Barby Drive', '533-467-9910', 'mfibbingsau@google.es', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nalmanav', 'PFol3wDS9p5r', 'Nonna', '1998-09-27', '여성', '2219 Pepper Wood Crossing', '113-550-1920', 'nbessentav@over-blog.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vmaccolganaw', 'SkbE8810Ckrp', 'Vergil', '1990-12-09', '남성', '34 Scoville Drive', '773-383-1317', 'vgoacheraw@indiegogo.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gstonefewingsax', 'lrbbl2a1zSL', 'Griswold', '1992-12-18', '남성', '1558 John Wall Alley', '871-385-1304', 'gedesonax@ovh.net', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lmebiusay', 'cOzJQFl', 'Laurie', '1992-03-19', '여성', '812 Springview Pass', '607-998-9451', 'lwycheay@miitbeian.gov.cn', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ahamneraz', 'HTbKdlPfheVt', 'Adriano', '2023-02-01', '남성', '49 Straubel Park', '739-513-8317', 'apersickeaz@wiley.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hsynnottb0', 'vNgiC5xnah', 'Hank', '2020-12-18', '남성', '351 High Crossing Alley', '511-891-5311', 'hmuntb0@sogou.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mnewhamb1', 'NJm2qD', 'Marijn', '1999-05-05', '남성', '6 Harbort Crossing', '229-837-8186', 'mgledeb1@phoca.cz', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cscannellb2', 'vDXnyA', 'Corilla', '1992-02-28', '여성', '6 Kipling Alley', '683-142-0570', 'cgoobleb2@chicagotribune.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hsokellb3', 'TFguXUgx', 'Hill', '2012-04-29', '남성', '8 Sloan Court', '588-118-5180', 'hrylandb3@youku.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sbarshamb4', 'OL5ai4T7E', 'Stefan', '2021-06-28', '남성', '77579 Autumn Leaf Pass', '726-427-7023', 'smonkhouseb4@feedburner.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('htrunkfieldb5', 'dYdxa13S', 'Hamlin', '2001-01-09', '남성', '5018 Evergreen Parkway', '127-790-8316', 'hpaolob5@zimbio.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hgaymerb6', 'N5w4PzLSD', 'Herbert', '1991-10-11', '남성', '3 Sundown Court', '955-799-1860', 'hferrollib6@weibo.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cblackshawb7', 'pkIuF7TdUOC8', 'Cornelius', '2010-01-01', '남성', '286 Garrison Avenue', '789-398-1475', 'cstancerb7@nymag.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kaddingtonb8', 'pdgCU47feu', 'Kent', '1995-07-29', '남성', '3733 Morningstar Avenue', '241-617-9646', 'kmoyceb8@cyberchimps.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hlamzedb9', 'jsgkN3lTwrM', 'Harbert', '2010-01-20', '남성', '3 Schiller Circle', '986-243-8238', 'hcoxheadb9@earthlink.net', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kroullierba', 'VytyRPgmYYu', 'Keen', '2012-11-27', '남성', '0 Clemons Street', '417-665-0926', 'kshowtba@paypal.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tohowbanebb', 'tTHJmGGQO7JA', 'Tammie', '2004-02-21', '여성', '5 Menomonie Parkway', '211-364-6804', 'tpercifullbb@microsoft.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jplunketbc', '5vQJxz', 'Jemie', '2011-11-02', '여성', '0 Montana Street', '495-399-7056', 'jspeachleybc@cnet.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bskrinesbd', 'OeIvAoPDKUk', 'Bevan', '2002-11-01', '남성', '94 Becker Park', '142-242-6312', 'bkorfbd@senate.gov', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hledrunbe', 'VXCFO9f1pYB', 'Hasty', '2002-02-03', '남성', '5031 Main Parkway', '678-176-7042', 'hbrundlebe@google.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vvandersonbf', 'oocfU4x3', 'Vale', '2006-09-10', '여성', '20274 Bunting Parkway', '146-288-4312', 'vmillmoebf@g.co', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('atomaszbg', 'SCXRl4F', 'Alasteir', '2017-01-27', '남성', '286 Cordelia Place', '635-359-9660', 'abuesnelbg@meetup.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wduckerbh', 'vJHEpGBB', 'Waiter', '2007-10-18', '남성', '11 Porter Junction', '842-526-3419', 'wdringbh@engadget.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jthewlessbi', 'wBICa34lxC', 'Javier', '1990-12-09', '남성', '13372 Killdeer Terrace', '303-213-2015', 'jkitleebi@thetimes.co.uk', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aoshevlanbj', 'FWX1EAd', 'Ashlan', '2002-09-06', '여성', '62908 Del Mar Avenue', '737-538-6862', 'ahowlebj@forbes.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('svoletbk', '4RUDLIUJrO4', 'Sandi', '1996-02-11', '여성', '61 Londonderry Alley', '402-175-2557', 'smahabk@sakura.ne.jp', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fdannebl', 'Xhx5EXbvuhN', 'Fritz', '2001-10-12', '남성', '97 Village Pass', '132-408-9051', 'fodbybl@elegantthemes.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rlunkbm', 'pHUsbtXOA', 'Reyna', '2011-01-09', '여성', '5958 Hanson Road', '547-819-0433', 'rkempsonbm@guardian.co.uk', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bwallerbridgebn', 'CpClO7MKFtUk', 'Braden', '1994-12-29', '남성', '04 Roxbury Center', '450-215-5980', 'bmatschukbn@google.ca', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdadsonbo', '11l8Ozq', 'Codie', '2004-11-27', '여성', '029 Bobwhite Avenue', '755-582-8057', 'csandhillbo@ted.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('etomesbp', 'TSKJDJ5u', 'Evy', '1995-03-23', '여성', '72 Killdeer Lane', '868-328-7488', 'ecornboroughbp@toplist.cz', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecostockbq', 'RGsflbvaM', 'Etheline', '2018-03-17', '여성', '7810 Hoepker Hill', '473-277-3292', 'edessaurbq@freewebs.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mpetrazzibr', 'kCVOwUIoq', 'Mylo', '1996-11-15', '남성', '2 Ridge Oak Alley', '885-516-5538', 'mtaddbr@unesco.org', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bwillesonbs', 'NyYZoZwO42HD', 'Beth', '2016-03-20', '여성', '58 Nevada Drive', '942-797-9179', 'bandriolettibs@bluehost.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lcindereybt', 'TgrX2xeaWnhs', 'Lindie', '1997-08-08', '여성', '8 Petterle Parkway', '336-978-4724', 'lmiskenbt@printfriendly.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('abladderbu', 'ppTW4R', 'Aldridge', '1996-11-16', '남성', '13539 Vidon Hill', '961-823-9982', 'abuglerbu@msu.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('efollisbv', 'o1UXGBOOz', 'Eberhard', '2004-09-13', '남성', '69 Myrtle Avenue', '823-191-3400', 'escrancherbv@columbia.edu', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('atregidgobw', 'sluBSEQFsC2j', 'Andriette', '2009-04-14', '여성', '511 Crownhardt Center', '956-823-6660', 'aspinellobw@blinklist.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wmayhoubx', 'DvT4ImgJD', 'Willem', '2018-06-03', '남성', '56 Fulton Junction', '374-401-9208', 'wcardenosabx@alibaba.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmcgillicuddyby', 'l3IVxN', 'Jenny', '2018-12-14', '여성', '5 Hintze Plaza', '451-777-9132', 'jbenechby@g.co', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rsmailebz', 'l3k10fWrF8wp', 'Rockwell', '1996-11-04', '남성', '57 Prairie Rose Alley', '867-410-5553', 'rlampettbz@mac.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ddemangec0', 'uQzQ7T', 'Dacy', '1992-04-28', '여성', '15260 Garrison Lane', '404-264-3334', 'dkilmurryc0@ibm.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bpallyc1', 'w62Rdcj', 'Bethina', '1996-11-08', '여성', '5065 Fallview Plaza', '655-208-0155', 'bmorec1@epa.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cfreezorc2', 'oF9LlLthJrc', 'Cynthia', '2019-06-23', '여성', '1286 Porter Circle', '342-558-6066', 'clanktreec2@kickstarter.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dskippenc3', 'SaDDb3AILO', 'Dorelia', '2012-04-01', '여성', '43243 La Follette Junction', '752-497-3396', 'dhendinc3@zimbio.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('achristescuc4', 'Hx6TDsWxuvF', 'Amye', '2007-04-09', '여성', '81078 Red Cloud Plaza', '236-639-1841', 'adarycottc4@china.com.cn', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbaxterc5', 'ZpjiSbwl', 'Brandy', '2020-01-09', '남성', '185 Summerview Parkway', '877-283-8541', 'bdomaschkec5@dot.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rblackbournc6', 'WIvwBOidj', 'Rickie', '2011-11-27', '남성', '834 Mendota Crossing', '588-843-9720', 'rsoutherdenc6@ucoz.ru', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jtravissc7', 'xrFrhRyL', 'Jonell', '1994-01-24', '여성', '147 Merchant Parkway', '266-326-4329', 'jdoughertyc7@wordpress.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bleythleyc8', 'sXst91KdkoZx', 'Barbara', '2020-11-06', '여성', '67742 Grim Drive', '988-251-1654', 'bderingtonc8@desdev.cn', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('morchartc9', 'fSntJkizBD', 'Maxy', '2012-03-18', '남성', '03262 Kinsman Plaza', '310-538-0765', 'mwonforc9@sogou.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mkellieca', 'B6RGKs', 'Melisent', '2002-11-03', '여성', '54 Beilfuss Parkway', '632-544-6042', 'mcastendaca@prlog.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rfrangletoncb', 'Ibylpf520GRi', 'Rikki', '2007-10-01', '남성', '6567 Anthes Trail', '816-369-8315', 'rwinterbottomcb@google.com.br', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ibrabhamcc', 'SA8ZEQBV3', 'Ignacio', '1991-05-13', '남성', '49 Golf Circle', '658-438-5199', 'ibeethamcc@gmpg.org', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kdunkerkcd', 'Fu7Zus', 'Kiri', '1992-07-01', '여성', '43981 Ridgeview Road', '281-638-5418', 'kcarlillcd@constantcontact.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pbarbierce', 'NyTtJLWZBXI', 'Pia', '1998-05-16', '여성', '434 Ilene Lane', '713-355-2751', 'playcockce@sbwire.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ldaughertycf', 'A2hxufuMtg', 'Lynette', '2014-07-25', '여성', '778 Sunbrook Terrace', '371-328-3474', 'lpiersecf@hibu.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ubrodeurcg', 'ogO6Diw2ao', 'Ursula', '2019-05-31', '여성', '5332 Oxford Junction', '670-647-9014', 'ubendellcg@redcross.org', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('blightench', 'fpDVEZJ', 'Brittney', '2002-02-19', '여성', '855 Hintze Parkway', '389-277-7134', 'broncich@arstechnica.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bskeechci', 'sCOb6wt', 'Benjie', '2010-04-06', '남성', '6 Alpine Point', '513-247-5846', 'bthunnercliffci@vimeo.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('agierhardcj', '9myTgkKv', 'Artair', '1992-02-19', '남성', '9811 Mallory Hill', '943-920-2685', 'aseedcj@bravesites.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jlintotck', 'klsvNYmPh4', 'Jerrine', '2021-07-10', '여성', '4686 Knutson Parkway', '918-661-9870', 'jpriddeyck@va.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('keastopecl', 'dWxM0iK', 'Kristen', '1991-04-02', '여성', '1013 Wayridge Park', '824-817-7910', 'kelesandercl@indiegogo.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cskitteralcm', '95toAQM6aZSU', 'Cathe', '1994-10-19', '여성', '228 Heffernan Hill', '227-267-8224', 'cdeyenhardtcm@aboutads.info', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pgheraldicn', 'wyy9bnM', 'Pietro', '1995-02-27', '남성', '67 Killdeer Parkway', '988-537-1973', 'pstonardcn@bloglovin.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sbreckonco', 'fb93HeMTS', 'Sheila-kathryn', '2000-03-26', '여성', '8733 Hansons Road', '331-768-6567', 'shandesco@stanford.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hlayborncp', 'LIVJb6', 'Harvey', '2021-06-01', '남성', '379 Laurel Plaza', '682-753-5248', 'htollidaycp@networkadvertising.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('zabramofcq', 'pD6pnq', 'Zedekiah', '2014-11-27', '남성', '85817 Marquette Junction', '404-154-2869', 'ztomasonicq@blogger.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mbikkercr', '3LRMtP4BN', 'Marsh', '2022-01-04', '남성', '92 Caliangt Plaza', '198-223-6697', 'mmacdonoghcr@plala.or.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('oyakunchikovcs', '6GwkLL', 'Orelee', '2018-06-04', '여성', '76 Jay Trail', '926-662-6634', 'oragotcs@flavors.me', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('soldershawct', 'nz4AlOHR7', 'Shannan', '2011-06-15', '남성', '06 Killdeer Avenue', '974-412-5121', 'slowethct@slate.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ggilbankscu', 'TdNYCwTv', 'Griff', '2021-05-03', '남성', '608 Homewood Pass', '791-707-0494', 'gdabneycu@etsy.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pandreotticv', 'iE1rRx', 'Phil', '2016-03-16', '남성', '84510 Graceland Circle', '421-507-5740', 'pcotecv@aol.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fsinkinsoncw', 'mwQeq7JpgkSC', 'Fin', '1996-12-16', '남성', '04 Debra Circle', '427-285-4420', 'ftrenholmecw@cisco.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jwatercx', 'tHoqGb', 'Jaye', '1999-05-13', '남성', '00 Union Pass', '379-982-9625', 'jbirdwhistellcx@csmonitor.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pbuxsycy', 'AcrTjYHpRE', 'Pattie', '2011-07-25', '여성', '88470 Pearson Alley', '880-635-6460', 'pdittercy@friendfeed.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kcarruthcz', 'B1U1pHfRyt', 'Kathie', '2002-06-06', '여성', '13 Lyons Park', '907-318-3288', 'krowlettcz@php.net', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wraycroftd0', 'RVcEuPX5jWz', 'Wallie', '1994-11-15', '남성', '5 Anhalt Alley', '668-874-1337', 'wputtickd0@bizjournals.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mmontrosed1', 'e0FEhCs', 'Marrilee', '1997-03-06', '여성', '193 Colorado Pass', '902-652-2829', 'mabbyd1@unesco.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nstonefewingsd2', 'pdhP6wKUX', 'Ninette', '2014-05-07', '여성', '7 Mendota Street', '234-457-3929', 'nfochsd2@smugmug.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kchazetted3', 'Uf6iUR4zQ8', 'Keven', '2013-08-09', '남성', '795 Blaine Center', '408-429-6701', 'kchaffeyd3@gravatar.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dkarlemand4', '9KDKHm2', 'Darelle', '2012-01-14', '여성', '42638 Dryden Way', '390-241-2189', 'dstirtond4@whitehouse.gov', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ekegginsd5', 'kwuNV9Y', 'Estrella', '2005-09-29', '여성', '2 Sunbrook Circle', '446-663-3527', 'ecalderond5@example.com', '생산/ 기술직/ 노무직I', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ieeded6', 'mnLOaSA', 'Inna', '2013-08-01', '여성', '27 Hansons Lane', '378-195-5243', 'iharbaged6@devhub.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mfoucard7', 'PoAH9dpevz', 'Marilyn', '2021-06-12', '여성', '63 Waywood Center', '938-791-7216', 'mgoodad7@dailymail.co.uk', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ewealed8', 'QqIUTSsd27y', 'Esther', '2005-12-17', '여성', '04103 Randy Park', '193-750-9005', 'eceelyd8@tamu.edu', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdearthd9', 'ZCEVmdlYFm', 'Carly', '2000-06-28', '여성', '2163 Cordelia Alley', '896-846-2678', 'cjedrzaszkiewiczd9@earthlink.net', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ghearthfieldda', 'QJq8o1t', 'Gunar', '2006-09-24', '남성', '97525 Scott Terrace', '917-505-0114', 'ggarthsideda@qq.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bpettetdb', 'kpFwQ1UAr', 'Barbette', '1995-07-02', '여성', '92820 Reinke Place', '328-869-2270', 'bgregoriodb@va.gov', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gbiasettidc', 'qqz3avyu', 'Gladi', '2013-12-20', '여성', '82 Carberry Parkway', '768-792-8247', 'gsarathdc@elegantthemes.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlevermoredd', 'BmUNCrHi8', 'Melania', '2006-02-27', '여성', '351 Ludington Pass', '429-272-3671', 'mcorrettdd@51.la', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kchadbournde', 'c20HAG4mzh', 'Kathie', '2003-12-06', '여성', '03871 Ridgeway Terrace', '575-593-4956', 'kmarkussende@ning.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmcgaheydf', '40jdox', 'Justina', '2018-12-17', '여성', '79 Center Crossing', '711-837-3899', 'jlapwooddf@acquirethisname.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csunderlanddg', 'tffpGQobW', 'Carrissa', '2007-12-06', '여성', '5673 Lunder Parkway', '397-823-4523', 'cscanderetdg@behance.net', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cclelanddh', '7NX4EJ', 'Christy', '1993-08-30', '남성', '86911 Spaight Avenue', '613-308-7271', 'cmilesdh@army.mil', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mhauxbydi', 'jyB1Bt', 'Miller', '2002-01-26', '남성', '3460 Barby Alley', '618-291-2871', 'mnesbittdi@biglobe.ne.jp', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mpurdondj', 'FUdM2M9HUqtS', 'Maye', '1999-09-26', '여성', '71270 Rusk Parkway', '652-238-1258', 'mreynoolldsdj@oaic.gov.au', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mcatherickdk', 'gHfYWTZa', 'Marius', '2017-09-19', '남성', '700 Waxwing Road', '903-884-9159', 'moakwelldk@addtoany.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jburneydl', 'RowCDF12AiXQ', 'Jami', '2019-12-10', '여성', '0 Gulseth Center', '707-287-8954', 'jwoodroofedl@spiegel.de', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cderrelldm', 'F9zpQSrh', 'Caesar', '2008-08-23', '남성', '25427 Artisan Lane', '443-986-0281', 'cjorissendm@senate.gov', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nfalconbridgedn', 'CyrkK0J9tjS', 'Nessa', '2018-02-23', '여성', '265 Fallview Road', '231-930-9991', 'nbeenhamdn@cornell.edu', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kdallingdo', 'xFsfJdztx', 'Kelli', '2011-07-06', '여성', '76 Miller Street', '675-755-2742', 'kdebenedictisdo@indiegogo.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('keighteendp', 'tbqiyXUmDi3', 'Kacie', '1991-08-19', '여성', '790 Sheridan Road', '427-282-7291', 'kmcmahondp@weather.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ehainningdq', 'Zxlz1tWbu5a', 'Emelia', '1993-08-10', '여성', '43 Calypso Court', '346-212-1684', 'ekegandq@netlog.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nlyesdr', 's1c9Hb', 'Nichols', '2022-12-04', '남성', '010 Surrey Drive', '977-346-6505', 'nhofdr@dagondesign.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mrogerotds', 'iksXYhsuH', 'Malia', '1991-03-23', '여성', '17112 Forest Dale Alley', '720-953-7757', 'mmatthessends@flavors.me', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gtamasdt', 'mbYmcNX9dD', 'Giacomo', '1999-04-02', '남성', '2 Cardinal Drive', '803-843-1285', 'gburkettdt@xing.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gbourdasdu', '5UE2d4odt', 'Garner', '2005-12-10', '남성', '2 Aberg Lane', '458-576-9260', 'gprichetdu@timesonline.co.uk', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aheddedv', 'DCw5ns7UkDx', 'Alverta', '2012-12-01', '여성', '6 Nelson Alley', '504-226-7232', 'acowendv@uol.com.br', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mfoggdw', 'mB3H8BSt6iO', 'Miguela', '1996-08-09', '여성', '87 Mesta Lane', '728-919-7976', 'mbrasenerdw@buzzfeed.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ltomblindx', 'Iv1Q3M0N2r', 'Lilas', '1997-05-15', '여성', '4672 Chinook Alley', '349-871-7944', 'lfinlaisondx@digg.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('spipedy', 'V0TkThj', 'Sasha', '2004-07-18', '남성', '5 Briar Crest Pass', '389-189-4941', 'sbutterickdy@google.com.br', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hdilworthdz', 'N6BM4Lm3gj', 'Hyacinthie', '2005-08-25', '여성', '8135 Cordelia Junction', '806-918-0796', 'hcharnockdz@admin.ch', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aputtname0', 'TmqX8HQ', 'Asa', '2003-07-18', '남성', '69 Gateway Terrace', '461-734-1717', 'acamamilee0@deviantart.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmeanye1', 'MUZZuUoQQ3', 'Jolyn', '2005-04-14', '여성', '24 Saint Paul Plaza', '279-770-5244', 'jbeste1@gravatar.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcunnowe2', 'APxRA1b30', 'Dyann', '2009-01-08', '여성', '3745 Fallview Junction', '461-172-7675', 'dewolse2@wiley.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rflotte3', 'qoiDQAoP0Wv', 'Roseline', '2005-03-08', '여성', '91 Transport Crossing', '518-225-5222', 'rbynerte3@ezinearticles.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmckechniee4', 'zaKNxsXRB', 'Curcio', '1999-10-31', '남성', '77646 Sutteridge Trail', '849-837-6459', 'ccanellase4@tumblr.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pbernate5', 'a0jprPgnOt', 'Phillip', '2001-04-17', '남성', '88 Donald Trail', '474-262-6197', 'prameauxe5@webmd.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('isaffene6', 'yUBwQUmoaBTX', 'Izabel', '2013-05-30', '여성', '7 South Alley', '513-852-9491', 'itreee6@phoca.cz', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cwroathe7', 'OgewUZ8FL', 'Christabella', '2020-01-30', '여성', '934 Division Court', '848-159-3408', 'chalye7@goo.ne.jp', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tgarrawaye8', 'ccNmcIa64Fr', 'Tabbie', '1990-11-11', '남성', '9816 Chive Hill', '523-125-8407', 'tliccardie8@ucsd.edu', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlandsberge9', 'bSFspUXoBsMx', 'Michail', '2001-11-15', '남성', '52584 Lakewood Gardens Junction', '419-908-7717', 'miacovidese9@pbs.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cempletonea', 'SeIFRn', 'Cori', '2000-06-23', '남성', '78 Kipling Way', '890-575-8999', 'cmaciakea@usda.gov', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('grainoneb', '6fskumWTAsb', 'Galvin', '2006-01-15', '남성', '99337 Susan Crossing', '164-230-8124', 'gstutelyeb@blogs.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gdurransec', 'eZDFHALMfipD', 'Genvieve', '1999-12-15', '여성', '887 Calypso Way', '508-826-2804', 'gclokeec@addthis.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aomulderriged', 'rvCqM2L4si', 'Anne', '2000-09-24', '여성', '6 Forest Dale Pass', '289-668-9938', 'amaturaed@springer.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mdraytonee', 'i76lCdB', 'Merry', '2011-02-19', '남성', '8 Dayton Circle', '140-133-3835', 'mantwisee@paypal.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ggurnayef', 'hHhVBv', 'Gerhard', '1993-01-30', '남성', '8 Crownhardt Terrace', '995-120-3017', 'gheckleef@vistaprint.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('teggereg', 'zheEVncWnHA', 'Tudor', '1998-03-14', '남성', '0231 Banding Trail', '880-430-3748', 'tcubbinellieg@guardian.co.uk', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jhewkineh', '9UPhEC8YKKe', 'James', '2016-03-03', '남성', '239 Esker Way', '576-202-2223', 'jcommussoeh@myspace.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cashburnerei', 'ljHei8lD', 'Ced', '1996-05-26', '남성', '281 Drewry Point', '590-861-9385', 'cbevanei@deviantart.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ahickej', 'CigqZfOMhl', 'Addy', '1999-07-17', '남성', '24 Pepper Wood Plaza', '556-939-3731', 'acarnockej@g.co', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hleebeterek', 'OEWz17uF33d', 'Harlan', '2003-07-08', '남성', '3 Truax Circle', '219-338-6569', 'handersek@timesonline.co.uk', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mtrudgeonel', 'gzKqUH5', 'Mindy', '2003-01-30', '여성', '7053 Coleman Trail', '537-218-4610', 'msaurinel@engadget.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('uivushkinem', 'yLYu6wI', 'Urbain', '2014-02-23', '남성', '3668 Dakota Pass', '162-517-1768', 'uplimmerem@nba.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbrandlien', '7FghthFeTrQ6', 'Barbie', '2009-03-11', '여성', '63 Doe Crossing Drive', '727-697-6551', 'bleinthallen@jiathis.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aduhigeo', 'VgeFGh', 'Amandy', '2005-09-20', '여성', '6 Badeau Avenue', '522-715-2431', 'ahousoneo@fda.gov', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('zmalitrottep', 'UrMNzM97', 'Zach', '2014-09-06', '남성', '7 7th Pass', '682-742-5129', 'zlealleep@newsvine.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('desbergereq', 'hVy6Os0i6K', 'Darnell', '2008-11-04', '남성', '8 Novick Place', '468-832-4462', 'dwursteq@icq.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dbauduiner', '2TyLjAK9MqLQ', 'Donella', '2009-08-28', '여성', '58997 La Follette Trail', '835-613-6281', 'dvasilover@usatoday.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlotheringtones', 'r55YdoZgG7Q', 'Mattheus', '2009-07-08', '남성', '582 Dakota Parkway', '334-913-1071', 'mpawelczykes@wikimedia.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ctawnet', 's7wjUSKG', 'Coleman', '2008-11-17', '남성', '15821 Corry Place', '200-904-0138', 'cokeyet@xinhuanet.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tlukinseu', 'zXqR7Bh', 'Trixy', '1994-12-23', '여성', '2773 Milwaukee Road', '217-386-4909', 'treedayeu@google.ru', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ybourneev', 'DgwPW8', 'Ynes', '2019-04-25', '여성', '2 Pennsylvania Way', '307-989-1967', 'yogeaneyev@tamu.edu', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wgrzeszczykew', 'pasNHCM5hHXf', 'Wyn', '2012-08-02', '남성', '22908 Maple Drive', '313-306-2305', 'wseatonew@ucoz.ru', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sclewex', 'owBxvXdDyB', 'Shawnee', '2004-12-30', '여성', '950 Texas Plaza', '621-539-3271', 'shailsex@miibeian.gov.cn', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dgumbrelley', 'OueH0UTnjAg', 'Debby', '2020-12-27', '여성', '5227 Service Avenue', '697-232-7066', 'dcokelyey@latimes.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('apladenez', 'kmCOjal', 'Aili', '2004-01-02', '여성', '4985 Little Fleur Junction', '478-791-2834', 'asodaez@addtoany.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('noakenfordf0', 'l8QGg8C', 'Nichole', '2017-10-06', '남성', '3703 Fair Oaks Circle', '375-515-4443', 'njessef0@msn.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mryhorovichf1', 'HLU024nr1', 'Manya', '2016-02-08', '여성', '1 School Center', '991-887-2262', 'mmcchruiterf1@symantec.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sharoldf2', 'oEd9o3h', 'Stillman', '2018-08-27', '남성', '4 Alpine Drive', '104-519-4821', 'smerwoodf2@ted.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fpantlingf3', '6M2hJ1V0K2', 'Flynn', '2022-06-21', '남성', '6 4th Street', '595-778-3731', 'fvowdonf3@whitehouse.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aisakssonf4', 'ZIFIL9ENok', 'Armstrong', '2003-06-12', '남성', '5 Saint Paul Drive', '306-793-5119', 'agentricf4@sina.com.cn', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bhavikf5', 'SGdZ4PNeB', 'Baird', '2018-06-15', '남성', '77216 Upham Alley', '481-920-5988', 'brosenblathf5@unc.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdemetrf6', 'Y7tChYaUXmLQ', 'Claude', '1999-06-22', '여성', '9682 Caliangt Court', '409-938-1615', 'ccostyf6@geocities.jp', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aosheerinf7', 'QB98U2eS07', 'Annamarie', '2004-05-09', '여성', '612 Swallow Junction', '327-193-8947', 'aanneyf7@simplemachines.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rbaytropf8', 'bjEoUKa', 'Ruthe', '1999-09-14', '여성', '09 Fuller Drive', '545-914-5332', 'rfehnerf8@yahoo.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cphippf9', 'jK5FqRXAwH', 'Clim', '2019-01-11', '남성', '55544 School Hill', '466-653-1773', 'cvondrachf9@google.pl', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('avoiseyfa', 'wIU6jz', 'Aldus', '1996-09-20', '남성', '95 Sundown Hill', '218-776-0643', 'areadshallfa@earthlink.net', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmollinfb', 'PI23UVzy6Y', 'Colene', '2005-01-30', '여성', '59284 Independence Parkway', '194-608-4397', 'ckullfb@examiner.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('slinggardfc', '9tY74qCAN', 'Stafani', '1993-07-24', '여성', '72 Boyd Parkway', '552-585-0129', 'satcherleyfc@seesaa.net', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hgeffcockfd', 'RfoJyDVwLI7', 'Harmony', '2013-10-11', '여성', '64364 Sunfield Court', '252-721-7843', 'hgouldthorpfd@home.pl', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sgyteshamfe', 'zfMtIO', 'Sonnnie', '2004-08-27', '여성', '437 Havey Point', '133-774-2901', 'sbuggyfe@tiny.cc', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmccartneyff', 'NYC2KoDQ7vm', 'Roobbie', '1999-10-28', '여성', '2820 Green Alley', '302-258-7642', 'roranff@cbsnews.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dmckeefg', 'ba7Y9WD00e', 'Dugald', '1993-09-12', '남성', '2 Nobel Parkway', '587-496-9374', 'dyearnesfg@aboutads.info', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('scheesworthfh', 'YV50JgNZkF1Y', 'Sawyer', '1996-07-16', '남성', '33928 Express Trail', '616-375-0743', 'sfeighneyfh@techcrunch.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tpurdomfi', '7xkYCA4PV5u', 'Terrijo', '2016-02-05', '여성', '70 Summer Ridge Lane', '592-328-9184', 'trangerfi@seesaa.net', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nabbyfj', 'hXZ2LdNM', 'Nial', '2005-07-08', '남성', '2 Bashford Road', '500-356-3619', 'ndanielsenfj@bluehost.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mguitelfk', 'jeo0Vmde', 'Moselle', '1997-05-17', '여성', '358 Derek Pass', '267-453-8315', 'mluttyfk@answers.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccominottifl', 'dc5uiX', 'Collete', '1997-04-27', '여성', '015 Pine View Drive', '232-888-4214', 'candrinifl@etsy.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kwarmishamfm', 'gg1FxWFWdft', 'Kalvin', '1999-09-28', '남성', '2 Stuart Plaza', '412-171-0035', 'kblandfordfm@reference.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rtwinbournefn', 'x9kd96c', 'Rosana', '2022-05-25', '여성', '5 Doe Crossing Lane', '192-274-3611', 'rthulbornfn@yolasite.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('beffemyfo', 'nHWkgcKFA', 'Binky', '2002-01-23', '남성', '94947 Sommers Place', '563-368-3962', 'blongforthfo@princeton.edu', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tpeetersfp', '5EHFJsrha', 'Tom', '2002-11-09', '남성', '7598 Glendale Terrace', '729-808-3385', 'tgabbatfp@sun.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('adoumerfq', 'ju6RYm8Vi', 'Amelina', '2019-01-27', '여성', '5 Mockingbird Point', '110-615-2004', 'aasplingfq@springer.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ldavidsfr', 'X7QwsXSVB9', 'Lucita', '2011-01-11', '여성', '23 Rockefeller Pass', '526-168-0217', 'lcannfr@topsy.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('djorgerfs', 'ZnrBKSih64B7', 'Dickie', '2015-07-23', '남성', '8894 Artisan Street', '263-971-5006', 'daskellfs@buzzfeed.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dtowellft', 'fW4S91kv', 'Dieter', '1994-11-12', '남성', '7256 Elgar Alley', '135-108-0201', 'dmaynardft@buzzfeed.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tdrewsfu', '36SQKU', 'Teressa', '2019-12-23', '여성', '293 Gerald Hill', '215-328-2415', 'tlinhamfu@intel.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aballinghallfv', '4E9tpPLswa', 'Adamo', '2005-04-21', '남성', '61 Golf Course Road', '715-147-8534', 'adafterfv@seattletimes.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rdiffleyfw', 'sO8gso3y9', 'Rochester', '2016-03-01', '남성', '57 Mosinee Street', '381-792-0704', 'rmapholmfw@state.gov', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tdeadmanfx', 'eLQCBV7d', 'Tiphani', '2016-09-26', '여성', '346 Southridge Lane', '256-634-2595', 'tchildesfx@linkedin.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('scufffy', '3JY1KEe2Q', 'Serge', '2017-11-05', '남성', '5 Wayridge Plaza', '394-145-9960', 'swaterfallfy@gnu.org', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('chenkensfz', 'ZK68Rr', 'Chen', '1998-12-02', '남성', '0 American Point', '542-682-9768', 'cilyuchyovfz@arstechnica.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sthrussellg0', 'zPPsEdcZL', 'Sula', '2006-02-10', '여성', '196 Pankratz Center', '878-421-6485', 'sdevaang0@free.fr', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bcornockg1', 'Y3KKf2vdSp', 'Barnett', '2000-05-14', '남성', '5822 Blaine Trail', '675-714-9541', 'bnellesg1@paginegialle.it', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amateusg2', 'Fp88EuTSoN', 'Aggie', '1993-06-20', '여성', '649 Beilfuss Parkway', '365-193-5565', 'ahawickg2@yahoo.co.jp', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ssorbieg3', 'IlFw984gC', 'Sharla', '2016-09-28', '여성', '7 Prairieview Trail', '255-141-9659', 'sgraveneyg3@economist.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('awalliceg4', 'l3IgPJiMzVIw', 'Amanda', '1998-03-27', '여성', '79 Springs Street', '177-419-6240', 'acantg4@theglobeandmail.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fdowdleg5', 'Y64SrM1z', 'Felix', '1990-10-25', '남성', '2 Melby Crossing', '195-827-6882', 'frossettig5@thetimes.co.uk', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aelletsong6', 'vkIEbZPnzJ', 'Abbye', '2011-02-06', '여성', '1505 Kennedy Trail', '105-606-1253', 'abutteng6@statcounter.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tclereg7', 'Iaexuz1XNW', 'Toiboid', '2017-08-20', '남성', '2398 Steensland Road', '447-700-2916', 'tsreenang7@vinaora.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gcreping8', 'V6FUPgta1HtZ', 'Gilda', '2010-05-30', '여성', '52365 Old Shore Circle', '920-890-9927', 'gdebrettg8@nasa.gov', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tinking9', 'wkiUPmXH', 'Tully', '1999-07-14', '남성', '8709 Stoughton Point', '528-722-6068', 'tpessoltg9@whitehouse.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rdownerga', 'LvqzBZ7', 'Roanne', '2021-12-13', '여성', '54 Prentice Parkway', '429-235-1098', 'rcubbinelliga@chron.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rfriberggb', 'fXWvxgetZ6', 'Robby', '2019-06-16', '남성', '5 Dovetail Terrace', '591-999-2870', 'rfilongb@cdbaby.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dalkinsgc', 'BEu0s6r7RA0', 'Dara', '2016-10-08', '여성', '51055 Continental Place', '512-206-5561', 'dwiddowesgc@cdbaby.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mgaskampgd', '8MNLX1OS', 'Margarethe', '2003-11-19', '여성', '3122 Mitchell Point', '683-594-6894', 'mjanickigd@google.com.au', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('adumingoge', 'wbeUgWPzck', 'Archaimbaud', '2006-09-01', '남성', '10130 Derek Terrace', '402-481-3900', 'ahowsonge@wufoo.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sgassgf', 'lA6Cmpep5', 'Sapphira', '2010-12-31', '여성', '2534 Tony Avenue', '128-202-2034', 'sbrannongf@soup.io', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rlongdongg', 't8lUhWL6QXNt', 'Rosabelle', '2011-12-01', '여성', '319 Ridgeview Crossing', '765-607-0293', 'rtoynbeegg@java.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amonangh', 'T2oUsz2', 'Ade', '2003-01-12', '남성', '79 Warner Circle', '750-388-3812', 'ajurischgh@blogspot.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bcathrogi', 'zN3WC2Uh6s', 'Brigit', '1991-08-26', '여성', '119 Mallory Street', '349-782-5175', 'bdiegogi@go.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('iblondellgj', 'YemMmKVw7i', 'Ibrahim', '2013-10-17', '남성', '10757 Cardinal Point', '893-260-2678', 'iditchettgj@example.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amaryangk', 'W96dOl', 'Allard', '2019-11-13', '남성', '938 Holmberg Terrace', '514-232-8446', 'aeptongk@so-net.ne.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bwyldgl', 'qxy2KRl5Z', 'Bobina', '2017-03-18', '여성', '2129 Memorial Plaza', '224-146-3123', 'bbufferygl@cafepress.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('medisgm', 'dhetUiO', 'Manfred', '1998-12-21', '남성', '0 Knutson Crossing', '527-578-7350', 'mhaggishgm@ifeng.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ahamprechtgn', 'fKzKoYMbkm', 'Adolphe', '2002-08-23', '남성', '6627 Dapin Junction', '376-383-6381', 'anobletgn@si.edu', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('areddingtongo', 'KC2QhOqB', 'Arlyn', '1993-07-18', '여성', '9 Forest Run Court', '892-984-0476', 'astiddardgo@simplemachines.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('orippongp', 'wCjHOzd', 'Olivero', '1992-11-26', '남성', '329 Scott Trail', '749-712-9009', 'oparsellgp@naver.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jcaldwellgq', 'GtELAHySU', 'Johannah', '2006-06-28', '여성', '579 Oriole Terrace', '331-691-8852', 'jfeatleygq@dailymail.co.uk', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dchittemgr', 'LZxbEpuzFYa2', 'Dall', '2008-04-19', '남성', '8070 Aberg Avenue', '789-463-7993', 'dwoehlergr@cbc.ca', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rshadrackgs', 'c4yCBNr', 'Robbin', '2011-10-13', '여성', '255 Meadow Ridge Hill', '581-935-0698', 'rdrohanegs@icq.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cwestbygt', '9OrnCwyB', 'Corina', '1994-10-22', '여성', '092 Northridge Crossing', '218-619-1479', 'cmacgaughiegt@wix.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fwhittlesgu', 'fxTBEm6hWtC', 'Fleurette', '1996-01-23', '여성', '4376 Commercial Hill', '509-253-8009', 'flingardgu@cocolog-nifty.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlattagv', 'VBBQTa', 'Maddi', '2014-02-07', '여성', '29 Warrior Hill', '949-921-6349', 'mhartleygv@liveinternet.ru', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('etulkgw', 'GZ9bpW', 'Edmund', '1997-03-20', '남성', '9 Victoria Place', '579-971-3258', 'eweekleygw@163.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cballintynegx', 'lRA0zn0QwR', 'Cassie', '1996-09-03', '남성', '27054 Del Mar Drive', '396-774-2404', 'cjaggardgx@techcrunch.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('crappgy', 'hEaw60BWfO', 'Cleve', '2004-02-19', '남성', '77 Declaration Street', '969-673-4245', 'cadlamgy@wikimedia.org', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rtwininggz', 'uDyGIhNyrC', 'Richie', '1991-04-04', '남성', '95737 Farragut Hill', '207-807-5725', 'raronsongz@example.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('qtirreyh0', '1CsicNxJSWj', 'Quinta', '2008-01-01', '여성', '8 Fairview Circle', '374-251-0884', 'qsuttillh0@msn.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hweitzelh1', 'Zrv3fi4P', 'Halli', '1999-11-05', '여성', '6 Graceland Lane', '779-554-0915', 'hspearh1@macromedia.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lmarsyh2', 'B1Q8ffU', 'Lorant', '2011-08-23', '남성', '577 Magdeline Circle', '280-889-1583', 'lfuttyh2@alibaba.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hnorthgravesh3', 'SSOSAdWWbD', 'Hilton', '2014-04-20', '남성', '4245 Esch Hill', '316-898-9485', 'hdahlerh3@blogtalkradio.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('edwerryhouseh4', 'z1crDteG6b', 'Em', '2002-07-08', '여성', '81 Corben Alley', '749-941-9787', 'epearneh4@archive.org', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mbetonh5', 's60bqaT4cGu', 'Madelene', '1995-02-25', '여성', '37441 Dottie Lane', '784-645-8951', 'mrivallanth5@boston.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dshearah6', 'tmNR87Mln', 'Delcina', '2020-01-06', '여성', '2840 Evergreen Alley', '502-541-0867', 'dheeranh6@prweb.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcruth7', 'qkBm74QY2a', 'Ripley', '2001-12-18', '남성', '813 Dapin Center', '808-221-9067', 'rgarfathh7@gmpg.org', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nbroughamh8', '5hRgSV', 'Noel', '2009-01-30', '여성', '44058 Meadow Valley Parkway', '276-740-4614', 'ngabeh8@oakley.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gferedayh9', '62PYVARLo', 'Gerri', '2001-06-10', '남성', '95 Commercial Circle', '960-131-1029', 'ghealeash9@examiner.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fsabertonha', 'nBqTkgwW', 'Freeland', '2012-11-12', '남성', '28946 Westport Place', '984-802-3799', 'fmerrigansha@sogou.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rwernhamhb', 'dEjraGAk', 'Rudolph', '2001-12-06', '남성', '3 Saint Paul Road', '644-304-1452', 'rbartolichb@opera.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bsantihc', 'iGORGCrsqRGJ', 'Bastian', '2016-07-16', '남성', '1988 Lakewood Center', '559-136-2231', 'bmcquorkelhc@last.fm', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ahavelinehd', '8jo8z7Se', 'Allyn', '1992-01-03', '여성', '4 Mosinee Road', '663-885-6921', 'abaudouhd@goo.ne.jp', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dbrantzenhe', '3Qf2f7QS', 'Duffie', '2003-11-18', '남성', '01237 Memorial Circle', '501-766-6317', 'darmalhe@washingtonpost.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cbonwellhf', 'YOxrsQdzCw', 'Chuck', '2020-05-24', '남성', '6204 Brickson Park Junction', '185-442-0944', 'cfeatenbyhf@blogger.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mhenworthhg', 'igu0apP6Qd', 'Marv', '2003-05-07', '남성', '7 Gina Plaza', '495-545-3945', 'mmacguiganhg@technorati.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmacarthurhh', 'Tky0JVeO9', 'Charles', '1995-06-04', '남성', '83 Dwight Alley', '514-536-8669', 'chollierhh@dell.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nbirdhi', '19J0mL', 'Nichols', '1992-09-10', '남성', '81 Morningstar Place', '419-923-7740', 'narnehi@acquirethisname.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ncallhj', '1lZKe7Y', 'Nathaniel', '2014-03-05', '남성', '466 Gina Crossing', '626-556-0026', 'nmckinnhj@independent.co.uk', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kpicketthk', 'mgqpXsNf', 'Kirsti', '1996-08-29', '여성', '6093 Autumn Leaf Road', '191-339-4232', 'ksorbyhk@webnode.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bpinnionhl', 'MGyJfWgl', 'Bret', '2012-10-01', '남성', '20191 Miller Crossing', '456-689-1475', 'bsaltmarshehl@reddit.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dfearensidehm', 'Cy646OqhhO9w', 'Dell', '1996-03-08', '여성', '75560 Lakeland Court', '452-661-9344', 'dsimantshm@wunderground.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcraigghn', 'UomyKlOh', 'Daisi', '1998-08-01', '여성', '2429 Straubel Street', '779-665-2897', 'dveldehn@etsy.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('emurdieho', 'xlw792', 'Elbertina', '1991-07-08', '여성', '739 Carioca Center', '129-895-2583', 'ebirtleho@go.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jlaniganhp', 's0MPPwOms0', 'Johnna', '2011-08-04', '여성', '81796 Oxford Road', '110-188-6254', 'jfrancishp@rediff.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dsahlstromhq', 'A8F4234Xz', 'Diego', '1990-11-01', '남성', '47932 Pepper Wood Terrace', '315-551-3784', 'dyounghusbandhq@geocities.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mberresfordhr', '7w0khxUoq', 'Morgun', '2015-03-16', '남성', '81713 Dunning Way', '946-210-9480', 'mwineshr@adobe.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jseeviourhs', '4v4di5CdBHAc', 'Jacinda', '2015-05-11', '여성', '841 Burning Wood Circle', '958-416-3821', 'jbereclothhs@economist.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lshapterht', 'kFDC8Z', 'Link', '1996-10-05', '남성', '202 Vera Road', '286-137-3201', 'llangdridgeht@intel.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gharvatthu', 'sGte5TEQTT', 'Gilbertine', '2018-05-25', '여성', '0 Sheridan Point', '569-699-3192', 'gdeardshu@linkedin.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('oramehv', 'OBJPO4od9QX', 'Ozzy', '1994-01-13', '남성', '6 Randy Drive', '442-569-5983', 'okenderhv@youtube.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jshepcutthw', 'nuFG9g6Oa', 'Jorrie', '1994-04-04', '여성', '21 Sunnyside Plaza', '368-470-2586', 'jstarsmorehw@oaic.gov.au', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cbleacklyhx', 'TzDcgU3IjBI', 'Curr', '2007-02-14', '남성', '83 Laurel Center', '219-900-0626', 'clawreyhx@mapquest.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fpeadenhy', 'yo2fnpaAsvG', 'Fan', '2003-05-18', '여성', '04216 Jenna Place', '351-969-9043', 'fwalshhy@kickstarter.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lsynkehz', 'nV1H7pVI6QPW', 'Leshia', '1990-12-27', '여성', '5285 Northview Terrace', '496-631-4074', 'lkelwaybamberhz@usatoday.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('htonguei0', '2zGzMW', 'Hubert', '2010-10-14', '남성', '636 Brickson Park Circle', '394-104-4312', 'hbumfordi0@ebay.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmatkini1', '7JFnxfLXYR', 'Cointon', '2010-10-22', '남성', '165 Mayfield Alley', '842-792-1095', 'cablei1@adobe.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('slightningi2', '7uToJH4uPn', 'Sherri', '2010-02-24', '여성', '93 Express Way', '404-657-5389', 'sgilhoolyi2@dot.gov', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('msurmanwellsi3', 'rz7wS6WojEk', 'Mora', '2013-10-18', '여성', '413 Londonderry Lane', '995-369-9066', 'mcoursei3@google.pl', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('etrussmani4', 'Vwe4WJ', 'Eamon', '2000-11-01', '남성', '30 Walton Crossing', '336-994-5112', 'eboxeri4@google.ru', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gbraidwoodi5', 'tQguMYX', 'Gal', '2011-06-29', '남성', '63049 Lerdahl Court', '926-921-4056', 'gkearnsi5@networksolutions.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acasonii6', 'EyR8i17T', 'Aimee', '1999-05-04', '여성', '29634 Schiller Alley', '623-174-5855', 'awilcockesi6@wsj.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dakrami7', 'N2MP0FNMAm', 'Duane', '1994-02-04', '남성', '90320 Loomis Street', '582-396-3545', 'dgottschalki7@ca.gov', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dwainmani8', 'LZBGphEBj6', 'Dylan', '2020-01-31', '남성', '21 Kenwood Pass', '635-206-6768', 'dsageri8@devhub.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('snuddei9', 'TWC2VIp', 'Sal', '2007-03-19', '여성', '82640 Hayes Way', '974-615-6484', 'sramsayi9@seattletimes.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lfollinia', 'NgFPtH', 'Lewiss', '2011-12-12', '남성', '3 Briar Crest Park', '619-372-3806', 'lfroomia@dmoz.org', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ttoderbruggeib', 'x2eyEvvfsxB', 'Tracie', '2013-06-25', '여성', '259 Goodland Circle', '334-232-5499', 'ttrawinib@theatlantic.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ehargic', 'O1EYhaF', 'Eveline', '2011-06-15', '여성', '0939 Myrtle Court', '285-515-8640', 'eklaaasenic@who.int', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fwoofindenid', 'IfdABPq0Z', 'Faunie', '2017-07-27', '여성', '470 Logan Crossing', '790-385-8002', 'fwinstonid@google.de', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jventumie', 'opWBcOLz', 'Joycelin', '2013-10-23', '여성', '7 Kedzie Way', '244-158-6951', 'jdannelie@ameblo.jp', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gcasottiif', '5cnmGf7MHjb', 'Galvan', '1993-12-28', '남성', '2 Bultman Court', '664-484-8896', 'gcurrif@examiner.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('slandeauxig', 'zmq3zJc', 'Sebastian', '1992-06-22', '남성', '0409 Schmedeman Court', '645-660-3354', 'ssheehyig@homestead.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dburrillih', 'TfBzaaAEoMbx', 'Dewie', '2016-10-10', '남성', '5397 International Pass', '235-333-3769', 'dgoutih@samsung.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mchatinii', 'pwFNiw', 'Morrie', '2001-01-29', '남성', '175 Hanover Lane', '800-968-6879', 'mcastanii@umn.edu', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ssmyleyij', 'tOUGG37', 'Stacee', '1997-04-11', '여성', '01 Northwestern Lane', '648-446-6120', 'sattwoulij@examiner.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sgoodreidik', '17Jq9ORS', 'Sinclair', '2000-08-29', '남성', '9690 Hansons Hill', '523-964-3464', 'spetrielloik@imdb.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('njakucewiczil', '1Kr11ubqF2', 'Nicol', '1999-12-01', '여성', '29611 Kipling Drive', '727-615-0991', 'nhancillil@jimdo.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bphillpim', 'n50RAog', 'Bellanca', '2007-04-25', '여성', '276 Miller Terrace', '707-337-8924', 'bhankinim@bing.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jrembaudin', 'm9NRn8', 'Jeth', '2007-08-26', '남성', '963 Lighthouse Bay Parkway', '241-697-1108', 'jolyuninin@yahoo.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rhargrevesio', 'IiIZMSLwd', 'Radcliffe', '2007-08-17', '남성', '04 Forest Run Place', '408-163-8558', 'rgatrillio@reuters.com', '자유직/프리랜서I', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tsimoneschiip', 'M2cREG0ggq', 'Thadeus', '2017-05-16', '남성', '5151 Menomonie Court', '635-915-8322', 'tyurlovip@yahoo.co.jp', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('asedgeriq', 'maCNWe9', 'Andria', '2000-05-08', '여성', '168 Merry Drive', '682-363-5217', 'asnodayiq@gizmodo.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('datcherleyir', 'rHgO85', 'Damaris', '1992-08-27', '여성', '5 Nobel Junction', '904-730-9888', 'dhuntressir@examiner.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('crikardis', 'MgHPboc', 'Caron', '1998-02-11', '여성', '81451 Huxley Park', '441-402-1219', 'ckarolyis@yellowpages.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ptodariit', 'E1iJubnVphN', 'Paulo', '2001-09-15', '남성', '7 Johnson Trail', '908-263-7992', 'pbolliniit@woothemes.com', 'Developer I', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('avossgeniu', 'faHjarbIR', 'Alleyn', '2020-09-12', '남성', '1419 Bartelt Way', '888-879-8864', 'adolbeyiu@gmpg.org', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ajachimczakiv', '1lThdeJ5Y', 'Artur', '2015-03-22', '남성', '73095 Lindbergh Avenue', '322-181-8286', 'arisebareriv@dailymail.co.uk', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cyoelliw', 'Fr4XOk1', 'Caterina', '1994-12-26', '여성', '23302 Washington Center', '638-570-6626', 'cartindaleiw@toplist.cz', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tlistonix', 'jyM9Vkdsifpm', 'Tandie', '2015-07-16', '여성', '86020 Dunning Crossing', '412-963-0150', 'twarbysix@oracle.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('atheakeriy', 'aJKcfH6BHcuc', 'Aloysia', '1990-08-02', '여성', '34 Milwaukee Parkway', '186-792-0412', 'aburgoniy@livejournal.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rcopleyiz', 'NUsnvS3DxIvA', 'Rochell', '1998-02-08', '여성', '62426 Eggendart Terrace', '170-218-7628', 'rosborniz@archive.org', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('opackhamj0', 'ckgLD2WeBe', 'Orbadiah', '2006-08-08', '남성', '9718 Crownhardt Hill', '221-301-0421', 'oruhbenj0@google.ru', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdehnj1', 'nMAsmP', 'Cody', '1994-01-08', '남성', '00729 Dunning Park', '497-909-4626', 'cspeddingj1@studiopress.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cforstallj2', 'oXcnbEL1', 'Christoffer', '2011-04-09', '남성', '6 Maryland Drive', '475-660-2621', 'cmalinj2@php.net', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csteuhlmeyerj3', '8yLNBPZ', 'Chad', '2015-04-13', '남성', '43 Dottie Avenue', '469-318-3800', 'ccolstonj3@comcast.net', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kmattiatoj4', 'wSziDxE4ohO', 'Kerrin', '2022-05-16', '여성', '7811 Susan Junction', '918-532-3841', 'kkumaarj4@jugem.jp', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bferrerij5', 'Z3cAPH4j2', 'Brenden', '2004-09-19', '남성', '7592 Victoria Plaza', '486-850-2899', 'babreheartj5@foxnews.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tliebmannj6', '75KtOBnHAn', 'Tabbitha', '2021-09-17', '여성', '21151 Fulton Trail', '977-765-0943', 'tcongdonj6@examiner.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('afarnhamj7', 'gYAKiqkFy', 'Arline', '2001-08-18', '여성', '179 Hagan Park', '933-863-0343', 'apresmanj7@icq.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('eseagoodj8', 'ktnJdI29cQ', 'Elbertina', '1992-10-12', '여성', '05 Truax Court', '671-732-6063', 'ecootej8@github.io', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bmaulkinj9', 'J0hOC7KarQE', 'Belicia', '2018-02-18', '여성', '868 Union Avenue', '502-112-4380', 'bneemj9@blogs.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lcopemanja', 'Ani5jenw', 'Loralee', '1991-07-17', '여성', '32615 Alpine Drive', '424-312-9281', 'lfernelyja@tmall.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pkervinjb', 'JGzjzMyd', 'Perkin', '2006-01-23', '남성', '7552 Cordelia Road', '373-920-7096', 'pgourliejb@cafepress.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tgollardjc', 'cJ8fdS0', 'Thekla', '2018-09-24', '여성', '96 Pennsylvania Terrace', '232-633-2088', 'tidneyjc@photobucket.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gjappjd', '4Nhn0nmKd9', 'Georgena', '1990-11-17', '여성', '28 Delaware Plaza', '544-780-7326', 'gcloptonjd@bloomberg.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ofairbrotherje', 'ZTsbH7VO9', 'Ozzy', '1997-01-12', '남성', '3782 Saint Paul Hill', '145-795-3457', 'ofishbournje@squidoo.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mbranfordjf', 'ZEjPkOHNLUa4', 'Moria', '1996-09-06', '여성', '6084 Mesta Point', '222-308-0197', 'mminghijf@sbwire.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bsantojg', 'Q0IWgiPlK', 'Buddie', '2000-12-11', '남성', '376 Hayes Place', '631-361-2312', 'ballkinsjg@loc.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kcapstakejh', 'GGpSioW8C', 'Kale', '2008-10-27', '남성', '742 Independence Terrace', '465-661-7228', 'kcoronajh@behance.net', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pprineji', 'PP2Mv87J0s', 'Pru', '1999-05-29', '여성', '18025 3rd Alley', '612-897-1857', 'psteptowji@ameblo.jp', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('abustinjj', 'CLuZ5Ds3Tw', 'Adoree', '2018-04-19', '여성', '6168 Mariners Cove Street', '118-591-3263', 'aoharneyjj@sfgate.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kfulkesjk', 'Zid9KfewWqBl', 'Kissie', '2005-03-11', '여성', '3507 Summit Avenue', '802-823-4243', 'kfrostjk@microsoft.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nteresiajl', 'HdJegsPr', 'Nico', '2005-03-08', '남성', '8 Division Court', '639-283-0674', 'nfrederickjl@bluehost.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('alargentjm', 'HUKBWxqty', 'Alic', '1991-03-21', '남성', '07573 Bobwhite Lane', '615-595-6790', 'alavingtonjm@amazonaws.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('scaveneyjn', 'tR2Rc9', 'Saundra', '2016-02-11', '남성', '4538 Michigan Road', '643-901-1321', 'scowsbyjn@trellian.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gabrahamsonjo', 'BL1jtXk', 'Gail', '2000-03-12', '여성', '373 Tomscot Avenue', '649-683-0570', 'gframejo@com.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jparadycejp', '4NH3kjp', 'Joyce', '2008-08-14', '여성', '6 Fuller Parkway', '838-642-0296', 'jeddinsjp@webnode.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cthomtonjq', 'lVsywa36', 'Colman', '2022-11-29', '남성', '755 Barnett Hill', '805-693-8354', 'cshoresonjq@java.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('achazierjr', 'nAjykzh6', 'Ashil', '2015-06-06', '여성', '5 Dixon Way', '235-527-5315', 'acocklandjr@drupal.org', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ggaskinjs', 'MGEBON', 'Grata', '2000-12-11', '여성', '135 Rigney Way', '454-375-2416', 'gfibbingsjs@columbia.edu', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('avaneschijt', 'k4NM1aLAHz', 'Ardisj', '2003-02-10', '여성', '6 Stone Corner Alley', '236-458-8884', 'acharerjt@amazonaws.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vaikenju', 'UPuSnzWLkHQ', 'Vail', '2017-10-15', '남성', '2721 Autumn Leaf Road', '309-632-8519', 'vpreddyju@theatlantic.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('opeasbyjv', 'qh1J0JON', 'Oberon', '1999-07-24', '남성', '72 Rieder Terrace', '895-160-4825', 'ogierokjv@npr.org', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('podonohuejw', '8av1Tm9c', 'Pollyanna', '1998-07-07', '여성', '4 Del Sol Circle', '826-929-3985', 'psturtonjw@devhub.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('asilversmidjx', 'dbSh2KF', 'Angelica', '2009-01-15', '여성', '6 Forest Run Point', '779-349-4156', 'afarralljx@npr.org', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amacchaelljy', 'hNI7Y7C', 'Angelika', '1998-02-06', '여성', '69 Manley Center', '188-442-7252', 'amariansjy@economist.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jdomenichellijz', 'RJ3SOlKzIwF0', 'Joey', '2022-04-08', '여성', '7614 Commercial Alley', '989-135-8830', 'jgrunnilljz@zimbio.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ssomersetk0', '96KfPGVBiJI', 'Skipton', '1996-01-17', '남성', '90 Spaight Place', '302-957-9139', 'slingfootk0@comsenz.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ydorkensk1', 'qs1L9H', 'Ynes', '2002-10-14', '여성', '28 Randy Street', '272-135-7181', 'ydimeloek1@amazon.co.jp', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amacanek2', 'P3LRK5', 'Alethea', '1998-07-21', '여성', '65 Dayton Drive', '290-177-3436', 'astitlek2@geocities.jp', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('xferrisk3', 'Om90N2rDuxD', 'Xavier', '2009-06-27', '남성', '6 Dakota Drive', '668-544-1416', 'xfaceyk3@hexun.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bcleenk4', 'JqBldg', 'Bink', '2020-08-24', '남성', '45 Garrison Street', '393-448-5142', 'bmccullenk4@fastcompany.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sjacobsohnk5', 'EPmlcY9', 'Sybil', '1995-08-01', '여성', '07 Mccormick Park', '100-169-7802', 'ssaxbyk5@fc2.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ssivyourk6', 'OsPrq0KntL', 'Schuyler', '1992-04-29', '남성', '699 Florence Junction', '349-697-2569', 'ssutchk6@pinterest.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aplessingk7', 'SJ1YqV', 'Angelle', '2013-08-04', '여성', '5695 Holy Cross Place', '374-421-1083', 'aannablek7@goo.ne.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mronnayk8', 'KSR5Tg0D', 'Marylynne', '2017-01-28', '여성', '033 Southridge Alley', '935-745-0741', 'mpettusk8@patch.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ttatherk9', '6QHMnKPIwaI', 'Tobye', '2015-05-23', '여성', '01 Vahlen Center', '962-409-3399', 'tsighartk9@dedecms.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('arainonka', 'QZQHkzIkTD', 'Agnola', '2020-02-06', '여성', '58993 Service Point', '126-322-6209', 'acarlessoka@domainmarket.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('agrahamkb', 'nDWf2i5oTQV', 'Augustina', '2022-03-17', '여성', '639 Roxbury Court', '786-853-4285', 'agabbykb@smugmug.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mgrouerkc', 'viiajAUW', 'Marchall', '1995-10-06', '남성', '0 Sundown Court', '614-575-4113', 'mownsworthkc@networksolutions.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecoweykd', 'Gv1gOOya1C', 'Evelina', '2005-03-25', '여성', '695 Manufacturers Parkway', '279-446-9972', 'elitchmorekd@bravesites.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sczajkowskike', 'iCHop3cibT3d', 'Shurlocke', '2013-09-23', '남성', '3054 Duke Drive', '513-696-7758', 'sphilpottke@examiner.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cpfaffelkf', '6KAMs7wf4', 'Carmella', '2005-02-21', '여성', '959 Macpherson Point', '873-296-5197', 'cdenyakinkf@artisteer.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mdanielskykg', 'GApWpd9NRR25', 'Mycah', '2013-04-18', '남성', '02 Spaight Parkway', '509-848-9209', 'mkingsfordkg@sun.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('icoltankh', 'ezX87KVtjhOU', 'Iain', '2006-07-16', '남성', '11 Rieder Avenue', '353-366-2603', 'iterringtonkh@zdnet.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mquembyki', 'U6ZlHUXLO9', 'Merell', '1992-12-16', '남성', '4 Sherman Terrace', '811-777-3594', 'msilvermanki@prnewswire.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('leliasenkj', 'lLSiYvswvT', 'Lynnelle', '2010-05-16', '여성', '90 Knutson Way', '174-132-8933', 'llethcoekj@europa.eu', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aweatherellkk', 'ypLDUtpLrCxf', 'Ardelle', '1997-04-30', '여성', '9 Haas Park', '984-684-3606', 'awhitecrosskk@github.io', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('iohenehankl', '5G2HlL7', 'Isabeau', '2008-07-10', '여성', '4072 Hanover Avenue', '449-386-8442', 'imcowiskl@irs.gov', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ggoodsallkm', 'xlH5wP7xb', 'Glenn', '2010-01-24', '남성', '0253 Eastlawn Junction', '173-332-4137', 'ggrzesiewiczkm@ft.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acutmerekn', '1gNBwt', 'Adolphus', '2018-09-27', '남성', '3 Florence Trail', '697-842-1696', 'atockellkn@networksolutions.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('agatmanko', 'CJoHZudyUnG4', 'Ardith', '2005-02-25', '여성', '7604 Corben Pass', '619-579-3563', 'askinnerko@yellowpages.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wsinekp', 'RStTCX', 'Welch', '2004-08-08', '남성', '20 Novick Junction', '255-294-9853', 'woverkp@zimbio.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('oboycottkq', 'WORRs6SiV', 'Ogdan', '2003-01-08', '남성', '85 Arapahoe Street', '871-392-8266', 'obussekq@pbs.org', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wmcpolinkr', 'TkTQQ9', 'Winnah', '1994-04-01', '여성', '749 Buhler Crossing', '359-481-0417', 'wfurseykr@livejournal.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pschonfeldks', 'pqn4Hl', 'Porty', '2019-10-04', '남성', '7302 Golf Course Parkway', '192-207-6950', 'pobradainks@washingtonpost.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dbexonkt', 'oIjsp8Z', 'Delphine', '2014-08-09', '여성', '5 Golf Circle', '250-432-1883', 'ddiviskt@yale.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aiglesiaku', 'uF0cb70oIilW', 'Allistir', '2021-02-16', '남성', '31 High Crossing Parkway', '914-282-6540', 'arentonku@infoseek.co.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('alegravekv', 'zsNJ5LCu5sr0', 'Avie', '2007-09-26', '여성', '95 7th Alley', '181-551-1272', 'aboweskv@privacy.gov.au', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sreihmkw', 'j1pFGXWK6FqP', 'Sharyl', '2020-12-28', '여성', '64398 Canary Court', '212-785-0457', 'svellakw@pinterest.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('glibermorekx', 'luMGzr', 'Gasper', '2003-12-17', '남성', '68365 Upham Pass', '826-677-6684', 'gegintonkx@mozilla.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('larmitky', 'guKMhZlaxQO', 'Lou', '2008-11-22', '여성', '4 Old Gate Alley', '681-681-7662', 'lcarderky@cnbc.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('abottomskz', 'cviccA', 'Alix', '2003-11-07', '남성', '59 Scoville Road', '805-479-1034', 'acreegankz@blogspot.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mdalgardnol0', 'zfSdSFTCvo', 'Mile', '2013-05-04', '남성', '8 Dennis Court', '713-128-2526', 'mantonioul0@stanford.edu', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('apennycuickl1', 'yF8xzj', 'Abbot', '2005-06-25', '남성', '2998 Donald Drive', '527-821-5500', 'asimsl1@cbsnews.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mpendergrastl2', '6piOOM6UMqnV', 'Merilee', '2009-01-21', '여성', '52 Manufacturers Crossing', '658-336-5589', 'mlabounel2@stumbleupon.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('edisleyl3', 'jv0A3Plw', 'Erhard', '2011-10-26', '남성', '345 Springview Lane', '365-995-4501', 'ehanscombl3@ihg.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('owooffl4', 'XR7rOup', 'Orbadiah', '1998-03-28', '남성', '1 Judy Drive', '192-940-8260', 'odraycottl4@usa.gov', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fwestcarl5', 'kZOZuoxpd', 'Florence', '1998-10-13', '여성', '86 Melvin Parkway', '840-515-9230', 'fstaffl5@biglobe.ne.jp', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lwilkersonl6', 'OoIiHZU0Lu6h', 'Lana', '2018-09-16', '여성', '3774 Ridge Oak Center', '329-739-6883', 'lpatrickl6@github.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('amarzelel7', 'XVeY4fceo', 'Arne', '2000-10-14', '남성', '19 Bay Way', '996-483-3259', 'agrimoldbyl7@goo.gl', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hbalharriel8', '3rJ3PVfCTD7u', 'Harrie', '2014-09-04', '여성', '44 Ilene Road', '251-808-1256', 'hmatthessenl8@paypal.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hadamskyl9', '4xMGCAa6Zp8', 'Halie', '2015-05-31', '여성', '17 Moose Road', '481-475-7357', 'hclemmittl9@over-blog.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sfiddymentla', '8DvnYnDc', 'Sandie', '2009-01-11', '여성', '8 Warner Point', '280-404-7367', 'sfrankcombela@deviantart.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rgraveslb', 'yv7qMgS', 'Rutledge', '2011-01-16', '남성', '9670 David Way', '250-553-2867', 'rburkartlb@istockphoto.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tseccombelc', 'xqiN9aIZBDwU', 'Theresita', '1992-03-22', '여성', '37 Summerview Court', '158-748-6178', 'ttrowsdalllc@examiner.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('eroantreeld', 'mobisMV6KLe', 'Em', '2017-09-18', '남성', '72894 Merchant Avenue', '460-718-8459', 'egilderld@smh.com.au', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcurryerle', 'H3CMydCwYaMJ', 'Delila', '2003-03-22', '여성', '8079 Clove Parkway', '317-287-0502', 'dhaylettle@skype.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('omacdougallf', 'W08PFlSHFrn', 'Orly', '2005-07-16', '여성', '312 Cordelia Park', '235-471-0522', 'omionilf@microsoft.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccordenlg', 'C1GUcw', 'Corrinne', '2022-05-25', '여성', '8 Homewood Plaza', '122-485-8144', 'cnaceylg@phoca.cz', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kmazinlh', '8JAwRN5dh5', 'Ketti', '2014-05-26', '여성', '2945 Kensington Point', '143-859-8802', 'kmellhuishlh@google.es', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lshippli', 'AYbC54', 'Lisa', '1995-08-22', '여성', '19 Sherman Place', '442-852-8563', 'lelnerli@zdnet.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jstandrinlj', 'oJWS1D', 'Julie', '1996-09-16', '남성', '48688 Eagle Crest Hill', '658-627-1747', 'jweedslj@archive.org', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ehruslk', '6goZXy', 'Emmye', '2019-01-30', '여성', '59 Fair Oaks Point', '547-289-9301', 'epollaklk@naver.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tclemll', '4H8MMj', 'Travus', '2018-02-16', '남성', '1526 Erie Junction', '631-334-5367', 'tfortunll@hatena.ne.jp', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rfoxwelllm', 'urqMqYmYC5f', 'Roshelle', '2020-03-13', '여성', '625 Prairieview Place', '536-804-5025', 'rthorntonlm@angelfire.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ttomaselloln', '6p9gyhC1yho', 'Tamera', '1995-04-21', '여성', '8 Ryan Park', '953-441-7607', 'tdubbleln@zimbio.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hvankinlo', 'gPpzJebT', 'Harlan', '1991-06-29', '남성', '71162 Anthes Crossing', '302-668-9892', 'hmacterrellylo@yandex.ru', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lorricelp', 'DQetAixNEY5', 'Lisha', '1993-02-15', '여성', '726 Buell Terrace', '265-222-4196', 'lrittelmeyerlp@mit.edu', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wbartolommeolq', 'HnytWhO', 'Weidar', '2013-01-12', '남성', '58 Ryan Junction', '806-395-8908', 'wsnowballlq@opera.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('oeshlr', 'jho9l3XTbmfJ', 'Otho', '1997-03-27', '남성', '09 Main Point', '550-310-2345', 'ophilipardlr@latimes.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lswinerdls', 'QV64FogI', 'Les', '1996-07-12', '남성', '89 Carey Place', '732-784-8084', 'ljeynesls@a8.net', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rrustidgelt', 'xAuHQxxrs9', 'Roanna', '2007-10-09', '여성', '675 Huxley Pass', '775-189-5232', 'rovilllt@seattletimes.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ajothamlu', 'uifc5m', 'Antonius', '1999-11-09', '남성', '92 Rutledge Crossing', '899-933-5987', 'apidgeleylu@opera.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csidnelllv', 'nqs6NSfPqVOw', 'Corbin', '1993-05-08', '남성', '495 Dexter Parkway', '721-828-4543', 'cwelshlv@t-online.de', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rarkowlw', 'tZ5NG0y', 'Russ', '2012-02-16', '남성', '82 Barby Parkway', '865-313-8090', 'rskitterellw@stanford.edu', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nbeveragelx', '6A08EcFpO', 'Nickolas', '2014-06-03', '남성', '74464 Lakewood Gardens Junction', '501-496-3364', 'ndarwoodlx@prnewswire.com', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ulessliely', 'jPkKvicuvm08', 'Ulrich', '2004-06-24', '남성', '10 Mallory Circle', '134-979-5524', 'uwycliffely@tmall.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tvidgenlz', 'trRA4WoG', 'Theodor', '2005-06-07', '남성', '9 Anzinger Avenue', '803-882-1327', 'teccersleylz@typepad.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('snundm0', 'a2d69o4RIqDq', 'Sophia', '2020-03-31', '여성', '8985 Shasta Parkway', '593-767-8136', 'skuhwaldm0@smh.com.au', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lvintonm1', '2QUq3xgkdL', 'Leesa', '2005-06-28', '여성', '3 Maryland Junction', '238-422-0174', 'lfahertym1@google.co.uk', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tdutteridgem2', 'MyjkRZr', 'Tabatha', '2021-01-24', '여성', '3 Sugar Terrace', '802-393-3646', 'tblankenshipm2@globo.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mcamockm3', 'Tvx8j0', 'Mora', '2013-07-12', '여성', '448 Mallard Terrace', '416-645-1356', 'mbyerm3@skyrock.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wgallaherm4', '5S27xX9k', 'Wynnie', '1995-08-19', '여성', '8003 Badeau Parkway', '692-122-7312', 'wroubottomm4@google.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mwandenm5', 'LvIPsgiVjRr', 'Michelina', '2020-09-21', '여성', '93718 Shelley Circle', '639-783-3443', 'mstoodm5@yandex.ru', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fpimblottem6', 'bph5O1mG0', 'Fredric', '2012-05-14', '남성', '1362 Anderson Parkway', '485-247-4522', 'fleatherborrowm6@bluehost.com', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cclotherm7', 'SFAEIS', 'Cordelia', '2007-03-23', '여성', '73569 Hallows Drive', '201-513-4931', 'crowcastlem7@ed.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lbedborom8', 'MzSypSzHuXII', 'Lannie', '2000-11-14', '남성', '116 Morrow Plaza', '148-233-4447', 'lsnaddinm8@google.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmeenehanm9', 'Sq97eL', 'Rick', '2017-03-29', '남성', '03492 Northridge Street', '510-546-8811', 'rbridlem9@topsy.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gjessardma', 'eilguYcmgc3', 'Gianni', '2004-05-22', '남성', '92 Haas Park', '318-893-9230', 'gtoulamainma@archive.org', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ddevenishmb', '0Q2pK0WrRFF', 'Dick', '2005-01-26', '남성', '9086 Acker Junction', '548-880-2730', 'dgouldthorpemb@parallels.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wtrangmarmc', 'nYVYQ4CUH', 'Worth', '2000-11-08', '남성', '903 Texas Point', '378-223-4417', 'wmurismc@bbc.co.uk', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hgentlemd', 'LVoq3LovtO', 'Herbert', '2004-04-24', '남성', '79644 Independence Center', '628-994-5117', 'hnaveinmd@discuz.net', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('llivesayme', '2jaOCDcHI', 'Leone', '2006-05-17', '여성', '09 Parkside Trail', '234-211-3461', 'lvossme@google.ru', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ttolworthiemf', '8b7B9uUQnvp', 'Tedi', '1996-07-05', '여성', '16879 Rusk Junction', '150-865-2641', 'tmalimoemf@cisco.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csaywoodmg', '9VHdF7KiGgu', 'Courtenay', '2009-07-12', '여성', '8241 Eagle Crest Place', '912-295-8264', 'cwiersmamg@joomla.org', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccucinottamh', 'uFMUO7anf0Gr', 'Cullen', '2010-04-10', '남성', '47 Bay Hill', '543-488-2517', 'cvelasquezmh@spiegel.de', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bschwaigermi', 'xC4Gr28', 'Berni', '2013-05-20', '여성', '52 Forest Dale Lane', '162-364-6380', 'bbonifacemi@moonfruit.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dpembermj', 'D3fXlPvO1', 'Derrek', '2013-02-14', '남성', '8986 Service Lane', '486-380-7831', 'dcawsmj@ucsd.edu', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pinnerstonemk', 'Cgn4Fbs6', 'Pat', '2017-05-01', '여성', '03 Coolidge Plaza', '170-708-5520', 'pardleymk@tiny.cc', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('edanilovml', 'HCfgP7Fyb3', 'Evyn', '1998-11-15', '남성', '43600 Graceland Place', '510-247-6192', 'ematushenkoml@e-recht24.de', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pthorbonmm', 'SKTBVu4fAd', 'Patten', '2013-02-24', '남성', '237 Old Shore Avenue', '925-826-1752', 'pbenemm@nba.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mshovelbottommn', 'Efqf5Dpg', 'Michele', '1996-09-27', '남성', '5 Rusk Hill', '347-468-1671', 'mfindermn@chronoengine.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gopiemo', 'biK3qxWxW', 'Ginni', '2005-02-04', '여성', '99858 Mariners Cove Pass', '536-595-5810', 'gfranssenmo@jigsy.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aortzenmp', '10B28s15q79I', 'Aurel', '2012-05-27', '여성', '96 Menomonie Junction', '390-239-0058', 'ablazhevichmp@rambler.ru', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bsallariemq', 'VbEi1yTq', 'Burton', '1990-11-04', '남성', '7 Washington Road', '221-429-3845', 'bhickinmq@t.co', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('emozzettimr', 'Rk9n49y3', 'Emmie', '2004-01-01', '여성', '94 Schiller Center', '461-914-6783', 'egougemr@usnews.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aszaboms', 'bb45bSsAZCwC', 'Adamo', '2016-11-22', '남성', '06969 Rockefeller Terrace', '217-220-2498', 'astarbeckms@who.int', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ffordemt', 'H2zxNII1B1gi', 'Flss', '2007-06-09', '여성', '79382 Karstens Avenue', '614-282-9992', 'fguslonmt@weather.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tmacrowmu', 'mN67tkhe', 'Thomasine', '2014-07-22', '여성', '4549 4th Court', '641-917-5696', 'tmapsonmu@reference.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gwewellmv', 'j2rNklWsvNzB', 'Giorgi', '1998-05-23', '남성', '9096 Arapahoe Pass', '746-418-9831', 'gchristenemv@examiner.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wgrunnellmw', 'aR7d55uhR', 'Waverley', '1998-08-21', '남성', '905 Schiller Center', '167-124-0769', 'wbrimnermw@indiatimes.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kandricmx', 'ErKZlVZu0', 'Katharina', '2002-07-24', '여성', '0 Hazelcrest Pass', '228-971-2070', 'kperlmx@drupal.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('umcillrickmy', '3TPwCG0AEH9', 'Ulrick', '2018-01-12', '남성', '0 Veith Alley', '997-798-2125', 'uyurkovmy@hud.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hfleaymz', 'Sqeptuu', 'Helge', '2010-10-27', '여성', '4 Hollow Ridge Parkway', '296-229-6695', 'hhebbronmz@home.pl', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cmoncrieffen0', 'DMDdiyS', 'Carissa', '2022-06-07', '여성', '1 Summer Ridge Parkway', '370-703-1885', 'crickertsenn0@jugem.jp', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ggauchiern1', 'oAapfZDJnTn', 'Garwood', '1995-03-05', '남성', '55 Kennedy Circle', '922-869-2190', 'giwanowiczn1@ow.ly', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('zcollinn2', 'S2iN1y0gxrz', 'Zedekiah', '1991-01-16', '남성', '38 Tony Circle', '153-371-4951', 'zfrearn2@biglobe.ne.jp', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bmellmothn3', 'BXefqD0', 'Berk', '2006-03-25', '남성', '4 Northfield Lane', '774-715-4232', 'btroddn3@angelfire.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('csurphlissn4', 'qYG80FB6', 'Chrystel', '1997-08-19', '여성', '2597 Knutson Plaza', '612-425-0518', 'ckeaveneyn4@delicious.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('shoonahann5', 'MdEq4okrYM6g', 'Stevy', '2012-11-09', '남성', '8 Delladonna Point', '895-588-7910', 'sklimschn5@nytimes.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmartinhon6', 'NnZbUfHzO', 'Rubina', '2008-05-13', '여성', '231 Reindahl Lane', '584-469-3114', 'rpurcelln6@smh.com.au', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tbressonn7', 'a9NZQHMJ', 'Tobias', '1994-11-16', '남성', '589 Caliangt Drive', '706-757-1322', 'tleathlayn7@google.pl', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bsomerscalesn8', 'e6GbuC', 'Barde', '2018-08-17', '남성', '5 Dottie Lane', '588-285-2256', 'bknivetonn8@shop-pro.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cgentschn9', 'SxHpkCTpD', 'Cad', '2018-07-04', '남성', '0535 Rowland Crossing', '716-934-1154', 'ckeymen9@miibeian.gov.cn', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gchadwickna', '5ZND8ArHAy', 'Gene', '2008-11-30', '남성', '8871 Waxwing Avenue', '487-562-5867', 'gmaryskana@free.fr', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aspillmannb', '67tWBbF3', 'Ardith', '1998-10-31', '여성', '4 Graedel Pass', '455-362-6699', 'acissellnb@sogou.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bstertnc', 'zHRZrcP', 'Brenda', '2019-07-05', '여성', '8 Debs Circle', '248-610-7853', 'bbaldacchinonc@upenn.edu', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cbowchernd', 'g5aKt0za', 'Carce', '2012-07-31', '남성', '599 Butterfield Way', '435-554-9249', 'cbrunond@fotki.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sscimonene', 'awEowcZ15', 'Shirline', '2022-01-12', '여성', '3304 West Avenue', '831-768-9532', 'sskentelburyne@miibeian.gov.cn', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('relmarnf', '9WM1LU', 'Reagan', '2014-01-24', '남성', '8828 Bay Hill', '978-338-1655', 'rburnsidesnf@psu.edu', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('edegiorgiong', 'WyYknfUxo', 'Ernst', '1992-01-20', '남성', '2593 Sauthoff Trail', '152-303-2842', 'elindrong@state.tx.us', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rgabernh', 'xcyLsPwlP4Zr', 'Rancell', '2006-12-04', '남성', '4104 Grasskamp Circle', '860-719-7238', 'rheinishnh@netlog.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('stuckleyni', 'QFeIWM0e', 'Sharron', '1993-01-02', '여성', '80 5th Place', '931-601-6029', 'sapedaileni@unicef.org', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aoxbrownj', 'cc0rF3IdxFG', 'Agustin', '2002-12-18', '남성', '10760 Victoria Drive', '943-286-8284', 'apettersennj@cargocollective.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccratchleynk', 'fuhqJMaRc4Q', 'Carola', '1993-01-01', '여성', '10458 Meadow Valley Way', '673-490-7226', 'cklugenk@live.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jhuckernl', '2iiM1JaV', 'Janelle', '2019-06-30', '여성', '61089 Delladonna Circle', '463-257-7028', 'jchevertonnl@salon.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rtrewarthanm', 'IqMetutgL', 'Riccardo', '2006-01-14', '남성', '0266 Shelley Lane', '119-217-1633', 'rwatkissnm@theglobeandmail.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hhinckesnn', 'knBIMWz', 'Hedi', '1999-06-18', '여성', '82624 Lindbergh Terrace', '930-429-5135', 'hmitchinernn@elpais.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tfarlambno', '6lf4ae4kV', 'Terry', '2006-01-19', '여성', '5 Monterey Court', '231-720-4691', 'tpeasgoodno@hubpages.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bstaignp', 'ousZrib', 'Brewster', '2013-11-10', '남성', '8 Claremont Plaza', '166-238-5293', 'bricksnp@narod.ru', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dboignq', 'BOxpmAg', 'Derk', '2004-10-12', '남성', '4468 Badeau Junction', '703-916-7715', 'dsaltersnq@ifeng.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('spollendinenr', 'H2sbjT', 'Sidnee', '2011-10-07', '남성', '48666 Nancy Parkway', '907-605-1797', 'seassebynr@biglobe.ne.jp', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mwillmentns', 'CLfcJuytkq', 'Maddalena', '2005-03-15', '여성', '96 Raven Terrace', '932-985-2414', 'mboolns@fastcompany.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pmewsnt', '31iVtMVTdHT', 'Piper', '2009-11-06', '여성', '70106 Dayton Terrace', '791-144-7829', 'pbwynt@symantec.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bmacneilagenu', 'QV7cuYD6fM', 'Bertrand', '2019-12-24', '남성', '42013 Ronald Regan Lane', '872-560-0475', 'bcrabbenu@twitter.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pculvernv', '0s1S1HsvLuT', 'Puff', '2005-05-21', '남성', '705 Packers Street', '393-249-6214', 'pplanenv@edublogs.org', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('klislenw', 'WDeoELSn1E', 'Kelcy', '2020-04-16', '여성', '38 Talisman Road', '612-992-8288', 'kmurrnw@usa.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mbickardikenx', 'dog4ZjAxYSE', 'Moises', '1991-08-17', '남성', '21 Meadow Valley Trail', '316-294-1936', 'makriggnx@vistaprint.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nmillwallny', '3FR6B9', 'Neala', '2014-07-12', '여성', '8 Fordem Court', '301-294-1084', 'nbremleyny@360.cn', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ecrichmerenz', 'Ms0azrT', 'Elmira', '2003-10-10', '여성', '43035 Glacier Hill Terrace', '227-129-6704', 'earmandnz@opensource.org', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dplumbleyo0', '4W5vfRz', 'Danette', '2022-09-08', '여성', '0024 Del Mar Plaza', '539-636-8279', 'dweatherbyo0@sfgate.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('equeripelo1', 'PbDafyFr', 'Eugen', '1991-01-01', '남성', '79 Shasta Place', '797-662-0154', 'efirko1@youtube.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bwickwaro2', 'K5bibBEQfz1', 'Berkie', '1999-06-22', '남성', '62844 Fuller Park', '946-849-3465', 'bstoadeo2@amazon.de', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ncumberso3', '4lZF7xVZAa', 'Naomi', '1992-12-11', '여성', '63987 Hanover Alley', '705-599-0978', 'nmeganyo3@gravatar.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vittero4', 'zuGXOCZXbVSS', 'Vasilis', '2007-01-07', '남성', '54499 Schlimgen Terrace', '481-432-9559', 'vpurdeyo4@mozilla.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hmotto5', 'g8R496', 'Humphrey', '2018-01-13', '남성', '3 Holy Cross Way', '883-241-1686', 'hridgleyo5@ihg.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcoggillo6', 'EYBmxU', 'Dall', '2012-08-01', '남성', '71258 Delaware Place', '114-344-4181', 'dmasdino6@merriam-webster.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nfitzsymondso7', 'IPGW8zTs', 'Nadya', '2016-01-19', '여성', '817 Autumn Leaf Lane', '540-677-2030', 'nwinscombo7@over-blog.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ljanso8', 'LQIMQm', 'Lydie', '2018-08-30', '여성', '4929 Crescent Oaks Junction', '884-481-9478', 'lhookeso8@topsy.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cogreadyo9', 'kCXNUlP', 'Cullen', '2003-11-21', '남성', '5 Oak Court', '738-980-1745', 'cstaddarto9@hatena.ne.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ccarahoa', 'jhlOi0yv5gT', 'Carlita', '2005-03-02', '여성', '4841 Dakota Parkway', '423-462-1236', 'cwayvilloa@engadget.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mguilaemob', 'qKbNOaI', 'Maria', '2017-05-23', '여성', '98 Columbus Trail', '459-697-2486', 'merskinob@technorati.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lcoateoc', 'jzdNL1MAhd', 'Lev', '2009-07-31', '남성', '0 Sachtjen Street', '950-103-7674', 'ledselloc@google.ru', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vdomineyod', '2dWhPuUcIRLP', 'Velvet', '2020-11-03', '여성', '6 Michigan Plaza', '928-640-7668', 'vbatchelorod@reverbnation.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gromeroe', 'E37hoHIFFg', 'Genovera', '2016-11-20', '여성', '078 Oxford Park', '463-753-2590', 'gezeleoe@example.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mcondellof', 'PpP9FcS7Lk8', 'Meredith', '2008-08-27', '남성', '78 Prairieview Street', '293-884-2007', 'mbiskupekof@answers.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('msummersideog', 'D2lmEgCu', 'Mel', '2011-06-05', '여성', '9 Talisman Plaza', '252-815-9204', 'mlyonsog@ed.gov', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dkennonoh', 'EOKu64YDW4', 'Derward', '2017-09-29', '남성', '40 Florence Park', '965-553-9140', 'dlarkingoh@ox.ac.uk', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ewhordleyoi', 'IMHKcS4OZw', 'Ezequiel', '1999-11-01', '남성', '6 Crowley Circle', '325-863-1687', 'ellopisoi@reference.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hmatuskaoj', 'kd05AVZL9D', 'Hall', '1992-09-27', '남성', '402 Stone Corner Lane', '233-359-6162', 'hwillockoj@theglobeandmail.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('marcaseok', 'GyqYC7MdqCE', 'Mathe', '2013-03-25', '남성', '52 Melvin Drive', '887-793-7462', 'mtwellsok@nbcnews.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kfarrinol', '3xUDIbXxxiVK', 'Kain', '2022-05-16', '남성', '5189 Emmet Street', '388-217-2054', 'kpitcaithleyol@nytimes.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcardiffom', 'rJkDFIv57', 'Darb', '1996-06-20', '남성', '0978 Stoughton Terrace', '921-680-2289', 'drambleom@hp.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hkiehlon', '5gTGe9Z', 'Hildegaard', '1998-12-27', '여성', '5 Springs Hill', '824-643-8739', 'hbonhommeon@google.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mfratsonoo', 'zKXXI1', 'Matti', '1996-10-06', '여성', '7 Charing Cross Parkway', '863-422-4805', 'mdentonoo@ox.ac.uk', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tsibberingop', 'jrfcboRR', 'Tyne', '2018-03-28', '여성', '76696 Waubesa Pass', '643-772-6195', 'tpinnionop@shop-pro.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nyoungeoq', 'Qyky7a4E', 'Nanni', '1999-01-06', '여성', '040 Daystar Junction', '638-963-2990', 'nallumoq@cafepress.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jblasgenor', 'rFTt0B8XaY4', 'Jacquetta', '2002-08-02', '여성', '63 Kingsford Road', '445-878-6151', 'jjallandor@ow.ly', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mlangcastleos', '5yUs0QAG6', 'Margarette', '1996-08-05', '여성', '901 Paget Avenue', '813-426-6392', 'mblickos@cbslocal.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dgarrowayot', 'VCMeWCKKTG6', 'Duncan', '1996-06-17', '남성', '8343 Monica Circle', '183-172-2589', 'dthurbyot@amazon.co.jp', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bfominovou', 'giCue0FeDv1', 'Bobina', '2022-10-01', '여성', '422 Moulton Alley', '794-892-6021', 'bdavidekou@dailymotion.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nrainerov', 'UgnHgK96', 'Naoma', '2012-08-16', '여성', '057 Kropf Junction', '820-623-5543', 'nblamiresov@scientificamerican.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hakenheadow', 'wAQiUdN1Dk', 'Hilliary', '2014-07-09', '여성', '7 Manley Circle', '731-166-9588', 'hsheehanow@deviantart.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cbubeerox', 'wHvCNL1zs', 'Cletis', '2008-09-10', '남성', '710 Village Green Plaza', '825-584-9129', 'cjudronox@epa.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rmannionoy', 'IHQOJQeP', 'Rasia', '2018-01-12', '여성', '7395 Hovde Center', '603-462-9489', 'rfontenotoy@abc.net.au', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mmandyoz', 'Hp7eqpkz', 'Marlene', '2016-10-15', '여성', '6 Briar Crest Terrace', '821-942-2572', 'mgarretsonoz@bbc.co.uk', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jrosellp0', 'O7D82FR0ej9A', 'Jordain', '2004-09-14', '여성', '85034 Dottie Court', '976-859-2581', 'jferrymanp0@salon.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('alegrovep1', '1rVxAZgN2JsG', 'Amory', '2018-10-11', '남성', '99068 Oak Street', '960-216-2437', 'ashurmorep1@mayoclinic.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gvanep2', 'O46D5qG2m', 'Gussi', '1994-12-09', '여성', '5920 Lawn Center', '702-732-6207', 'gnearyp2@canalblog.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jgedlingp3', 'ouL2BFlT6', 'Jemima', '2008-08-21', '여성', '48736 Manufacturers Drive', '468-244-8043', 'jfitzpaynp3@icio.us', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ehyndsonp4', 'Khllj3jeL56E', 'Eben', '2020-03-29', '남성', '06496 Union Parkway', '923-642-1342', 'eashwoodp4@unc.edu', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jshimonp5', 'TvqYTZ', 'Joli', '2001-01-08', '여성', '7677 Kenwood Way', '266-874-4138', 'jgerramp5@comsenz.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mprangnellp6', 'yH5AhVkW', 'Marlo', '2019-08-10', '남성', '468 Vernon Alley', '571-918-6773', 'mzimmermannsp6@imageshack.us', '서비스/ 영업/ 판매직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vtiremanp7', 'HhncSu', 'Virgil', '2017-02-26', '남성', '835 Oakridge Pass', '632-201-0139', 'vlehemannp7@sourceforge.net', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jbelmontp8', '1kxsXu', 'Jemmie', '2014-02-20', '여성', '9630 Hallows Avenue', '154-950-4091', 'jkovelmannp8@shinystat.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hschustlp9', 'IsWRU910H', 'Hayley', '2002-02-09', '여성', '1 Bunting Parkway', '566-850-9605', 'hmcvityp9@mail.ru', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cdurbinpa', 'bDxjzWW0bK', 'Cyrillus', '2000-01-30', '남성', '3 Summit Lane', '425-660-8902', 'cbutlinpa@nytimes.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('oniccolspb', 'P1R6b4RxBFg', 'Oliy', '2000-05-19', '여성', '84798 Delladonna Junction', '697-195-8832', 'ojayespb@facebook.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bridelpc', 'cQWiyrabzJ', 'Bevon', '2008-05-06', '남성', '8226 Mesta Point', '819-150-7570', 'brewcastlepc@vistaprint.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gvinickpd', 'CoD3rB', 'Gil', '2015-06-18', '남성', '85 Brentwood Park', '628-566-6943', 'gtolomeipd@google.com.hk', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jlawelespe', 'NkGhMFV6wk', 'John', '2019-06-04', '남성', '17 Walton Point', '480-942-8404', 'jsurgeonerpe@oracle.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('apuckhampf', 'GhfPIru4jE', 'Alidia', '2008-12-08', '여성', '1 Arrowood Way', '974-370-5841', 'aansticepf@wikispaces.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rbussepg', 'bjHB96lp2E', 'Ringo', '1991-03-31', '남성', '14 Buell Pass', '282-489-9690', 'rarranpg@washington.edu', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sroppph', 'WpGL4cR1GE', 'Sully', '2007-05-20', '남성', '16382 Blue Bill Park Drive', '174-337-7325', 's남성ph@adobe.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('oreppaportpi', 'rjNVYU', 'Ophelia', '1996-04-20', '여성', '39872 Graedel Parkway', '256-985-5860', 'omoretpi@weather.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jidwalevanspj', 'lwPCNYBNMpA', 'Jewel', '2008-08-09', '여성', '48 Holmberg Street', '875-902-7462', 'jwyvillpj@imgur.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmaccaffertypk', '9tHi326', 'Jules', '1993-12-21', '남성', '09 Union Terrace', '780-241-6994', 'jcurpheypk@timesonline.co.uk', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ldadamopl', 'wYw6kSnt', 'Laurent', '2005-02-01', '남성', '4 Russell Center', '362-220-3821', 'lsedgwickpl@census.gov', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acurmipm', 'SFUPX7', 'Amye', '2015-02-26', '여성', '2 Di Loreto Park', '816-230-5091', 'aquelchpm@china.com.cn', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('scluelypn', 'ZrinPjMLXCfg', 'Stanley', '1995-04-04', '남성', '5 Heath Park', '346-660-1866', 'sdownagepn@boston.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbiasipo', 'IqhOUpa', 'Barnard', '1996-10-04', '남성', '275 Golf View Terrace', '662-972-2471', 'bheatonpo@npr.org', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lkincaidpp', 'v6zZpn6NY7i', 'Leilah', '1995-02-19', '여성', '691 Corscot Park', '363-708-0529', 'lmargerrisonpp@purevolume.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('iburgoinpq', '5B0CcQe4G', 'Innis', '2019-07-29', '남성', '321 Little Fleur Point', '984-194-9234', 'icowgillpq@columbia.edu', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rlochetpr', 'sRk1psxda', 'Ranee', '2002-11-13', '여성', '26 Arapahoe Center', '498-531-7443', 'rwhitehornepr@go.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('awhitnallps', 'hLEVvd', 'Aylmer', '2001-07-23', '남성', '12432 Springview Lane', '277-585-9332', 'arubenovicps@nyu.edu', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('nduffilpt', 'ZnFsKPXAQ', 'Norton', '2016-05-05', '남성', '99868 Manufacturers Hill', '124-470-4298', 'nallingtonpt@google.com.hk', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bbrierlypu', 'wBgS9egZ', 'Blinni', '1994-04-21', '여성', '17 Shasta Drive', '227-797-4454', 'bhallewellpu@skype.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hlynaghpv', 'VmtTdFgljhZ', 'Hurleigh', '1992-12-06', '남성', '69 Continental Park', '509-245-2165', 'hcarnpv@sourceforge.net', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vfyrthpw', 'GNDCjY9d0d', 'Virgilio', '2014-06-17', '남성', '50351 Marcy Crossing', '104-417-8144', 'vtrencherpw@addtoany.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dohenerypx', 'pdKldMss0', 'Dalston', '1991-07-02', '남성', '85 Tomscot Trail', '549-274-4469', 'dhegdenpx@artisteer.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kosbidstonpy', 'GjnBFwrG', 'Kat', '2021-05-11', '여성', '73046 Commercial Drive', '915-484-8581', 'kbeangepy@skype.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bdackpz', 'VNwmWOfSJp', 'Becki', '2018-02-24', '여성', '00207 Oak Center', '554-111-3878', 'bdurranpz@webmd.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aorrellq0', 'YsXXTX42x1N', 'Almeta', '2015-01-26', '여성', '36811 Stuart Drive', '761-481-7858', 'abueyq0@addtoany.com', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('scashmoreq1', 'WLFMjH', 'Skipton', '2014-04-09', '남성', '79 Sutherland Road', '711-372-4930', 'scordeixq1@mozilla.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vpechaq2', '8s08kwRSwB', 'Vassily', '2003-10-24', '남성', '84476 Hintze Parkway', '877-830-6045', 'vlemanq2@cargocollective.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bmashq3', 'qvuGA7P85Ijc', 'Beau', '1992-11-25', '남성', '081 Myrtle Place', '431-945-1987', 'bbathaq3@cisco.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bonealq4', 'QRZ7A1fm2X', 'Barret', '2004-01-28', '남성', '4 Pleasure Pass', '851-699-6505', 'bsapeyq4@1und1.de', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lbellangerq5', 'nRcCsyQi', 'Launce', '2013-10-07', '남성', '1 Mallard Lane', '574-525-8222', 'lkirschq5@globo.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lbaythropq6', 'Qj9kFOL', 'Latia', '2021-03-19', '여성', '84 Porter Street', '792-311-6766', 'ljoslingq6@businessweek.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jrayworthq7', 'ooVMaSS2i', 'Jessalyn', '1991-12-10', '여성', '8206 South Way', '591-665-2814', 'jissacsonq7@bandcamp.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rollivierreq8', 'kVhCTH0m8X', 'Robbyn', '2017-11-07', '여성', '42 Fordem Center', '449-162-0093', 'rghioneq8@berkeley.edu', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('gbreznovicq9', 'GjvLGdWqojpG', 'Goldie', '1999-04-09', '여성', '0 Gerald Street', '481-342-7234', 'gshilstoneq9@geocities.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dminshullqa', '2HvpC3H', 'Dan', '2009-01-15', '남성', '56 Rieder Parkway', '530-323-7008', 'dcurbishleyqa@skype.com', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kgrievsonqb', 'bPYFDP', 'Kellby', '1994-09-26', '남성', '55 Stephen Point', '589-795-7541', 'ksteedenqb@arizona.edu', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('aformieqc', '1qbIzjoS', 'Allayne', '2003-03-31', '남성', '6 Warrior Trail', '741-218-0910', 'adimeoqc@netvibes.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mrosiqd', 'Ay8EFdKmoJ0', 'Muhammad', '2016-09-25', '남성', '43 Morrow Pass', '951-620-9083', 'msabatiqd@soup.io', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fvasicqe', 'WZz8FcXPGNn9', 'Fidelio', '2019-02-12', '남성', '66019 Farragut Hill', '495-286-5780', 'fbednellqe@nba.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('bjosephqf', 'fkESSVMi0ouq', 'Benson', '2008-10-30', '남성', '077 Ohio Hill', '826-118-3906', 'bponteqf@nature.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dspellecyqg', 'vuniRj9', 'Derwin', '2004-12-21', '남성', '2 Fremont Drive', '679-511-2973', 'dskevingtonqg@pen.io', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wmulbryqh', 'RcmKOI8qCgI', 'Wilbert', '1997-03-27', '남성', '48194 Gerald Pass', '524-603-8042', 'waldrinqh@aol.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ajadosqi', 'zAY9awn', 'Aldis', '2009-03-24', '남성', '6 Glacier Hill Center', '708-958-7149', 'agleasaneqi@mtv.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('tvearncombeqj', 'muqjROVN1', 'Tommie', '1995-02-21', '남성', '85 Jenna Road', '951-529-2334', 'twraightqj@ezinearticles.com', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('solczykqk', 'CmAX9JLpuXJ', 'Sigismond', '2005-02-20', '남성', '729 Coolidge Lane', '637-906-1273', 'scrookeqk@goo.ne.jp', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rpfaffeql', 'xjFTedd', 'Rickie', '2011-12-25', '남성', '931 Victoria Street', '879-176-6691', 'rewinsql@state.gov', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('wrenhardqm', 'RVTWJowzc0fX', 'Wald', '2022-06-02', '남성', '02614 Waywood Point', '849-610-9470', 'wiacovielliqm@un.org', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mgambieqn', 'jmx7RcIEcY', 'Merwin', '1993-03-17', '남성', '6206 Toban Lane', '353-728-9110', 'mbavageqn@spotify.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('yrainqo', 'SQA0HU', 'Yvette', '2000-02-14', '여성', '2 Tomscot Road', '949-660-6543', 'ykinceyqo@unblog.fr', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('fstrickqp', 'yaRHUgEn402p', 'Farah', '2008-07-29', '여성', '21861 Loftsgordon Circle', '760-974-1443', 'fmackisonqp@gravatar.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cpollicattqq', 'xX19OT', 'Chickie', '1992-08-06', '남성', '42 International Center', '259-250-3446', 'cobrianqq@webmd.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kdahlbomqr', 'pUc8Wq', 'Kipp', '1991-09-17', '남성', '7 South Place', '672-492-7732', 'kleftleyqr@mapquest.com', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rhartburnqs', 'J1OyGO', 'Rozanne', '1992-11-07', '여성', '9343 Union Lane', '152-157-6490', 'rolerenshawqs@springer.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('roscannillqt', 'gM1Wxum', 'Rahal', '2010-09-02', '여성', '0945 Corry Court', '983-799-2125', 'rgabbottsqt@desdev.cn', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rdevilqu', 'jv5D67H', 'Roz', '2022-02-05', '여성', '56 Sunfield Way', '413-183-9746', 'rbortoluzziqu@ycombinator.com', '농/임/어업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kdutteridgeqv', 'QpYLupmp3IB', 'Koenraad', '2018-07-15', '남성', '8 Scoville Lane', '789-734-8306', 'kglasscottqv@imageshack.us', '생산/ 기술직/ 노무직V', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('osummerfieldqw', '7xT3Zp6M', 'Ofelia', '2012-12-24', '여성', '557 Miller Point', '769-274-9714', 'opiggremqw@amazon.co.jp', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jkippaxqx', 'AOhYf9E3QViW', 'Jilleen', '2004-12-10', '여성', '8693 Drewry Drive', '413-989-3071', 'jrallinqx@clickbank.net', '사무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rflettqy', 'BXtXeiDO9Cs', 'Raynor', '1991-02-17', '남성', '76 Loomis Alley', '349-928-8470', 'rhartusqy@people.com.cn', '무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cbarnewilleqz', 'S0BDNz', 'Chlo', '2011-11-29', '여성', '4291 Waxwing Road', '282-217-0479', 'cunionqz@smh.com.au', '공무원(공기업포함)', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('djakor0', 'OdDW8klHnn', 'Dagny', '1994-12-22', '남성', '573 Autumn Leaf Way', '778-741-0822', 'dboylundr0@blinklist.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hcryerr1', 'HMs6IAp', 'Harley', '2014-04-15', '여성', '887 Maryland Place', '472-535-4060', 'hsandesonr1@soup.io', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('mgiacobillor2', 'DnxKiTrzyv', 'Marinna', '1997-04-02', '여성', '69466 Village Green Junction', '680-766-0883', 'mlandorr2@reddit.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rroizr3', '03memwp6', 'Rosie', '1995-05-09', '여성', '100 Pierstorff Drive', '225-937-6055', 'rliccardir3@fastcompany.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('kaspinr4', '7h3SMgRk', 'Kerianne', '2002-11-23', '여성', '64 Fuller Park', '447-245-3980', 'kmcquorkellr4@blogger.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('acasoner5', 'TjXnOkTk97', 'Alexis', '2011-04-28', '여성', '1586 Dottie Way', '687-455-9907', 'abilamr5@shutterfly.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('glakesr6', 'LPmBlMZGu', 'Gabriel', '1995-01-29', '남성', '4 Messerschmidt Circle', '883-355-0388', 'gpllur6@abc.net.au', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ygwatkinsr7', 'uCLnTj', 'Yasmin', '2001-06-15', '여성', '3 Hallows Drive', '561-267-2122', 'ystaningr7@salon.com', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sconer8', 'ELspKP', 'Stephana', '1991-09-20', '여성', '0 Anzinger Drive', '615-597-5183', 'studhoper8@yahoo.com', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jphippinr9', 'h2S98NzS', 'Jeni', '2015-03-07', '여성', '25 Buhler Way', '918-398-0450', 'jcamilir9@jiathis.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cwollardra', 'JbhvLst', 'Cammie', '2005-03-02', '여성', '531 Judy Trail', '400-444-4653', 'crochellra@w3.org', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('cpringellrb', 'jJXzVj', 'Clary', '1995-05-27', '여성', '46640 Anniversary Parkway', '315-438-4718', 'cfowellrb@live.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rbarnewellerc', 'MCWRcnnI0', 'Robinia', '2021-03-15', '여성', '1453 Portage Avenue', '991-500-8748', 'rdumphreyrc@ca.gov', '경영직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jmckinnonrd', 'GwkhhdZ', 'Jakob', '2008-07-20', '남성', '9 Schiller Road', '858-428-1976', 'jwhacketrd@soundcloud.com', '전문직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('hharriesre', 'kw69ptKU', 'Helga', '2020-10-19', '여성', '14380 Lakeland Way', '298-220-2475', 'hambrogettire@drupal.org', '전업주부', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dcotsfordrf', 'aAWwS5Nj', 'Dorothy', '2019-09-09', '여성', '0999 Truax Place', '608-308-4662', 'dkaganrf@yellowpages.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('pbrindedrg', 'HomlYuuuEwJS', 'Prudy', '2010-09-17', '여성', '5 Weeping Birch Drive', '702-269-2643', 'pcawkillrg@noaa.gov', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('vblowrh', 'oanx6njOa4F', 'Vittoria', '1994-02-11', '여성', '49755 Reindahl Plaza', '619-988-9284', 'vbelfitrh@ameblo.jp', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('ceastwayri', '3THUkZzS4a1', 'Clarance', '2017-09-25', '남성', '01263 Sutherland Plaza', '217-564-9593', 'culyatri@amazonaws.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lgrocottrj', 'dx9UkZXTV8', 'Lura', '2002-10-30', '여성', '37 Milwaukee Parkway', '551-904-8652', 'lthayrj@ibm.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('rpatesrk', '2gaq18awnMyA', 'Roxi', '2019-02-24', '여성', '85 Green Road', '490-947-0390', 'rfullwoodrk@is.gd', '생산/ 기술직/ 노무직', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jkienzlerl', 'UP2suvWW5IR3', 'Jared', '1997-12-25', '남성', '7860 Raven Place', '233-758-5044', 'jbrinklerrl@biblegateway.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('dsymondsrm', '2IgYG4or34c', 'Dory', '2012-12-04', '남성', '1 Goodland Plaza', '588-848-9326', 'dharveyrm@imdb.com', '자영업', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('btweedellrn', 'XhnpyNLi', 'Berty', '2004-01-31', '여성', '232 Mallard Place', '895-557-9985', 'bdelasallern@eepurl.com', '자유직/프리랜서', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('sroscampsro', 'hRu4aX', 'Shanta', '2017-07-17', '여성', '34117 Shoshone Circle', '644-196-4719', 'ssagersonro@wikia.com', '기타', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('lfabbrp', 'DZ8pb6Fe', 'Lu', '2018-06-24', '여성', '9571 Lyons Place', '446-182-9517', 'ltordifferp@apache.org', '교사/학원강사', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jkeavenyrq', 'EySBwu6P', 'Julius', '2009-07-14', '남성', '71 Bunker Hill Court', '168-442-9795', 'jbriteerq@sun.com', '학생', 'Member');
insert into member (user_id, user_pw, user_name, user_birth, user_gender, user_address, user_phone, user_email, user_job, user_type) values ('jgerattrr', 'Cfi16C4P', 'Julienne', '1994-04-09', '여성', '7464 Fremont Hill', '175-299-6226', 'jdubbinrr@surveymonkey.com', '전문직', 'Member');

select * from member order by user_idx;


---------------------------------------------------------------------------------------------------------- 게시판 -----------------------------------------------------------------------------------------------------------
    

insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values(4, 'ap9407', '더미데이터 쌓는거 개귀찮음 ㅇㅈ?', '쉽게할만한 방법 추천좀용~', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (2, 'objade', 'Augue.xls', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Lacus.mp3', 'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/11.0.652.0 Safari/534.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Aliquam.xls', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'CurabiturInLibero.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; ja-JP) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'OrciLuctus.xls', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Est.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; de-de) AppleWebKit/534.15+ (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Sed.tiff', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'InQuam.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.803.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', '0aUltrices.jpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.861.0 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DonecDiamNeque.avi', 'Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20100101 Firefox/7.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'SedAccumsanFelis.txt', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/21.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'AtNibhIn.mpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'In.avi', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20120421 Gecko Firefox/11.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'TemporTurpis.png', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; zh-cn) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DuisAt.tiff', 'Mozilla/5.0 (Windows NT 6.0; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Donec.ppt', 'Mozilla/4.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/11.0.1245.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'EuMagnaVulputate.avi', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.815.10913 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'InterdumVenenatis.ppt', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.699.0 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'Cras.avi', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0a2) Gecko/20111101 Firefox/9.0a2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'OrciLuctusEt.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-gb) AppleWebKit/528.10+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Eu.ppt', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EstPhasellusSit.mp3', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Tempor.mp3', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2225.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'PosuereCubilia.doc', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LectusVestibulum.mpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0a2) Gecko/20110613 Firefox/6.0a2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EnimLorem.avi', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Diam.avi', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.53 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Id.avi', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'RutrumAt.avi', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LuctusEt.doc', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'QuisqueUtErat.ppt', 'Mozilla/5.0 (X11; OpenBSD amd64; rv:28.0) Gecko/20100101 Firefox/28.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MassaDonecDapibus.xls', 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3 like Mac OS X; pl-pl) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8F190 Safari/6533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VenenatisTristiqueFusce.mp3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Ac0aSed.gif', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DapibusAtDiam.avi', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.6 Safari/537.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'QuisqueArcu.xls', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.04 Chromium/14.0.804.0 Chrome/14.0.804.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SagittisNamCongue.png', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.13 (KHTML, like Gecko) Chrome/24.0.1290.1 Safari/537.13', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IntegerTincidunt.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MiPedeap9407suada.jpeg', 'Mozilla/5.0 (iPhone; U; ru; CPU iPhone OS 4_2_1 like Mac OS X; fr) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148a Safari/6533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Sit.avi', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.04 Chromium/14.0.813.0 Chrome/14.0.813.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NequeLiberoConvallis.xls', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2226.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'PellentesqueAt.avi', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-TW) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Neque.mov', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20130401 Firefox/31.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Elit.txt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'CubiliaCurae.xls', 'Mozilla/5.0 (Windows NT 6.0; rv:14.0) Gecko/20100101 Firefox/14.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AtNibh.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; tr-TR) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'CommodoPlacerat.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-us) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AtDiam.doc', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; zh-cn) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IdOrnare.xls', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.26 Safari/537.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EuFelisFusce.avi', 'Mozilla/5.0 (X11; Linux i686; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'LuctusEt.mp3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.13 (KHTML, like Gecko) Chrome/24.0.1290.1 Safari/537.13', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MetusSapien.xls', 'Mozilla/5.0 (X11; Linux amd64) AppleWebKit/534.36 (KHTML, like Gecko) Chrome/13.0.766.0 Safari/534.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'APedePosuere.mp3', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.8 (KHTML, like Gecko) Chrome/17.0.940.0 Safari/535.8', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Venenatis.jpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MaecenasLeo.png', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.815.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PedeLobortis.ppt', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; nl-nl) AppleWebKit/533.16 (KHTML, like Gecko) Version/4.1 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IntegerAcNeque.xls', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; ja-JP) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Suscipit0a.txt', 'Mozilla/5.0 (iPhone; U; fr; CPU iPhone OS 4_2_1 like Mac OS X; fr) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148a Safari/6533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Lobortis.xls', 'Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20100101 Firefox/19.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LectusSuspendissePotenti.mp3', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'CongueEtiam.mpeg', 'Mozilla/5.0 (iPhone; U; ru; CPU iPhone OS 4_2_1 like Mac OS X; fr) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148a Safari/6533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Justo.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; ca-es) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Erat.xls', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MaurisMorbi.avi', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/10.10 Chromium/17.0.963.65 Chrome/17.0.963.65 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LobortisEstPhasellus.jpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_3) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MassaDonecDapibus.mp3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.10 Chromium/14.0.808.0 Chrome/14.0.808.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0a.pdf', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.20 (KHTML, like Gecko) Chrome/11.0.669.0 Safari/534.20', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Dolor.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Pede.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-gb) AppleWebKit/528.10+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'NecSem.ppt', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AdipiscingElitProin.xls', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20130331 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Luctus.pdf', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/21.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'In.pdf', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'MassaTemporConvallis.tiff', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; tr-TR) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AtVelitEu.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/10.10 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Viverra.mp3', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1464.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VestibulumSedMagna.ppt', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Platea.xls', 'Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko ) Version/5.1 Mobile/9B176 Safari/7534.48.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ArcuSed.mp3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.815.10913 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Facilisi.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.724.100 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Maecenas.xls', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'UtMaurisEget.ppt', 'Mozilla/5.0 Slackware/13.37 (X11; U; Linux x86_64; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/11.0.696.50', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'QuisTurpisEget.xls', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PlateaDictumstMorbi.avi', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.04 Chromium/14.0.808.0 Chrome/14.0.808.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'CommodoVulputateJusto.gif', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.12 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'LobortisSapienSapien.xls', 'Mozilla/5.0 (Windows NT 6.1; rv:22.0) Gecko/20130405 Firefox/22.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MontesNascetur.mp3', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:15.0) Gecko/20121011 Firefox/15.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0aPedeUllamcorper.pdf', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2226.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Posuere.txt', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.792.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Nunc.mp3', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.15 (KHTML, like Gecko) Chrome/24.0.1295.0 Safari/537.15', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Sit.avi', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; fr-FR) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Tempus.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'OrnareConsequatLectus.avi', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.15 (KHTML, like Gecko) Chrome/24.0.1295.0 Safari/537.15', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Venenatis.avi', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Sapien.avi', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:23.0) Gecko/20131011 Firefox/23.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AccumsanTellusNisi.jpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1664.3 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Vehicula.mov', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; ko-KR) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Ipsum.png', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'EnimLoremIpsum.xls', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MattisPulvinar0a.txt', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.3 Safari/534.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IpsumPrimisIn.ppt', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7xs5D9rRDFpg2g', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Ultrices.mp3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Ubuntu/11.04 Chromium/15.0.871.0 Chrome/15.0.871.0 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AeneanFermentumDonec.jpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Tristique.mp3', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Bibendum.avi', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.6 Safari/537.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'HabitassePlatea.mp3', 'Mozilla/5.0 (Windows NT 6.1; de;rv:12.0) Gecko/20120403211507 Firefox/12.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0aJusto.xls', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', '0aAc.avi', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DictumstMorbi.tiff', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/11.04 Chromium/14.0.803.0 Chrome/14.0.803.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Nisi.mp3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.20 (KHTML, like Gecko) Chrome/19.0.1036.7 Safari/535.20', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PlateaDictumstMorbi.jpeg', 'Mozilla/5.0 (X11; CrOS i686 12.433.109) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.93 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EstRisusAuctor.xls', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7ad-imcjapan-syosyaman-xkgi3lqg03!wgz', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Nonummy.mov', 'Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (2, 'objade', 'NonQuamNec.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_4) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NonInterdum.mov', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; HTC-P715a; en-ca) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Erat.mp3', 'Mozilla/5.0 (Windows NT 6.1; rv:12.0) Gecko/ 20120405 Firefox/14.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LiberoRutrum.mp3', 'Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20130514 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Blandit.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; ja-JP) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Mus.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.107 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MetusSapien.png', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AliquamEratVolutpat.mov', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VivamusVel.xls', 'Mozilla/5.0 (X11; U; Linux x86_64; en-ca) AppleWebKit/531.2+ (KHTML, like Gecko) Version/5.0 Safari/531.2+', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MagnaAtNunc.pdf', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; fr-ch) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'Rutrum0aNunc.ppt', 'Mozilla/5.0 (X11; FreeBSD i386) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.121 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Accumsan.mp3', 'Mozilla/4.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/11.0.1245.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'InLacus.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-au) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NisiVolutpat.ppt', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.215 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VolutpatDui.mov', 'Mozilla/5.0 (X11; Linux amd64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.24 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AeneanAuctor.tiff', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_6) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'BlanditNonInterdum.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20100101 Firefox/9.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ScelerisqueMauris.doc', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; hu-HU) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Habitasse.jpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Eu.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ru-RU) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'Auctor.mp3', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1041.0 Safari/535.21', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Sodales.xls', 'Mozilla/5.0 (X11; NetBSD) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', '0amPorttitorLacus.mp3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.2 (KHTML, like Gecko) Chrome/22.0.1216.0 Safari/537.2', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0aNuncPurus.doc', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Quam.xls', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-HK) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Luctus.mpeg', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.864.0 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'PorttitorPedeJusto.png', 'Mozilla/5.0 (X11; Linux i686; rv:21.0) Gecko/20100101 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'In.png', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AtIpsum.mp3', 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3 like Mac OS X; en-gb) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8F190 Safari/6533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'UtEratId.ppt', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.14 (KHTML, like Gecko) Chrome/24.0.1292.0 Safari/537.14', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EgetEleifend.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-gb) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'In.png', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.0 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (2, 'objade', 'MiInPorttitor.mpeg', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.68 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VolutpatSapienArcu.jpeg', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NamDuiProin.txt', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.1 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MontesNascetur.mov', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; fr-fr) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NibhInHac.ppt', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20130401 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'OdioElementum.gif', 'Mozilla/5.0 Slackware/13.37 (X11; U; Linux x86_64; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/11.0.696.50', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IdSapienIn.avi', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-HK) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Diam.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; ko-kr) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'Primis.gif', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.699.0 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MagnaBibendum.ppt', 'Mozilla/5.0 (X11; Linux x86_64; rv:28.0) Gecko/20100101 Firefox/28.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'Platea.jpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Ridiculus.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.861.0 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'CubiliaCuraeDuis.mp3', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1623.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'RhoncusMauris.doc', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; WOW64; en-US; rv:2.0.4) Gecko/20120718 AskTbAVR-IDW/3.12.5.17700 Firefox/14.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Rutrum.mov', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.21 (KHTML, like Gecko) Chrome/19.0.1041.0 Safari/535.21', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EtUltricesPosuere.avi', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SemPraesent.avi', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.2 (KHTML, like Gecko) Chrome/22.0.1216.0 Safari/537.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AmetDiamIn.png', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; de-de) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Fermentum.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_4) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IpsumAliquamNon.mp3', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; ja-JP) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IdMaurisVulputate.txt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Sem.xls', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20130401 Firefox/31.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LacusPurus.ppt', 'Mozilla/5.0 Slackware/13.37 (X11; U; Linux x86_64; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/12.0.742.91', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NislUtVolutpat.tiff', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20130328 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'QuamSuspendisse.mpeg', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/10.10 Chromium/17.0.963.65 Chrome/17.0.963.65 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'PedeAcDiam.avi', 'Mozilla/5.0 (X11; NetBSD amd64; rv:16.0) Gecko/20121102 Firefox/16.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NislUtVolutpat.mpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_6) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.698.0 Safari/534.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'EuMassaDonec.mov', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; ko-kr) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ElitProin.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) AppleWebKit/534.1+ (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MaurisEnim.mov', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10; rv:33.0) Gecko/20100101 Firefox/33.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Erat.avi', 'Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Venenatis.jpeg', 'Mozilla/5.0 (Windows NT 5.2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.813.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MagnisDisParturient.tiff', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (2, 'objade', 'VelSem.avi', 'Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'RisusPraesent.txt', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'TellusInSagittis.mp3', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IpsumAliquam.xls', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; ja-jp) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AugueQuamSollicitudin.mpeg', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.35 (KHTML, like Gecko) Ubuntu/10.10 Chromium/13.0.764.0 Chrome/13.0.764.0 Safari/534.35', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SapienDignissimVestibulum.mp3', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AeneanFermentum.ppt', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EuOrci.xls', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SapienA.png', 'Mozilla/5.0 (Macintosh; AMD Mac OS X 10_8_2) AppleWebKit/535.22 (KHTML, like Gecko) Chrome/18.6.872', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Ut.mpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20130401 Firefox/31.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Suspendisse.mov', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20130330 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Erat.mp3', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Nisl.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; WOW64; en-US; rv:2.0.4) Gecko/20120718 AskTbAVR-IDW/3.12.5.17700 Firefox/14.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'FeugiatEt.tiff', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.2309.372 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DolorSit.mp3', 'Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_1 like Mac OS X; zh-cn) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8G4 Safari/6533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'BlanditMiIn.txt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; zh-cn) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Felis.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.19 (KHTML, like Gecko) Chrome/11.0.661.0 Safari/534.19', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Dolor.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.12 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Vel0aEget.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; fr-fr) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VestibulumVestibulumAnte.mp3', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/21.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Rhoncus.tiff', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-TW) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'OrciLuctusEt.png', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.815.10913 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MusEtiamVel.mov', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; es-ES) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NonummyIntegerNon.mov', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.91 Chromium/12.0.742.91 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Sapien.avi', 'Mozilla/5.0 (Windows NT 5.2) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Luctus.avi', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1500.55 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'TurpisElementumLigula.avi', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'DiamCrasPellentesque.avi', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Ultrices.tiff', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/11.04 Chromium/13.0.782.41 Chrome/13.0.782.41 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Condimentum.avi', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:21.0.0) Gecko/20121011 Firefox/21.0.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LacusAtTurpis.pdf', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; zh-cn) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AdipiscingElit.tiff', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/534.55.3 (KHTML, like Gecko) Version/5.1.3 Safari/534.53.10', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SitAmetJusto.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; it-it) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'OrciLuctus.avi', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'ProinInterdum.png', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Et.ppt', 'Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_3 like Mac OS X; ja-jp) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DolorQuis.txt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/10.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SedNisl.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; fr-ch) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MaecenasRhoncusAliquam.mp3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_3) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EstCongue.mpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ViverraPedeAc.avi', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; tr-TR) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NonLectus.mpeg', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; sv-se) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Phasellus.pdf', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; tr-TR) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'HabitassePlateaDictumst.tiff', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/10.10 Chromium/17.0.963.65 Chrome/17.0.963.65 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Non.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.24 (KHTML, like Gecko) Ubuntu/10.10 Chromium/12.0.703.0 Chrome/12.0.703.0 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Faucibus.tiff', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; tr) AppleWebKit/528.4+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Lectus.gif', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:14.0) Gecko/20100101 Firefox/14.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'TellusSemper.txt', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2224.3 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Odio.tiff', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; ko-kr) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LoremIntegerTincidunt.doc', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.792.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EratVolutpat.xls', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/21.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Dui.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1664.3 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Enim.pdf', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-TW) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SemperPorta.xls', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SedInterdumVenenatis.mp3', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.04 Chromium/14.0.813.0 Chrome/14.0.813.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'JustoSit.avi', 'Mozilla/5.0 ArchLinux (X11; U; Linux x86_64; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.60 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Arcu.mp3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.36 (KHTML, like Gecko) Chrome/13.0.766.0 Safari/534.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AdipiscingElit.mp3', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; ja-jp) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Orci.mp3', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'QuamTurpis.png', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.67 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Ligula.xls', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/11.04 Chromium/14.0.803.0 Chrome/14.0.803.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VivamusTortor.xls', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; de) AppleWebKit/528.4+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'TristiqueEstEt.mp3', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.20 (KHTML, like Gecko) Chrome/11.0.672.2 Safari/534.20', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VivamusInFelis.doc', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Erat.avi', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2225.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'ViverraPedeAc.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/10.10 Chromium/17.0.963.65 Chrome/17.0.963.65 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SedSagittisNam.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; HTC-P715a; en-ca) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'NislDuis.pdf', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.68 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NuncCommodoPlacerat.mov', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LuctusCum.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Morbi.doc', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; de-de) AppleWebKit/533.16 (KHTML, like Gecko) Version/4.1 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Donec.png', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.8 (KHTML, like Gecko) Chrome/17.0.940.0 Safari/535.8', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ConsequatLectus.jpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.24 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'Fusce.doc', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/21.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NonMi.txt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.107 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Consectetuer.doc', 'Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DuiLuctus.jpeg', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.812.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AliquetMassaId.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'UtUltricesVel.ppt', 'Mozilla/5.0 Slackware/13.37 (X11; U; Linux x86_64; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/12.0.742.91', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Ac.mp3', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.20 (KHTML, like Gecko) Chrome/11.0.672.2 Safari/534.20', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'AliquetPulvinarSed.gif', 'Mozilla/5.0 (Windows NT 5.2; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Est.mp3', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; fr-FR) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'QuamSapienVarius.gif', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; ar) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Lacus.jpeg', 'Mozilla/5.0 (X11; CrOS i686 1193.158.0) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DuiMaecenasTristique.jpeg', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Justo.ppt', 'Mozilla/5.0 (X11; Linux amd64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.24 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', '0a.jpeg', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Posuere.ppt', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:18.0) Gecko/20100101 Firefox/18.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PellentesqueQuisquePorta.jpeg', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:15.0) Gecko/20100101 Firefox/15.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Lorem.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Justo.avi', 'Mozilla/5.0 (Windows NT 6.1; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.750.0 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'DisParturientMontes.gif', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20130401 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PharetraMagna.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0a2) Gecko/20111101 Firefox/9.0a2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Mauris.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; ca-es) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'In.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MolestieNibh.jpeg', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AIpsumInteger.pdf', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.62 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'CongueElementum.png', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Congue.xls', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.810.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IntegerAc.avi', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.18 (KHTML, like Gecko) Chrome/11.0.661.0 Safari/534.18', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'PretiumIaculis.jpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_6) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.12 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LeoOdio.mp3', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DuiProinLeo.mp3', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.35 (KHTML, like Gecko) Ubuntu/10.10 Chromium/13.0.764.0 Chrome/13.0.764.0 Safari/534.35', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'ProinInterdumMauris.mp3', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.14 (KHTML, like Gecko) Chrome/24.0.1292.0 Safari/537.14', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Mi.tiff', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:27.0) Gecko/20121011 Firefox/27.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'FelisSed.tiff', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en) AppleWebKit/526.9 (KHTML, like Gecko) Version/4.0dp1 Safari/526.8', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'BlanditNam.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; zh-cn) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EratTortor.doc', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Elit.jpeg', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.517 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'PedeLobortis.xls', 'Mozilla/5.0 (Windows NT 5.2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.792.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LigulaVehiculaConsequat.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/11.04 Chromium/17.0.963.56 Chrome/17.0.963.56 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Semper.doc', 'Mozilla/5.0 (X11; Linux i686; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AIpsumInteger.mpeg', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.803.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Imperdiet.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'InterdumMauris.txt', 'Mozilla/5.0 (iPhone; U; ru; CPU iPhone OS 4_2_1 like Mac OS X; fr) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148a Safari/6533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AugueQuamSollicitudin.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; th-th) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Viverra.tiff', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; zh-cn) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VitaeNisl.png', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.15 (KHTML, like Gecko) Chrome/24.0.1295.0 Safari/537.15', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SedMagna.ppt', 'Mozilla/5.0 (Windows NT 6.2; rv:9.0.1) Gecko/20100101 Firefox/9.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SollicitudinVitaeConsectetuer.mp3', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.16 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SapienIn.avi', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Ubuntu/11.10 Chromium/15.0.874.120 Chrome/15.0.874.120 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'In.xls', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.700.3 Safari/534.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Nam.avi', 'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MetusSapien.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_7) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.790.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MattisOdioDonec.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'DuiVel.txt', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.14 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Pede.png', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-HK) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (9, 'mcholwell0', 'In.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.19 (KHTML, like Gecko) Ubuntu/11.10 Chromium/18.0.1025.142 Chrome/18.0.1025.142 Safari/535.19', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'InFaucibus.avi', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.860.0 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NonMauris.doc', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.834.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'UltricesLiberoNon.xls', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Aenean.ppt', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'IpsumPrimisIn.tiff', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.6 Safari/537.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Orci.mov', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/10.10 Chromium/17.0.963.65 Chrome/17.0.963.65 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DuisBibendumMorbi.mp3', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SuscipitA.mpeg', 'Chrome/15.0.860.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/15.0.860.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VelitDonec.avi', 'Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20130331 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'Sed.mp3', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.700.3 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Quam.tiff', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; fr-ch) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'FuscePosuereFelis.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-gb) AppleWebKit/528.10+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AliquamAugue.avi', 'Mozilla/5.0 (Windows NT 5.2; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Odio.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; de-DE) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'InFelisDonec.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/11.0.652.0 Safari/534.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Cubilia.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'InMagnaBibendum.txt', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'ProinLeoOdio.doc', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.13 (KHTML, like Gecko) Chrome/24.0.1284.0 Safari/537.13', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Augue.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:15.0) Gecko/20121011 Firefox/15.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DictumstMorbiVestibulum.mov', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_8) AppleWebKit/534.31 (KHTML, like Gecko) Chrome/13.0.748.0 Safari/534.31', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Massa.mpeg', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'ConvallisEgetEleifend.mp3', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PrimisIn.mov', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; nl-nl) AppleWebKit/533.16 (KHTML, like Gecko) Version/4.1 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SedNislNunc.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.151 Safari/535.19', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AmetConsectetuerAdipiscing.ppt', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.13 (KHTML, like Gecko) Chrome/24.0.1290.1 Safari/537.13', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'JustoPellentesqueViverra.xls', 'Mozilla/5.0 (X11; NetBSD amd64; rv:16.0) Gecko/20121102 Firefox/16.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VivamusIn.gif', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.803.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Eu.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LuctusEtUltrices.mov', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.10 Chromium/14.0.808.0 Chrome/14.0.808.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DiamEratFermentum.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EtiamJustoEtiam.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; ja-jp) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'InFaucibusOrci.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Convallis0a.tiff', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.803.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Leo.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; de-de) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'UtMassa.xls', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VulputateJustoIn.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.151 Safari/535.19', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0aNuncPurus.pdf', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.65 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'SapienCursus.mov', 'Mozilla/5.0 (Windows NT 6.2; rv:22.0) Gecko/20130405 Firefox/22.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Morbi.tiff', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MaurisVulputateElementum.gif', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.700.3 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'RisusSemperPorta.jpeg', 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; ru-ru) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'RutrumAt.jpeg', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Ridiculus.mp3', 'Mozilla/5.0 (X11; CrOS i686 1660.57.0) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.46 Safari/535.19', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'PretiumNisl.avi', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_5_8; ja-jp) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Et.avi', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.62 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AliquamConvallis.jpeg', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EnimIn.xls', 'Mozilla/5.0 (Windows NT 6.2; rv:21.0) Gecko/20130326 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MorbiAIpsum.mp3', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; zh-cn) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Integer.doc', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.834.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MontesNasceturRidiculus.doc', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'ElementumEuInterdum.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DiamNequeVestibulum.avi', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Massa.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Amet.mp3', 'Mozilla/5.0 ArchLinux (X11; U; Linux x86_64; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.60 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SuspendisseAccumsan.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; es-ES) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'CondimentumId.txt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1944.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IdPretium.txt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_4; en-gb) AppleWebKit/528.4+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IpsumDolor.gif', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1467.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Et.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:15.0) Gecko/20121011 Firefox/15.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VehiculaConsequatMorbi.tiff', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; tr) AppleWebKit/528.4+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Morbi.avi', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'FeugiatNon.avi', 'Mozilla/5.0 (X11; Linux amd64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.24 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Erat.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:15.0) Gecko/20121011 Firefox/15.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Sed.txt', 'Mozilla/5.0 (Windows NT 6.1; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.750.0 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Porttitor.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; ar) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Semper.mp3', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IdOrnare.jpeg', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; ja-JP) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AcTellusSemper.ppt', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EstPhasellusSit.xls', 'Mozilla/5.0 (X11; CrOS i686 1660.57.0) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.46 Safari/535.19', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LacusAtVelit.mp3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.8 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.8', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ElementumLigulaVehicula.jpeg', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.2309.372 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'QuisOdioConsequat.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-HK) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LectusIn.doc', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20130401 Firefox/31.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Lorem.pdf', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-gb) AppleWebKit/528.10+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Luctus.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.18 (KHTML, like Gecko) Chrome/11.0.660.0 Safari/534.18', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NibhFusce.gif', 'Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20130331 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EratVolutpatIn.ppt', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; de-de) AppleWebKit/533.16 (KHTML, like Gecko) Version/4.1 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DolorSitAmet.txt', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:15.0) Gecko/20121011 Firefox/15.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Condimentum.tiff', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (3, 'jwsabout1', 'AIpsumInteger.mp3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'DolorMorbiVel.avi', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Nibh.tiff', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0amSit.ppt', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; ja-JP) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'OrciLuctus.avi', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Leo.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_7) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.813.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', '0a.txt', 'Mozilla/5.0 (Windows NT 5.1; rv:21.0) Gecko/20130401 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MiSitAmet.xls', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'NibhInQuis.xls', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; zh-cn) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'UltricesLibero.pdf', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/11.04 Chromium/13.0.782.41 Chrome/13.0.782.41 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Venenatis.mpeg', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.812.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LoremIpsumDolor.gif', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.34 Safari/534.24', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Pellentesque.mov', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; ja-jp) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IdSapien.gif', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; fr) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IntegerANibh.ppt', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VulputateVitae.xls', 'Mozilla/5.0 (Windows NT 6.2; rv:22.0) Gecko/20130405 Firefox/23.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'LectusPellentesqueAt.mp3', 'Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120405 Firefox/14.0a1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'UltricesPosuereCubilia.mpeg', 'Mozilla/5.0 (Windows NT 6.1; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.750.0 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'UltricesPosuereCubilia.jpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20120101 Firefox/29.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Dui.tiff', 'Mozilla/5.0 (Windows NT 6.1; rv:21.0) Gecko/20100101 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'UltricesPosuere.avi', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.724.100 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'InBlandit.mp3', 'Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20100101 Firefox/19.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Non.gif', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_7_0; en-US) AppleWebKit/534.21 (KHTML, like Gecko) Chrome/11.0.678.0 Safari/534.21', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Arcu.avi', 'Mozilla/5.0 (Windows NT 6.0; rv:14.0) Gecko/20100101 Firefox/14.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VenenatisTristiqueFusce.xls', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'In.tiff', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; ja-jp) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Vel.ppt', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20130331 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SapienVariusUt.tiff', 'Mozilla/5.0 (X11; U; Linux x86_64; en-ca) AppleWebKit/531.2+ (KHTML, like Gecko) Version/5.0 Safari/531.2+', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', '0aTellus.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AmetJusto.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.18 (KHTML, like Gecko) Chrome/11.0.661.0 Safari/534.18', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (9, 'mcholwell0', 'Placerat.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (9, 'mcholwell0', 'QuisTurpisEget.pdf', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EleifendDonecUt.avi', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'InFaucibus.mpeg', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SedMagnaAt.mp3', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.864.0 Safari/535.2', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'FelisSed.avi', 'Mozilla/5.0 (X11; OpenBSD amd64; rv:28.0) Gecko/20100101 Firefox/28.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AcLobortis.xls', 'Mozilla/5.0 (Macintosh; AMD Mac OS X 10_8_2) AppleWebKit/535.22 (KHTML, like Gecko) Chrome/18.6.872', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Tellus0a.mpeg', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.8 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.8', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NuncDonecQuis.tiff', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.3 Safari/534.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'ViverraEget.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/11.04 Chromium/17.0.963.56 Chrome/17.0.963.56 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EuMagnaVulputate.tiff', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'JustoMorbiUt.mp3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Metus.tiff', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'Vestibulum.avi', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.20 (KHTML, like Gecko) Chrome/11.0.669.0 Safari/534.20', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'RutrumAc.xls', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:14.0) Gecko/20100101 Firefox/14.0.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Dis.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; it-it) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (7, 'test1', 'IdJustoSit.xls', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.20 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'BibendumMorbi.mpeg', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EgetOrci.ppt', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; HTC-P715a; en-ca) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AliquetAtFeugiat.tiff', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Id.xls', 'Mozilla/5.0 (iPod; U; CPU iPhone OS 4_3_1 like Mac OS X; zh-cn) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8G4 Safari/6533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'Ultrices.ppt', 'Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko ) Version/5.1 Mobile/9B176 Safari/7534.48.3', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Elementum.avi', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AuctorSedTristique.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.21 (KHTML, like Gecko) Chrome/11.0.682.0 Safari/534.21', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'QuisLibero.gif', 'Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MassaDonec.jpeg', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_7; ja-jp) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AnteIpsumPrimis.avi', 'Mozilla/5.0 (X11; CrOS i686 1660.57.0) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.46 Safari/535.19', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (6, 'test', 'Nec.mp3', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; en) AppleWebKit/528.4+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (9, 'mcholwell0', 'In.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_4) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.100 Safari/534.30', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'EgetTincidunt.avi', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Ultrices.xls', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.21 (KHTML, like Gecko) Chrome/11.0.682.0 Safari/534.21', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LectusAliquam.xls', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.45 Safari/535.19', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LigulaPellentesque.gif', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-au) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Faucibus.mpeg', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; ko-kr) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EratIdMauris.ppt', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36 Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SemMaurisLaoreet.ppt', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.36 (KHTML, like Gecko) Chrome/13.0.766.0 Safari/534.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Vel.xls', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.215 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Cubilia.pdf', 'Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Libero0am.mp3', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.13 (KHTML, like Gecko) Chrome/24.0.1284.0 Safari/537.13', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'FaucibusOrciLuctus.ppt', 'Mozilla/5.0 (Windows NT 6.1; rv:12.0) Gecko/ 20120405 Firefox/14.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Lorem.avi', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7ad-imcjapan-syosyaman-xkgi3lqg03!wgz', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MaecenasLeo.avi', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'InFelis.xls', 'Mozilla/5.0 (X11; Mageia; Linux x86_64; rv:10.0.9) Gecko/20100101 Firefox/10.0.9', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Volutpat.gif', 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; nb-no) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148a Safari/6533.18.5', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'LectusIn.mp3', 'Mozilla/5.0 (Windows NT 5.0; rv:21.0) Gecko/20100101 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SuspendissePotentiCras.ppt', 'Mozilla/6.0 (Windows NT 6.2; WOW64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'RutrumAtLorem.png', 'Mozilla/5.0 (Windows NT 5.2) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.813.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'VenenatisNonSodales.ppt', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_3) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.32 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MaurisNonLigula.mp3', 'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AtDiamNam.mp3', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.67 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'IdNislVenenatis.pdf', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; it-it) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AliquetUltrices.xls', 'Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120405 Firefox/14.0a1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0aDapibus.ppt', 'Mozilla/5.0 (X11; U; Linux x86_64; en-ca) AppleWebKit/531.2+ (KHTML, like Gecko) Version/5.0 Safari/531.2+', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DuiVelNisl.mov', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.04 Chromium/14.0.804.0 Chrome/14.0.804.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Curae.mpeg', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20130331 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ASuscipit.xls', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20130330 Firefox/21.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', '0a.ppt', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'AmetConsectetuer.jpeg', 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IdLobortisConvallis.mpeg', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'EstLaciniaNisi.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.71 Safari/534.24', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Fermentum.mov', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2224.3 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'UltricesMattisOdio.mp3', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.30 (KHTML, like Gecko) Ubuntu/11.04 Chromium/12.0.742.112 Chrome/12.0.742.112 Safari/534.30', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Eget.xls', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:25.0) Gecko/20100101 Firefox/25.0', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Quam.ppt', 'Mozilla/5.0 (Windows NT 5.2; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.41 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'MattisPulvinar0a.xls', 'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.66 Safari/535.11', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Vestibulum.ppt', 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; ja-jp) AppleWebKit/533.16 (KHTML, like Gecko) Version/4.1 Safari/533.16', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'JustoAliquam.avi', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.10 Chromium/14.0.808.0 Chrome/14.0.808.0 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AcEst.avi', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_4; en-gb) AppleWebKit/528.4+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'NatoquePenatibus.jpeg', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'VariusInteger.ppt', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/534.25 (KHTML, like Gecko) Chrome/12.0.706.0 Safari/534.25', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'AcConsequat.ppt', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Ubuntu/10.04 Chromium/14.0.804.0 Chrome/14.0.804.0 Safari/535.1', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'SemperEst.tiff', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.861.0 Safari/535.2', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'LacusMorbi.jpeg', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_5; de-de) AppleWebKit/534.15+ (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Semper.ppt', 'Mozilla/5.0 (Windows NT 6.2) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'OdioIn.ppt', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/29.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IpsumAliquamNon.xls', 'Mozilla/5.0 (Windows; U; Windows NT 6.1; de-DE) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'ElementumLigulaVehicula.xls', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.6 Safari/537.11', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'MorbiSemMauris.mp3', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36 Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'Diam.tiff', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'DonecPosuereMetus.png', 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.2 (KHTML, like Gecko) Ubuntu/11.10 Chromium/15.0.874.120 Chrome/15.0.874.120 Safari/535.2', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (5, 'checkmate147', 'SapienCumSociis.xls', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.13 (KHTML, like Gecko) Chrome/24.0.1290.1 Safari/537.13', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (2, 'objade', 'Et.avi', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.24 Safari/535.1', 'N', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (8, 'test2', 'PhasellusSitAmet.gif', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'IpsumPrimis.avi', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view) values (4, 'ap9407', 'Quisque.mp3', 'Mozilla/5.0 (X11; Linux i686; rv:21.0) Gecko/20100101 Firefox/21.0', 'Y', 0);
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (2, 'objade', 'ppt만들고 싶은데..', '오류 안나는 방법 추천 좀 요', 'Y', 0, '23/02/28');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (5, 'checkmate147', '취업해서 기분이 너무 좋아요', '예비 직장인 화이팅', 'N', 0, '23/03/1');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (4, 'ap9407', '방법이 두가지가 있나요?', '그게 어떤 방법일까요', 'Y', 0, '23/03/01');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (5, 'checkmate147', '신입평균 연봉에 대한 설문은?', '진짜 궁금하네요', 'N', 0, '23/03/2');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (4, 'ap9407', '물가상승률에 대한 설문은 안하나요?', '제곧내', 'Y', 0, '23/03/02');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values(4, 'ap9407', '더미데이터 쌓는거 개귀찮음 ㄴㅇㅈ', '노가다 하세요!', 'N', 0, '23/03/03');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values(4, 'ap9407', '설문조사는 하지마세요 제발요', '진짜루 하지마세요', 'N', 0, '23/03/03');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (2, 'objade', '설문조사 프로젝트는...', '하지마세요!', 'Y', 0, '23/03/06');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (5, 'checkmate147', '다들 고생했습니다!', '이제 마지막이네요', 'N', 0, '23/03/07');
insert into q_board (user_idx, qboard_writer, qboard_title, qboard_content, qboard_privacy, qboard_view, qboard_date) values (3, 'jwsabout1', '다들 수고했습니다!', '찐막이네요!', 'Y', 0, '23/03/07');

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'온라인문화상품권 중단 안내',
'안녕하세요. 
지아고 패널파워입니다. 

 

온라인 문화상품권의 컬쳐캐쉬 충전이 중단되어, 온라인 문화상품권 신청을 중단할 예정입니다. 

중단 이전 발송된 온라인상품권은 정상적으로 사용이 가능하며, 모바일 문화상품권은 계속 신청하실 수 있습니다. 

 

중단 일시: 22년 12월 17일 (토) 부터',
'2022-11-04'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'2022년 11월 조사후기 당첨자 발표', 
'안녕하세요. 지아고 패널파워입니다.

패널님들의 적극적인 설문 조사 참여에 감사 드립니다.

2022년 11월 한 달 동안 조사 후기에 조사의 발전 방향 및 좋은 의견을 남성겨주신 분들 중 10분을 추첨하였습니다.

당첨되신 10분께는 적립금 5,000원을 적립하여 드립니다.

아래 리스트에서 당첨 여부를 확인해 주시기 바랍니다.

- 2023년 1월 조사 후기 당첨자 -  
 
석*성  ap**07
김*수  chec*****47
유*은  ob**de
정*성  jw****ut1

 
1월 베스트 조사후기인 석*성 패널님과 정*성 패널님의 후기를 공개합니다.

석*성 [114818 조사]

초반 부에 평일과 주말에 특정 OTT를 몇 %인지 사용하는 지 질문을 하는데에 있어서 주말에도 관련된 같은 질문을 할 지 모르고 
짐짓 평일과 주말을 포함한 %를 생각해서 입력했습니다. 다음 설문에서는 주말과 평일에 대해 물어볼 것이라는 질문을 해주시면 더 정확한 응답을 할 수 있을 것 같습니다.

정*성 [114800 조사]

퍼센트를 적을 때 감에 의존하다보니 약간 즉흥적으로 쓰게 되는 경향이 있습니다. 보다 정확한 결과를 위해서는 섭취한 빈도를 물어봐서 그 결과를 토대로 퍼센트를 도출하는 편이 좋겠습니다. 
또한 귀사의 치즈 브랜드는 이름만 들었을 때는 잘 몰라도 음식 위에 올려진 모습은 익숙하니 이 점을 참고해 사진 자료를 함께 보여주신다면 더 많은 사람들의 의견을 수렴하는 데 도움이 되시리라 생각합니다.

 

 

좋은 의견 감사합니다. 다시 한번 축하드립니다.',
'2022-12-13'
);


insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[정기 서버 점검] 서비스 일시 중단 안내',
'안녕하세요. 지아고 패널파워 입니다.

지아고는 안정적인 서비스를 위해
정기적으로 서버 점검을 진행하고 있습니다. 
아래 시간 동안 서비스가 중단되오니, 
이용에 차질 없으시길 바랍니다.

일시: 12월 16일(금) 23:00 ~ 17일(토) 09:00   

내용: 패널파워, 조사 서비스 중단

이용에 불편을 드려 죄송합니다. 

더욱 노력하는 지아고가 되겠습니다.

감사합니다.',
'2022-12-14'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[12월 22일] 적립금 기부 결과 입니다.',
'안녕하세요. 지아고 패널파워입니다.

2022년 12월 1일 부터 15일 까지의 기부금 신청패널에 대한 이체 작업이 완료되었습니다.

후원금 영수증 발급은 전자결제 기간이 지난후 후원회에서 후원금의 입금확인 후 가능합니다.
온라인 후원금 결제에 따른 후원금 영수증 발급 가능일은 다음 기간 이후에 가능합니다.

신 용 카 드 : 후원금결제일부터 10일 정도
실시간 계좌이체 : 후원금 결제일로부터 10일 정도
휴 대 폰 : 후원금 결제일로부터 2개월 정도

저희 지아고를 이용해주신 분들께 다시한번 감사드립니다.',
'2022-12-22'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'2022년 11월 가입이벤트 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

11월 신규가입 이벤트 이벤트 결과를 발표합니다.

(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2022-12-23'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'2022년 11월 추천이벤트 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

11월 친구추천 이벤트 이벤트 결과를 발표합니다.
(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2022-12-27'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'12월 소비자패널조사 경품 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

12월 112676번 소비자패널조사 이벤트 결과를 발표합니다.
(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2023-01-05'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[01월 06일] 적립금 기부 결과 입니다.',
'안녕하세요. 지아고 패널파워입니다.

2022년 12월 16일 부터 31일 까지의 기부금 신청패널에 대한 이체 작업이 완료되었습니다.

후원금 영수증 발급은 전자결제 기간이 지난후 후원회에서 후원금의 입금확인 후 가능합니다.
온라인 후원금 결제에 따른 후원금 영수증 발급 가능일은 다음 기간 이후에 가능합니다.

신 용 카 드 : 후원금결제일부터 10일 정도
실시간 계좌이체 : 후원금 결제일로부터 10일 정도
휴 대 폰 : 후원금 결제일로부터 2개월 정도

저희 지아고를 이용해주신 분들께 다시한번 감사드립니다.',
'2023-01-06'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'지아고 패널파워 2022년 적립금 총 결산',
'2022년 한 해 동안 보내주신 성원에 감사드립니다
올 한 해도 많은 참여 부탁드리며, 2022년 적립금 결산 내역을 공개합니다.
>>> 2022년 적립금 총 결산 <<<

2022년 적립된 조사 참여 적립금은 약 50억2천5백만원(?5,025,122,020)으로
2021년 보다 약 7억2천7백만원(?727,620,370)이 증가하였습니다.
조사에 참여해 주신 모든 패널들께 감사드립니다!',
'2023-01-09'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'2022년 12월 조사후기 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.
 

패널님들의 적극적인 설문 조사 참여에 감사 드립니다.

2022년 12월 한 달 동안 조사 후기에 조사의 발전 방향 및 좋은 의견을 남성겨주신 분들 중 10분을 추첨하였습니다.

당첨되신 10분께는 적립금 5,000원을 적립하여 드립니다.

아래 리스트에서 당첨 여부를 확인해 주시기 바랍니다.

- 2022년 12월 조사 후기 당첨자 -  
 
이*협  san****up2
허*희  ve****047
조*하  ne***a3
김*서  pri****ily18
이*아  bo***19
김*아  rla****krj1
지*경  hkj****219
조*훈  ah***45
전*  leg****s33
이*희  hypa****415
 

12월 베스트 조사후기인 구*희 패널님과 김*향 패널님의 후기를 공개합니다.
김*서 [114348 조사]

품목이 많은 설문에 응답할 때, 예를 들어 1 ~ 5(구매할 의향이 있다 이런 거) 중에 선택해야할 때 스크롤을 내릴수록 1~5의 내용이 무엇이었는지 잘 기억이 나지 않아 다시 올라갔다 내려와야 했습니다. 1~5 보기는 유지한채로 설문 내용만 스크롤 되는 방식으로 하면 더 편하지 않을까 생각합니다! 감사합니다~

이*희 [113834 조사]

어플 유료 정기결제 서비스와 어플 내 상품 구매에 대한 내용이 제대로 분리되지 않아 질문이 모호한 측면이 있었습니다. 어플 내 유료 결제 여부 질문 시 정기결제(구독)와 상품 구매를 월평균으로 합쳐서 응답하는 게 어려웠고 이어서 유료 서비스에 대한 질문이 이어져 어플 내 상품 구매와는 별도의 질문인지 어떤지 구분이 되지 않아 헷갈렸습니다.

좋은 의견 감사합니다. 다시 한번 축하드립니다.',
'2023-01-11'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[1월 27일] 그룹사(계열사) 신설에 따른 개인정보취급방침 개정 안내',
'안녕하세요. 지아고 패널파워입니다.
패널파워를 이용해주시는 패널님들께 깊은 감사의 말씀을 드립니다. 

당사의 자회사인 ㈜지아고퍼블릭은 사업별 경쟁력 강화를 위하여 자회사 ㈜지아고컨설팅을 신설하였습니다.

이에 따라 1월 27일부로 지아고 패널파워의 개인정보처리방침 및 이용약관이 개정됨을 안내드립니다.
패널님의 개인정보는 패널 활동과 관련한 정보 제공에 이용되고, 
개인정보보호법 및 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법규에 따라 안전하게 보호됩니다.
 

모든 설문조사는 기존대로 지아고 패널파워를 통하여 제공되기 때문에
기존 지아고 패널은 계속 유지되며, 패널님의 활동과 적립금에는 변동 사항이 없습니다.

패널님께서 시행일인 2023년 1월 27일 까지 거부의사(탈퇴)를 표시하지 않는 경우 본 개정에 동의한 것으로 간주하며, 
동의하지 않는 경우 패널파워 홈페이지에서 탈퇴를 하실 수 있습니다.

패널파워는 국내 리서치 회사 중 유일하게 개인정보보호 우수사이트 인증을 받았으며, 패널님의 개인정보 보호에 최선을 다하고 있습니다.

앞으로도 더욱 좋은 서비스를 위해 노력하겠습니다.

감사합니다.',
'2023-01-20'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'2022년 12월 가입이벤트 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

12월 신규가입 이벤트 이벤트 결과를 발표합니다.

(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2023-01-20'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[01월 20일] 적립금 기부 결과 입니다.',
'안녕하세요. 지아고 패널파워입니다.

2023년 01월 01일 부터 15일 까지의 기부금 신청패널에 대한 이체 작업이 완료되었습니다.

후원금 영수증 발급은 전자결제 기간이 지난후 후원회에서 후원금의 입금확인 후 가능합니다.
온라인 후원금 결제에 따른 후원금 영수증 발급 가능일은 다음 기간 이후에 가능합니다.

신 용 카 드 : 후원금결제일부터 10일 정도
실시간 계좌이체 : 후원금 결제일로부터 10일 정도
휴 대 폰 : 후원금 결제일로부터 2개월 정도

저희 지아고를 이용해주신 분들께 다시한번 감사드립니다.',
'2023-01-20'
);


insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[정기 서버 점검] 서비스 일시 중단 안내',
'안녕하세요. 지아고 패널파워 입니다.

지아고는 안정적인 서비스를 위해
정기적으로 서버 점검을 진행하고 있습니다. 
아래 시간 동안 서비스가 중단되오니, 
이용에 차질 없으시길 바랍니다.

일시: 1월 27일(금) 23:00 ~ 28일(토) 09:00

내용: 패널파워, 조사 서비스 중단

이용에 불편을 드려 죄송합니다. 

더욱 노력하는 지아고가 되겠습니다.

감사합니다.',
'2023-01-25'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'2022년 12월 추천이벤트 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

12월 친구추천 이벤트 이벤트 결과를 발표합니다.
(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2022-01-27'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'1월 소비자패널조사 경품 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

1월 114626번 소비자패널조사 이벤트 결과를 발표합니다.
(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2023-02-03'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[2월 7일] 적립금 기부 결과 입니다.',
'안녕하세요. 지아고 패널파워입니다.

2023년 1월 16일 부터 31일 까지의 현금이체 신청패널에 대한 이체 작업이 완료되었습니다.

후원금 영수증 발급은 전자결제 기간이 지난후 후원회에서 후원금의 입금확인 후 가능합니다.
온라인 후원금 결제에 따른 후원금 영수증 발급 가능일은 다음 기간 이후에 가능합니다.

신 용 카 드 : 후원금결제일부터 10일 정도
실시간 계좌이체 : 후원금 결제일로부터 10일 정도
휴 대 폰 : 후원금 결제일로부터 2개월 정도

저희 지아고를 이용해주신 분들께 다시한번 감사드립니다.',
'2023-02-07'
);


 

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'[2월 9일] SKT 통신사 휴대폰 본인인증 서비스 중단 안내',
'안녕하세요. 지아고 패널파워 입니다.

언제나 저희 지아고 패널로 활동해 주셔서 대단히 감사드립니다.

SKT 통신사의 시스템 점검으로 인하여

아래 기간동안 휴대폰 본인인증 서비스가 일시 중단됩니다.


본인인증을 통한 서비스 이용(회원가입, 비밀번호 찾기 등)에 차질 없으시길 바랍니다.


     일시: 2023년 2월 9일(목) 03:40 ~ 06:00 (약 2시간 40분)

     내용: SKT 통신사 휴대폰 본인인증 서비스 일시 중단

     * 중단시간은 작업 상황에 따라 늘어날 수 있습니다.                  

     * SKT(MNO), SKT 알뜰폰(MVNO) 모두 적용됩니다. 

     * SKT를 제외한 타통신사 인증은 영향 없습니다.


이용에 불편을 드리는 점 이해 부탁드립니다.

더욱 노력하는 지아고 패널파워가 되겠습니다.

감사합니다.',
'2022-02-07'
);

insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin',
'1월 소비자패널조사 경품 당첨자 발표',
'안녕하세요. 지아고 패널파워입니다.

1월 112676번 소비자패널조사 이벤트 결과를 발표합니다.
(개인정보보호를 위하여 정보를 공개하지 않습니다)

당첨자 확인

※ 이벤트 관련 자세한 내용은 이벤트>당첨자 확인 에서 확인하여 주시기 바랍니다.
※ 정회원이 아니거나, 허위정보, 개인정보불성실의 경우 추첨 및 당첨 대상에서 제외됩니다.
※ 경품은 이벤트 마감일 기준 정보로 발송되며, 정보불일치나 연락두절로 인한 배송오류 시재발송하지 않습니다.
※ 경품은 회사와 판매처 사정에 따라 변경될 수 있습니다.',
'2023-02-08'
);


insert into notice (notice_admin, notice_name, notice_content, notice_date) values(
'admin', 
'지아고 패널파워 공식 인스타그램 OPEN!!!', 
'안녕하세요. 지아고 패널파워입니다. 지아고 패널파워 공식 인스타그램을 개설하여 패널님들께 안내 드립니다. 
지아고의 조사 결과는 물론, 다양한 이벤트 정보가 업데이트 될 예정이오니 팔로우하고 더 많은 소식을 쉽게 받아보시기 바랍니다.
*계정 이름: @embrain_panelpower
*위 이미지 클릭시 인스타그램으로 이동
많은 관심 부탁드립니다.
앞으로도 더욱 좋은 서비스를 위해 노력하겠습니다.
감사합니다.',
'2023-02-09'
);


---------------------------------------------------------------------------------------------------------- 회사이름 -----------------------------------------------------------------------------------------------------------

insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (1, '비사이드홀딩스', '647-902-4388', '63824-282','부산시 남성구' , 'gplaxton0@unblog.fr');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (2, '주식회사 기웅', '968-342-1379', '68645-282', '전남성 함평군 대동면 동함평산단길 19-72', 'akohnen1@adobe.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (3, '못과 망치', '333-150-1120', '0173-0695', '산청군 금서면', 'tnizard2@canalblog.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (4, '오라오라', '913-491-2814', '68987-010', '경기도 부천시', 'jkarlolak3@aol.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (5, '고라니[GOLANI]', '291-617-2656', '33992-8684', '서울시 송파구', 'jkyffin4@miitbeian.gov.cn');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (6, '일상커머스', '916-205-8164', '43742-0250', '경남성 김해시 인제로 197', 'kjaggs5@storify.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (7, '동동이마켓', '825-370-5228', '66391-0301', '경기 과천시 부림로 2', 'mcorsham6@nps.gov');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (8, '핸드디자인', '990-936-5758', '55910-596', '서울 용산구 청파로 359', 'nfrogley7@hhs.gov');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (9, '고카롱', '182-780-6627', '67659-080', '부산시 서구', 'nupham8@a8.net');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (10, '에스제이[SJ]', '212-168-2481', '68151-0084', '전라남성도 함평군 대동면 동함평산단길 19-72', 'amenco9@indiatimes.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (11, '빛나', '329-841-9733', '76237-103', '광주 광산구 앰코로 21', 'mswainsburya@google.pl');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (12, '포레드희', '964-668-8448', '55312-076', '경기 시흥시 경제로 296', 'gfishpooleb@stumbleupon.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (13, '에튜맥스코리아', '882-805-2643', '10812-168', '경상남성도 창원시 원이대로774', 'pbestmanc@diigo.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (14, '로랑쉬', '581-883-3074', '0074-0522', '부산시 서구 구덕로330-11', 'schalfantd@google.fr');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (15, '스마트유통', '789-721-1185', '51079-777', '경기도 성남성시 분당구 매화로 51', 'fcrosslande@dmoz.org');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (16, '블링블링', '151-850-2817', '42254-134', '서울 서대문구 홍제천로4길', 'pgasquoinef@ed.gov');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (17, '수참치', '484-154-7497', '0032-1101', '경기 오산시 운천로 52', 'jthurstong@tinypic.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (18, '브라이튼룩', '611-618-5232', '0430-0979', '경기 화성시 정남성면 정남성산단3길 10', 'fashbolth@imdb.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (19, '예쁜걸 장신구', '763-304-5659', '0904-6418', '부산 서구 구덕로280번길 29', 'kmckiernani@bloglovin.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (20, '벨로[Vello]', '671-414-4189', '54569-0409', '경기 화성시 동탄산단9길 9-8 ', 'rmatfieldj@constantcontact.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (21, '아구랑추어랑', '109-273-8027', '0904-4062', '서울시 양천구 목동 609-25', 'cneillk@quantcast.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (22, '유쓰들', '905-518-8313', '49852-302', '부산 서구 보수대로320번길 11', 'sgammidgel@unesco.org');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (23, '부경티앤티', '172-611-9980', '51079-515', '경북 칠곡군 지천면 신동로23', 'sbrunescom@github.io');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (24, '인어아지매', '551-308-6839', '49035-199', '부산광역시 영도구 봉래동2가 39-5', 'tbonninn@deliciousdays.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (25, '안경잽이', '932-584-3455', '58232-4020', '부산 서구 대영로38번길 11', 'awolleno@wsj.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (26, '방콕통신', '552-343-7476', '49035-595', '부산 서구 까치고개로 159', 'nifflandp@nifty.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (27, '에이치제이 마켓[H.J Market]', '134-468-3005', '36987-2479', '경기 화성시 향남성읍 발안공단로4길 30 ', 'msinnockeq@unesco.org');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (28, '내상점', '318-931-7516', '10742-6751', '부산 서구 구덕로185번길 22-23', 'bdewsr@bbb.org');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (29, '가방천국', '688-240-5944', '64764-510', '부산 동래구 석사로17번길 20', 'rsambells@youtu.be');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (30, '퍼시픽피셔리[주]', '744-591-3907', '62011-0061', '부산 사하구 장림번영로104번길 55', 'emclaughlant@simplemachines.org');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (31, '심플베베', '837-911-6806', '49348-233', '부산 서구 대티로 161', 'bdedonu@hao123.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (32, '서구러닝교육센터', '523-595-7448', '24658-242', '인천 서구 경서동', 'mbinnallv@cmu.edu');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (33, '오디너리[ordinary]', '978-320-6376', '52685-434', '경기 파주시 지목로 70-17', 'kdanburyw@nsw.gov.au');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (34, '매튜 DEWL', '741-269-9572', '0023-9155', '경기도 양평군 강상면 강남성로 689', 'rhendersonx@hugedomains.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (35, '스튜디오 라온', '729-150-5641', '67718-938', '서울 강남성구 도산대로17길 23', 'ofawlksy@disqus.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (36, '아띠', '485-724-6166', '54868-4885', '서울 중구 명동길 7-1', 'oollierz@va.gov');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (37, '유 커뮤니케이션[U communication]', '510-748-7040', '49288-0931', '경기 오산시 가수행복로 55-5', 'thaycock10@who.int');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (38, '모바일테크', '134-399-9994', '59779-143', '울산 중구 종가6길 21', 'lgiggie11@weather.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (39, '띵션[Thinction]', '801-189-0000', '64305-006', '부산 금정구 금정로231번길 29', 'lclemmitt12@examiner.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (40, '소감상점', '717-161-4553', '0185-0932', '부산 서구 천마로111번길 ', 'kbolesworth13@multiply.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (41, '예나푸드', '958-210-2013', '63029-611', '부산 서구 구덕로124번길 15', 'raggas14@hhs.gov');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (42, '메이커올', '772-219-3204', '0065-1433', '부산 남성구 용소로14번길', 'tgarms15@flickr.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (43, '제이앤선[Jeon]', '651-786-0842', '49738-175', '경기도 용인시 기흥구청', 'cwhimpenny16@symantec.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (44, '진어웨이[jeanaway]', '544-184-3302', '60505-0084', '부산 서구 충무시장길 50', 'lsiebert17@sitemeter.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (45, '띵호야[ThingHOYA]', '698-611-8590', '51079-886', '부산 서구 아미초장로 24', 'dgiraldo18@wiley.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (46, '[주]우신냉장', '865-530-9287', '0378-1012', '부산 서구 등대로 123', 'jmonument19@51.la');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (47, '백오십삼[153]', '298-468-3964', '0363-0504', '강원 속초시 만천길 25', 'iforster1a@tinyurl.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (48, '판다고', '970-960-6039', '36987-1747', '대구 남성구 앞산순환로63길', 'lnulty1b@adobe.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (49, '요기요기 싼마켓', '763-697-8262', '0087-6071', '부산 서구 해돋이로 12-1', 'fhoofe1c@com.com');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (50, '[주]하나푸드', '542-638-4775', '18860-342', '경기 의왕시 고천공업로 52', 'jcomelli1d@cdc.gov');
insert into survey_company (company_id, company_name, company_num, company_registnum, company_address, company_email) values (51, '제주도서', '372-248-5675', '19960-186', '제주 서귀포시 중앙로 104 (동홍동) 우생당', 'happybook@bok.com');

---------------------------------------------------------------------------------------------------------- 설문지 문제 -----------------------------------------------------------------------------------------------------------


insert into question (question_content) values ('전체답변');
insert into question (question_content) values ('당신의 연령대는?');
insert into question (question_content) values ('당신의 성별은?');
insert into question (question_content) values ('당신의 직업은?');


Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 거주지역은 어디입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 올해 만으로 나이가 어떻게 되십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 성별은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 현재 직업은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 본인 또는 가족의 전반적인 경제적 상황에 대해 알고 계십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 본인 또는 가족의 주요 소비결정 시 주로 참여하시는 편입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 본인 또는 가족의 주요 소비생활은 어떤것입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('다음의 점포를 직접 방문하여 이용해 보셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('선택한 점포의 이용횟수는 얼마입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('선택한 점포의 1회 구매액은 얼마입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('다음의 거래를 이용해보셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('선택한 거래의 이용횟수는 얼마입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('선택한 거래의 1회 구매액은 얼마입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에 얼마나 자주 방문하시나요?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에 가는 이유는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('최근 1년간 도서관에서 도서자료 및 대출을 한 경험이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에 귀하께서 찾는 신간 도서를 가지고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에 내가 찾는 분야의 도서를 잘 갖추고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('최근 1년간 도서관 직원에게 정보를 문의한 경험이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에 직원은 지식이 풍부해서 내가 원하는 정보에 대한 상담(문의)을 할 수 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에 직원은 친절합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관의 환경(시설, 청소상태 등)은 관리가 잘 되어 있어 독서 및 학습을 하기에 불편함이 없습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에서 컴퓨터를 이용하거나 DVD 등 자료를 이용할 수 있는 시설이나 장비가 잘 갖추어져 있어 이용하기 편합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관에서 진행하는 문화프로그램에 대한 정보는 쉽게 얻을 수 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('최근 1년간 도서관에서 진행하는 전시회/특강/강좌/공연/공모전 등의 문화 프로그램을 이용한적이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관 문화프로그램은 내용이 알차 내가 참여했거나 참여하고 싶은 프로그램이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도보, 자전거 등으로 방문하거나 대중교통(버스, 지하철 등)을 이용해 오기 편합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('찾아가기 쉽도록 이정표가 잘 설치되어 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('색각 이상표라는 것을 가족이나 친척을 포함하여, 주변에서 얼마나 알고있습니까? ');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하께서 색각검사표를 보면 기분이 어떻습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스마트폰, 노트북 등의 전자기기를 사용할 때 색 보정 기능을 사용하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('색약 보정 안경이나 렌즈를 알고 계십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('색약 보정 안경이나 렌즈의 구매 경험이 있으십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 평상시 영화관람을 위해 영화관을 자주 이용하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 지난 3개월간 평균 몇번이나 영화관을 이용하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하가 주로 이용하는 영화관은 어느곳 입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하가 자주 시청하는 영화의 장르는 어떤것입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 영화를 예매할때 주로 어떤 방식으로 예매하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 지난 7일동안 커피전문점을 몇번 방문하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('다음 다섯가지 커피브랜드 중 가장 선호하는 브랜드는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('커피 전문점 이용을 결정할때 가장 결정적인 요인은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하가 커피 전문점에서 머무르는 평균적인 시간을 기재해주세요');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('커피 전문점을 이용하는 이유가 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 다가올 휴가 때 해외 여행을 희망하시나요?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신이 희망하는 해외여행 종류는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신이 희망하는 여행지는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신이 희망하는 여행 기간은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신이 생각하는 여행의 1인당 금액은? (쇼핑비용 제외)');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신이 해외 여행지를 선택할 때 고려하는 사항은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('본인의 회사의 직원들은 필요하다면 새로운 업무에 대해 기꺼이 받아드린다');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신이 속한 회사에서 당신이 도움이 필요하면 조직원들이 기꺼이 도와주려고 합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('직원들은 능동적으로 새로운 도전과 기회를 인지하고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신의 동료직원들은 상황이 어려워도 계속해서 일을 합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신의 조직에서 직원들은 어려운 상황을 빠르게 적응합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('나의 업무에서 직업 규율을 완전히 숙지하고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('나는 매일 나의 일에 최선을 다하려고 하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('나는 관련된 업무를 할때 시간이 빠르게 지나갑니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('나는 나의 일이 재밌습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신의 조직에서 소프트웨어를 구매할때, 당신의 역할은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('무엇이 당신의 제품이나 업무에서 가장 매력적인 부분이라고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 최근에 물건을 구입하는걸 결정하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신의 회사에서 물건을 사고 얼마나 만족하고 불만족 하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('우리 도서관 일반도서 중 확충이 필요한 분야를 고르세요');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도서관 도서대출예약서비스를 이용하면서 가장 불편했던 점은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('직원에게 요구되는 가장 중요한 것은 무엇이라고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('향후 가장 참여하고 싶은 강좌나 프로그램 분야는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('코로나19로 온라인 교육이 활성화 되고 있습니다 우리도서관 온라인 교육을 운영할 경우 참여할 의향이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('시민들의 독서 진흥을 위해 가장 우선시 되어야 할 사업은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 참가 형태는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('기술 박람회에 처음 방문하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('가상전시, 기술세미나, 미래기술관 등 프로그램이 유익했습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('유익했던 프로그램을 선택해주세요');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('관심이 있다거나 흥미로운 기술(부스)가 있었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('프로그램 운영 안내(E-BOOK)및 정보 획득이 용이 하였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('박람회 접속 환경(품질, 서비스 등)은 전반적으로 적절 하였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('박람회 시기와 기간은 적절 하였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('하나푸드 기술 박람회 전반적으로 만족스러웠습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 회사(업무)에 도움이 될 것 같습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('내년에도 박람회를 실시한다면 재방문(참여) 의사가 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('예나푸드 농업박람회에 참가하신 목적은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('예나푸드 농업박람회에 대한 정보는 어디를 통해 알게 되었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업에 관한 정보를 얻을수 있었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업에 관한 첨단기술을 알게 되었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업관리사에 대해서 알게 되었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('다양한 이벤트와 프로그램이 제공되었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업박람회 홈페이지에서 필요한 정보를 쉽게 찾을 수 있었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시 농업박람회 홈페이지로딩 및 반응속도가 적절했습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업박람회 홈페이지 이용 중 시스템오류 문제가 없었습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업박람회 홈페이지에 대해 전반적으로 만족하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업박람회를 통해 도시농업을 실제로 해볼 의향이 생겼습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업박람회를 내년에도 진행한다면 다시 참가할 의향이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('도시농업박람회를 주변 사람에게 추천할 의향이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('현재 사용중인 스마트폰의 제조사는 어디입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('해당 제조사의 스마트폰을 선택할 때 관심있게 고려한 부분은 무엇입니까');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스마트폰 제품을 선택할 때 최종 구매결정에 영향을 미친 요소는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('현재 사용중인 스마트폰에 대해서 어느정도 만족하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('현재 사용중인 스마트폰에 어떠한 점이 개선되었으면 합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스마트폰의 필요성에 대해서 어떻게 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스마트폰을 통화의 목적에 어떤 용도로 많이 사용하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스마트폰의 교체주기에 대해서 어떻게 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('사용중인 스마트폰의 약정 종료 후 주입할 때 선택하고 싶은 제조사는 어디입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('TV방송은 어떤 식으로 시청하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('TV는 주로 어떤 용도로 사용하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('하루 TV시청 시간은(주말 포함해서 평균)');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('TV와 홈시어터는 연결하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('TV에는 기기들을 연결해 보셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('TV는 언제 구입하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('사용하고 계신 TV화질은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('사용하고 계신 TV유형은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('방송 +VOD 화질-음질은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('방송+VOD 의 불편한 점은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('UHD TV구입은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('UHD TV-방송의 문제는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('일주일에 1회 이상 운동을 하고 있는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('어떤 운동을 하고 있는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('헬스장에 등록해본 경험이 있는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('헬스장 이용권 기간 단위는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('헬스장 이용권 기간 중 실제 이용한 기간은 얼마나 되나?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('헬스장 이용권 기간 만료 전, 환불을 시도한 적이 있는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('헬스장 이용권 환불에 성공하였는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('헬스장 이용권 만료 전 헬즈장이 폐업/휴업하여 손해를 본 적이 있는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('''헬스장 이용권 중간 해지 시 3일 내 환불'' 법안이 제대로 지켜질 것 같은가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('식사는 늘 배가 부르도록 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('식사 시에는 식품의 배합을 생각하여 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('1일 3끼의 식사 중 거르는 일이 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('채소는 좋아하며 자주 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('육류요리 (쇠고기, 돼지고기, 닭고기)는 자주 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('과일은 자주 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('생선, 두부, 및 콩제품을 자주 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('우유나 요구르트를 매일 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('해조류(미역, 김 등)을 자주 먹습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('음식의 간은 어느 정도로 합니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('아침식사를 제대로 하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('만약 아침식사를 제대로 하지 않으면 이유는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('식사는 규칙적으로 하시는 편입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('식사 속도는 어떻습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('음식에 대한 편식 정도는 어떻습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('하루 3끼 식사 중 가장 중요하게 생각하는 식사는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('면역기능을 강화한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('피로회복 및 기력회복에 좋다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('노화방지에 좋다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('항암 효과가 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('혈압을 조절한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당뇨 및 혈당대사를 조절한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('정력을 증진한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('간기능 회복에 효과가 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 학년은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 소속 단과대학은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하의 대학교 소재지는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('졸업 후 어떤 분야로 진출하실 생각이십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('취업을 원하신다면 어떤 기업에 종사하고 싶습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('그렇다면 이유는 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하가 선호하는 근무지역은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하가 선호하는 근무지역을 선택한 이유는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('취업대상기업의 업무환경 및 구체적인 업무사항에 대해서는 알고 계십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('중소기업에 대한 귀하의 인식은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('중소기업에 대한 인식에서 긍적적으로 생각하는 이유는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('중소기업에 대한 인식에서 부정적으로 생각하는 이유는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하가 취업을 위한 준비로 가장 중요시 생각하는 것은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 취업정보를 어디서 얻고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('대학교에서는 취업정보를 충분하게 제공한다고 느끼십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('현재 사회적 이슈인 대졸자 실업률이 높은 원인은 무엇이라고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스트레스를 감소시키는 효능이 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('기억력 증진에 좋다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과 선택시 가장 비중을 두는 것은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과를 선택하는 요소?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과에 대한 이미지는 어떤가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('어떤 치과에 가고 싶은가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과 의사에 대한 생각');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과 의사에 대해 바라는점');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('동네치과를 가는 이유는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과를 방문하는 이유는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과에 바라는점');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('치과 보험에 대해서는 어떻게 생각하는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('가장 많이 사용하는 인터넷 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('전체적으로 이미지가 좋은 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('메인 디자인이 마음에드는 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('사용하기 편리한 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('고객서비스가 우수한 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('언론규제에 취약한 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털사이트의 실시간 검색어를 확인하는 편인가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털사이트의 실시간 검색어는 믿을만한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('스마트 폰을 통해 이용하는 포털사이트는?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('카카오톡 내 다음 모바일이 제공된다면 이용할것인가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('밥맛은 어떠한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('국맛은 어떠한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('김치의 맛은 어떠한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('반찬의 맛은 어떠한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('식단, 식기, 수저 등은 깨끗한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('직원들의 복장은 깨끗하고 단정한가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('음식은 위생적으로 제공되고 있는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('직원들은 밝은 얼굴로 친절하게 인사하는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('편안하고 기분좋은 서비스가 제공되는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('반찬의 간은 어느정도 선호하는가?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 선호하는 방식은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 활용하고 있는 플렛폼은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 플렛폼을 선정한 이유?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('선택한 플랫폼의 기능적인 면에서 중요하게 고려한 부분');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('대면강의랑 비교해서 시간과 노력이 어느정도 투자됩니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 실습이 꼭 함께 진행되어야 할 경우가 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 대면강의와 비교해 가장 큰 애로사항은?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 대면강의와 비교해 장점은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의로 부터 받은 지침, 정보, 지원 등에 대해서 얼마나 만족하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 가장 시급히 지원해 줬으면 하는 부분은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 가장 우선적으로 필요한 교육은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('진행중인 온라인 강의에서 피드백을 받거나 받으실 계획이 있으십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('있다면 어떤 형태로 피드백을 받으실 계획입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('나는 현실 생활보다 게임 속에서 더 유능한 사람인 것 같다');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('친구들과 주로 게임 이야기를 많이 한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('요즘 외출을 거의하지 않는다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('해야할 일이 있는데도, 게임을 그만 둘 수가 없다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 구하거나 설치하느라 보내는 시간이 적지 않다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('다른 사람들과 함께 있을 때에도 게임에 대한 생각을 종종한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('세상의 모든 일이 게임처럼 진행되었으면 좋겠다는 생각이 들 때가 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하느라 밤을 새운 적이 많다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임 때문에 시험(일)을 망친 적이 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임 시간을 줄이려고 노력하는데도 변변히 실패한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임에 관한 꿈을 꾼 적이 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 통해서는 불가능한 일을 할 수 있다고 느낀다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 안 하는데도 게임을 하는 느낌이 들 때가 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하느라고 약속을 취소하거나 시간을 어기는 일이 많다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하는 것 때문에 가족을과 다툰 적이 있다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임 캐릭터가 다치거나 죽으면 내가 그런거 같은 느낌이 든다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하는 도중에 방해를 받으면 과도허게 화를 낸다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하는 동안은 모든 근심 걱정을 잊는다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하다가 고함을 치느 경우가 많다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하느라고 식사를 거른 적이 많다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하지 못할 때면 짜증이 나거나 화가 난다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 거의 매일 한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 하지 않을 때에도 줄곧 게임에 관한 생각만 한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임를 한 번 시작하면 끝을 볼 때까지 한다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('게임을 한 이후로 집중력이 떨어졌다.');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 국내여행보다 해외여행을 선호하시나요?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하께서는 부산광역시에 살고 계시는 것에 대해 어느 정도 만족하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('만족하시는 분야를 선택해 주십시요');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('불만족스러운 분야를 선택해 주십시요');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('3년동안 가장 큰 발전을 한 분야는 무엇이라고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('아래 예문은 부산광역시의 장기적인 발전을 추진하는 주요 정책사업입니다 가장 잘추진되고 있는 사업을 선택해주세요');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털사이트에 대한 전반적인 만족도는 어떻습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털사이트에 방문하시는 주요 목적은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('귀하는 최근 3개월동안 얼마나 자주 방문하셨습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털은 개인정보보호관련 정보 및 자료를 적절하게 제공하고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털 내 온라인 교육서비스를 이용하기 위한 절차가 간편하다고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털의 디자인 및 기능은 서비스를 이용하는데 적절하다고 생각하십니까? ');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털 내 서비스는 신속하게 제공하고 있다고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('포털에서 제공하는 서비스에 대해 전반적으로 만족하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복의 역할은 동해 방지 외에도 중요한 점이 있습니다 알고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복은 언제 했습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복까지 주로 수관의 어느 위치에 과실을 수확했습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복 직전의 가을 응애 방제는 했습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복하는 과실은 어느 정도 크기의 과실입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복은 전체 결과량 중 어느 정도의 비율로 실시했습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('봉지 피복은 나무의 한 부분에 집중시키는 방식입니까? 아니면 분산 방식입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('월동 수확 재배를 하기 위해 봉지를 씌울 때 온주 밀감의 당도는 어느 정도였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('월동 수확 재배를 하기 위해 봉지를 씌울 때 온주 밀감의 산 함량은 어느 정도였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('본년도의 당 함량은 어느 정도였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('본년도의 산 함량은 어느 정도였습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 보안을 통합하는것을 매주의 루틴으로 하고 계십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 보안통합을 하는 방법을 알고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 회사 보안정책을 따르고 있습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 보안정책이 당신의 업무에 도움이 된다고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신의 회사 보안레벨이 고객들에게 신뢰를 준다고 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('가장 최근에 사용한 스킨케어 제품은 무엇입니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('당신은 어디서 화장품 정보를 얻습니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('제품을 고를때, 어느 요소를 가장 중요하게 생각하십니까?');
Insert into C##JIAGO.QUESTION (QUESTION_CONTENT) values ('내가 속한 조직의 직원들은 변화를 기꺼이 받아들일 준비가 되어있다');


---------------------------------------------------------------------------------------------------------- 설문지 제목 -----------------------------------------------------------------------------------------------------------

insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE,
    SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (1, '설문 테스트', '23/02/07~23/02/28', 500, '30', '20대',
    '남성', '공통', '설문 테스트 입니다.');  
    
insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE,
    SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (2, '설문 테스트2', '20/05/06~20/07/22', 500, '30', '30대',
    '남성', '공통', '설문 테스트 입니다2');      

insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE,
    SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (2, '설문 테스트3', '23/01/01~23/01/31', 500, '20', '40대',
    '남성', '공통', '설문 테스트 입니다3');
    
insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE,
    SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (2, '설문 테스트3', '23/01/01~23/12/31', 500, '20', '40대', '남성', '사무직', '설문 테스트 입니다3');    
    
insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE, SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (6, '소비생활 조사', '23/01/10~23/03/20', 100, '5', '30대', '여성', '경영직', '소비생활 현황을 파악하여 소비생활 향상을 위한 지표와 제도마련을 위해, 본 설문조사를. 실시하고 있습니다.'); 
    
insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE, SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (51, '도서관 이용자 만족도 설문조사', '23/02/01~23/02/26', 100, '5', '10대', '공통', '학생', '도서관 이용자 만족도 설문조사를 통하여 도서관 서비스에 대한 이용자의 다양한
의견과 요구 파악');

insert into survey
    (COMPANY_IDX, SURVEY_TITLE , SURVEY_DATE, SURVEY_POINT, SURVEY_TIME, SURVEY_TARGETAGE, SURVEY_TARGETGENDER, SURVEY_TARGETJOB, SURVEY_INFO) 
    values (25, '색각 이상표 설문조사', '22/12/05~23/01/20', 50, '5', '20대', '공통', '공통', '색각 이상자 안경 사용현황 조사');


Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (44,'스마트폰 설문조사','23/03/17~23/03/31',200,'10','공통','공통','공통','스마트폰 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (24,'구내식당 설문조사','23/04/12~23/04/19',100,'5','공통','공통','공통','구내식당 설문조사입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (1,'설문 테스트','23/02/07~23/02/28',500,'30','20대','남성','공통','설문 테스트 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (2,'설문 테스트2','20/05/06~20/07/22',500,'30','30대','남성','공통','설문 테스트 입니다2','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (2,'설문 테스트3','23/01/01~23/02/01',500,'20','40대','남성','공통','설문 테스트 입니다3','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (2,'설문 테스트3','23/01/01~23/02/01',500,'20','40대','남성','공통','설문 테스트 입니다3','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (6,'소비생활 조사','23/01/10~23/03/20',100,'5','30대','여성','경영직','소비생활 현황을 파악하여 소비생활 향상을 위한 지표와 제도마련을 위해, 본 설문조사를. 실시하고 있습니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (51,'도서관 이용자 만족도 설문조사','23/02/01~23/02/26',100,'5','10대','공통','학생','도서관 이용자 만족도 설문조사를 통하여 도서관 서비스에 대한 이용자의 다양한
의견과 요구 파악','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (25,'색각 이상표 설문조사','22/12/05~23/01/20',50,'5','20대','공통','공통','색각 이상자 안경 사용현황 조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (23,'채용 만족도 설문조사','23/03/02~23/04/20',100,'5','20대','공통','무직','채용만족도 설문조사입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (43,'스트레스 설문조사','23/03/05~23/04/05',200,'8','공통','공통','교사/학원강사','[교사대상] 스트레스 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (8,'가상 화폐 설문조사','23/03/30~23/04/10',100,'5','공통','공통','공통','가상화폐 설문조사입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (4,'분류 인지도 설문조사','23/03/02~23/03/02',100,'5','30대','여성','공통','[30대,여성] 분류 인지도 설문조사입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (10,'동물병원 직원 평가 설문조사','23/03/28~23/05/28',200,'10','공통','공통','전문직','동물병원 직원 평가 설문조사 입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (1,'보안 인식 설문조사','23/03/20~23/04/30',200,'10','공통','공통','전문직','[IT 개발자 대상] 보안 인식 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (39,'스킨 케어 제품 설문조사','23/03/02~23/04/08',100,'5','공통','여성','공통','[여성대상] 스킨 케어 제품 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (18,'[MZ 세대] 직무 몰입도 설문조사','23/03/02~23/03/16',300,'5','20대','공통','공통','[MZ 세대] 직무 몰입도 설문조사입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (12,'성취와 실패에 관한 설문조사','23/03/15~23/04/15',100,'5','공통','공통','공통','성취와 실패에 관한 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (50,'[주]하나푸드 기술 박람회 설문조사','23/03/10~23/03/17',500,'10','공통','공통','공통','[주]하나푸드 기술 박람회 설문조사 입니다
','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (41,'[예나푸드] 농업박람회 만족도 조사','23/04/10~23/04/15',200,'10','공통','공통','공통','[예나푸드] 농업박람회 만족도 조사입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (32,'영화관 설문조사','23/03/02~23/03/30',100,'9','공통','공통','공통','영화관 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (45,'커피브랜드 설문조사','23/03/08~23/04/13',300,'5','공통','공통','공통','커피브랜드 설문조사입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (51,'휴가 계획 설문조사','23/04/05~23/04/26',200,'12','공통','공통','공통','휴가 계획 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (12,'부산 광역시 설문조사','23/03/10~23/03/17',500,'5','공통','공통','공통','부산 광역시 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (29,'대학생 취업 설문조사','23/04/05~23/05/17',400,'15','20대','공통','학생','대학생 취업 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (17,'TV시청 설문조사','23/04/04~23/04/11',200,'15','공통','여성','전업주부','[여성/주부] TV시청 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (22,'헬스장 설문조사','23/03/03~23/04/28',200,'10','공통','공통','공통','헬스장 설문조사 입니다','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (31,'식습관 설문조사','23/03/03~23/05/16',200,'10','70대 이상','공통','무직','[70대 이상] 식습관 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (47,'인삼의 인식도 설문조사','23/03/03~23/03/08',200,'11','공통','공통','공통','인삼의 인식도 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (11,'치과 설문조사','23/03/18~23/03/25',200,'10','공통','공통','공통','치과 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (5,'포털사이트 설문조사','23/02/28~23/04/29',200,'14','30대','공통','공통','[30대 대상] 포털 사이트 설문조사 입니다.','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (15,'온라인 강의 설문조사','23/03/03~23/04/13',400,'20','공통','공통','공통','온라인 강의 설문조사','N');
Insert into C##JIAGO.SURVEY (company_idx, SURVEY_TITLE,SURVEY_DATE,SURVEY_POINT,SURVEY_TIME,SURVEY_TARGETAGE,SURVEY_TARGETGENDER,SURVEY_TARGETJOB,SURVEY_INFO,SURVEY_DELETE) values (44,'청소년 게임 중독 설문조사','23/03/01~23/04/01',500,'20','10대','공통','학생','[중고 학생] 청소년 게임 중독 설문조사 ','N');






update survey_question set survey_idx = 1 where survey_idx is null;   

select * from survey_question;

insert into survey_example
    (survey_idx, question_idx, example_content) 
    values (1, 2, '10대');
    
insert into survey_example
    (survey_idx, question_idx, example_content) 
    values (1, 2, '20대');
    
insert into survey_example
    (survey_idx, question_idx, example_content) 
    values (1, 3, '남성');
    
insert into survey_example
    (survey_idx, question_idx, example_content) 
    values (1, 3, '여성');
    
insert into survey_example
    (survey_idx, question_idx, example_content) 
    values (1, 4, '사무직');    
    
insert into survey_example (survey_idx, question_idx, example_content) values (1, 4, '영업직');   
    
insert into survey_example(survey_idx, question_idx, example_content) values (1, 4, '기타');
 
select * from survey_example;


commit;

select * from survey where survey_idx = 28;


--------------------- 영화 질문 시작 -----------------
insert into survey_question(survey_idx, question_idx, question_content) values (28, 2, '당신의 연령대는?');
insert into survey_question(survey_idx, question_idx, question_content) values (28, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (28, 4, '당신의 직업은?');
insert into survey_question(survey_idx, question_idx, question_content) values (28, 40, '귀하가 주로 이용하는 영화관은 어느곳 입니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (28, 39, '귀하는 지난 3개월간 평균 몇번이나 영화관을 이용하셨습니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (28, 41, '귀하가 자주 시청하는 영화의 장르는 어떤것입니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (28, 42, '귀하는 영화를 예매할때 주로 어떤 방식으로 예매하십니까?');


------------------ 영화 설문 보기 시작 -----------------------------------
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '10대');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '20대');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '30대');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '40대');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '50대');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '60대');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 2, '70대 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (28, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '전문직');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '경영직');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '사무직');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '교사/학원강사');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '공무원');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '학생');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '전업주부');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '자영업');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '무직');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 4, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (28, 40, 'CGV');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 40, '롯데시네마');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 40, '메가박스');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 40, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (28, 39, '일주일에 한번');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 39, '한달에 한번');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 39, '세달에 한번');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 39, '일년에 한번');

insert into survey_example(survey_idx, question_idx, example_content) values (28, 41, '액션');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 41, '공상과학');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 41, '로맨스');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 41, '코메디');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 41, '기타');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 42, '온라인');
insert into survey_example(survey_idx, question_idx, example_content) values (28, 42, '오프라인');


------------------- 영화 답변 시작 --------------------------------------------
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '60대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '여성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '사무직', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '한달에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '메가박스', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '코메디', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (7, '오프라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '20대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '여성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '사무직', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '일주일에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '롯데시네마', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '로맨스', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '무직', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '일주일에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '롯데시네마', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (1, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '롯데시네마', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, '40대', '23/03/04', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, '여성', '23/03/04', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, '공무원', '23/03/04', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, '한달에 한번', '23/03/04', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, 'CGV', '23/03/04', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, '기타', '23/03/04', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (90, '온라인', '23/03/04', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (9, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, '일년에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (66, '온라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, '30대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, '기타', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, '한달에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, '기타', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (33, '오프라인', '23/03/02', 42, 28);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '20대', '23/03/02', 2, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '남성', '23/03/02', 3, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '공무원', '23/03/02', 4, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '일주일에 한번', '23/03/02', 39, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, 'CGV', '23/03/02', 40, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '로맨스', '23/03/02', 41, 28);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '온라인', '23/03/02', 42, 28);

---------------------------------------영화 답변 끝 -------------------------------



--------------------- 온라인 강의 질문 시작 -----------------
insert into survey_question(survey_idx, question_idx, question_content) values (39, 2, '당신의 연령대는?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 199, '진행중인 온라인 강의에서 선호하는 방식은 무엇입니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (39. 200, '진행중인 온라인 강의에서 활용하고 있는 플렛폼은?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 201, '진행중인 온라인 강의에서 플렛폼을 선정한 이유?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 202, '선택한 플랫폼의 기능적인 면에서 중요하게 고려한 부분');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 203, '대면강의랑 비교해서 시간과 노력이 어느정도 투자됩니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 204, '진행중인 온라인 강의에서 실습이 꼭 함께 진행되어야 할 경우가 있습니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 205, '진행중인 온라인 강의에서 대면강의와 비교해 가장 큰 애로사항은?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 206, '진행중인 온라인 강의에서 대면강의와 비교해 장점은 무엇입니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 207, '진행중인 온라인 강의로 부터 받은 지침, 정보, 지원 등에 대해서 얼마나 만족하십니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 210, '진행중인 온라인 강의에서 피드백을 받거나 받으실 계획이 있으십니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (39, 211, '있다면 어떤 형태로 피드백을 받으실 계획입니까?');


------------------ 온라인 설문 보기 시작 ------------------------------------
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '10대');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '20대');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '30대');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '40대');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '50대');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '60대');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 2, '70대 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 199, '녹화된 강의 재생');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 199, '실시간 화상 강의');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 199, '강의 자료 업로드');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 199, '과제 제출 방식');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 199, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 200, '학교 제공 시스템');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 200, '유튜브');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 200, '줌');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 200, '스카이프');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 200, '디스코드');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 200, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 201, '대학이 선정한 플랫폼이라서');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 201, '이미 사용해 본 플랫폼이라 익숙해서');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 201, '주위 동료 교수/강사 분들의 추천으로');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 201, '본인의 강의를 위해 적절한 기능들이 있어서');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 201, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 202, '영상과 음질의 성능');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 202, '접속의 편리성');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 202, '모바일 디바이스 접근가능');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 202, '사용방법의 편리성');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 202, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 203, '대면 강의보다 절약');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 203, '대면 강의와 비슷');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 203, '대면 강의보다 2배');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 203, '대면 강의보다 3배 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 204, '있다');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 204, '없다');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 205, '사용 전반적인 문제');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 205, '강의용 학습물을 제작하는 문제');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 205, '학생들의 이해정도와 학습 상황 파악의 문제');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 205, '온라인 접속 불안정으로 인한 강의 전달의 문제');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 205, '애로 사항 없음');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 206, '강의 준비하는 장소와 시간이 자유롭다');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 206, '수업자료의 재활용이 가능하다');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 206, '학생을 대면하지 않아 덜 부담스럽다');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 206, '질문과 토론이 오프라인보다 더 활발하다');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 206, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 207, '매우 만족');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 207, '만족');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 207, '보통');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 207, '불만족');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 207, '매우 불만족');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 210, '있다');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 210, '없다');

insert into survey_example(survey_idx, question_idx, example_content) values (39, 211, '플랫폼 활용');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 211, '이메일');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 211, '전화');
insert into survey_example(survey_idx, question_idx, example_content) values (39, 211, '기타');

------------------------ 온라인 강의 설문 답변 시작

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '70대 이상', '23/03/02', 2, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '기타', '23/03/02', 3, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '과제 제출 방식', '23/03/02', 199, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '본인의 강의를 위해 적절한 기능들이 있어서', '23/03/02', 201, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '기타', '23/03/02', 202, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '대면 강의보다 3배 이상', '23/03/02', 203, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '없다', '23/03/02', 204, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '강의용 학습물을 제작하는 문제', '23/03/02', 205, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '수업자료의 재활용이 가능하다', '23/03/02', 206, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '불만족', '23/03/02', 207, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '없다', '23/03/02', 210, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (70, '전화', '23/03/02', 211, 39);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '20대', '23/03/02', 2, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '여성', '23/03/02', 3, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '녹화된 강의 재생', '23/03/02', 199, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '대학이 선정한 플랫폼이라서', '23/03/02', 201, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '모바일 디바이스 접근 가능', '23/03/02', 202, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '대면 강의보다 3배 이상', '23/03/02', 203, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '없다', '23/03/02', 204, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '애로 사항 없음', '23/03/02', 205, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '수업자료의 재활용이 가능하다', '23/03/02', 206, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '만족', '23/03/02', 207, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '없다', '23/03/02', 210, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '기타', '23/03/02', 211, 39);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '30대', '23/03/02', 2, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '남성', '23/03/02', 3, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '과제 제출 방식', '23/03/02', 199, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '실시간 화상 강의', '23/03/02', 201, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '기타', '23/03/02', 202, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '대면 강의보다 2배 이상', '23/03/02', 203, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '없다', '23/03/02', 204, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '학생들의 이해정도와 학습 상황 파악의 문제', '23/03/02', 205, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '학생을 대면하지 않아 덜 부담스럽다', '23/03/02', 206, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '만족', '23/03/02', 207, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '없다', '23/03/02', 210, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '기타', '23/03/02', 211, 39);



insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '20대', '23/03/02', 2, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '남성', '23/03/02', 3, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '강의 자료 업로드', '23/03/02', 199, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '본인의 강의를 위해 적절한 기능들이 있어서', '23/03/02', 201, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '기타', '23/03/02', 202, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '대면 강의보다 2배 이상', '23/03/02', 203, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '없다', '23/03/02', 204, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '강의용 학습물을 제작하는 문제', '23/03/02', 205, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '수업자료의 재활용이 가능하다', '23/03/02', 206, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '보통', '23/03/02', 207, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '없다', '23/03/02', 210, 39);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '기타', '23/03/02', 211, 39);

---------------------------------------온라인 강의 설문 답변 끝 -------------------------------



--------------------- 인삼 질문 시작 -----------------
insert into survey_question(survey_idx, question_idx, question_content) values (36, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 2, '당신의 연령대는?');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 5, '귀하의 거주지역은 어디입니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (36. 143, '면역기능을 강화한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 144, '피로회복 및 기력회복에 좋다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 145, '노화방지에 좋다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 146, '항암 효과가 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 147, '혈압을 조절한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 148, '당뇨 및 혈당대사를 조절한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 149, '정력을 증진한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 150, '간기능 회복에 효과가 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 167, '스트레스를 감소시키는 효능이 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (36, 168, '기억력 증진에 좋다.');


------------------ 온라인 설문 보기 시작 ------------------------------------
insert into survey_example(survey_idx, question_idx, example_content) values (36, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 2, '20대');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 2, '30대');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 2, '40대');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 2, '50대');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 2, '60대');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 2, '70대 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '서울');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '부산');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '대구');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '인천');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '광주');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '경상도');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '전라도');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 5, '충청도');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 143, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 143, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 143, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 143, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 143, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 144, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 144, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 144, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 144, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 144, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 145, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 145, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 145, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 145, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 145, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 146, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 146, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 146, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 146, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 146, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 147, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 147, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 147, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 147, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 147, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 148, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 148, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 148, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 148, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 148, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 149, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 149, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 149, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 149, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 149, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 150, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 150, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 150, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 150, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 150, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 167, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 167, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 167, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 167, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 167, '매우그렇다');

insert into survey_example(survey_idx, question_idx, example_content) values (36, 168, '전혀아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 168, '아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 168, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 168, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (36, 168, '매우그렇다');

---------------------- 인삼 질문 끝 ---------------------------------------------


---------------------- 인삼 답변 시작 ----------------------------------------------------

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '30대', '23/03/04', 2, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '남성', '23/03/04', 3, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '부산', '23/03/04', 5, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '그렇다', '23/03/04', 144, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '그렇다', '23/03/04', 145, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 146, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 147, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 148, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 149, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 150, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 167, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (50, '보통이다', '23/03/04', 168, 36);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '30대', '23/03/04', 2, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '남성', '23/03/04', 3, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '부산', '23/03/04', 5, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '그렇다', '23/03/04', 144, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '그렇다', '23/03/04', 145, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '보통이다', '23/03/04', 146, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '보통이다', '23/03/04', 147, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '그렇다', '23/03/04', 148, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '보통이다', '23/03/04', 149, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '보통이다', '23/03/04', 150, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '그렇다', '23/03/04', 167, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '보통이다', '23/03/04', 168, 36);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '60대', '23/03/04', 2, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '남성', '23/03/04', 3, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '서울', '23/03/04', 5, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '그렇다', '23/03/04', 144, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '그렇다', '23/03/04', 145, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '보통이다', '23/03/04', 146, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '보통이다', '23/03/04', 147, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '그렇다', '23/03/04', 148, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '보통이다', '23/03/04', 149, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '보통이다', '23/03/04', 150, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '그렇다', '23/03/04', 167, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (30, '보통이다', '23/03/04', 168, 36);



insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '50대', '23/03/04', 2, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '여성', '23/03/04', 3, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '대구', '23/03/04', 5, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '그렇다', '23/03/04', 144, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '그렇다', '23/03/04', 145, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '보통이다', '23/03/04', 146, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '보통이다', '23/03/04', 147, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '그렇다', '23/03/04', 148, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '보통이다', '23/03/04', 149, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '보통이다', '23/03/04', 150, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '그렇다', '23/03/04', 167, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '그렇다', '23/03/04', 168, 36);



insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '50대', '23/03/04', 2, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '남성', '23/03/04', 3, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '부산', '23/03/04', 5, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '그렇다', '23/03/04', 144, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '그렇다', '23/03/04', 145, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '그렇다', '23/03/04', 146, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '보통이다', '23/03/04', 147, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '그렇다', '23/03/04', 148, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '보통이다', '23/03/04', 149, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '보통이다', '23/03/04', 150, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '그렇다', '23/03/04', 167, 36);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (20, '보통이다', '23/03/04', 168, 36);

-------------- 인삼 답변 끝 ----------------------------------------------


------------ 스킨 설문 시작 ---------------------------------------------------------
insert into survey_question(survey_idx, question_idx, question_content) values (23, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (23, 2, '당신의 연령대는?');
insert into survey_question(survey_idx, question_idx, question_content) values (23, 267, '가장 최근에 사용한 스킨케어 제품은 무엇입니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (23, 268, '당신은 어디서 화장품 정보를 얻습니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (23, 269, '제품을 고를때, 어느 요소를 가장 중요하게 생각하십니까?');

------------------ 스킨 설문 보기 시작 ------------------------------------
insert into survey_example(survey_idx, question_idx, example_content) values (23, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '10대');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '20대');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '30대');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '40대');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '50대');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '60대');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 2, '70대 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (23, 267, '바디로션');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 267, '선크림');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 267, '바디 파우더');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 267, '향수');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 267, '땀 억제제');

insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, '친구나 가족');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, '라디오');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, '잡지');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, '인터넷 사이트');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, '판매 직원');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, 'TV');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 268, '제품 패키지');

insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '동물 테스트를 하지 않은 제품');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '브랜드');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '친구 추천');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '상품의 질');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '활용성');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '편리성');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '직원의 추천');
insert into survey_example(survey_idx, question_idx, example_content) values (23, 269, '가격');

------------- 스킨 답변 시작 ---------------------------------------------------
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '20대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '여성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '향수', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '인터넷 사이트', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '활용성', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '30대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '남성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '향수', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '인터넷 사이트', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '활용성', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '20대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '남성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '향수', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '친구나 가족', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '활용성', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (17, '30대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (17, '여성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (17, '바디로션', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (17, '친구나 가족', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (17, '브랜드', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '50대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '여성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '바디오션', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '잡지', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (10, '활용성', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (11, '50대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (11, '남성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (11, '바디로션', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (11, '친구나 가족', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (11, '친구 추천', '23/03/04', 269, 23);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '30대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '남성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '향수', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '판매 직원', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '직원의 추천', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (386, '50대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (386, '여성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (386, '향수', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (386, '잡지', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (386, '브랜드', '23/03/04', 269, 23);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (694, '20대', '23/03/04', 2, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (694, '여성', '23/03/04', 3, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (694, '향수', '23/03/04', 267, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (694, '인터넷 사이트', '23/03/04', 268, 23);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (694, '활용성', '23/03/04', 269, 23);

------------------------------------- 스킨 답변 끝 ------------------------------------------

--------------------------- MZ 세대 질문 시작 ------------------------------------------------

insert into survey_question(survey_idx, question_idx, question_content) values (24, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 2, '당신의 연령대는?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 4, '당신의 직업은?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 270, '내가 속한 조직의 직원들은 변화를 기꺼이 받아들일 준비가 되어있다');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 54, '본인의 회사의 직원들은 필요하다면 새로운 업무에 대해 기꺼이 받아드린다');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 55, '당신이 속한 회사에서 당신이 도움이 필요하면 조직원들이 기꺼이 도와주려고 합니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 56, '직원들은 능동적으로 새로운 도전과 기회를 인지하고 있습니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 57, '당신의 동료직원들은 상황이 어려워도 계속해서 일을 합니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 58, '당신의 조직에서 직원들은 어려운 상황을 빠르게 적응합니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 59, '나의 업무에서 직업 규율을 완전히 숙지하고 있습니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 60, '나는 매일 나의 일에 최선을 다하려고 하십니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 61, '나는 관련된 업무를 할때 시간이 빠르게 지나갑니까?');
insert into survey_question(survey_idx, question_idx, question_content) values (24, 62, '나는 나의 일이 재밌습니까?');

------------------ MZ세대 설문 보기 시작 ------------------------------------
insert into survey_example(survey_idx, question_idx, example_content) values (24, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '10대');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '20대');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '30대');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '40대');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '50대');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '60대');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 2, '70대 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 4, '서비스/영업/판매직');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 4, '사무직');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 4, '전문직');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 4, '공무원');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 4, '농/임/어업');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 4, '자유직/프리랜서');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 270, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 270, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 270, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 270, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 270, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 54, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 54, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 54, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 54, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 54, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 55, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 55, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 55, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 55, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 55, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 56, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 56, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 56, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 56, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 56, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 57, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 57, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 57, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 57, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 57, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 58, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 58, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 58, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 58, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 58, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 59, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 59, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 59, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 59, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 59, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 60, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 60, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 60, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 60, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 60, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 61, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 61, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 61, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 61, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 61, '매우 그렇지 않다');

insert into survey_example(survey_idx, question_idx, example_content) values (24, 62, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 62, '그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 62, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 62, '그렇지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (24, 62, '매우 그렇지 않다');

---------------------------- MZ 세대 답변 시작 ------------------------------------

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '20대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '여성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (2, '매우 그렇다', '23/03/04', 62, 24);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '30대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '남성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '매우 그렇다', '23/03/04', 62, 24);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '30대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '남성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (3, '매우 그렇다', '23/03/04', 62, 24);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '30대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '여성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (13, '매우 그렇다', '23/03/04', 62, 24);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '10대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '여성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (15, '그렇다', '23/03/04', 62, 24);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '20대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '남성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (25, '매우 그렇다', '23/03/04', 62, 24);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '20대', '23/03/04', 2, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '여성', '23/03/04', 3, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '사무직', '23/03/04', 4, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 270, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 54, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 55, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 56, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 57, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 58, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 59, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 60, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 61, 24);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (44, '매우 그렇다', '23/03/04', 62, 24);


-------------------------- 헬스장 질문 시작 -------------------------------------
insert into survey_question(survey_idx, question_idx, question_content) values (34, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 2, '당신의 연령대는?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 118, '일주일에 1회 이상 운동을 하고 있는가?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 119, '어떤 운동을 하고 있는가?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 120, '헬스장에 등록해본 경험이 있는가?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 121, '헬스장 이용권 기간 단위는?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 122, '헬스장 이용권 기간 중 실제 이용한 기간은 얼마나 되나?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 123, '헬스장 이용권 기간 만료 전, 환불을 시도한 적이 있는가?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 124, '헬스장 이용권 환불에 성공하였는가?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 125, '헬스장 이용권 만료 전 헬즈장이 폐업/휴업하여 손해를 본 적이 있는가?');
insert into survey_question(survey_idx, question_idx, question_content) values (34, 126, '''헬스장 이용권 중간 해지 시 3일 내 환불'' 법안이 제대로 지켜질 것 같은가?');

----------------------------헬스장 설문 보기 시작 ----------------------------------------------------

insert into survey_example(survey_idx, question_idx, example_content) values (34, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '10대');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '20대');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '30대');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '40대');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '50대');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '60대');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 2, '70대 이상');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 118, '예');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 118, '아니요');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 119, '각종 댄스');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 119, '각종 무술');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 119, '걷기/조깅');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 119, '스카이프');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 119, '골프');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 119, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 120, '예');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 120, '아니요');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 121, '1개월권');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 121, '3개월권');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 121, '6개월권');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 121, '1년권');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 121, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 122, '10% 정도');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 122, '30%');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 122, '50%');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 122, '70%');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 122, '90%이상');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 123, '환불을 시도한 적이 있었다');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 123, '환불을 시도한 적이 없었다');

insert into survey_example(survey_idx, question_idx, example_content) values (34, 124, '환불에 실패했다(한푼도 돌려받지 못함)');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 124, '환불에 성공했다(남은 기간에 해당하는 일부만 돌려받음)');


insert into survey_example(survey_idx, question_idx, example_content) values (34, 125, '예');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 125, '아니요');


insert into survey_example(survey_idx, question_idx, example_content) values (34, 126, '전혀 그럴거 같지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 126, '별로 그럴거 같지 않다');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 126, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 126, '약간 그럴 것이다');
insert into survey_example(survey_idx, question_idx, example_content) values (34, 126, '매우 그럴 것이다');

---------------------------헬스장 설문 답변 시작

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '20대', '23/03/03', 2, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '기타', '23/03/03', 3, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '예', '23/03/03', 118, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '걷기/조깅', '23/03/03', 119, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '예', '23/03/03', 120, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '3개월권', '23/03/03', 121, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '50%', '23/03/03', 122, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '환불을 시도한 적이 없었다', '23/03/03', 123, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '환불에 성공했다(남은 기간에 해당하는 일부만 돌려받음)', '23/03/03', 124, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '아니요', '23/03/03', 125, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (4, '약간 그럴 것이다', '23/03/03', 126, 34);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '10대', '23/03/04', 2, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '남성', '23/03/04', 3, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '예', '23/03/04', 118, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '골프', '23/03/04', 119, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '아니요', '23/03/04', 120, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '3개월권', '23/03/04', 121, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '70%', '23/03/04', 122, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '환불을 시도한 적이 있었다', '23/03/04', 123, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '환불에 성공했다(남은 기간에 해당하는 일부만 돌려받음)', '23/03/04', 124, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '예', '23/03/04', 125, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (6, '전혀 그럴거 같지 않다', '23/03/04', 126, 34);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '50대', '23/03/04', 2, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '여성', '23/03/04', 3, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '아니요', '23/03/04', 118, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '골프', '23/03/04', 119, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '예', '23/03/04', 120, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '1년권', '23/03/04', 121, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '90%이상', '23/03/04', 122, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '환불을 시도한 적이 있었다', '23/03/04', 123, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '환불에 성공했다(남은 기간에 해당하는 일부만 돌려받음)', '23/03/04', 124, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '예', '23/03/04', 125, 34);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (5, '매우 그럴 것이다', '23/03/04', 126, 34);



-----------------------------청소년 게임중독 설문조사--------------------------
insert into survey_question(survey_idx, question_idx, question_content) values (40, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 212, '나는 현실 생활보다 게임 속에서 더 유능한 사람인 것 같다');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 213, '친구들과 주로 게임 이야기를 많이 한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 214, '요즘 외출을 거의하지 않는다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 215, '해야할 일이 있는데도, 게임을 그만 둘 수가 없다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 216, '게임을 구하거나 설치하느라 보내는 시간이 적지 않다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 217, '다른 사람들과 함께 있을 때에도 게임에 대한 생각을 종종한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 218, '세상의 모든 일이 게임처럼 진행되었으면 좋겠다는 생각이 들 때가 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 219, '게임을 하느라 밤을 새운 적이 많다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 220, '게임 때문에 시험(일)을 망친 적이 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 221, '게임 시간을 줄이려고 노력하는데도 변변히 실패한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 222, '게임에 관한 꿈을 꾼 적이 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 223, '게임을 통해서는 불가능한 일을 할 수 있다고 느낀다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 224, '게임을 안 하는데도 게임을 하는 느낌이 들 때가 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 225, '게임을 하느라고 약속을 취소하거나 시간을 어기는 일이 많다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 226, '게임을 하는 것 때문에 가족을과 다툰 적이 있다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 227, '게임 캐릭터가 다치거나 죽으면 내가 그런거 같은 느낌이 든다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 228, '게임을 하는 도중에 방해를 받으면 과도허게 화를 낸다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 229, '게임을 하는 동안은 모든 근심 걱정을 잊는다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 230, '게임을 하다가 고함을 치느 경우가 많다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 231, '게임을 하느라고 식사를 거른 적이 많다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 232, '게임을 하지 못할 때면 짜증이 나거나 화가 난다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 233, '게임을 거의 매일 한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 234, '게임을 하지 않을 때에도 줄곧 게임에 관한 생각만 한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 235, '게임를 한 번 시작하면 끝을 볼 때까지 한다.');
insert into survey_question(survey_idx, question_idx, question_content) values (40, 236, '게임을 한 이후로 집중력이 떨어졌다.');


-------------------------------청소년 게임중독 설문 보기 시작 ------------------------------------------

insert into survey_example(survey_idx, question_idx, example_content) values (40, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 212, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 212, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 212, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 212, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 212, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 213, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 213, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 213, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 213, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 213, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 214, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 214, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 214, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 214, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 214, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 215, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 215, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 215, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 215, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 215, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 216, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 216, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 216, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 216, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 216, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 217, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 217, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 217, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 217, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 217, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 218, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 218, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 218, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 218, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 218, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 219, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 219, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 219, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 219, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 219, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 220, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 220, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 220, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 220, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 220, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 221, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 221, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 221, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 221, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 221, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 222, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 222, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 222, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 222, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 222, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 223, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 223, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 223, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 223, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 223, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 224, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 224, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 224, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 224, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 224, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 225, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 225, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 225, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 225, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 225, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 226, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 226, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 226, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 226, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 226, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 227, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 227, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 227, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 227, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 227, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 228, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 228, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 228, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 228, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 228, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 229, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 229, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 229, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 229, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 229, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 230, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 230, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 230, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 230, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 230, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 231, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 231, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 231, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 231, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 231, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 232, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 232, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 232, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 232, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 232, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 233, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 233, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 233, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 233, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 233, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 234, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 234, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 234, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 234, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 234, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 235, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 235, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 235, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 235, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 235, '전혀 아니다');

insert into survey_example(survey_idx, question_idx, example_content) values (40, 236, '대체로 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 236, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 236, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 236, '거의 아니다');
insert into survey_example(survey_idx, question_idx, example_content) values (40, 236, '전혀 아니다');

------------------------------ 청소년 게임중독 설문 답변 시작 -------------------------------------------

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '남성', '23/03/01', 3, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 212, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 213, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 214, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 215, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 216, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 217, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 218, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 219, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 220, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 221, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 222, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '보통이다', '23/03/01', 223, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 224, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '보통이다', '23/03/01', 225, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 226, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 227, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 228, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 229, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 230, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 231, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '보통이다', '23/03/01', 232, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 233, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '약간 그렇다', '23/03/01', 234, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '보통이다', '23/03/01', 235, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (29, '대체로 그렇다', '23/03/01', 236, 40);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '여성', '23/02/19', 3, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 212, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '약간 그렇다', '23/02/19', 213, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 214, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 215, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '대체로 그렇다', '23/02/19', 216, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 217, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 218, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '약간 그렇다', '23/02/19', 219, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 220, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 221, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 222, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '보통이다', '23/02/19', 223, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '대체로 그렇다', '23/02/19', 224, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '보통이다', '23/02/19', 225, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 226, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 227, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '약간 그렇다', '23/02/19', 228, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 229, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 230, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전혀 아니다', '23/02/19', 231, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '보통이다', '23/02/19', 232, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '거의 아니다', '23/02/19', 233, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '약간 그렇다', '23/02/19', 234, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '보통이다', '23/02/19', 235, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '거의 아니다', '23/02/19', 236, 40);



insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '여성', '23/02/28', 3, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 212, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '거의 아니다', '23/02/28', 213, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 214, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 215, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 216, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '거의 아니다', '23/02/28', 217, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 218, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 219, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 220, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '거의 아니다', '23/02/28', 221, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 222, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 223, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '거의 아니다', '23/02/28', 224, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 225, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 226, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 227, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 228, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 229, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 230, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '전혀 아니다', '23/02/28', 231, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 232, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 233, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '거의 아니다', '23/02/28', 234, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '보통이다', '23/02/28', 235, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (22, '거의 아니다', '23/02/28', 236, 40);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '남성', '23/03/04', 3, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 212, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 213, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 214, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 215, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '보통이다', '23/03/04', 216, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 217, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 218, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 219, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 220, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 221, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 222, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 223, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 224, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 225, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 226, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 227, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 228, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 229, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 230, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 231, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 232, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 233, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 234, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 235, 40);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (98, '대체로 그렇다', '23/03/04', 236, 40);


---------------------------- 포털사이트 설문 시작 ----------------------------------------------------
insert into survey_question(survey_idx, question_idx, question_content) values (38, 3, '당신의 성별은?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 4, '당신의 직업은?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 180, '전체적으로 이미지가 좋은 포털사이트는?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 181, '메인 디자인이 마음에드는 포털사이트는?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 182, '사용하기 편리한 포털사이트는?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 183, '고객서비스가 우수한 포털사이트는?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 184, '언론규제에 취약한 포털사이트는?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 185, '포털사이트의 실시간 검색어를 확인하는 편인가?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 186, '포털사이트의 실시간 검색어는 믿을만한가?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 187, '스마트 폰을 통해 이용하는 포털사이트는?');
insert into survey_question(survey_idx, question_idx, question_content) values (38, 188, '카카오톡 내 다음 모바일이 제공된다면 이용할것인가?');

---------------------------- 포털사이트 설문 보기 시작 ----------------------------------------------------

insert into survey_example(survey_idx, question_idx, example_content) values (38, 3, '남성');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 3, '여성');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 3, '기타');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '전문직');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '경영직');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '사무직');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '서비스/영업/판매직');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '교사/학원강사');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '전업주부');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '자영업');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 4, '무직');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 179, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 179, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 179, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 179, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 179, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 180, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 180, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 180, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 180, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 180, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 181, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 181, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 181, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 181, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 181, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 182, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 182, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 182, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 182, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 182, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 183, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 183, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 183, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 183, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 183, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 184, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 184, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 184, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 184, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 184, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 185, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 185, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 185, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 185, '별로 그렇지않다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 185, '전혀 그렇지않다');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 186, '매우 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 186, '약간 그렇다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 186, '보통이다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 186, '별로 그렇지않다');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 186, '전혀 그렇지않다');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 187, '네이버');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 187, '다음');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 187, '구글');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 187, '네이트');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 187, '줌');

insert into survey_example(survey_idx, question_idx, example_content) values (38, 188, '예');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 188, '아니요');
insert into survey_example(survey_idx, question_idx, example_content) values (38, 188, '잘모르겠다');

---------------------------포털사이트 설문 답변 시작 -------------------------------

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '남성', '23/03/05', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '전문직', '23/03/05', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '네이버', '23/03/05', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '다음', '23/03/05', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '네이버', '23/03/05', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '줌', '23/03/05', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '네이트', '23/03/05', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '네이버', '23/03/05', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '매우 그렇다', '23/03/05', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '매우 그렇다', '23/03/05', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '네이버', '23/03/05', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (43, '잘모르겠다', '23/03/05', 188, 38);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '여성', '23/03/04', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '경영직', '23/03/04', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '다음', '23/03/04', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '다음', '23/03/04', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '네이트', '23/03/04', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '다음', '23/03/04', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '네이버', '23/03/04', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '네이버', '23/03/04', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '보통이다', '23/03/04', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '보통이다', '23/03/04', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '네이트', '23/03/04', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (26, '아니요', '23/03/04', 188, 38);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '기타', '23/03/03', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '교사/학원강사', '23/03/03', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '다음', '23/03/03', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '네이트', '23/03/03', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '줌', '23/03/03', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '네이버', '23/03/03', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '다음', '23/03/03', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '다음', '23/03/03', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '별로 그렇지않다', '23/03/03', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '매우 그렇다', '23/03/03', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '다음', '23/03/03', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (79, '예', '23/03/03', 188, 38);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '남성', '23/03/02', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '교사/학원강사', '23/03/02', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '네이버', '23/03/02', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '다음', '23/03/02', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '줌', '23/03/02', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '줌', '23/03/02', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '네이버', '23/03/02', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '네이버', '23/03/02', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '별로 그렇지않다', '23/03/02', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '전혀 그렇지않다', '23/03/02', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '다음', '23/03/02', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '예', '23/03/02', 188, 38);


insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '남성', '23/03/05', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '전문직', '23/03/05', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '네이버', '23/03/05', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '다음', '23/03/05', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '네이버', '23/03/05', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '줌', '23/03/05', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '네이트', '23/03/05', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '네이버', '23/03/05', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '매우 그렇다', '23/03/05', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '매우 그렇다', '23/03/05', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '네이버', '23/03/05', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (77, '잘모르겠다', '23/03/05', 188, 38);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '여성', '23/03/04', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '경영직', '23/03/04', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '다음', '23/03/04', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '다음', '23/03/04', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '네이트', '23/03/04', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '다음', '23/03/04', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '네이버', '23/03/04', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '네이버', '23/03/04', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '보통이다', '23/03/04', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '보통이다', '23/03/04', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '네이트', '23/03/04', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (34, '아니요', '23/03/04', 188, 38);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '기타', '23/03/03', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '교사/학원강사', '23/03/03', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '다음', '23/03/03', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '네이트', '23/03/03', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '줌', '23/03/03', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '네이버', '23/03/03', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '다음', '23/03/03', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '다음', '23/03/03', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '별로 그렇지않다', '23/03/03', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '매우 그렇다', '23/03/03', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '다음', '23/03/03', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (54, '예', '23/03/03', 188, 38);

insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '남성', '23/03/02', 3, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '교사/학원강사', '23/03/02', 4, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '네이버', '23/03/02', 179, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '다음', '23/03/02', 180, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '줌', '23/03/02', 181, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '줌', '23/03/02', 182, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '네이버', '23/03/02', 183, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '네이버', '23/03/02', 184, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '별로 그렇지않다', '23/03/02', 185, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '전혀 그렇지않다', '23/03/02', 186, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '다음', '23/03/02', 187, 38);
insert into answer (user_idx, answer_content, answer_date, question_idx, survey_idx) values (88, '예', '23/03/02', 188, 38);




commit;






select * from member order by user_idx;
select * from survey;
select * from question order by question_idx;
select * from survey_question where survey_idx = 24;
desc survey_question;
select * from survey_example where survey_idx = 24;
select * from answer where survey_idx = 39;
desc answer;


-------------------- 기부 더미 시작 ----------------------


insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (4, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (4, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (4, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (4, 5000, '23/02/01');

insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (5, 5000, '23/02/01');

insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (3, 5000, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (2, 5000, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (6, 5000, '23/02/01');


insert into user_donate (user_idx, total_donate, donate_date) values (11, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (13, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (12, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (12, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (11, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (13, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (13, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (13, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (22, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (22, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (31, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (43, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (73, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (84, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (42, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (15, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (34, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (28, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (33, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (32, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (45, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (44, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (17, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (38, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (25, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (22, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (11, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (35, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (36, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (49, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (48, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (14, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (35, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (236, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (22, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (12, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (35, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (46, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (297, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (25, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (19, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (63, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (53, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (141, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (411, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (111, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (113, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (112, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (112, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (661, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (883, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (993, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (414, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (554, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (51, 500, '22/07/01');;
insert into user_donate (user_idx, total_donate, donate_date) values (991, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (783, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (943, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (164, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (254, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (138, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (963, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (482, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (752, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (851, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (753, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (823, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (964, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (54, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (121, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (13, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (42, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (562, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (811, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (663, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (683, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (984, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (164, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (551, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (523, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (532, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (152, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (891, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (843, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (83, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (94, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (34, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (81, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (43, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (251, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (252, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (561, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (953, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (843, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (84, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (14, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (231, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (513, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (612, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (842, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (851, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (833, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (913, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (614, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (684, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (571, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (413, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (223, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (229, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (139, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (338, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (339, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (415, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (484, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (305, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (360, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (844, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (405, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (105, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (303, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (200, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (200, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (100, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (300, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (603, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (40, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (804, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (561, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (503, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (602, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (520, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (822, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (303, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (503, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (844, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (884, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (991, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (663, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (502, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (612, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (951, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (843, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (363, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (304, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (554, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (501, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (693, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (582, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (302, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (501, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (503, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (603, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (74, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (490, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (801, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (308, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (203, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (222, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (130, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (302, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (321, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (445, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (489, 500, '23/02/01');
insert into user_donate (user_idx, total_donate, donate_date) values (169, 500, '22/07/01');
insert into user_donate (user_idx, total_donate, donate_date) values (353, 500, '22/08/01');
insert into user_donate (user_idx, total_donate, donate_date) values (225, 500, '22/09/01');
insert into user_donate (user_idx, total_donate, donate_date) values (284, 500, '22/10/01');
insert into user_donate (user_idx, total_donate, donate_date) values (189, 500, '22/11/01');
insert into user_donate (user_idx, total_donate, donate_date) values (334, 500, '22/12/01');
insert into user_donate (user_idx, total_donate, donate_date) values (361, 500, '23/01/01');
insert into user_donate (user_idx, total_donate, donate_date) values (415, 500, '23/03/01');
insert into user_donate (user_idx, total_donate, donate_date) values (564, 500, '23/02/01');

insert into user_donate (user_idx, total_donate, donate_date) select user_idx, total_donate, donate_date from user_donate;
insert into user_donate (user_idx, total_donate, donate_date) select user_idx, total_donate, donate_date from user_donate;

select * from user_donate order by total_idx desc;

-----------------------------------------------------------------------------------------
commit;

select * from notice;
select * from answer where survey_idx = 40;

commit;