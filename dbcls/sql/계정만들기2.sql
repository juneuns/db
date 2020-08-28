-- system 계정에서 작업한다.
-- FREE 계정을 만든다.
CREATE USER free IDENTIFIED BY free ACCOUNT UNLOCK;

-- free 계정에 권한 부여
GRANT resource, connect, select any table TO free;