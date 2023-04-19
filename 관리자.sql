/*
1일차 수업

1. 소프트웨어 다운로드(11g)
https://www.oracle.com/database/technologies/xe-prior-release-downloads.html

2. Oracle 설치(SYS, SYSTEM 계정에 대한 암호 설정 : 1004)

3. sqlplus 프로그램 제공(CMD) : 단점 >> GUI 환경을 제공하지 않음

4. 별도의 프로그램(접속 Tool) 설치
4.1 SqlDeveloper >> 무료버전, dbeaver >> 무료버전
4.2 토드, 오렌지, SqlGate >> 회사가면 볼 수 있을듯..?

5. SqlDeveloper 실행 >> Oracle 서버 접속 >> GUI
5.1 HR(Human Resource) 계정 사용(unlock)
-- USER SQL
ALTER USER "HR" IDENTIFIED BY "1004" 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;
-- QUOTAS
ALTER USER "HR" QUOTA UNLIMITED ON "USERS";
-- ROLES
ALTER USER "HR" DEFAULT ROLE "CONNECT","RESOURCE";
-- SYSTEM PRIVILEGES

5.2 KOSA 계정 생성
-- USER SQL
CREATE USER "KOSA" IDENTIFIED BY "1004"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- QUOTAS
-- ROLES
GRANT "CONNECT" TO "KOSA" WITH ADMIN OPTION;
GRANT "RESOURCE" TO "KOSA" WITH ADMIN OPTION;
ALTER USER "KOSA" DEFAULT ROLE "CONNECT","RESOURCE";
-- SYSTEM PRIVILEGES

실습코드

CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;

CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

DB 분야
개발자(CRUD)(insert, select, update, delete) >> DML(조작어) + DDL(정의어)(create, alter, drop)

관리자(DBA) >> 데이터를 백업, 복원, 네트워크 관리, 자원 관리, 하드웨어 관리

튜너 : SQL 튜너(문장 튜너) >> 속도 >> index >> 자료구조
      하드웨어(네트워크) 튜너

모델러 : 설계(PM) - ERD - 요구사항 분석 ERD
 */
 
show user;
select * from emp;
select * from dept;
select * from salgrade;
------------------------------------------------------------
-- 1. 사원 테이블에서 모든 데이터를 출력하세요
select * from emp;
SELECT * FROM EMP;
SELECT * FROM emp;

-- 2. 특정 컬럼 데이터 출력하기
select empno, ename, sal from emp;

-- 3. 가명칭 사용하기(별칭: alias)
select empno "사 번", ename "이름" from emp;
-- 권장 문법(ANSI) >> 표준 문법 >> Oracle, Ms-sql, Mysql에서 모두 동작
select empno as "사 번", ename as "이름" from emp;

-- Oracle에서는 문자열 데이터의 대소문자를 엄격하게 구별한다
/*
JAVA : 문자 >> 'A', 문자열 >> "AAAA"
ORACLE : 문자열 >> 'AAA'
ORACLE : 데이터 'a'와 'A'는 다른 문자열
 */
select * from emp where ename = 'KING'; --대소문자를 엄격하게 구분하기 때문에 king이라고 하면 안나옴

/*
select 절 >> 3
from 절   >> 1
where 절  >> 2
 */

-- Oracle Query(질의어) : 언어
/*
연산자
JAVA : + 숫자(산술연산), + 문자열(결합연산)
---------------------------------------
ORACLE :
결합 연산자 ||
산술 연산자 + (산술연산)

MS-SQL : + (산술, 결합)
 */

select '사원의 이름은 ' || ename || '입니다' as 사원정보
from emp;

-- 테이블의 기본 정보(컬럼, 타입)
desc emp;

/*
JAVA : class Emp{private int empno, private String ename}
ORACLE : create Table Emp(empno number, ename varchar2(20)); >> 2byte에 한글 1글자, 1byte에 영,숫자 1글자
 */

-- 중복 행 제거 키워드 : distinct
select distinct job from emp;

-- distinct
-- 재미로 >> grouping
select distinct job, deptno
from emp
order by job;

-- Oracle SQL 언어
-- JAVA   : (+,-,*,/) 나머지 %
-- ORACLE : (+,-,*,/) 나머지 %는 다른 곳에 사용 .. 함수 mod()
-- 문자열 패턴 검색 : ename like '%신%'

-- 사원테이블에서 사원의 급여를 100달라 인상한 결과를 출력하세요
select empno, ename, sal, sal + 100 as "인상급여" from emp;

-- dual 임시 테이블
select 100 + 100 from dual;
select 100 || 100 from dual; -- 100100
select '100' + 100 from dual; -- 200 -- '100' 숫자형 문자 ex) '123456'
select 'A100' + 100 from dual; -- Error

--비교연산자
-- < > <=
-- 주의
-- JAVA : 같다(==) 할당(=), JavaScript : (==, ===)
-- ORACLE : 같다 =, 같지않다 !=

-- 논리연산자 (AND, OR, NOT)

select empno, ename, sal
from emp
where sal>= 2000;

-- 사번이 7788번인 사원의 사번, 이름, 직종, 입사일을 출력하세요
select empno, ename, job, hiredate 
from emp 
where empno = 7788;

-- 사원의 이름이 KING 사원의 사번, 이름, 급여 정보를 출력하세요
select empno, ename, sal from emp where ename = 'KING';

/*
      AND , OR
 0 0   0     0
 1 0   0     1
 0 1   0     1
 1 1   1     1
 */

-- 급여가 2000달러 이상이면서 직종이 MANAGER인 사원의 모든 정보를 출력하세요
select * from emp where job = 'MANAGER' and sal >= 2000;

-- 급여가 2000달러 초과이면서 직종이 manager인 사원의 모든 정보를 출력하세요
select * from emp where job = 'MANAGER' and sal > 2000;

-- 오라클 날짜(DB 서버의 날짜)
-- sysdate
select sysdate from dual; --23/04/17

