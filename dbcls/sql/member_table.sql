CREATE TABLE member(
    mno NUMBER(4)
        CONSTRAINT MEMB_NO_PK PRIMARY KEY,
    id VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_ID_UK UNIQUE
        CONSTRAINT MEMB_ID_NN NOT NULL,
    name VARCHAR2(10 CHAR)
        CONSTRAINT MEMB_NAME_NN NOT NULL,
    mail VARCHAR2(50 CHAR)
        CONSTRAINT MEMB_MAIL_UK UNIQUE
        CONSTRAINT MEMB_MAIL_NN NOT NULL,
    tel VARCHAR2(13 CHAR)
        CONSTRAINT MEMB_TEL_UK UNIQUE
        CONSTRAINT MEMB_TEL_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT MEMB_GEN_CK CHECK (gen IN ('F', 'M'))
        CONSTRAINT MEMB_GEN_NN NOT NULL,
    avt NUMBER(2)
        CONSTRAINT MEMB_AVT_NN NOT NULL
        CONSTRAINT MEMB_AVT_FK REFERENCES avatar(ano),
    joinDate Date
        CONSTRAINT MEMB_JOIN_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT MEMB_SHOW_NN NOT NULL
        CONSTRAINT MEMB_SHOW_CK CHECK (isshow IN('Y', 'N'))
);


INSERT INTO
    member01(mno, id, name, mail, tel, gen, avt)
VALUES(
    1000, 'euns', '전은석', 'euns@increpas.com',
    '010-3175-9042', 'M', 11
);

INSERT INTO
    member01(mno, id, name, mail, tel, gen, avt)
VALUES(
    1001, 'joo', '김주영', 'joo@increpas.com',
    '010-1111-1111', 'F', 14
);

INSERT INTO
    member01(mno, id, name, mail, tel, gen, avt)
VALUES(
    1002, 'joseph', '윤요셉', 'joseph@increpas.com',
    '010-2222-2222', 'M', 12
);

commit;

ALTER TABLE
    member01
ADD
    joinDate DATE DEFAULT sysdate
    CONSTRAINT MEMB01_JDAY_NN NOT NULL
;



SELECT * FROM member01;
SELECT id FROM member01 WHERE isshow = 'Y';

ALTER TABLE
    member01
ADD
    pw VARCHAR2(10) DEFAULT '12345'
        CONSTRAINT MEMB01_PW_NN NOT NULL
;

ALTER TABLE
    member01
MODIFY
    pw VARCHAR2(10) DEFAULT (null)
;

select *




