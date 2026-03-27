--script to create Clearwater Traders database
--revised 8/17/02 JM

DROP TABLE order_line CASCADE CONSTRAINTS;
DROP TABLE shipment_line CASCADE CONSTRAINTS;
DROP TABLE shipment CASCADE CONSTRAINTS;
DROP TABLE inventory CASCADE CONSTRAINTS;
DROP TABLE color CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE order_source CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;

CREATE TABLE customer
(c_id NUMBER(5), 
c_last VARCHAR2(30),
c_first VARCHAR2(30),
c_mi CHAR(1),
c_birthdate DATE,
c_address VARCHAR2(30),
c_city VARCHAR2(30),
c_state CHAR(2),
c_zip VARCHAR2(10),
c_dphone VARCHAR2(10),
c_ephone VARCHAR2(10),
c_userid VARCHAR2(50),
c_password VARCHAR2(15),
CONSTRAINT customer_c_id_pk PRIMARY KEY (c_id));

CREATE TABLE order_source
(os_id NUMBER(3),
os_desc VARCHAR2(30),
CONSTRAINT order_source_os_id_pk PRIMARY KEY(os_id));

CREATE TABLE orders
(o_id NUMBER(8), 
o_date DATE,
o_methpmt VARCHAR2(10),
c_id NUMBER(5),
os_id NUMBER(3),
CONSTRAINT orders_o_id_pk PRIMARY KEY (o_id),
CONSTRAINT orders_c_id_fk FOREIGN KEY (c_id) REFERENCES customer(c_id),
CONSTRAINT orders_os_id_fk FOREIGN KEY (os_id) REFERENCES order_source(os_id));

CREATE TABLE category
(cat_id NUMBER(2),
cat_desc VARCHAR2(20),
CONSTRAINT category_cat_id_pk PRIMARY KEY (cat_id));

CREATE TABLE item
(item_id NUMBER(8),
item_desc VARCHAR2(30),
cat_id NUMBER(2),
item_image BLOB,
CONSTRAINT item_item_id_pk PRIMARY KEY (item_id),
CONSTRAINT item_cat_id_fk FOREIGN KEY (cat_id) REFERENCES category(cat_id));

CREATE TABLE color
(color VARCHAR2(20),
CONSTRAINT color_color_pk PRIMARY KEY (color));

CREATE TABLE inventory
(inv_id NUMBER(10),
item_id NUMBER(8),
color VARCHAR2(20),
inv_size VARCHAR2(10),
inv_price NUMBER(6,2),
inv_qoh NUMBER(4),
CONSTRAINT inventory_inv_id_pk PRIMARY KEY (inv_id),
CONSTRAINT inventory_item_id_fk FOREIGN KEY (item_id) REFERENCES item(item_id),
CONSTRAINT inventory_color_fk FOREIGN KEY (color) REFERENCES color(color));

CREATE TABLE shipment
(ship_id NUMBER(10),
ship_date_expected DATE,
CONSTRAINT shipment_ship_id_pk PRIMARY KEY (ship_id));

CREATE TABLE shipment_line
(ship_id NUMBER(10), 
inv_id NUMBER(10),
sl_quantity NUMBER(4),
sl_date_received DATE, 
CONSTRAINT shipment_line_ship_id_fk FOREIGN KEY (ship_id) REFERENCES shipment(ship_id),
CONSTRAINT shipment_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES inventory(inv_id),
CONSTRAINT shipment_line_shipid_invid_pk PRIMARY KEY(ship_id, inv_id));

CREATE TABLE order_line 
(o_id NUMBER(8), 
inv_id NUMBER(10), 
ol_quantity NUMBER(4) NOT NULL,  
CONSTRAINT order_line_o_id_fk FOREIGN KEY (o_id) REFERENCES orders(o_id),
CONSTRAINT order_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES inventory(inv_id),
CONSTRAINT order_line_oid_invid_pk PRIMARY KEY (o_id, inv_id));