select * from nls_session_parameters;
/*
NLS_LANGUAGE        KOREAN
NLS_DATE_FORMAT     RR/MM/DD
NLS_DATE_LANGUAGE   KOREAN
NLS_TIME_FORMAT     HH24:MI:SSXFF
 */
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS'; -- 현재 접속한 사용자가 시간을 요 형식으로 볼 수 있게 한다
-- 도구 >> 환경설정 >> 데이터베이스 >> NLS 로 이동하면 시간 설정을 바꿀 수 있다
select sysdate from dual;

select * from emp;
-- 날짜 데이터 검색 >> 문자열 검색처럼 >> '날짜'
-- 포멧에 맞기만 하면 유도리 있기 모두 출력이 가능하다
select * from emp where hiredate = '1980-12-17';
select * from emp where hiredate = '1980/12/17';
select * from emp where hiredate = '1980.12.17';

-- 사원의 급여가 2000 이상이고 4000 이하인 모든 사원의 정보를 출력하세요
select * from emp where sal >= 2000 and sal <= 4000;

-- between A and B 연산자 >> 이상, 이하만 적용 가능,, 초과 미만은 안된다
select * from emp where sal between 2000 and 4000;

-- 부서번호가 10번 또는 20번 또는 30번인 사원의 사번, 이름, 급여, 부서번호를 출력하세요
select empno, ename, deptno from emp where deptno in (10, 20, 30);

-- 부서번호가 10번 또는 20번이 아닌 사원의 사번, 이름, 급여, 부서번호를 출력하세요
select * from emp where deptno not in (10, 20);


-- Today Point
-- null에 대한 이야기
-- 값이 없다
create table member(
    userid varchar2(20) not null, -- null을 허용하지 않겠다(필수입력)
    name varchar2(20) not null, -- 필수입력
    hobby varchar2(50) -- default null 허용, 선택입력
);

desc member;
insert into member(userid, hobby) values('kim','농구');
-- name에 not null을 선언해놓고 name에 값을 안넣었기 때문에 에러 발생
-- ORA-01400: cannot insert NULL into ("KOSA"."MEMBER"."NAME")
insert into member(userid, name) values('hong','홍길동');
commit;
select * from member;

------------------------------------------------------------------
/*
DB마다 설정
Oracle
insert, update, delete 명령
기본적으로 쿼리문 실행시 begin tran 구문이 자동으로 따라붙는다 >> 개발자는 반드시 end(완료, 취소)를 알려줘야 한다
오라클은 대기 상태 ... 마지막 명령에 대해(commit : 실제반영, rollback : 취소) 작업을 완료해야 한다

Ms-sql
자동 auto-commit
delete from emp; 자동 commit;

begin tran
    delete from emp;
    
    commit or rollback 하지 않으면 데이터 처리 안됨

DB Transaction : 논리적인 작업 단위
OLTP(실시간 데이터 처리 시스템) : 웹 환경

OLAP(데이터 분석) : 일정기간 데이터를 모아서 분석

****오라클에서 insert, update, delete 하면 반드시!!
****commit, rollback 처리 여부를 결정해야 한다
 */
------------------------------------------------------------------
-- 수당(comm)을 받지 않는 모든 사원의 정보를 출력하세요
select * from emp;
select * from emp where comm is null;

-- comm을 받는 사원들(comm 컬럼의 데이터가 null이 아닌 사원들)
select * from emp where comm is not null;

-- 사원 테이블에서 사번, 이름, 급여, 수당, 총급여(급여+수당)을 출력하세요
select empno 사번, ename 이름, sal 급여, comm 수당, sal+comm 총급여 
from emp;
/*
null 이란 녀석
1. null과의 모든 연산 결과는 null >> ex) null+100 = null
2. null을 해결하기 위한 함수 >> nvl(), nvl2() 암기

Tip)
MySQL >> null > IFNULL() > select ifnull(null,'')
Ms-SQL >> null > Convert()
 */
select empno, ename, sal, comm, sal+nvl(comm,0) as 총급여 --nvl(comm,0) >> comm에서 null을 만나면 0으로 바꿔라
from emp;

select 1000 + null from dual;
select 1000 + nvl(null, 0) from dual;
select comm, nvl(comm,111111) from emp;
select nvl(null,'hello world') from dual;

-- 사원의 급여가 1000 이상이고 수당을 받지 않는 사원의 사번, 이름, 직종, 급여, 수당을 출력하세요
select empno, ename, job, sal, comm from emp where sal >=1000 and comm is null;

-- 문자열 검색
-- 주소검색 >> 역삼 >> 역삼 단어가 있는 모든 주소가 나오는 것
-- Like 문자열 패턴 검색
-- 와일드카드(%(모든것), _(한문자))
select * from emp where ename like 'A%'; -- A로 시작하는 모든 이름을 찾으세요
select * from emp where ename like '%LL%'; -- ALLEN, MILLER
select * from emp where ename like '%A%A%'; -- A가 두개 ADAMS
select * from emp where ename like '_A%'; -- 두번째 글자는 A, WARD, MARTIN, JAMES

-- 정규표현식 regexp_like()
select * from emp where regexp_like (ename, '[A-C]');
-- 과제(정규표현식 5개 만들기) 추후 카페에 올라가면 하세요

-- 데이터 정렬하기
-- order by 컬렴명 : 문자, 숫자, 날짜 정렬 가능
-- 오름차순 : asc(default) >> 낮은 순
-- 내림차순 : desc         >> 높은 순
-- 정렬(알고리즘) >> 비용이 많이 드는 작업(cost)

select * from emp order by sal; -- default : order by sal asc;
select * from emp order by sal desc;

-- 입사일이 가장 늦은 순으로 정렬해서 사번, 이름, 급여, 입사일을 출력하세요
select empno, ename, sal, hiredate from emp order by hiredate desc;

/*
select 절   >> 3
from 절     >> 1
where 절    >> 2
order by 절 >> 4 (select 결과를 정렬)
 */

select empno, ename, sal, job, hiredate from emp where job='MANAGER' order by  hiredate desc;
-- emp 테이블에서 직종이 MANAGER인 사람의 사번, 이름, 급여, 직종, 입사일을 입사일 기준 내림차순으로 출력하세요

