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
-- 1. 사원들의 이름, 부서번호, 서이름을 출력하라.
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
select deptno, ename, job 
from emp
where deptno in (select deptno from dept where dname = 'SALES');

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

---------------------------------------------------------------------------------
/*
DDL(데이터 정의어) : [create, alter, drop, trucate], rename, modify
DML(데이터 조작어) : 트랜잭션을 일으키는 작업 : insert, update, delete
ex) 개발자 .. 회사 갑자기 .. DB select는 잘되는데 insert, update, delete가 안된다 ..
    >> log에 write를 수행하는 작업(어떤 놈이 언제 어떤 무슨 기록)
    >> DISK 기록(log file full) >> log write가 안된다. >> DML 작업을 못한다
    >> log backup >> log 삭제 >> log write가 된다 >> DML 작업을 시작할 수 있다
    
    >> commit 하지 않은 경우 ... >> 실습 예정!
DQL(데이터 질의어) : select
DCL(데이터 제어어) : grant, revoke
TCL(트랜잭션)     : commit, rollback, savepoint(commit, rollback 지점을 정의)
 */

-- 오라클 insert, update, delete 작업 시 -> 반드시 commit, rollback 처리
-- Tip) tab, col 테이블 사용하기
select * from tab; -- 사용자(KOSA)가 가지고 있는 테이블 목록

-- 내가 테이블을 생성.. 그 이름이 있는지 없는지
select * from tab where tname = 'BOARD';
select * from tab where tname = 'EMP'; -- 테이블에 대한 정보 출력
select * from col where tname = 'EMP'; -- 컬럼에 대한 정보 출력
--------------------------------------------------------------------------------
-- insert, update, delete 무조건 암기 !!

-- 1. insert
create table temp(
    id number primary key, -- id가 not null, unique 하다(회원 ID, 주민번호)
    name varchar2(20)
);
desc temp;

-- 1. 일반적인 insert
insert into temp(id, name) values(100, '홍길동');

-- commit, rollback 하기 전까지 실반영되지 않는다
select * from temp;
commit;

-- 2. 컬럼 목록을 생략하고 insert하는 방법 >> 되도록이면 쓰지 말 것..
insert into temp values(200, '김유신');
select * from temp;
rollback;

-- 3. 문제 .. insert
insert into temp(name) values ('아무개'); 
-- ORA-01400: cannot insert NULL into ("KOSA"."TEMP"."ID")
-- primary key에는 null 안됨

insert into temp(id, name) values(100, '개똥이'); 
-- ORA-00001: unique constraint (KOSA.SYS_C007000) violated
-- primary key에는 중복 안됨

insert into temp(id, name) values (200, '정상이');
select * from temp;
commit;
--------------------------------------------------------------------------------
-- Tip
-- Sql은 프로그램적 요소가 없음
-- PL-SQL 변수, 제어문

create table temp2(id varchar2(50));
desc temp2;

-- PL-SQL
-- for(int i=1; i<=100; i++){}
/*
begin
    for i in 1..100 loop
        insert into temp2(id) values('A' || to_char(i));
    end loop;
end;
 */
 -- 위 코드 블럭 주석처리 안하면 아래 select가 안먹힌다
select * from temp2;

create table temp3(
    memberid number(3) not null, -- 3자리 정수 null은 올 수 없다
    name varchar2(10), -- null을 허용하겠다는 의미
    regdate date default sysdate --  테이블 기본값 설정(insert 하지 않으면 자동으로 날짜 데이터를 들어가게 하겠다)
);
desc temp3;

select sysdate from dual;

-- 1. 정상
insert into temp3(memberid, name, regdate) values(100, '홍길동', '2023-04-19');
select * from temp3;
commit;

-- 2. 날짜 생략
insert into temp3(memberid, name) values(200, '김유신'); -- regdate에 default로 sysdate가 들어간다
select * from temp3;
commit;

-- 3. 컬럼 하나
insert into temp3(memberid) values(300);
select * from temp3;
commit;

-- 4. 오류
insert into temp3(name) values('나는누구'); 
-- ORA-01400: cannot insert NULL into ("KOSA"."TEMP3"."MEMBERID")
-- id에 null값을 넣으려고 시도한다 -> primary key .. null 안됨!
---------------------------------------------------------------------------------
-- TIP)
create table temp4(id number);
create table temp5(num number);

desc temp4;
desc temp5;

insert into temp4(id) values(1);
insert into temp4(id) values(2);
insert into temp4(id) values(3);
insert into temp4(id) values(4);
insert into temp4(id) values(5);
insert into temp4(id) values(6);
insert into temp4(id) values(7);
insert into temp4(id) values(8);
insert into temp4(id) values(9);
insert into temp4(id) values(10);
commit;

select * from temp4;

-- 1. 대량 데이터 삽입하기
select * from temp5;
-- temp4 테이블에 있는 모든 데이터를 temp5에 넣고 싶다
-- insert into 테이블명(컬럼리스트) values(컬럼값) ...
-- insert into 테이블명(컬럼리스트) select 절 *******
insert into temp5(num) select id from temp4; -- 대량 데이터 삽입
select * from temp5;
commit;

-- 2. 대량 데이터 삽입하기
-- 데이터를 담을 테이블도 없고 >> 테이블 구조(복제):스키마 + 데이터 삽입
-- 단, 제약 정보는 복제할 수 없다 !! >> primary key, foreign key, unique key ...
-- 순수한 데이터 구조 + 데이터만 복사 가능
create table copyemp as select * from emp;
select * from copyemp;

create table copyemp2 as select empno, ename, sal from emp where deptno = 30;
select * from copyemp2;

-- 토막 퀴즈
-- 틀만(스키마) 복제하고 데이터는 복사하고 싶지는 않아요
create table copyemp3 as select * from emp where 1=2; -- 거짓조건을 만들면 틀만 만들어줌.. 정확히는 데이터가 안들어감 맞는게 없어서
select * from copyemp3;
--------------------------------------------------------------------------------
-- insert end ------------------------------------------------------------------

-- update
/*
update 테이블명 set 컬럼명 = 값, 컬럼명 = 값, 컬럼명 = 값 ... where 조건절

update 테이블명 set 컬럼명 = subquery, where 컬럼명 = subquery
 */
 
select * from copyemp;
 
update copyemp set sal = 0; -- 조건이 없으면 전체를 다 바꿔버린다
select * from copyemp;
rollback;
update copyemp set sal = 1111 where deptno = 20; -- 조건절 update
update copyemp set sal = (select sum(sal) from emp); -- sub query update
update copyemp set ename = 'AAA', job = 'BBB', hiredate = sysdate, sal = (select sum(sal) from emp) where empno = 7788;
select * from copyemp where empno = 7788;
commit;
-------------------------------------------------------------------------------
-- update end------------------------------------------------------------------

