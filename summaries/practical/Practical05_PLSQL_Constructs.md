# Practical 5: PL/SQL Programming Constructs

This practical builds upon basic PL/SQL by introducing control structures (decision making and loops), cursors for retrieving data, and exception handling for managing runtime errors.

---

## 1. Decision Control Structures

Decision structures allow your code to execute different branches based on conditions. The logical operators `AND`, `OR`, and `NOT` can be used to build complex conditions (with `AND` evaluated before `OR`).

### IF / THEN
Executes code only if the condition is TRUE.
```plsql
IF condition THEN
    -- commands
END IF;
```

### IF / THEN / ELSE
Executes one block if TRUE, another if FALSE.
```plsql
IF condition THEN
    -- commands if TRUE
ELSE
    -- commands if FALSE
END IF;
```

### IF / ELSIF / ELSE
Evaluates multiple conditions sequentially.
```plsql
IF condition1 THEN
    -- commands
ELSIF condition2 THEN
    -- commands
ELSE
    -- commands if none are true
END IF;
```

---

## 2. Using SQL Queries in PL/SQL

- **DML Commands (Allowed)**: `SELECT`, `INSERT`, `UPDATE`, `DELETE` work natively within PL/SQL. You can use PL/SQL variables inside these queries.
- **DDL Commands (Not Allowed Native)**: `CREATE`, `ALTER`, `DROP` cannot be executed directly in standard PL/SQL execution blocks without using dynamic SQL (like `EXECUTE IMMEDIATE`).

---

## 3. Loops

Loops repeatedly execute a block of code. PL/SQL offers several loop structures:

**1. Basic `LOOP ... EXIT`**
Executes endlessly until it hits an `EXIT` statement.
```plsql
LOOP
    -- statements
    IF condition THEN
        EXIT;
    END IF;
END LOOP;
```

**2. `LOOP ... EXIT WHEN`**
A cleaner version of the basic loop.
```plsql
LOOP
    -- statements
    EXIT WHEN condition; -- For example: EXIT WHEN counter > 3;
END LOOP;
```

**3. `WHILE ... LOOP` (Pretest Loop)**
Evaluates the condition *before* executing the loop body.
```plsql
WHILE condition LOOP
    -- statements
END LOOP;
```

**4. Numeric `FOR` Loop**
Automatically declares an integer counter that increments from a start value to an end value.
```plsql
FOR counter_variable IN start_value .. end_value LOOP
    -- statements
END LOOP;

-- Example:
FOR i IN 1 .. 5 LOOP
    DBMS_OUTPUT.PUT_LINE(i);
END LOOP;
```

---

## 4. Cursors

A Cursor is a pointer to a memory location used by the DBMS to process an SQL query.

### Implicit Cursors
Automatically created by Oracle whenever you execute a `SELECT ... INTO ...` or DML statement.
- **Restriction**: A `SELECT ... INTO ...` must return **exactly one record**. It will throw an error if it returns 0 rows or > 1 row.
```plsql
SELECT street_address INTO v_street_address
FROM locations WHERE location_id = 1000;
```

### Explicit Cursors
Used for queries that return **multiple records** (or might return no records). They must be explicitly declared, opened, fetched from, and closed.

**Basic Explicit Cursor Steps:**
```plsql
DECLARE
    -- 1. Declare the cursor
    CURSOR loc_cursor IS SELECT room FROM location WHERE bldg_code = 'LIB';
    v_room location.room%TYPE;
BEGIN
    -- 2. Open the cursor
    OPEN loc_cursor;
    
    LOOP
        -- 3. Fetch data row sequentially
        FETCH loc_cursor INTO v_room;
        
        -- Exit when no more rows exist (%NOTFOUND)
        EXIT WHEN loc_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_room);
    END LOOP;
    
    -- 4. Close the cursor
    CLOSE loc_cursor;
END;
```

**Cursor `FOR` Loop (The Shortcut):**
Automatically opens, fetches, checks `%NOTFOUND`, and closes the cursor. This is the cleanest and most efficient way to loop through a cursor.
```plsql
DECLARE
    CURSOR loc_cursor IS SELECT room, capacity FROM location WHERE bldg_code = 'LIB';
BEGIN
    -- No need to explicitly OPEN, FETCH, or CLOSE!
    FOR loc_rec IN loc_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Room: ' || loc_rec.room);
    END LOOP;
END;
```

---

## 5. Handling Runtime Errors (Exceptions)

Exceptions transfer control from the `BEGIN` section to the `EXCEPTION` section.

**1. Predefined Exceptions**
Standard Oracle errors that already have names (e.g., `NO_DATA_FOUND`, `TOO_MANY_ROWS`).
```plsql
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found!');
```

**2. Undefined Exceptions**
Oracle system errors that have an error code (like `ORA-01400` for violating a NOT NULL constraint) but no predefined name. You name them using `PRAGMA EXCEPTION_INIT`.
```plsql
DECLARE
    insert_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(insert_excep, -01400); -- Bind name to code
BEGIN
    -- code that might trigger ORA-01400
EXCEPTION
    WHEN insert_excep THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed due to constraint violation.');
END;
```

**3. User-Defined Exceptions**
Not a real Oracle database error, but a logical error based on business rules. You must `RAISE` them manually.
```plsql
DECLARE
    invalid_dept EXCEPTION;
BEGIN
    UPDATE departments SET department_name = 'abc' WHERE department_id = 999;
    
    IF SQL%NOTFOUND THEN -- If the update modified 0 rows
        RAISE invalid_dept; -- Trigger the exception
    END IF;
EXCEPTION
    WHEN invalid_dept THEN
        DBMS_OUTPUT.PUT_LINE('No such department ID found for update.');
END;
```

---

## Review Questions

**Difficulty: Low**
1. What is the keyword used in an `IF` statement to chain multiple distinct conditions together (the PL/SQL equivalent of "else if")?
2. Which type of loop evaluates its exit condition *before* executing the loop body even once?
3. True or False: You can place a `CREATE TABLE` command directly inside the `BEGIN` block of standard PL/SQL.

**Difficulty: Medium**
4. What are the four mandatory steps required to process an Explicit Cursor using a basic `LOOP...EXIT` structure?
5. Why would an Implicit Cursor fail (throw an error) if its underlying query evaluates to `SELECT name INTO v_name FROM users;` and the `users` table contains 10 rows?
6. Write a small PL/SQL numeric `FOR` loop that iterates from 10 to 20 and prints the counter value to the screen.

**Difficulty: High**
7. Discuss the advantages of using a Cursor `FOR` Loop over a simple `LOOP...EXIT` block when working with explicit cursors.
8. Explain the difference between an Undefined Exception and a User-Defined Exception. In which scenario do you need to use `PRAGMA EXCEPTION_INIT`?
9. You want to implement a business rule that no employee can receive a salary cut. Write an excerpt of PL/SQL code showing how you would declare a user-defined exception named `salary_cut_excep` and `RAISE` it if a variable `new_salary` is less than `old_salary`.

---
*End of Practical 5 Summary*