select job, deptno from emp order by job asc, deptno desc;
-- order by 컬럼명 asc, 컬럼명 asc, ...;

-- 연산자
-- 합집합(union)     : 테이블과 테이블의 데이터를 합치는 것(중복값 배제)
-- 합집합(union all) : 테이블과 테이블의 데이터를 합치는 것(중복값 허용)
create table uta(name varchar2(20));
insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;

create table ut(name varchar2(20));
insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;

select * from uta;
select * from ut;

select * from ut union select * from uta; -- ut의 집에 uta 식구들이 놀러가는 것(중복제거)
select * from ut union all select * from uta; -- ut의 집에 uta 식구들이 놀러가는 것(중복허용)

-- union
-- 1. [대응]되는 [컬럼]의 [타입]이 동일

select empno, ename from emp     -- 숫자, 문자열
union 
select dname, deptno from dept;  -- 문자열, 숫자

select empno, ename from emp
union
select deptno, dname from dept;

-- 2. [대응]되는 [컬럼]의 개수가 [동일]
-- 필요약 (null) >> 컬럼을 대체한다
select empno, ename, job, sal from emp
union
select deptno, dname, loc, null from dept; -- null을 이용해 컬럼의 개수를 맞춰준다

------------------------------------------------------------------------------
-- 초급 개발자가 의무적으로 해야하는 단일 테이블 select..
-- 오라클.pdf (~47page)
------------------------------------------------------------------------------

show user;
select sysdate from dual;

/*
단일 행 함수의 종류
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다.
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다.
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를
제외하고 모두 날짜 데이터형의 값을 RETURN 한다.
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다.
5) 일반적인 함수 : NVL, DECODE
 */
-- 문자열 함수
select initcap('the super man') from dual; -- 단어의 첫 글자를 대문자로 변환
select lower('AAA'), upper('aaa') from dual;
select ename, lower(ename) as "ename" from emp;
select * from emp where lower(ename) = 'king';
select length('abcd') from dual; -- 글자수 출력하기
select length('홍길동') from dual; -- 3, byte를 계산하는것이 아닌 개수를 출력
select length('   홍 길 동a') from dual; -- 9, 공백도 문자열로 센다
select concat('a','b') from dual; -- ab
-- select concat('a','b','c') from dual; -- overloading을 해놓지 않아서.. 오류난다
select 'a' || 'b' || 'c' from dual; -- abc, || 연결연산자가 좀 더 유연하다
select concat(ename, job) from emp;
select ename || ' ' || job from emp; -- || 연결연산자가 띄어쓰기에도 유리하다

-- JAVA : substring
-- ORACLE : substr

select substr('ABCDE',2,3) from dual; -- BCD, 2번째부터 3개 출력
select substr('ABCDE',1,1) from dual; -- A, 1번째부터 1개 출력
select substr('ABCDE',3,1) from dual; -- C, 3번째부터 1개 출력
select substr('asdfwekfasv',3) from dual; -- 3번째부터 모두 출력

/*
사원테이블에서 ename 컬럼의 데이터에 대해서 첫글자는 소문자로 나머지 글자는 대문자로
출력하되 하나의 컬럼으로 만들어서 출력하시고 컬럼의 별칭은 fullname이라고 하고 첫글자와
나머지 문자 사이에는 공백 하나를 넣으세요
 */
select substr(lower(ename),1,1) || ' ' || substr(upper(ename),2) as fullname from emp;

select lpad('ABC',10,'*') from dual; -- 10글자를 만들건데 왼쪽을 *로 다 채워넣어라!
select rpad('ABC',10,'*') from dual; -- 오른쪽을 *로 채워넣어라!
-- 사용자 비번 : hong1004 or k1234
-- 화면에 출력할 때 앞 2글자만 보여주고 나머지는 특수문자로 처리
select rpad(substr('hong1004',1,2), length('hong1004'), '*') from dual;
select rpad(substr('k1234',1,2), length('k1234'), '*') from dual;

-- 사원 테이블에서 ename 컬럼의 데이터를 출력하되 첫 글자만 출력하고 나머지는 *로 출력하세요
select rpad(substr(ename, 1, 1), length(ename), '*') as ename from emp;

create table member2(
    id number,
    jumin varchar2(14)
);
insert into member2(id, jumin) values(100, '123456-1234567');
insert into member2(id, jumin) values(200, '234567-1234567');
commit;

select * from member2;
-- 출력 결과
-- 100 : 123456-*******
-- 200 : 234567-*******
select id || ' : ' || rpad(substr(jumin, 1,7),length(jumin),'*') as 출력결과 from member2;

-- rtrim 함수
-- 오른쪽 문자를 지워라
select rtrim('MILLER','ER') from dual; -- MILL

-- ltrim 함수
-- 왼쪽 문자를 지워라
select ltrim('MILLLLLLLLLLER','MIL') from dual; -- ER

-- trim의 목적은 공백제거
select '>' || rtrim('MILLER       ', ' ') || '<' from dual;

-- 치환함수
select ename, replace(ename, 'A', '와우') from emp;
-----------------------------------------------------------------
-- 숫자함수
-- round(반올림함수)
-- trunc(절삭함수)
-- mod()(나머지 구하는 함수)

-- -3 -2 -1 0(정수) 1 2 3
select round(12.345, 0) as r from dual; -- 12, 정수부만 남겨라(반올림)
select round(12.567, 0) as r from dual; -- 13
select round(12.345, 1) as r from dual; -- 12.3
select round(12.567, 1) as r from dual; -- 12.6
select round(12.345, -1) as r from dual; -- 10
select round(15.345, -1) as r from dual; -- 20
select round(15.345, -2) as r from dual; -- 0

select trunc(12.345, 0) as t from dual; -- 12, 정수부만 남겨라(절삭)
select trunc(12.567, 0) as t from dual; -- 12
select trunc(12.345, 1) as t from dual; -- 12.3
select trunc(12.567, 1) as t from dual; -- 12.5
select trunc(12.345, -1) as t from dual; -- 10
select trunc(15.345, -1) as t from dual; -- 10
select trunc(15.345, -2) as t from dual; -- 0

