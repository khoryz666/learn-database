# Practical 1: Database Security – Access Control and Data Integrity

This document covers the concepts and practical syntax related to Oracle Database Security, including user accounts, roles, privileges, and data integrity through constraints.

---

## 1. Oracle Overview & Database Objects

A database system consists of a DBMS (Database Management System) and one or more Database Applications. Oracle 21c is a Client/Server Database designed for high-volume, multi-user applications.

### Key Database Objects
- **Table**: Basic unit of storage; composed of columns and rows.
- **View**: Logically represents subsets of data from one or more tables.
- **Sequence**: Generates numeric values.
- **Index**: Improves the performance of data retrieval queries.
- **Synonym**: Gives alternative names to database objects.

**Oracle Naming Standard**:
- Must be 1 to 30 characters long.
- Must begin with a character.
- Can contain characters, numbers, and the symbols `$`, `_`, and `#`.

---

## 2. User Accounts and Access Control

To maintain security, you must create user accounts and grant appropriate privileges. A user account defines authentication, default tablespaces, and account/password status.

### Creating and Managing Users
*Note: These commands are typically executed by a Database Administrator (DBA).*

**Syntax for Creating a User:**
```sql
CREATE USER username IDENTIFIED BY password;
```
**Example:**
```sql
CREATE USER demo IDENTIFIED BY DEMOPASS;
```

**Changing a Password:**
```sql
ALTER USER demo IDENTIFIED BY demo123;
```
*(A user can change their own password if granted the privilege to do so.)*

---

## 3. Database Privileges

Privileges control what a user is allowed to do. There are two main types:

1. **System Privileges**: Gives a user the ability to perform a particular action within the database entirely (e.g., `CREATE SESSION`, `CREATE TABLE`, `CREATE USER`).
2. **Object Privileges**: Gives a user the ability to perform a particular action on a *specific* database object (e.g., `SELECT` on the `employees` table).

### Managing System Privileges

**Granting System Privileges:**
```sql
GRANT privilege1 [, privilege2, ...] TO user [, role ];

-- Example:
GRANT CREATE SESSION, CREATE TABLE TO demo;
```

**The `WITH ADMIN OPTION` Clause:**
Allows the grantee to further grant the same system privilege to other users.
```sql
GRANT CREATE TABLE TO demo WITH ADMIN OPTION;
```

**Revoking System Privileges:**
```sql
REVOKE privilege1, privilege2, ... FROM username;

-- Example:
REVOKE CREATE TABLE FROM demo;
```

### Managing Object Privileges

**Granting Object Privileges:**
```sql
GRANT object_priv ON object TO { user | role | PUBLIC } [WITH GRANT OPTION];

-- Example 1: Select on a whole table
GRANT SELECT ON employees TO demo;

-- Example 2: Update on specific columns
GRANT UPDATE (department_name, location_id) ON departments TO demo, manager;
```

**The `WITH GRANT OPTION` Clause:**
Similar to `WITH ADMIN OPTION`, but for object privileges. It allows the grantee to pass on the object privilege.
```sql
GRANT SELECT ON employees TO demo WITH GRANT OPTION;
```

---

## 4. Database Roles

A **Role** is a named group of related privileges that can be granted to users. It simplifies privilege management because you can grant a role to many users instead of granting individual privileges repeatedly.

**Creating a Role and Assigning Privileges:**
```sql
CREATE ROLE role_name;
GRANT privilege1, privilege2 ... TO role_name;

-- Example:
CREATE ROLE manager;
GRANT CREATE TABLE, CREATE VIEW TO manager;
```

**Assigning a Role to a User:**
```sql
GRANT role_name TO user_name;

-- Example:
GRANT manager TO demo;
```

---

## 5. Data Integrity Constraints

Constraints are rules that restrict data values entered into a table field, ensuring data accuracy and reliability.

### Constraint Types
1. **NOT NULL**: Ensures a column cannot have a NULL value (must be specified at the column level).
2. **UNIQUE**: Ensures all values in a column are different.
3. **PRIMARY KEY (PK)**: Uniquely identifies each row (implies NOT NULL + UNIQUE).
4. **FOREIGN KEY (FK)**: Enforces a link between two tables.
5. **CHECK**: Ensures column values meet specific conditions.

**Note on Constraint Naming**: It is good practice to name your constraints (e.g., `tablename_fieldname_constraintID`). If you don't, Oracle generates a system name (`SYS_C...`).

### Creating Constraints
**1. At Column Level:**
```sql
CREATE TABLE client (
    cl_no NUMBER(4) CONSTRAINT client_cl_no_pk PRIMARY KEY,
    cl_first VARCHAR2(20),
    cl_last VARCHAR2(20)
);
```

**2. At Table Level:** (Required if a constraint involves multiple columns)
```sql
CREATE TABLE client (
    cl_no NUMBER(4) NOT NULL,
    cl_first VARCHAR2(20),
    cl_last VARCHAR2(20),
    CONSTRAINT client_cl_no_pk PRIMARY KEY (cl_no)
);
```

**Examples of Various Constraints:**
```sql
-- Foreign Key
CONSTRAINT faculty_loc_id_fk FOREIGN KEY (loc_id) REFERENCES location(loc_id);

-- Check Constraint
CONSTRAINT student_s_class_cc CHECK (s_class IN ('FR', 'SO', 'JR', 'SR'));

-- Default Value (Not strictly a constraint, but related to data entry)
hire_date DATE DEFAULT SYSDATE
```

### Managing Constraints (ALTER TABLE)

**Adding a Constraint:**
```sql
ALTER TABLE tablename ADD CONSTRAINT constraint_name constraint_definition;

-- Example:
ALTER TABLE faculty ADD CONSTRAINT faculty_loc_id_fk FOREIGN KEY (loc_id) REFERENCES location(loc_id);
```

**Dropping a Constraint:**
```sql
ALTER TABLE tablename DROP CONSTRAINT constraint_name;
```

**Disabling and Enabling a Constraint:**
Sometimes it's useful to temporarily disable constraints during bulk data modifications.
```sql
ALTER TABLE tablename DISABLE CONSTRAINT constraint_name;
ALTER TABLE tablename ENABLE CONSTRAINT constraint_name;
```

---

## Review Questions

**Difficulty: Low**
1. What is the difference between an Object Privilege and a System Privilege?
2. What symbol is used to ensure a newly created user has a password in the `CREATE USER` syntax?
3. Can a `NOT NULL` constraint be created at the table level? Why or why not?

**Difficulty: Medium**
4. Explain the difference between `WITH ADMIN OPTION` and `WITH GRANT OPTION`.
5. You want to group several privileges together so they can be assigned easily to new developers on your team. Write the SQL syntax to create a role named `dev_role`, grant it `CREATE VIEW` and `CREATE TABLE`, and then assign it to a user named `alice`.
6. Write an `ALTER TABLE` statement to add a unique constraint to the `email` column of an `employees` table. Name the constraint `emp_email_uk`.

**Difficulty: High**
7. Discuss the architectural benefit of a Client/Server database like Oracle over a Personal database. In practical terms, what happens if a client application crashes in a client/server setup versus a personal database setup?
8. When creating a `CHECK` constraint, what specific Oracle components/functions are you *not* allowed to reference?
9. A user named `demo` leaves the company. You execute `DROP USER demo;` but the command fails because `demo` owns several tables. How do you delete the user and all their associated objects in one command?

---
*End of Practical 1 Summary*
