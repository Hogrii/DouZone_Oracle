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






