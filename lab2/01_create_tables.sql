CREATE TABLE GROUPS (
                        ID NUMBER PRIMARY KEY,
                        NAME VARCHAR2(100),
                        C_VAL NUMBER
);

CREATE TABLE STUDENTS (
                          ID NUMBER PRIMARY KEY,
                          NAME VARCHAR2(100),
                          GROUP_ID NUMBER,
                          CONSTRAINT fk_group_id FOREIGN KEY (GROUP_ID) REFERENCES GROUPS(ID)
);