-- delete
delete from copyemp;

select * from copyemp;
rollback;

delete from copyemp where deptno = 20;
select * from copyemp where deptno = 20;
commit;
--------------------------------------------------------------------------------
-- delete end ------------------------------------------------------------------

-- regex 과제
--주차장 관리 테이블
create table parking_lot (
    owner_name varchar2(12),     --소유주 이름
    car_number varchar2(10),     --차량번호 최대 8자리
    phone_number varchar2(13),  --핸드폰 번호
    registration_date date,     --등록일
    expiration_date date,       --만료일
    total_payment number(8)     --총결제금액
);

insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('홍길동', '82버5012', '010-0183-4241', '2023-03-13 17:28:59', '2023-07-14', 40000);
insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('이영희', '123고4819', '010-4334-6958', '2023-02-08 08:00:37', '2023-07-08', 50000);    
insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('김철수', '235우9273', '010-7134-1234', '2023-01-19 13:48:51', '2023-07-19', 60000);
insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('손흥민', '72너5487', '010-9102-2017', '2023-01-20 19:28:22', '2023-05-20', 40000);
insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('박지성', '32리2946', '010-2194-3836', '2023-01-04 15:12:19', '2023-02-04', 10000);
insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('김진철', '28시1935', '010-3817-5592', '2023-03-09 10:37:49', '2023-06-09', 30000);
insert into parking_lot(owner_name, car_number, phone_number, registration_date, expiration_date, total_payment)
values('마동탁', '55저7139', '010-6192-8120', '2023-02-27 11:50:14', '2023-05-27', 30000);
commit;

select * from parking_lot;

select * from parking_lot where regexp_like(registration_date,'^\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}$');
--------------------------------------------------------------------------------
/*
개발자(SQL)
1. CRUD (create > insert, read > select, update, delete)
2. APP(JAVA) - 표준(JDBC API) - Oracle
3. insert, update, delete, select (70%)

하나의 테이블에 대해서 작업가능
JAVA에서 EMP 테이블에 접근(CRUD)
APP(JAVA)
MVC(패턴) >> Model(DTO, DAO, SERVICE) - View(HTML, JSP) - Controller(Servlet) >> 니가 잘하는 것만 해!

DB 작업(DAO) >> EmpDao.java >> DB 연결(CRUD)
기본적으로 5개의 함수를 생성 ..
1. 전체 조회 : select * from emp;
>> public List<Emp> getEmpList() { select * from emp return null; }
>> List<Emp> >> 데이터 여러건
2. 조건 조회 : select * from emp where empno = ?;
>> public Emp getEmpListByEmpno(int empno) { select * from emp where empno = ? return null; }
>> Emp >> 데이터 1건
3. 삽입 : insert into emp(..) values(..)
>> public int insertEmp(Emp emp) { insert into emp(..) values(..) return row; }
4. 수정 : update emp set .. where ..
5. 삭제 : delete from emp where ..
 */
-- 9장 테이블 생성하기
-- page 138

-- DDL(create, alter, drop, rename) 테이블(객체) 생성, 수정, 삭제
select * from tab;
select * from tab where tname = lower('board'); -- 테이블이 있는지 확인

create table board(
    boardid number,
    title nvarchar2(50), -- 영문자 특수 공백 상관없이 50자
    content nvarchar2(2000), -- 2000자 (4000 byte)
    regdate date
);
desc board; -- 가장 기본적인 정보 확인
select * from user_tables where lower(table_name) = 'board';
select * from col where lower(tname) = 'board';
-- 제약정보 확인하기(필수)
select * from user_constraints where lower(table_name) = 'board'; -- 제약조건이 없으면 아무것도 출력이 안된다
select * from user_constraints where lower(table_name) = 'emp'; -- "EMPNO" IS NOT NULL >> empno에는 null이 오면 안되는 제약이 있다

-- oracle 11g >> 실무 >> 가상컬럼(조합컬럼)
-- 학생 성적 테이블(국어, 영어, 수학)
-- 합계, 평균 ..
-- 각각의 점수 변화 >> 평균값도 변화 보장 >> 무결성
create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);
desc vtable;
select * from col where lower(tname) = 'vtable'; -- DEFAULTVAL : 'no1 + no2'
insert into vtable(no1, no2) values(100, 50);
select * from vtable; -- 100, 50, 150
-- insert into vtable(no1, no2, no3) values(10, 20, 30);
-- ORA-54013: INSERT operation disallowed on virtual columns
-- no3는 가상 컬럼이기 때문에 직접 입력하는 것은 안된다

-- 실무에서 활용되는 코드
-- 제품정보(입고) : 분기별 데이터 추출(4분기)
create table vtable2(
    no number, -- 순번
    p_code char(4), -- 제품코드(A001, B003)
    p_date char(8), -- 입고일(20230101)
    p_qty number, -- 수량
    p_bungi number(1) GENERATED ALWAYS as ( -- 비정규화 데이터이지만 업무상 사용하기도 한다
        case 
            when substr(p_date, 5, 2) in ('01', '02', '03') then 1
            when substr(p_date, 5, 2) in ('04', '05', '06') then 2
            when substr(p_date, 5, 2) in ('07', '08', '09') then 3
            else 4
        end
    ) VIRTUAL
);
desc vtable2;
select * from col where lower(tname) = 'vtable2';

insert into vtable2(p_date) values('20220101');
insert into vtable2(p_date) values('20220522');
insert into vtable2(p_date) values('20220601');
insert into vtable2(p_date) values('20221111');
insert into vtable2(p_date) values('20221201');
commit;

select * from vtable2;
select * from vtable2 where p_bungi = 2;

select * from all_users;
--------------------------------------------------------------------------------
-- 테이블 만들고 수정 삭제
-- 1. 테이블 생성하기
create table temp6(id number);
desc temp6;

-- 2. 테이블 생성 후 컬럼 추가
alter table temp6 add ename varchar2(20);
desc temp6;

-- 3. 기존 테이블에 있는 컬럼 이름 잘못 표기(ename -> username)
-- 기존 테이블에 있는 기존 컬럼 이름 바꾸기(rename)
alter table temp6 rename column ename to username;
desc temp6;

-- 4. 기존 테이블에 있는 기존 컬럼의 타입 크기 수정(기억하기) modify
alter table temp6 modify (username varchar2(2000));
desc temp6;

-- 5. 기존 테이블에 기존 컬럼 삭제
alter table temp6 drop column username;
desc temp6;

