--script to create Software Experts database
--revised 08/19/02 JM

DROP TABLE evaluation CASCADE CONSTRAINTS;
DROP TABLE project_consultant CASCADE CONSTRAINTS;
DROP TABLE project_skill CASCADE CONSTRAINTS;
DROP TABLE project CASCADE CONSTRAINTS;
DROP TABLE client CASCADE CONSTRAINTS;
DROP TABLE consultant_skill CASCADE CONSTRAINTS;
DROP TABLE skill CASCADE CONSTRAINTS;
DROP TABLE consultant CASCADE CONSTRAINTS;

CREATE TABLE consultant
(c_id NUMBER(6),
c_last VARCHAR2(20),
c_first VARCHAR2(20),
c_mi CHAR(1),
c_add VARCHAR2(30),
c_city VARCHAR2(20),
c_state CHAR(2),
c_zip VARCHAR2(10),
c_phone VARCHAR2(15),
c_email VARCHAR2(30), 
CONSTRAINT consultant_c_id_pk PRIMARY KEY (c_id));

CREATE TABLE skill
(skill_id NUMBER(3),
skill_description VARCHAR2(50),
CONSTRAINT skill_skill_id_pk PRIMARY KEY (skill_id));

CREATE TABLE consultant_skill
(c_id NUMBER(6),
skill_id NUMBER(3),
certification VARCHAR2(8),
CONSTRAINT consultant_skill_pk PRIMARY KEY (c_id, skill_id),
CONSTRAINT consultant_skill_c_id_fk FOREIGN KEY (c_id) REFERENCES consultant(c_id),
CONSTRAINT consultant_skill_skill_id_fk FOREIGN KEY (skill_id) REFERENCES skill(skill_id));

CREATE TABLE client
(client_id NUMBER(6),
client_name VARCHAR2(30),
contact_last VARCHAR2(30),
contact_first VARCHAR2(30),
contact_phone VARCHAR2(15),
CONSTRAINT client_client_id_pk PRIMARY KEY (client_id));

CREATE TABLE project
(p_id NUMBER(6),
project_name VARCHAR2(30),
client_id NUMBER(6),
mgr_id NUMBER(6),
parent_p_id NUMBER(6),
CONSTRAINT project_pid_pk PRIMARY KEY (p_id),
CONSTRAINT project_client_id_fk FOREIGN KEY (client_id) REFERENCES client(client_id),
CONSTRAINT project_mgr_id_fk FOREIGN KEY (mgr_id) REFERENCES consultant(c_id));

ALTER TABLE project
ADD CONSTRAINT project_parent_pid_fk FOREIGN KEY (parent_p_id) REFERENCES project(p_id);

CREATE TABLE project_skill
(p_id NUMBER(6),
skill_id NUMBER(3),
CONSTRAINT project_skill_pk PRIMARY KEY (p_id, skill_id),
CONSTRAINT project_skill_pid_fk FOREIGN KEY (p_id) REFERENCES project(p_id),
CONSTRAINT project_skill_skill_id_fk FOREIGN KEY (skill_id) REFERENCES skill(skill_id));

CREATE TABLE project_consultant
(p_id NUMBER(6),
c_id NUMBER(6),
roll_on_date DATE,
roll_off_date DATE,
elapsed_time INTERVAL DAY(6) TO SECOND,
CONSTRAINT project_consultant_pk PRIMARY KEY (p_id, c_id),
CONSTRAINT project_consultant_p_id_fk FOREIGN KEY (p_id) REFERENCES project(p_id),
CONSTRAINT project_consultant_c_id_fk FOREIGN KEY (c_id) REFERENCES consultant(c_id));

CREATE TABLE evaluation
(e_id NUMBER(8),
e_date DATE,
p_id NUMBER(6),
evaluator_id NUMBER(6),
evaluatee_id NUMBER(6),
score NUMBER(3),
comments VARCHAR2(300),
CONSTRAINT evaluation_e_id_pk PRIMARY KEY (e_id),
CONSTRAINT evaluation_p_id_fk FOREIGN KEY (p_id) REFERENCES project(p_id),
CONSTRAINT evaluation_evaluator_id_fk FOREIGN KEY (evaluator_id) REFERENCES consultant(c_id),
CONSTRAINT evaluation_evaluatee_id_fk FOREIGN KEY (evaluatee_id) REFERENCES consultant(c_id));
