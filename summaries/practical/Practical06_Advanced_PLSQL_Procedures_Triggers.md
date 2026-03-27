# Practical 6: Advanced PL/SQL (Procedures, Functions, Packages, and Triggers)

This practical delves into advanced PL/SQL concepts by covering how to create modular, reusable code components known as Stored Program Units, and how to automate database actions using Triggers.

---

## 1. Stored Program Units Overview

A stored program unit is a PL/SQL block compiled and stored permanently in the Oracle database. Because it is pre-compiled, it runs faster and can be shared among multiple users and client applications.

There are two main types of program units for typical data processing: **Procedures** and **Functions**.

*(Note: If you delete a program unit, you must also delete all references to it in your other programs, or compilation errors will occur).*

---

## 2. Stored Procedures

A procedure can receive multiple input parameters, perform an action (like `INSERT`, `UPDATE`, or `DELETE`), and optionally return multiple output values.

### Creating a Procedure

**Syntax:**
```plsql
CREATE OR REPLACE PROCEDURE procedure_name (
    parameter1 IN data_type,
    parameter2 OUT data_type,
    parameter3 IN OUT data_type
)
IS
    -- Variable declarations
BEGIN
    -- Executable statements
EXCEPTION
    -- Error handling
END;
/
```

**Parameter Modes:**
- `IN`: Read-only. The value is passed into the procedure but cannot be changed inside it.
- `OUT`: Write-only. Any initial value is ignored; the procedure assigns a new value that is returned to the calling environment.
- `IN OUT`: Read-write. The value is passed in, can be modified, and is returned.

**Example:**
```plsql
CREATE OR REPLACE PROCEDURE update_enrollment_grade (
    current_s_id IN VARCHAR2,
    current_c_sec_id IN NUMBER,
    current_grade IN CHAR
)
IS
BEGIN
    UPDATE enrollment
    SET grade = current_grade
    WHERE s_id = current_s_id AND c_sec_id = current_c_sec_id;
    COMMIT;
END;
/
```
*(Tip: To debug compilation errors in SQL*Plus, run `SHOW ERRORS` immediately after creation).*

### Calling a Procedure
**1. From the SQL*Plus prompt:**
```sql
EXECUTE update_enrollment_grade(5, 13, 'B');  -- Or simply EXEC
```
**2. From within another PL/SQL block:**
Just use the name directly without `EXECUTE`.
```plsql
BEGIN
    update_enrollment_grade(5, 13, 'B');
END;
```

---

## 3. Stored Functions

A function is similar to a procedure, but it *must always return exactly one value*. It is typically used for computations rather than performing database updates.

### Creating a Function

Notice the addition of the `RETURN datatype` clause before the `IS` keyword.

```plsql
CREATE OR REPLACE FUNCTION age (date_of_birth IN DATE)
RETURN NUMBER
IS
    current_age NUMBER;
BEGIN
    current_age := TRUNC((SYSDATE - date_of_birth) / 365.25);
    RETURN current_age;
END;
/
```

### Calling a Function
Because a function returns a value, it is normally called as part of an expression or assignment statement.
```plsql
DECLARE
    calculated_age NUMBER;
BEGIN
    -- The function 'age' is called on the right side of the assignment
    calculated_age := age(TO_DATE('07/01/1971', 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Calculated age is ' || calculated_age);
END;
```

---

## 4. Packages

A package groups related procedures, functions, variables, and SQL statements together. It has two parts:

1. **Specification**: Declares the public constructs (the "interface").
2. **Body**: Defines the actual code for the constructs declared in the specification (the "implementation"). It can also contain private constructs hidden from outside users.

**1. Create the Specification:**
```plsql
CREATE OR REPLACE PACKAGE emp_security AS
    FUNCTION setid (D1 VARCHAR2, D2 VARCHAR2) RETURN VARCHAR2;
END;
/
```

**2. Create the Body:**
```plsql
CREATE OR REPLACE PACKAGE BODY emp_security AS 
    FUNCTION setid (D1 VARCHAR2, D2 VARCHAR2) RETURN VARCHAR2 IS 
        stmt VARCHAR2(200);
    BEGIN
        stmt := 'ename = SYS_CONTEXT("userenv","session_user")';
        RETURN stmt;
    END;
END;
/
```

---

## 5. Database Triggers

A Database Trigger is a stored program unit that automatically executes ("fires") in response to specific database events (`INSERT`, `UPDATE`, or `DELETE`). Triggers cannot accept parameters. They are extremely useful for enforcing complex integrity constraints and building audit trails.

### Trigger Properties
- **Timing**: `BEFORE` or `AFTER` the triggering event.
- **Statement**: `INSERT`, `UPDATE`, or `DELETE`.
- **Level**: 
  - *Statement-level*: Fires once per SQL statement, regardless of how many rows are affected.
  - *Row-level*: Fires once for *each row* affected. Requires the `FOR EACH ROW` clause.

### Row-level Trigger References
In a row-level trigger, you can reference the old and new values of a row using:
- `:OLD.fieldname` (The value before the update/delete)
- `:NEW.fieldname` (The value being inserted/updated)

### Creating Triggers

**Example 1: A `BEFORE INSERT` Row-level Trigger**
Automatically sets the creation date before the row is saved.
```plsql
CREATE OR REPLACE TRIGGER orders_before_insert
BEFORE INSERT ON foodorders
FOR EACH ROW
BEGIN
    :NEW.create_date := SYSDATE;
END;
/
```

**Example 2: An `AFTER INSERT` Row-level Trigger (Audit Trail)**
Records the insertion into an audit table.
```plsql
CREATE OR REPLACE TRIGGER orders_after_insert
AFTER INSERT ON foodorders
FOR EACH ROW
BEGIN
    INSERT INTO foodorders_audit (order_id, quantity, cost_per_item, create_date)
    VALUES (:NEW.order_id, :NEW.quantity, :NEW.cost_per_item, :NEW.create_date);
END;
/
```

### Managing Triggers
```sql
-- Disable a trigger without deleting it
ALTER TRIGGER trigger_name DISABLE;

-- Enable it again
ALTER TRIGGER trigger_name ENABLE;

-- Completely remove the trigger
DROP TRIGGER trigger_name;

-- View trigger metadata
SELECT trigger_name, trigger_type, triggering_event FROM user_triggers;
```

---

## Review Questions

**Difficulty: Low**
1. What is the fundamental difference in expected output between a Stored Procedure and a Stored Function?
2. When creating a parameter for a procedure, which parameter mode acts as a read-only variable?
3. What is the command in SQL*Plus to view compilation errors immediately after an attempt to create a procedure fails?

**Difficulty: Medium**
4. Describe the two mandatory components (parts) necessary to create a complete PL/SQL Package. What role does each part serve?
5. Write the SQL syntax to execute a stored procedure named `delete_employee` that accepts an employee ID (`105`) directly from the SQL*Plus command line.
6. What is the difference between a Statement-level trigger and a Row-level trigger? Which one requires the `FOR EACH ROW` clause?

**Difficulty: High**
7. Discuss a practical business scenario where you would use an `AFTER UPDATE` Row-level trigger utilizing both the `:OLD` and `:NEW` record references.
8. If you have an `UPDATE` statement that modifies 50 rows in a table, and you have both a `BEFORE UPDATE` Statement-level trigger and a `BEFORE UPDATE` Row-level trigger on that table, how many times will each trigger fire?
9. Why are DML statements (like `INSERT` or `UPDATE`) generally placed inside Stored Procedures rather than Stored Functions? Explain in terms of standard architectural practices.

---
*End of Practical 6 Summary*