-- 6. 테이블 전체가 필요 없어요
-- 6.1 delete 데이터만 삭제
-- 테이블을 처음 만들면 처음 크기가 설정 >> 데이터를 넣으면 테이블의 크기가 증가
-- 처음 1M >> 데이터 10만건(insert) >> 100M >> delete 10만건 삭제 >> 테이블의 크기는 100M로 변하지 않는다

-- 테이블(데이터) 삭제(공간의 크기도 줄일 수 없을까~?)
-- truncate(단점 : where 절 사용을 못함)
-- 처음 1M >> 데이터 10만건(insert) >> 100M >> truncate table emp >> 테이블의 크기는 1M로 줄어든다 
-- ** 주로 DB 관리자들이 사용

-- 테이블 삭제
drop table temp6;
desc temp6;
--------------------------------------------------------------------------------
-- 테이블에 제약 설정하기
-- page 144

/*
제약조건 설명
PRIMARY KEY(PK) : 유일하게 테이블의 각행을 식별(NOT NULL 과 UNIQUE 조건을 만족)
FOREIGN KEY(FK) : 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
UNIQUE key(UK)  : 테이블의 모든 행을 유일하게 하는 값을 가진 열(NULL 을 허용)
NOT NULL(NN)    : 열은 NULL 값을 포함할 수 없습니다.
CHECK(CK)       : 참이어야 하는 조건을 지정함(대부분 업무 규칙을 설정)

제약은 아니지만 default sysdate ..
 */

-- primary key(pk) : not null과 unique 조건 >> null 데이터와 중복값을 허용하지 않겠다, 식별자로써의 역할 수행
-- 유일값 보장
-- empno primary key >> where empno = 7788 >> 데이터 1건 보장
-- pk(주민번호, 회원id, 상품id)
-- 성능(pk 자동으로 index ..) >> 조회 empno >> 성능 >> index >> 자동생성
-- pk는 테이블당 1개만 설정이 가능(1개의 의미는 (묶어서)) >> 복합키

-- 언제
-- 1. create table 생성시 제약 생성
-- 2. create table 생성 후에 필요에 따라서 추가 (권장) >> alter table emp add constraint ..

-- 제약 확인
select * from user_constraints where lower(table_name) = 'emp';

create table temp7(
    -- id number primary key, 권장하지 않는다(제약 이름이 자동으로 설정되기 때문 >> 제약 편집할 때 찾아봐야함..)
    id number constraints pk_temp7_id primary key, -- 키종류_테이블명_컬럼명 >> 관용, 제약 이름 : pk_temp7_id
    name varchar2(20) not null, -- 오라클에서는 not null도 제약으로 취급
    addr varchar2(50)
);
desc temp7;
select * from user_constraints where lower(table_name) = 'temp7'; -- constraint_name, constraint_type, index_name 확인

-- insert into temp7(name, addr) values('홍길동', '서울시 강남구'); -- ORA-01400: cannot insert NULL into ("KOSA"."TEMP7"."ID"), id 값을 생략했기 때문에 값이 입력되지 않는다 >> id가 pk
insert into temp7(id, name, addr) values(10, '홍길동', '서울시 강남구');
select * from temp7;
commit;

-- insert into temp7(id, name, addr) values(10, '야무지개', '서울시 강남구'); -- ORA-00001: unique constraint (KOSA.PK_TEMP7_ID) violated, id 값에 중복값이 입력되지 않는다 >> id가 pk

-- Unique(uk) : 테이블의 모든 행일 유일하게 하는 값을 가진 열(null 허용)
-- 컬럼 수만큼 생성 가능
-- null 허용
-- unique 제약을 걸고 추가적으로 not null >> 여러개
create table temp8(
    id number constraints pk_temp8_id primary key,
    name varchar2(20) not null,
    jumin nvarchar2(6) constraint uk_temp8_jumin unique,
    addr varchar2(50)
);
desc temp8;
select * from user_constraints where lower(table_name) = 'temp8'; -- constraint_name, constraint_type, index_name 확인

insert into temp8(id, name, jumin, addr) values(10, '홍길동', '123456', '경기도');
select * from temp8;
insert into temp8(id, name, jumin, addr) values(20, '길동', '123456', '서울'); -- ORA-00001: unique constraint (KOSA.UK_TEMP8_JUMIN) violated, jumin 값에 중복값이 입력되지 않는다 >> jumin이 uk
insert into temp8(id, name, addr) values(20, '길동', '서울'); -- unique는 null을 허락한다
select * from temp8;
insert into temp8(id, name, addr) values(30, '순신', '서울'); -- unique는 중복을 허락하지 않지만 null에 대한 중복은 허용한다
select * from temp8;
commit;
-- unique에 not null 추가하기
-- jumin nvarchar2(6) not null constraint uk_temp8_jumin unique,

-- 테이블 생성 후에 제약 걸기(추천, 권장)
create table temp9(id number);
alter table temp9 add constraint pk_temp9_id primary key(id);
select * from user_constraints where lower(table_name) = 'temp9';

-- 복합키 생성
-- alter table temp9 add constraint pk_temp9_id primary key(id, num);
-- 유일한 한개의 row를 출력하려면 >> where id = 100 and num =1; id와 num값을 조건에 모두 적어줘야 유일값을 얻을 수 있다

-- ename 컬럼 추가 후 not null 추가
alter table temp9 add ename varchar2(50);
alter table temp9 modify(ename not null);
desc temp9;

--------------------------------------------------------------------------------
-- check 제약(업무 규칙 : where 조건을 쓰는 것처럼)
-- where gender in ('남', '여');
create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) not null constraint uk_temp10_jumin unique,
    addr varchar2(30),
    age number constraint ck_temp10_age check(age >= 19) -- where age >= 19;
);
select * from user_constraints where lower(table_name) = 'temp10';

insert into temp10(id, name, jumin, addr, age) values(100, '홍길동', '123456', '서울시 강남구', 20);
select * from temp10;
insert into temp10(id, name, jumin, addr, age) values(200, '길동', '235678', '서울시 강남구', 18);
-- ORA-02290: check constraint (KOSA.CK_TEMP10_AGE) violated, check 제약에 걸려서 오류 발생
commit;

-- Foreign key(fk) : 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
-- 참조제약(테이블과 테이블과의 관계 설정)
create table c_emp as select empno, ename, deptno from emp where 1=2; -- emp 테이블로부터 틀만 가져와서 c_emp 테이블 만들기
select * from c_emp;
desc c_emp;