-- 나머지
select 12/10 from dual; -- 1.2
select mod(12, 10) from dual; -- 2(나머지)
select mod(0, 0) from dual; -- 0으로 나누어도 나누어진다..
------------------------------------------------------------------
-- 날짜 함수(연산)
select sysdate from dual;
-- Point
-- 1. Date + Number >> Date
-- 2. Date - Number >> Date
-- 3. Date - Date >> Number(일수가 나옴)***

select sysdate + 100 from dual;
select sysdate + 1000 from dual;
select sysdate - 1000 from dual;

select hiredate from emp;
select trunc(months_between('2022-09-27', '2020-09-27'), 0) from dual; -- 24, 두 날짜간의 개월차
select trunc(months_between(sysdate, '2020-01-01'), 0) from dual; -- 39개월

-- 주의사항!!!!!!!!!!!!!!!!!!
select '2023-01-01' + 100 from dual; -- ******함수 안에 있으면 날짜로 보는데 단독으로 있으면 문자열로 본다
-- 해결 함수 : 문자를 날짜로 바꾸는 함수 to_date(날짜형식)

select to_date('2023-01-01') + 100 from dual;

select * from emp;
-- 사원테이블에서 사원들의 입사일에서 현재날짜까지의 근속월수를 구하세요
-- 사원 이름, 입사일, 근속월수 출력
-- 단, 근속월수는 정수부만 출력
select ename as 사원명, hiredate as 입사일, trunc(months_between(sysdate, hiredate), 0) as 근속월수
from emp;
-- 한달이 31일 이라고 가정하고 .. 근속월수를 구하세요 >> 단 함수는 사용 금지, 반올림 금지
select ename as 사원명, hiredate as 입사일, trunc((sysdate-hiredate)/31,0) as 근속월수 
from emp;
-------------------------------------------------------------------------------------------------
-- 문자함수, 숫자함수, 날짜함수 END --

-- 변환함수 Today Point
-- 오라클 데이터 유형 : 문자열 , 숫자, 날짜

-- to_char() : 숫자 -> 형식문자(100000 -> $100,000) >> format 출력형식 정의
-- to_char() : 날짜 -> 형식문자('2023-01-01' -> 2023년01월01일) >> format 출력형식 정의

-- to_date() : 문자(날짜형식) -> 날짜
-- select to_date('2023-01-01') + 100 from dual;

-- to_number() : 문장 -> 숫자(자동 형변환이 있어서 거의 사용하지 않음)
select '100' + 100 from dual;
select to_number('100') + 100 from dual;

-- 변환시 표참조(page 69~71 참조)
-- 형식 format
select sysdate, to_char(sysdate, 'YYYY') || '년' as yyyy,
to_char(sysdate, 'YEAR') as YEAR,
to_char(sysdate, 'MM') as MM,
to_char(sysdate, 'DD') as DD,
to_char(sysdate, 'DAY') as DAY
from dual;

-- 입사일이 12월인 사원의 사번, 이름, 입사일, 입사년도, 입사월을 출력하세요
select 
    empno 사번, 
    ename 이름, 
    hiredate 입사일, 
    to_char(hiredate, 'YYYY') 입사년도, 
    to_char(hiredate, 'MM') 입사월
from emp 
where to_char(hiredate, 'MM') = 12; 

select '>' || to_char(12345, '999999999999999') || '<' from dual;
select '>' || ltrim(to_char(12345, '999999999999999')) || '<' from dual;
select '>' || to_char(12345, '$999,999,999,999,999') || '<' from dual;
select sal, to_char(sal, '$999,999') as 급여 from emp;

-- HR 계정 이동
show user; -- USER이(가) "HR"입니다.
select * from employees;
/*
사원테이블에서 사원의 이름은 last_name, first_name 합쳐서 fullname 별칭 부여하여 출력
입사일은 YYYY-MM-DD 형식으로 출력, 연봉(급여*12)을 구하고 연봉의 10%(연봉 * 1.1) 인상한 값을 출력 결과는 1000단위 콤마처리 출력
단 2005년 이후 입사자들만 출력, 연봉이 높은순으로 출력
 */
select 
    first_name || last_name as fullname, 
    to_char(hire_date, 'YYYY-MM-DD') as 입사일, 
    salary * 12 as 연봉,
    to_char((salary * 12)*1.1, '$999,999') as 인상연봉
from employees
where to_char(hire_date, 'YYYY') >= 2005
-- order by salary*12 desc;
order by 연봉 desc; -- select한 결과를 정렬하기 때문에 컬럼명을 사용해도 된다

-- 다시 KOSA USER로
show user;
-- Tip
select 'A' as a, 10 as b, null as c, empno from emp;
--------------------------------------------------------------------
-- 문자, 숫자, 날짜, 변환함수(to_...)
--------------------------------------------------------------------
-- 일반함수(프로그래밍 성격이 강하다)
-- SQL(변수, 제어문 개념이 없다)
-- PL-SQL(변수, 제어문, ...) 고급기능(트리거, 커서, 프로시져)

-- nvl() : null을 처리하는 함수
-- decode() >> java의 if문     >> 통계 데이터(분석) >> pivot, cube, rollup
-- case()   >> java의 switch문

select comm, nvl(comm, 0) from emp;

create table t_emp(
    id number(6), -- 정수 6자리
    job nvarchar2(20) -- n : unicode의 약자, unicode 체제에서는 한글이나 영문자나 2byte 취급.. 20자 >> 40byte
);

desc t_emp;
insert into t_emp(id, job) values(100, 'IT');
insert into t_emp(id, job) values(200, 'SALES');
insert into t_emp(id, job) values(300, 'MANAGER');
insert into t_emp(id, job) values(400);
insert into t_emp(id, job) values(500, 'MANAGER');
commit;

select * from t_emp;

select id, decode(id, 100, '아이티',
                      200, '영업팀',
                      300, '관리팀',
                           '기타부서') as 부서이름