create table c_dept as select deptno, dname from dept where 1=2; -- dept 테이블로부터 틀만 가져와서  c_dept 테이블 만들기
select * from c_dept;
desc c_dept;
-- c_emp 테이블에 있는 deptno 컬럼의 데이터는 c_dept 테이블에 있는 deptno 컬럼에 있는 데이터만 쓰겠다
-- >> 강제(fk)
-- alter table c_emp add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);
-- A REFERENCES clause in a CREATE/ALTER TABLE statement gives a column-list for which there is no matching unique or primary key constraint in the referenced table.
-- c_dept 테이블의 deptno 컬럼이 신용이 없다 >> pk, unique가 있어야 참조할 수 있다
alter table c_dept add constraint pk_c_dept_deptno primary key(deptno); -- deptno에 pk 제약 부여
alter table c_emp add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno); -- pk 제약이 부여되고 fk 제약 부여
select * from user_constraints where lower(table_name) = 'c_emp'; -- foreign key constraint_type : R
select * from user_constraints where lower(table_name) = 'c_dept';
-- c_emp 테이블의 deptno는 c_dept 테이블의 deptno를 참조하고
-- c_dept 테이블의 deptno는 c_emp 테이블의 deptno에게 참조를 당합니다

-- 부서
insert into c_dept(deptno, dname) values(100, '인사팀');
insert into c_dept(deptno, dname) values(200, '관리팀');
insert into c_dept(deptno, dname) values(300, '회계팀');
commit;
select * from c_dept;

-- 신입사원 입사
insert into c_emp(empno, ename, deptno) values(1, '신입이', 100);
select * from c_emp;
insert into c_emp(empno, ename, deptno) values(2, '아무개', 101); 
-- ORA-02291: integrity constraint (KOSA.FK_C_EMP_DEPTNO) violated - parent key not found
-- c_emp의 deptno가 c_dept의 deptno를 참조하고 있기 때문에 c_dept의 deptno에 없는 값이 오면 에러가 발생한다
commit;
--------------------------------------------------------------------------------
-- 제약 END --------------------------------------------------------------------

-- 개발자 관점에서 fk 살펴보기 --
-- master - detail 관계
-- 부모 - 자식 관계

-- c_emp 테이블과 c_dept 테이블은 (관계 fk) >> c_emp(deptno) 컬럼이 c_dept(deptno) 컬럼을 참조
-- fk 관계 : master(c_dept) - detail(c_emp) >> 화면(부서 출력) >> 부서 번호 클릭 >> 사원 정보 출력
-- deptno 참조 관계 부모(c_dept) - 자식(c_emp)
-- 관계 pk를 가지고 있는 쪽(master), fk를 가지고 있는 쪽(detail)

select * from c_dept;
select * from c_emp;
-- 1. 위 상황에서 c_emp 테이블에 있는 신입이 삭제할 수 있을까요?
delete from c_dept where deptno = 100;
-- ORA-02292: integrity constraint (KOSA.FK_C_EMP_DEPTNO) violated - child record found
-- c_emp에서 c_dept의 deptno = 100을 참조하고 있기 때문에 삭제할 수 없다.

delete from c_dept where deptno = 200;
-- c_emp에서 c_dept의 deptno = 200를 참조하지만 사용하는 데이터가 없기 때문에 지워진다.

delete from c_dept where deptno = 100;
delete from c_emp where empno = 1;
-- c_emp에서 참조하고 있는 데이터를 삭제하면 된다
-- 자식(c_emp)부터 삭제하고 부모(c_dept)쪽을 지우면 된다
commit;

/*
column datatype [CONSTRAINT constraint_name]
 REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE])
column datatype,
. . . . . . . ,
[CONSTRAINT constraint_name] FOREIGN KEY (column1[,column2,..])
 REFERENCES table_name (column1[,column2,..] [ON DELETE CASCADE])

ON DELETE CASCADE : 부모 테이블과 생명을 같이 하겠다

alter table c_emp add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno) ON DELETE CASCADE;

delete from c_emp where empno = 1; >> deptno >> 100번
delete from c_dept where deptno = 100; >> 삭제 안됨(참조하고 있으니까 ..)
ON DELETE CASCADE를 걸면 삭제가 됨..

부모삭제 >> 참조하고 있는 자식도 삭제

MS-SQL
ON DELETE CASCADE
ON UPDATE CASCADE
 */

create table student(
    id number constraint pk_student_id primary key,
    name varchar(20) not null,
    kor number default 0,
    eng number default 0,
    math number default 0,
    sum number GENERATED ALWAYS as (kor + eng + math) VIRTUAL,
    avg number GENERATED ALWAYS as ((kor+eng+math)/3) VIRTUAL,
    department_id varchar(20)
);
desc student;

create table department(
    id varchar(20) constraint pk_department_id primary key,
    name varchar(20) not null
);
desc department;

alter table student add constraint fk_student_department_id foreign key(department_id) references department(id);

select * from user_constraints where lower(table_name) = 'student';
select * from user_constraints where lower(table_name) = 'department';

insert into student(id, name, kor, eng, math, department_id) values(2, '은비', 80, 90, 100, '10');
insert into department(id, name) values('10', '공간정보공학');
insert into department(id, name) values('20', '메카트로공학');
insert into student(id, name, kor, eng, math, department_id) values(2, '은비', 80, 90, 100, '10');
insert into student(id, name, kor, eng, math) values(1, '진호', 50, 60, 70, '20');
insert into student(id, name, department_id) values(3, '이진호', '20');

select s.id as 학번, s.name as 이름, s.sum as 총점, nvl(s.department_id, 0) as 학과코드, d.id as 학과명 from student s join department d on s.department_id = d.id;

select * from student;
--------------------------------------------------------------------------------
-- 여기까지 초급 과정 END --------------------------------------------------------

-- 제 12장 VIEW(초중급)
-- 가상 테이블(subquery >> in line view >> from())
/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

옵션
OR REPLACE 이미 존재한다면 다시 생성한다.
FORCE Base Table 유무에 관계없이 VIEW 을 만든다.
NOFORCE 기본 테이블이 존재할 경우에만 VIEW를 생성한다.
view_name VIEW의 이름
Alias Subquery를 통해 선택된 값에 대한 Column명이 된다.
Subquery SELECT 문장을 기술한다.
WITH CHECK OPTION VIEW에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다. 
Constraint CHECK OPTON 제약 조건에 대해 지정된 이름이다.
WITH READ ONLY이 VIEW에서 DML이 수행될 수 없게 한다.
 */

create view view001 as select * from emp; 
-- view를 만드는 권한이 없기 때문에 오류가 발생한다
-- 관리자 >> 다른 사용자 >> KOSA 편집 >> 시스템 권한 >> CREATE ANY VIEW 체크
-- view001이라는 객체가 생성 되었어요(가상 테이블 >> 쿼리 문장을 가지고 있는 객체)
-- 이 객체는 테이블'처럼' 사용할 수 있는 객체 >> view001은 테이블이 아니라는 뜻!!