from t_emp;

select empno, ename, deptno, decode(deptno, 10, '인사부',
                                            20, '관리부',
                                            30, '회계부',
                                            40, '일반부서',
                                                'ETC') as 부서이름
from emp;

create table t_emp2(
    id number(2),
    jumin char(7) -- 고정길이 문자열
);

desc t_emp2;
insert into t_emp2(id, jumin) values(1, '1234567');
insert into t_emp2(id, jumin) values(2, '2234567');
insert into t_emp2(id, jumin) values(3, '3234567');
insert into t_emp2(id, jumin) values(4, '4234567');
insert into t_emp2(id, jumin) values(5, '5234567');
commit;

select * from t_emp2;
/*
t_emp2 테이블에서 id, jumin 데이터를 출력하되 jumin 컬럼의 앞자리가
1이면 남성, 2이면 여성, 3이면 중성 그외에는 기타라고 출력하고 컬럼명은 성별로 하세요
 */
select id, jumin, decode(substr(jumin,1,1), 1, '남성',
                                            2, '여성',
                                            3, '중성',
                                               '기타') as 성별
from t_emp2;

-- if 안에 if가 올 수 있듯이
-- decode 안에 decode가 올 수 있다(decode(decode())
/*
응용문제 : hint) if문 안에 if문
부서번호가 20번인 사원중에서 SMITH라는 이름을 가진 사원이라면 HELLO 문자 출력
부서번호가 20번인 사원중에서 SMITH라는 이름을 가진 사원이 아니라면 WORLD 문자 출력
부서번호가 20번인 사원이 아니라면 ETC라는 문자를 출력하세요 >> EMP 테이블에서..
 */
select decode(deptno, 20, decode(ename, 'SMITH', 'HELLO', 
                                                 'WORLD'),
                          'ETC') as 사원명
from emp;

-- CASE 문
/*
CASE 조건식 WHEN 결과1 THEN 출력1
           WHEN 결과2 THEN 출력2
           WHEN 결과3 THEN 출력3
           WHEN 결과4 THEN 출력4
           ELSE 출력5
END "컬럼명"
 */
 
create table t_zip(
    zipcode number(10)
);

desc t_zip;
insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(41);
commit;

select * from t_zip;

select 
    '0' || to_char(zipcode),
    case zipcode when 2 then '서울'
                 when 31 then '경기'
                 when 41 then '제주'
                 else '기타'
    end 지역이름
from t_zip;

/*
사원테이블에서 사원급여가 1000달러 이하면 4급
1001달러 2000달라 이하면 3급
2001달러 3000달라 이하면 2급
3001달러 4000달라 이하면 1급
4001달러 이상이면 '특급' 출력하세요

1. case 컬럼명 when 결과1 then 출력1
2. 조건식이 필요할 때
case when 조건 비교식 then 출력
     when 조건 비교식 then 출력
     else 출력
end 컬럼명
 */
select * from emp;
select
    ename,
    empno,
    sal,
    case
        when sal <=1000 then '4급'
        when sal between 1001 and 2000 then '3급'
        when sal between 2001 and 3000 then '2급'
        when sal between 3001 and 4000 then '1급'
        else '특급'
    end 급수
from emp;
---------------------------------------------------------------------------
-- 문자함수, 숫자함수, 날짜함수, 변환함수(to_), 일반함수(nvl, decode, case) END
---------------------------------------------------------------------------

-- 집계함수(그룹)
-- 75page
/*
1. count(*) >> row수, count(컬럼명) >> 데이터 건수
2. sum()
3. avg()
4. max()
5. min()
기타

1. 집계함수는 group by 절과 같이 사용
2. 모든 집계함수는 null 값을 무시한다
3. select 절에 집계함수 이외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시되어야 한다
 */
select count(*) from emp; -- 14, 14개의 row가 있다
select count(empno) from emp; -- 14건
select count(comm) from emp; -- 6, 집계함수는 null 값을 인지하지 못한다, null이 아닌 데이터만 카운팅한다
select count(nvl(comm,0)) from emp; -- 14

-- 급여의 합
select sum(sal) from emp;
-- 급여의 평균
select trunc(avg(sal),0) from emp;

-- null 값에 대한 고민을 하자!
-- 사장님 .. 총 수당이 얼마나 지급되었나?
select sum(comm) from emp;
-- 수당의 평균은 얼마지?
select trunc(avg(comm),0) from emp; -- 721 >> 6명으로 나눈 값.. 우리 회사는 14명..
select trunc(avg(nvl(comm,0))) from emp;

select max(sal) from emp; -- 5000
select min(sal) from emp; -- 800

-- 집계데이터는 데이터를 1건 출력하기 때문에 같은 자리에 놓을 수 있다
select sum(sal), avg(sal), max(sal), min(sal), count(*), count(sal) from emp;

-- empno는 14건, count(empno)는 1건을 만들기 때문에 오류가 발생한다 
select empno, count(empno) from emp; -- not a single-group group function

-- 부서별 평균 급여를 구하세요
select deptno, avg(sal) 
from emp 
group by deptno;

-- 직종별 평균 급여를 구하세요
select job, avg(sal) from emp group by job;
select avg(sal) from emp group by job; -- 문법적인 오류는 없지만 해당 값이 어떤 직종의 평균인지 판단할 수가 없다

select job, avg(sal), sum(sal), max(sal), min(sal), count(sal) 
from emp 
group by job;

/*
group
distinct 컬럼명1, 컬럼명2
order by 컬럼명1, 컬럼명2
group by 컬럼명1, 컬럼명2
 */
-- 부서별, 직종별 급여의 합을 구하세요
select deptno, job, sum(sal), count(*)
from emp 
group by deptno, job  -- 부서번호.. 그 안에서 직종별 그룹.. 합계
order by deptno;

/*
select 절   >> 5
from 절     >> 1
where 절    >> 2
group by 절 >> 3
having 절   >> 4
order by 절 >> 6

단일 테이블에서 처리할 수 있는 모든 구문
 */
-- 직종별 평균 급여가 3000달러 이상인 사원의 직종과 평균급여를 출력하세요
select * from emp;
select job, avg(sal) 
from emp
group by job
having avg(sal) >= 3000; -- having : grouping된 데이터의 조건절
-- from의 조건절 -> where
-- group by의 조건절 -> having (집계함수로 조건을 처리)

/*
사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인
사원들의 목록을 출력하세요 (comm이 0인 놈도 받는 것으로..)
급여의 합이 낮은 순으로 출력하세요
 */
select job, sum(sal) as sumsal
from emp
where comm is not null
group by job
having sum(sal) >= 5000
order by sumsal asc;

/* 사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력하세요 */
select deptno, count(*), sum(sal)
from emp
group by deptno
having count(*) > 4;

/* 
사원테이블에서 직종별 급여의 합이 5000을 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman)은 제외하고 급여합으로 내림차순 정렬하세요
 */
select job, sum(sal)
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000
order by sum(sal) desc;

/*
HR 계정으로 이동하세요
show user;
1. EMPLOYEES 테이블을 이용하여 다음 조건에 만족하는 행을 검색하세요. 
2005년이후에 입사한 사원 중에 부서번호가 있고, 급여가 5000~10000 사이인 사원을 검색합니다. 
가) 테이블 : employees 
나) 검색 : employee_id, last_name, hire_date, job_id, salary, department_id 
다) 조건
    ① 2005년 1월 1일 이후 입사한 사원
    ② 부서번호가 NULL이 아닌 사원 
    ③ 급여가 5,000보다 크거나 같고, 10,000 보다 작거나 같은 사원 
    ④ 위의 조건을 모두 만족하는 행을 검색 
라) 정렬: department_id 오름차순, salary 내림차순
 */
select * from employees;
select employee_id, last_name, hire_date, job_id, salary, department_id
from employees
where 
    to_char(hire_date, 'YYYY') >= 2005
    and department_id is not null 
    and salary between 5000 and 10000     
order by
    department_id asc,
    salary desc;
/*
2. EMPLOYEES 테이블을 이용하여 다음 조건에 만족하는 행을 검색하세요. 
부서번호가 있고, 부서별 근무 인원수가 2명 이상인 행을 검색하여 부서별 최대 급여와 최소 급여를 계산하
고 그 차이를 검색합니다. 
가) 테이블 : employees 
나) 검색 : department_id, MAX(salary), MIN(salary), difference 
        - MAX(salary) 와 MIN(salary)의 차이를 DIFFERENCE로 검색 
다) 조건
    ① 부서번호가 NULL이 아닌 사원 
    ② 부서별 근무 인원수가 2명 이상인 집합 
라) 그룹 : 부서번호가 같은 행
마) 정렬 : department_id
 */
select * from employees;
select department_id as 부서번호, max(salary) as 최대급여, min(salary) as 최소급여, max(salary)-min(salary) as difference
from employees
where department_id is not null
group by department_id
having count(*) >= 2;

---------------------------------------------------------------------------------------------------------------------
-- 단일 테이블 쿼리 END

-- ETC
-- create table 테이블명(컬럼명 타입, 컬럼명 타입)
create table member3(
    age number
);

-- 데이터 1건
insert into member3(age) values(100);

-- 데이터 여러건
insert into member3(age) values(200);
insert into member3(age) values(300);
insert into member3(age) values(400);

--------------------------------------------------------------------------------
/*
JAVA
class Member3 {
    private int age;
    setter;
    getter;
}
-- 데이터 1건
Member3 member = new Member3();
member.setAge(100);

-- 데이터 여러건
List<Member3> mlist = new ArrayList<>();
mlist.add(new Member3(200));
mlist.add(new Member3(300));
mlist.add(new Member3(400));
 */
/*
데이터 타입
문자열 데이터 타입
char(10)     >> 10byte >> 한글 5자, 영문자, 특수, 공백 10자 >> 고정길이 문자열
varchar2(10) >> 10byte >> 한글 5자, 영문자, 특수, 공백 10자 >> 가변길이 문자열

고정길이(데이터와 상관없이 크기를 갖는 것)
가변길이(들어오는 데이터 크기만큼 확보)

char(10) >> 'abc' >> [a][b][c][][][][][][][] >> 공간크기 변화 없음,, 남은 공간은 그대로 방치
varchar2(10) >> 'abc' >> [a][b][c] >> 데이터 크기만큼 공간을 확보

누가봐도 varchar2가 훨씬 좋음.. char를 왜 만들었을까~?

성능 ... 데이터 검색 >> char() >> 고정길이 .. 가변보다는 좀 앞서 검색

char(2) : 고정길이(남, 여, .. , 대, 중, 소, .. , 주민번호) 검색 성능이 좋음
가변길이 문자열(사람의 이름, 취미, 주소)

한글, 영어권 >> 한문자 >> unicode >> 한글, 영문 >> 2byte

nchar(20) >> 20자 >> 한글, 영문자, 특수문자, 공백 상관없이 >> 40byte
nvarchar2(20) >> 20자
 */

--오라클 함수 ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('가'); --한글 1자 3byte 인지 -- 등록이 안된다.. 오라클에서 utf-8은 한글 한 글자를 3byte로 인식하기 때문
-------------------------------------------------------------------------------
-- JOIN(하나 이상의 테이블에서 데이터 가져오기)
-- 신입에게 요구하는 기술
/*
Join의 종류
Join 방법 설명
Cartesian Product 모든 가능한 행들의 Join
**Equijoin Join 조건이 정확히 일치하는 경우 사용(일반적으로 PK 와 FK 사용) >> 등가 조인
**Non-Equijoin Join 조건이 정확히 일치하지 않는 경우에 사용(등급,학점)
**Outer Join Join 조건이 정확히 일치하지 않는 경우에도 모든 행들을 출력 
**Self Join 하나의 테이블에서 행들을 Join 하고자 할 경우에 사용
Set Operators 여러 개의 SELECT 문장을 연결하여 작성한다.

Equijoin Join
Non-Equijoin Join
Outer Join Join
Self Join

관계형 DB(RDBMS)

관계(테이블과 테이블과의 관계)
(클래스(자바) 비교) >> 연관 관계 존재

1:1
1:N (70%)
M:N

create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;
 */

select * from m;
select * from s;
select * from x;

-- 1. 등가조인(equi join)
-- 원테이블과 대응되는 테이블에 있는 컬럼의 데이터를 1:1로 매핑
-- SQL JOIN 문법(오라클 문법)
-- ANSI 문법 권장 >> 무조건 >> [inner] join on 조건절
-- 오라클 문법
select m.m1, m.m2, s.s2
from m, s
where m.m1 = s.s1;
-- ANSI 문법
select *
from m join s -- m inner join s라고 써야하는데 inner는 보통 생략
on m.m1=s.s1;

-- KOSA로 이동
-- 사원번호, 사원이름, 부서번호, 부서이름을 출력하세요
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp join dept
on emp.deptno = dept.deptno;

-- 현업에서 사용하는 방법 >> 테이블에 가명칭 부여
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;

-- Join은 select 절에 *을 선언하고 나서 컬럼을 명시하는게 좋다
select *
from s join x
on s.s1 = x.x1;

select sysdate from dual;
--------------------------------------------------------------------------
-- SQL JOIN 문법
select *
from m, s, x
where m.m1 = s.s1 and s.s1 = x.x1;

-- ANSI JOIN 문법
select *
from m join s on m.m1 = s.s1
       join x on s.s1 = x.x1;

-- HR 계정 이동
show user; -- USER이(가) "HR"입니다.
select * from employees;
select * from departments;
select * from locations;

-- 1. 사번, 이름(lastname), 부서번호, 부서이름을 출력하세요
select 
    e.employee_id as 사번, 
    e.last_name as 이름,
    e.department_id as 부서번호,
    d.department_name as 부서이름
from employees e join departments d on e.department_id = d.department_id;
-- 총 107명인데 106명만 출력.. >> department_id에 null값을 갖고 있는 사원이 있다..!

-- 2. 사번, 이름(lastname), 부서번호, 부서이름, 지역코드, 도시명을 출력하세요
select 
    e.employee_id as 사번,
    e.last_name as 이름,
    e.department_id as 부서번호,
    d.department_name as 부서이름,
    d.location_id as 지역번호,
    l.city as 도시명
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id;

-- KOSA 계정 이동
show user; -- USER이(가) "KOSA"입니다.
select * from emp;
select * from salgrade;

-- 사원의 등급(하나의 컬럼으로 매핑이 안된다 >> 컬럼을 2개 사용 >> 비등가 조인(non-equi))
-- 문법은 등가와 동일(의미만 따짐)
select e.empno, e.ename, s.grade, e.sal
from emp e join salgrade s 
on e.sal between s.losal and s.hisal;

-- outer join(equi 조인이 선행되고 나서 남아있는 데이터를 가져오는 방법)
-- 1. 주종 관계(주인이 되는 쪽에 남아있는 데이터를 가져오는 방법)
-- 2. left outer join(왼쪽이 주인)
-- 2.1 right outer join(오른쪽이 주인)
-- 2.2 full outer join(left, right >> union)

select *
from m left outer join s
on m.m1 = s.s1;

select *
from m right outer join s
on m.m1 = s.s1;

select *
from m full outer join s
on m.m1 = s.s1;

-- HR 계정 이동
show user;
-- 1. 사번, 이름(lastname), 부서번호, 부서이름을 출력하세요
select 
    e.employee_id as 사번, 
    e.last_name as 이름,
    e.department_id as 부서번호,
    d.department_name as 부서이름
from employees e left join departments d on e.department_id = d.department_id;
-- 총 107명인데 106명만 출력.. >> department_id에 null값을 갖고 있는 사원이 있다..!
-- outer join을 이용해서 null값을 가진 사원도 데리고 온다


-- KOSA 계정으로 이동
show user;

-- self join(자기 참조) -> 문법(x) -> 의미만 존재 -> 등가조인 문법
-- 하나의 테이블에 있는 컬럼이 자신의 테이블에 있는 특정 컬럼을 참조하는 경우
select * from emp;
-- SMITH 사원의 사수 이름 >> FORD
-- 사원테이블, 관리자테이블을 따로 만드는 것은 중복 데이터를 만드는 일이다 .. >> 셀프조인이 필요한 상황
-- 테이블 가명칭을 이용해서 하나의 테이블이 2개, 3개 있는 것처럼 사용할 수 있다.
select e.empno, e.ename, m.empno, m.ename
from emp e join emp m
on e.mgr = m.empno;

-- 총 14명인데 13명만 나온다 >> outer join으로 해결
select e.empno, e.ename, m.empno, m.ename
from emp e left join emp m
on e.mgr = m.empno;
---------------------------------------------------------------------------------
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ename, e.deptno, d.dname from emp e join dept d on e.deptno = d.deptno;

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 출력하라.
select e.ename, e.job, e.deptno, d.dname from emp e join dept d on e.deptno = d.deptno where d.loc = 'DALLAS';

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname from emp e join dept d on e.deptno = d.deptno where e.ename like '%A%';

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 출력하라.
select e.ename, d.dname from emp e join dept d on e.deptno = d.deptno where sal >= 3000;

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고 그 사원이 속한 부서 이름을 출력하라.
select e.job, e.ename, d.dname from emp e join dept d on e.deptno = d.deptno where job = 'SALESMAN';
​
-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션, 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라. (비등가 ) 1 : 1 매핑 대는 컬럼이 없다
select e.empno as 사원번호, e.ename as 사원이름, e.sal*12 as 연봉, e.sal*12+e.comm as 실급여, s.grade as 급여등급
from emp e join salgrade s on e.sal between s.losal and s.hisal where e.comm is not null;
​
-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급을 출력하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno = 10;
​
-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름, 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로 정렬하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno in (10, 20)
order by e.deptno asc, e.sal desc;

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라. SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)
select e1.empno as 사원번호, e1.ename as 사원이름, e1.mgr as 관리자번호, e2.ename as 관리자이름
from emp e1 left join emp e2 on e1.mgr = e2.empno;
----------------------------------------------------------------------------------------------------------
-- JOIN END ----------------------------------------------------------------------------------------------

-- subquery(서브쿼리) 100page
-- sql의 꽃 .. 만능 해결사

-- 1. 함수 > 단일 테이블 > 다중 테이블(join, union) > 해결이 안됨 >> subquery로 해결

-- 사원테이블에서 사원들의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 급여를 출력하세요
-- 1. 평균 급여
select avg(sal) from emp;
select empno, ename, sal from emp where sal > 2073;

-- 2개의 쿼리를 통합(하나의 쿼리로)
select empno, ename, sal 
from emp 
where sal > (select avg(sal) from emp);

-- subquery
/*
1. single row subquery : 실행 결과가 단일 컬럼에 단일 로우 값인 경우(한개의 값)
ex) select sum(sal) from emp; select max(sal) from emp;
연산자 : =, !=, <, >

2. multi row subquery : 실행 결과가 단일 컬럼에 여러 개의 로우 값인 경우
ex) select deptno from emp; select sal from emp;
연산자 : in, not in, any, all
ALL : sal > 1000 and sal > 40000 and ...
ANY : sal > 1000 or sal > 40000 or ...

문법)
1. 괄호 안에 있어야 한다 (select max(sal) from emp)
2. 단일 컬럼 구성       (select max(sal), min(sal) from emp) 서브쿼리 안돼요 (x)
3. 서브쿼리가 단독으로 실행 가능

서브 쿼리와 메인 쿼리
1. 서브 쿼리 실행
2. 서브쿼리의 결과를 가지고 메인 쿼리 실행

Tip)
select (subquery) >> scala subquery
from (subquery)   >> in line view(가상테이블)
where (subquery)  >> 조건
https://cafe.naver.com/erpzone?iframe_url=/MyCafeIntro.nhn%3Fclubid=30938434 참고
 */