select * from view001;
select * from view001 where deptno = 20;
-- view는 (가상 테이블)
-- 사용법 : 일반 테이블과 동일(select, insert, update, delete)
-- 단, view가 볼 수 있는 데이터에 한해서만!!
-- view를 통해 원본 테이블에 insert, update, delete(DML)이 가능한데 .. 가능하다는 것만 알고 넘어가도록 하자

-- view 목적
-- 1. 개발자의 편의성 : join, subquery 등의 복잡한 쿼리를 미리 생성해두었다가 사용
-- 2. 쿼리 단순화 : view를 생성해서 join 편리성
-- 3. DBA 보안 : 원본테이블은 노출하지 않고 view를 만들어서 제공(특정 컬럼을 노출하지 않는다) >> 신입사원한테 급여 테이블을 보여주면 안되니까 ,,

create or replace view v_001 as select empno, ename from emp; -- replace는 덮어버린다!
select * from v_001;

create or replace view v_emp as select empno, ename, job, hiredate from emp;
select * from v_emp;
select * from v_emp where job = 'CLERK';

-- 편리성
create or replace view v_002 as select e.empno, e.ename, e.deptno, d.dname from emp e join dept d on e.deptno = d.deptno;
-- 많이 쓰는 컬럼들을 조인해서 새롭게 뷰로 만들어 놓으면 상당히 편리하다
select * from v_002;

-- 자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 부서번호, 부서별 평균월급을 출력하세요
select e.empno, e.ename, e.deptno, e.sal, e1.avgsal
from emp e join (select deptno, trunc(avg(sal), 0) as avgsal from emp group by deptno) e1
on e.deptno = e1.deptno
where e.sal > e1.avgsal;

-- 직종별 평균 급여를 볼 수 있는 view
-- 객체를 drop하지 않는 한 영속적으로 남아 있다..
create view v_003 as select deptno, trunc(avg(sal), 0) as avgsal from emp group by deptno;
select * from v_003;

select e.empno, e.ename, e.deptno, e.sal, s.avgsal
from emp e join v_003 s
on e.deptno = s.deptno
where e.sal > s.avgsal;

/*
view도 나름 테이블(가상) view를 [통해서] view가 볼 수 있는 데이터에 대해서
DML(insert, update, delete) 가능 ..
 */
-- create or replace view v_emp as select empno, ename, job, hiredate from emp;
select * from v_emp;

update v_emp set sal = 0; -- 불가.. v_emp에는 sal이 없음

update v_emp set job = 'IT';
-- 실제로는 원본 emp 테이블 데이터 업데이트
-- 가상 테이블은 원본 테이블의 데이터를 볼 뿐이지 데이터를 갖고 있는 것이 아님..
select * from emp;
select * from v_emp;
rollback;

-- 30번 부서 사원들의 직종, 이름, 월급을 담는 VIEW를 만드는데,
-- 각각의 컬럼명을 직종, 사원이름, 월급으로 ALIAS를 주고 월급이
-- 300보다 많은 사원들만 추출하도록 하라
create or replace view view101 as select job as 직종, ename as 사원이름, sal as 월급 from emp where sal > 300;
select * from view101;

-- 부서별 평균월급을 담는 VIEW를 만들되, 평균월급이 2000 이상인
-- 부서만 출력하도록 하라
create or replace view view102 as select deptno as 부서번호, trunc(avg(sal), 0) as 평균월급 from emp group by deptno having avg(sal) >= 2000;
select * from view102;
--------------------------------------------------------------------------------
-- 기본 Query 끝 ----------------------------------------------------------------

-------------------------------- 문제 만들기 ------------------------------------
-- 국가별로 재직중인 직원 수, 국가별 평균 급여을 출력하세요
select l.country_id as 국가, count(*) as 직원수, trunc(avg(e.salary), 0) as 평균급여
from employees e join departments d on e.department_id = d.department_id
                join locations l on d.location_id = l.location_id
group by country_id;


-- 국가별 평균 급여보다 많은 급여를 받는 직원의 사번, 사원명(first last), 부서명, 국가명을 출력하되
-- 국가명 기준 오름차순, 사번 기준 오름차순으로 출력하세요
select e.employee_id as 사번, (e.first_name || ' ' || e.last_name) as 사원명, d.department_name as 부서명, l.country_id as 국가명
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id
                 join (select l.country_id, trunc(avg(e.salary) , 0) as 국가별평균급여
                       from employees e join departments d on e.department_id = d.department_id 
                                        join locations l on d.location_id = l.location_id group by country_id) e1 on l.country_id = e1.country_id
where e.salary > e1.국가별평균급여
order by 국가명 asc, 사번 asc;


-- 각 부서에서 가장 많은 급여를 받는 직원의 이름, 성, 부서 이름 그리고 해당 직원의 급여를 출력하는 쿼리를 작성하세용.
-- 단, 부서에서 가장 많은 급여를 받는 직원이 여러 명인 경우, 그 중 가장 많은 급여를 받는 직원의 이름순으로 출력해주세용.
select e.last_name as 이름, e.first_name as 성, d.department_name as 부서이름, e.salary as 급여
from employees e join departments d on e.department_id = d.department_id
                 join (select department_id, max(salary) as 최고급여 from employees group by department_id) e1 on e.department_id = e1.department_id
where e.salary = e1.최고급여
order by 급여 desc, 이름 asc;


-- 직업별로 월급이 높은 사람의 employee_id,last_name,job_id,email,salary,city,country_id 정보를 출력해주세여
select e.employee_id, e.last_name, e.job_id, e.salary, l.city, l.country_id
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id;


-- commission_pct의 값이 있는 직업별로 월급이 가장 많은 사원의 
-- employee_id, first_name, last_name, job_id, email, salary, city, country_id, 순위를 출력하여라.


-- (Q)이번에 회사에서 30, 50부서 중에서 20년 이상 회사를 위해 헌신한 직원에 한해서 이벤트를 할려고한다.
-- 1. 해당 사항에 있는 직원의 입사일을 년.월.일 순으로만 나오게 해주세요
-- 2. 축하 케이크에는 직원 이름(풀네임)으로 만들어진 양초를 특수 제작하기 위해서 해당 직원의 전체 이름 길이 수를 알아야된다.
-- 3. 그리고 추가로 직원이름의 첫글자와 20년동안 일한 부서명의 첫 글자 이니셜을 각각 가져와 명예 뱃지를 특수주문하여 선물을 할려고한다.
-- 4. 그리고 만들어진 케이스와 뱃지를 자택으로 선물해주기 위해서, 해당 직원이 살고 있는 도시를 알 수 있어야된다. (스칼라 서브커리 사용)
select 
    to_char(e.hire_date, 'YYYY-MM-DD') as 입사일,
    length(e.first_name)+length(e.last_name) as 이름길이,
    substr(e.first_name, 1, 1) || substr(d.department_name, 1, 1) as 철자,
    (select l.city
     from employees e join departments d on e.department_id = d.department_id
                      join locations l on d.location_id = l.location_id
     where e.department_id in(30, 50) and trunc((sysdate-e.hire_date)/365, 0) >= 20) as 도시