-- 사원테이블에서 jones의 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하세요
-- jones의 급여를 알고 있어야 해결 가능!
select sal from emp where ename = 'JONES'; -- single row subquery
select empno, ename, sal 
from emp 
where sal > (select sal from emp where ename = 'JONES');

-- 부서번호가 30번인 사원과 같은 급여를 받는 모든 사원의 정보를 출력하세요
select sal from emp where deptno = 30;
select *
from emp
where sal in (select sal from emp where deptno = 30);
-- sal = 1600 or sal = 1250 ...

-- 부서번호가 30번인 사원과 다른 급여를 받는 모든 사원의 정보를 출력하세요
select *
from emp
where sal not in (select sal from emp where deptno = 30);
-- sal != 1600 and sal != 1250 ... not in : 부정의 and

-- 부하직원이 있는 사원의 사번과 이름을 출력하세요
select * from emp;
select mgr from emp;
select * 
from emp 
where empno in (select mgr from emp);

select * 
from emp 
where empno not in (select nvl(mgr,0) from emp);

-- king에게 보고하는 즉, 직속상관이 king인 사원의 사번, 이름, 직종, 관리자사번을 출력하세요
select empno from emp where ename = 'KING';
select empno, ename, job, mgr 
from emp 
where mgr = (select empno from emp where ename = 'KING');

-- 20번 부서의 사원중에서 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의 사번, 이름, 급여, 부서번호를 출력하세요
select max(sal) from emp where deptno = 20;
select empno, ename, sal, deptno from emp where sal > (select max(sal) from emp where deptno = 20);

-- 스칼라 서브 쿼리
select e.empno, e.ename, e.deptno, (select d.dname from dept d where d.deptno = e.deptno) as dept_name
from emp e
where e.sal >= 3000;

-- 자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 부서번호, 부서별 평균월급을 출력하세요
select e.empno, e.ename, e.deptno, e.sal, e1.avgsal
from emp e join (select deptno, trunc(avg(sal), 0) as avgsal from emp group by deptno) e1
on e.deptno = e1.deptno
where e.sal > e1.avgsal;


--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
select sal from emp where ename = 'SMITH';
select ename, sal from emp where sal > (select sal from emp where ename = 'SMITH');

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
select sal from emp where deptno = 10;
select ename, sal, deptno from emp where sal in (select sal from emp where deptno = 10);

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라
select deptno from emp where ename = 'BLAKE';
select ename, hiredate from emp where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
select avg(sal) from emp;
select empno, ename, sal 
from emp 
where sal > (select avg(sal) from emp)
order by sal desc;

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
select deptno from emp where ename like '%T%';
select empno, ename 
from emp
where deptno in (select deptno from emp where ename like '%T%');

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
select max(sal) from emp where deptno = 30;
select ename, deptno, sal 
from emp 
where sal > ALL(select max(sal) from emp where deptno = 30);

--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
select d.deptno from emp e join dept d on e.deptno = d.deptno where d.loc = 'DALLAS';
select ename, deptno, job 
from emp
where deptno in (select d.deptno from emp e join dept d on e.deptno = d.deptno where d.loc = 'DALLAS');

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
select e.deptno, e.ename, e.job 
from emp e join dept d on e.deptno = d.deptno 
where d.dname = 'SALES';

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)
select empno from emp where ename = 'KING';
select ename, sal 
from emp
where mgr = (select empno from emp where ename = 'KING');

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.
select avg(sal) from emp;
select deptno from emp where sal > (select avg(sal) from emp) and ename like '%S%';
select empno, ename, sal 
from emp
where sal > (select avg(sal) from emp)
    and deptno in (select deptno from emp where ename like '%S%');

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
select deptno, sal from emp where comm is not null;
select ename, sal, deptno
from emp
where deptno in (select deptno from emp where comm is not null)
    and sal in (select sal from emp where comm is not null);

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
select sal, comm from emp where deptno = 30;
select ename, sal, comm 
from emp
where sal not in (select sal from emp where deptno = 30) 
    and comm not in (select nvl(comm, 0) from emp where deptno = 30 
    and comm is not null);