from employees e join departments d on(e.department_id = d.department_id)
where e.department_id in(30, 50) and trunc((sysdate-e.hire_date)/365, 0) >= 20;

------------------------------ 문제 풀이 ----------------------------------------
-- 4조
-- 자신의 급여가 부서별 평균 급여보다 많고 이름(firstname+lastname)에 ‘a’가 들어가는 사원들 중 가장 많은 country_ID의 급여 평균을 출력하라.
select max(avg(t.salary))
from (select *
      from employees e join (select department_id, avg(salary) as 부서별평균급여 from employees group by department_id) e1 on e.department_id = e1.department_id
                       join departments d on e.department_id = d.department_id
                       join locations l on d.location_id = l.location_id
      where e.salary > e1.부서별평균급여
            and (e.first_name like '%a%' or e.last_name like '%a%')) t
group by t.country_id;


-- 2조
-- 이름(last_name)에 'A'가 속하는 사원이 근무하는 부서의 도시명을 모두 출력하세요.
select distinct(l.city)
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id
where e.last_name like '%A%';


-- 'Colmenares'(last_name)이 근무하는 부서의 담당 관리자 이름을 출력하세요.
select e.last_name
from employees e join departments d on e.department_id = d.department_id
where e.employee_id = (select d.manager_id
                      from employees e join departments d on e.department_id = d.department_id
                      where last_name = 'Colmenares');


-- 3조
-- 근무도시별 평균봉급, 평균근속년수, 사원수를 계산하여,
-- '도시명', '평균봉급', '평균근속년수', '사원수' column명으로 출력하되
-- 도시별 평균봉급의 내림차순으로 정렬하시오.
-- 근속년수를 계산할 때, 현재날짜를 2010년 1월 1일로 가정하고
-- 근속 12개월마다 근속년수가 1씩 늘어나는 것으로 계산하시오.
-- 예) 입사일이 2009-09-03인 사원은 근속년수가 0년이다.
-- 단, 근무부서나 근무지역이 없는 사원은 제외하고, 평균은 반올림하여 소수점 1자리까지 출력하라
select * from employees;
select * from departments;
select * from locations;

select l.city, avg(e.salary)
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id
group by l.city;

select trunc((months_between('2010-01-01', hire_date)/12), 0) as 근속년수
from employees;
--------------------------------------------------------------------------------
/*
Sequence 특징
1) 자동적으로 유일 번호를 생성합니다.
2) 공유 가능한 객체(테이블간)
3) 주로 기본 키 값을 생성하기 위해 사용됩니다.
4) 어플리케이션 코드를 대체합니다.(로직을 만들 필요가 없다)
5) 메모리에 CACHE 되면 SEQUENCE 값을 액세스 하는 효율성을 향상시킵니다.

CREATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}];

sequence_name : SEQUENCE 의 이름입니다.
INCREMENT BY n : 정수 값인 n 으로 SEQUENCE 번호 사이의 간격을 지정. 이 절이 생략되면 SEQUENCE 는 1 씩 증가.
START WITH n : 생성하기 위해 첫번째 SEQUENCE 를 지정. 이 절이 생략되면 SEQUENCE 는 1 로 시작.
MAXVALUE n : SEQUENCE 를 생성할 수 있는 최대 값을 지정.
NOMAXVALUE : 오름차순용 10^27 최대값과 내림차순용-1 의 최소값을 지정.
MINVALUE n : 최소 SEQUENCE 값을 지정.
NOMINVALUE : 오름차순용 1 과 내림차순용-(10^26)의 최소값을 지정.
CYCLE | NOCYCLE : 최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를 지정. NOCYCLE 이 디폴트.
CACHE | NOCACHE : 얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지하는가를 지정. 디폴트로 오라클 서버는 20 을 CACHE
 */

desc board;
drop table board;

create table board(
    boardid number constraint pk_board_boardid primary key,
    title nvarchar2(50)
);

select * from user_constraints where lower(table_name) = 'board';
-- pk : not null, unique, index(검색 속도 향상)

-- 게시판 글쓰기 작업
insert into board(boardid, title) values(1, '처음글');
insert into board(boardid, title) values(2, '두번째');

select * from board;
rollback;
-- 처음 글을 쓰면 글 번호가 1번 .. 그 다음글부터는 순차적인 증가값 .. 2번, 3번, ..
-- 어떤 논리?
select count(boardid) + 1 from board;

insert into board(boardid, title) values((select count(boardid) + 1 from board), '내용1');
insert into board(boardid, title) values((select count(boardid) + 1 from board), '내용2');
insert into board(boardid, title) values((select count(boardid) + 1 from board), '내용3');

select * from board;
-- 게시글 삭제, 수정 ..
commit;

delete from board where boardid = 1;
select * from board;
commit;

insert into board(boardid, title) values((select count(boardid) + 1 from board), '새글');
-- ORA-00001: unique constraint (KOSA.PK_BOARD_BOARDID) violated

-- 데이터가 지워져도(삭제되어도) 문제가 없는 순번을 가지고 싶다
insert into board(boardid, title) values((select nvl(max(boardid),0) + 1 from board), '새글');
select * from board;

-- 시퀀스 생성하기(순번 만들기) : 객체(create ...) : 순차적인 번호를 생성하는 객체
create sequence board_num;

-- 순번
select board_num.nextval from dual; -- nextval : 채번(번호표 뽑기)
select board_num.currval from dual; -- currval : 현재까지 채번한 번호 확인

-- 공유(객체) >> 하나의 테이블이 아니라 여러개의 테이블을 사용

-- A 테이블,       B 테이블
-- (insert >> 1   (insert >> 2, insert >> 3)
-- (insert >> 4

create table kboard(
    num number constraint pk_kboard_num primary key,
    title nvarchar2(20)
);
create sequence kboard_num;
insert into kboard(num, title) values(kboard_num.nextval, '처음');
insert into kboard(num, title) values(kboard_num.nextval, '두번째');
insert into kboard(num, title) values(kboard_num.nextval, '세번째');
select * from kboard;
--------------------------------------------------------------------------------
/*
게시판
공지사항, 자유게시판, 답변형게시판 ....
공지사항 1, 2, 3     >> 공지사항 시퀀스
자유게시판 1, 2, 3   >> 자유게시판 시퀀스
답변형게시판 1, 2, 3 >> 답변형게시판 시퀀스
---------------------------------------
공지사항 1, 6
자유게시판 2, 3
답변형게시판 4, 5
>> 시퀀스를 1개만 가지고 3개 테이블에서 나눠 사용(공유 객체)

TIP)
sequence >> 모든 DB에 다 있을까..?
오라클 (O)
MS-sql (O) >> 2012 Ver~
My-sql (X)
MariaDB(엔진(MS-sql)) (O) : https://mariadb.com/kb/ko/sequence-overview/
PostgreSQL (O)

-- 순번 생성(테이블에 종속적으로)
MS-sql
create table board(boardnum int identity(1, 1) .. title
insert into board(title) values('제목'); >> boardnum >> 1이 자동으로 들어간다

My-sql
create table board(boardnum int auto_increament, .. title
insert into board(title) values('제목'); >> boardnum >> 1이 자동으로 들어간다
 */
-- 옵션
create sequence seq_num start with 10 increment by 2;

select seq_num.nextval from dual;
select seq_num.currval from dual;

-- 순번
-- 게시판 처음 ... 데이터 가져올 때
-- 쿼리문
-- num >> 1, 2, 3, .., 1000, .., 10000
-- 가장 나중에 쓴 글(최신글)
-- select * from board order by num desc

-- rownum : 의사 컬럼 : 실제 물리적으로 존재하는 컬럼이 아니고 논리적 존재(create table (x) 사용 안돼요)
-- rownum : 실제로 테이블에 컬럼으로 존재하지 않지만 내부적으로 행 번호를 부여하는 컬럼

select * from emp;
select rownum, empno, ename, sal from emp;

select empno, ename, sal from emp order by sal; 
-- select가 먼저 실행되고 order by가 실행되기 때문에 뒤죽박죽이가 된다
-- 실행 순서 >> from >> select >> order by

select rownum, e.*
from (
        select empno, ename, sal 
        from emp 
        order by sal
     ) e;
-- rownum은 select한 결과에 붙인다

-- Top-n 쿼리(기준이 되는 데이터 순으로 정렬시키고 상위 n개를 가져오는 방법) >> Oracle에는 없음..
-- MS-sql : select top 10, * from emp order by sal desc;
-- Oracle에서는 rownum을 이용해서 Top-n 쿼리를 대체해야 한다
-- 1. 정렬의 기준 설정하기(선행)
-- 2. 정렬된 기준에 rownum을 붙이고 .. 데이터 추출

-- 급여를 많이 받는 순으로 정렬된 데이터에 rownum >> 순번을 가짐
select rownum, e.*
from (
        select empno, ename, sal 
        from emp 
        order by sal desc
     ) e;

-- 급여를 많이 받는 사원 5명
select *
from (
        select rownum as num, e.*
        from (
                select empno, ename, sal 
                from emp 
                order by sal desc
             ) e
     ) n
where num <= 5;
-- Today Point !!
-- ***** 대용량 데이터에서 페이징의 원리
-- 페이징 >> between A and B 
--------------------------------------------------------------------------------
-- 기업(10만 ~ 1억건)
-- 게시판(게시글 10만건)
-- select * from board >> 10만건을 조회
-- 10만건을 나누어서 10건, 20건씩 봐야 한다
/*
totaldata = 100
pagesize = 10 >> 한 화면에 보여지는 데이터 row수를 10건씩 할거야
page 개수 >> 10개

[1][2][3][4][5][6][7][8][9][10]
<a href='page.jsp?page=1'>1</a>
1page 클릭 >> 1~10까지 글 : DB 쿼리 : select num between 1 and 10
2page 클릭 >> 11~20까지 글 : DB 쿼리 : select num between 11 and 20

1. rownum
2. between
 */

-- HR 계정 이동
show user;
select * from employees; -- 107건

-- 사원 번호가 낮은 순으로 정렬한 기준을 통해서 .. 41부터 50번째 데이터를 출력하세요
select *
from(
        select rownum as num, e.*
        from (
                select *
                from employees
                order by employee_id
             ) e
     ) n
where num between 41 and 50;
-- 게시판 만들기 할때 사용합니다
-- servlet/jsp
--------------------------------------------------------------------------------
-- 분석함수(조금씩) -- 개념(index) -- PL-sql 진도 조금씩 할게요
--------------------------------------------------------------------------------
-- 담주 JDBC(JAVA) - MariaDB세팅(기본작업)

show user;

create table dmlemp as select * from emp;
select * from dmlemp;
select * from user_constraints where lower(table_name) = 'dmlemp';
alter table dmlemp add constraints pk_dmlemp_empno primary key(empno);
select * from dmlemp where deptno = 10;

desc dmlemp;
--------------------------------------------------------------------------------
show user; -- USER이(가) "KOSA"입니다.

create table trans_A(
    num number,
    name varchar2(20)
);

create table trans_B(
    num number constraints pk_trans_B_num primary key,
    name varchar2(20)
);
select * from user_constraints where lower(table_name) = 'trans_b';
select * from trans_A;
select * from trans_B;

select * from dept;

select * from emp;
select * from user_constraints where lower(table_name) = 'emp';
delete from emp where empno = 3000;
commit;
--------------------------------------------------------------------------------
-- 집계 열 데이터 >> 행 데이터 바꾸기
-- 기본(decode, case) 사용(장점 표준화)
-- 11g 버전부터(pivot 이용)

/*
>> 행을 열로 전환하기
deptno, cnt
10      3
20      5
30      5

deptno_10  deptno_20  deptno_30
   3           5         6
 */
select deptno, count(*) as cnt fro emp group by deptno order by deptno asc;

select 
    deptno, 
    case when deptno = 10 then 1 else 0 end as dept_10,
    case when deptno = 20 then 1 else 0 end as dept_20,
    case when deptno = 30 then 1 else 0 end as dept_30
from emp
order by 1; -- order by deptno asc
--------------------------------------------------------------------------------
select 
    deptno, 
    sum(case when deptno = 10 then 1 else 0 end) as dept_10,
    sum(case when deptno = 20 then 1 else 0 end) as dept_20,
    sum(case when deptno = 30 then 1 else 0 end) as dept_30
from emp
group by deptno;
-- deptno 컬럼은 의미가 없다
-- dept_10 컬럼명.. 10번 부서

select 
    sum(case when deptno = 10 then 1 else 0 end) as dept_10, -- 이름 의미 부여 >> 10번 부서
    sum(case when deptno = 20 then 1 else 0 end) as dept_20,
    sum(case when deptno = 30 then 1 else 0 end) as dept_30
from emp;

select
    max(case when deptno = 10 then ecount else null end) as dept_10,
    max(case when deptno = 20 then ecount else null end) as dept_20,
    max(case when deptno = 30 then ecount else null end) as dept_30
from (
        select deptno, count(*) as ecount
        from emp
        group by deptno
     ) x;

/*
select *
from (피벗 대상 쿼리문)
pivot (그룹함수(집계컬럼) for 피벗컬럼 in (피벗컬럼값 as 별칭)

오라클 11g부터 pivot 기능 제공
 */

-- 통계, 차트 데이터 구현
-- 직종별, 월별 입사 건수
select * from emp;

select job, to_char(hiredate, 'FMMM') || '월' as hire_month from emp; -- 월 뽑기

--        1, 2, 3, 4, ..., 12월을 컬럼으로 만들어야 한다
-- CLERK  0  0  1  2
-- decode 12개 >> 1~12월
select *
from(
        select job, to_char(hiredate, 'FMMM') || '월' as hire_month from emp
    )
pivot(
        count(*) for hire_month in('1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월')
     );

-- 직종별, 부서별 급여 합계
select job, deptno, sum(sal) from emp group by job, deptno order by 1, 2;

select *
from (select job, deptno, sal from emp)
pivot (sum(sal) for deptno in ('10' as d10, '20' as d20, '30' as d30));


select * from dept;
select * from user_constraints where lower(table_name) = 'dept';
-------------------------------------------------------------------------------
-- Quiz
select deptno, job, sal from emp;

select *
from (
        select deptno, job, sal from emp
     )
pivot(sum(sal) for job in('PRESIDENT' as p, 'ANALYST' as a, 'MANAGER' as m, 'SALESMAN' as s, 'CLERK' as c));

-- 동일한 결과 decode 생성
-- 동일한 결과 case 생성
select 
    deptno,
    sum(case when job = 'PRESIDENT' then sal else null end) as p,
    sum(case when job = 'ANALYST' then sal else null end) as a,
    sum(case when job = 'MANAGER' then sal else null end) as m,
    sum(case when job = 'SALESMAN' then sal else null end) as s,
    sum(case when job = 'CLERK' then sal else null end) as c
from emp group by deptno;

--------------------------------------------------------------------------------
-- 사원테이블에서 부서별 급여합계와 전체 급여합을 출력하세요
select deptno, sum(sal)
from emp
group by deptno
order by deptno;

select sum(sal) from emp;

select deptno, sum(sal) from emp group by deptno
union all
select null, sum(sal) from emp;
--------------------------------------------------------------------------------
-- 분석 함수
-- Rollup, Cube 소개(주로 레포팅, 출력할때 많이 사용 >> OLAP(OnLine Analyst Process)
-- 다차원 분석 쿼리에 사용(소계를 만드는 방법)
select job, deptno, sum(sal), count(sal)
from emp
group by job, deptno
order by job, deptno;

select job, sum(sal)
from emp
group by rollup(job); -- 나는 직종별 급여의 합도 구하고,, 모든 직종 급여의 합도 구하겠다

select job, deptno, sum(sal)
from emp
group by rollup(job, deptno); -- 직종별, 전체 소계 포함
                              -- rollup의 한계 >> 좌측 컬럼을 기준으로 값을 보여준다.. (= 우측 끝 컬럼부터 연산에서 제외, 따라서 컬럼의 순서가 중요)
----------------------------------------------------------------------------------------------------------------------------------------
select job, deptno, sum(sal), count(sal)
from emp
group by job, deptno
order by job, deptno;
-- 기준 소계 : deptno별 소계, job별 소계, 전체 합 보고 싶음

-- 전체 합
select null, null, sum(sal)
from emp
order by deptno, job;

select deptno, job, sum(sal)
from emp
group by deptno, job
union all
select deptno, null, sum(sal)
from emp
group by deptno
union all
select null, job, sum(sal)
from emp
group by job
union all
select null, null, sum(sal)
from emp;

-- 복합한 쿼리(union), rollup(모든 컬럼의 집계는 안된다) >> cube >> 모든 컬럼의 소계를 구해준다
select deptno, job, sum(sal)
from emp
group by cube(deptno, job)
order by deptno, job; -- 부서별 직종의 급여 합, 부서별 급여 합, 직종별 급여 합, 전체 급여 합을 구해준다

--------------------------------------------------------------------------------
-- 순위 함수
-- rownum(select 결과에 순번 처리)
-- rank, dense_rank

-- 순위가 동일한 결과(같은 점수가 여러명)
select * from emp;

select 
    ename,
    sal,
    rank() over(order by sal desc) as 순위, -- >> 2명이 겹치면 둘 다 2등을 주고 그 다음 등수를 4등으로 준다
    dense_rank() over(order by sal desc) as 순위2 -- >> 2명이 겹치면 둘 다 2등을 주고 그 다음 등수를 3등으로 준다(등수에 공백이 없음)
from emp
order by sal desc;

-- 만약 동률이 나왔다면 기준을 더 만들어서 상세하게 구분지어주면 해결된다
-- 회사) 포인트 많은 3명에게 선물을 주겠다 >> 6명이 동률이 나왔네~? >> 입사순, 나이순, ... 으로 중복 해결해~

select 
    ename,
    sal,
    comm,
    hiredate,
    rank() over(order by sal desc, comm desc, hiredate) as 순위 -- 기준을 추가함으로써 중복되는 순위를 해결한다.. 급여순 >> 커미션순 >> 입사일순
from emp
order by sal desc;

-- 조건(그룹안에서 순위 정하기)
-- A group(1, 2, 3, ...), B group(1, 2, 3, ...)
select
    job,
    ename,
    sal,
    comm,
    rank() over(partition by job order by sal desc, comm desc) as 그룹순위
from emp
order by job asc, sal desc, comm desc;

-- 집계 함수(단점 : select절 집계 함수 이외에 나머지 컬럼은 group by절에 묶여야 한다)
-- in line view(서브쿼리를 사용해서 join
-- create view 가상테이블 join
select job, sum(sal), count(sal)
from emp
where job in('MANAGER', 'SALESMAN')
group by job
order by job;

-- 위 쿼리에서 이름, 사번을 보고싶다..
-- 해결
select ename, sal, job, sum(sal) over(partition by job)
from emp
where job in ('MANAGER', 'SALESMAN')
order by job;
-- 단점은 똑같은 데이터가 반복적으로 출력된다
















