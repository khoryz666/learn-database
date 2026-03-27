# Practical 4: Introduction to PL/SQL

This practical introduces PL/SQL (Procedural Language/SQL), Oracle's procedural extension to SQL. It covers block structure, variables, execution, and string manipulation.

---

## 1. Fundamentals of PL/SQL

PL/SQL is a full-featured, interpreted programming language. It allows you to combine SQL manipulation power with procedural statements (like loops and conditions) inside a single block.

### PL/SQL Block Structure
Every PL/SQL program is organized into blocks containing up to three sections:
1. `DECLARE` (Optional): Declare variables, constants, and cursors.
2. `BEGIN` (Mandatory): Contains SQL and PL/SQL executable statements.
3. `EXCEPTION` (Optional): Handles runtime errors.
4. `END;` (Mandatory): Marks the end of the block.

**Basic Example:**
```plsql
DECLARE
    -- Variable declarations
BEGIN
    -- Executable statements
EXCEPTION
    -- Error handling
END;
/
```
*(In SQL*Plus, you press Enter, type `/`, and press Enter again to execute the block).*

### Variables and Data Types
Variables store numbers, strings, dates, etc., and must be declared before use.

**Syntax:** `variable_name data_type [:= initial_value];`

**1. Scalar Data Types** (Hold a single value)
- `VARCHAR2(n)`: Variable-length string.
- `NUMBER(p, s)`: Numeric data.
- `DATE`: Date and time.
- `BOOLEAN`: TRUE, FALSE, or NULL.
- `BINARY_INTEGER`: Integer values.

**2. Reference Variables**
These directly reference a specific database field or record type, which is safer if the underlying table structure changes.
- `%TYPE`: Assumes the exact data type of a specific column.
  ```plsql
  -- Example:
  current_f_last FACULTY.F_LAST%TYPE;
  ```
- `%ROWTYPE`: Assumes the data structure of an entire row in a table.
  ```plsql
  -- Example:
  faculty_row FACULTY%ROWTYPE;
  ```

### Assignment Statements and Comments
- **Assignment**: Use `:=` to assign a value to a variable.
  ```plsql
  variable2 := variable1 + 1;
  current_s_first_name := 'John';
  ```
- **Comments**:
  - Single line: `-- comment text`
  - Multi-line: `/* comment text */`

---

## 2. Executing PL/SQL and Output

To display output from PL/SQL blocks in SQL*Plus, you must enable the `DBMS_OUTPUT` package printing environment.

**Enabling Output:**
```sql
SET SERVEROUTPUT ON;
```

**Printing Text:**
Use the `DBMS_OUTPUT.PUT_LINE` procedure. You use the double pipe `||` to concatenate strings and variables.
```plsql
DECLARE
    todays_date DATE := SYSDATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Today''s date is ' || todays_date);
END;
/
```

---

## 3. Useful PL/SQL Functions

### Data Conversion Functions
- `TO_CHAR(date_or_number, format)`: Converts dates or numbers to character strings.
- `TO_DATE(char_string, format)`: Converts strings to DATE format.
- `TO_NUMBER(char_string)`: Converts strings containing numbers to NUMBER format.

### Manipulating Character Strings
- **Concatenation (`||`)**: `new_string := string1 || string2;`
- **Trim Spaces**: `LTRIM(string)` removes leading spaces; `RTRIM(string)` removes trailing spaces.
- **Length**: `LENGTH(string)` returns the integer character count.
- **Case Transformation**: `UPPER(string)`, `LOWER(string)`, `INITCAP(string)`.
- **Search (`INSTR`)**: Returns the starting position of a substring. Returns 0 if not found.
  ```plsql
  start_position := INSTR(original_string, 'substring_to_find');
  ```
- **Extract (`SUBSTR`)**: Extracts characters starting at a specific point for a specific length.
  ```plsql
  -- Extracts 3 characters starting from position 1
  extracted_string := SUBSTR(string_variable, 1, 3);
  ```

---

## 4. Debugging PL/SQL Programs

There are two main types of programming errors you will encounter:

1. **Syntax Error**: The code breaks the rules of the PL/SQL language (e.g., missing a semicolon `;` at the end of a line, misspelling `VARCHAR2`). Generates an immediate compiler/interpreter error.
2. **Logic Error**: The program compiles and runs without crashing, but it produces the *wrong result* (e.g., using a plus sign instead of a minus sign, or extracting the wrong substring indices).

---

## Review Questions

**Difficulty: Low**
1. What command must you run in an SQL*Plus session before `DBMS_OUTPUT.PUT_LINE` will actually display information on your screen?
2. Which section of a PL/SQL block is mandatory: `DECLARE`, `BEGIN`, or `EXCEPTION`?
3. What is the assignment operator in PL/SQL?

**Difficulty: Medium**
4. Write a variable declaration for a variable called `v_salary` that automatically inherits the data type of the `salary` column in the `employees` table.
5. In PL/SQL, what will `SUBSTR('DATABASE', 5, 4)` output?
6. Write a complete, brief PL/SQL block that declares a `VARCHAR2(50)` variable containing 'Hello World', and immediately prints it to the screen.

**Difficulty: High**
7. Discuss the architectural and maintenance benefits of using `%TYPE` and `%ROWTYPE` in PL/SQL instead of hardcoding types (like `VARCHAR2(30)`).
8. Determine if the following error is a Syntax Error or a Logic Error: You use `INSTR(full_name, ' ')` to separate a first name from a last name, but you mistakenly apply it to a string that contains a middle initial (e.g., 'John A Smith'), causing your `SUBSTR` logic to break. Why?
9. Predict the output of the following block (assuming server output is on):
```plsql
DECLARE
  v_word VARCHAR2(20) := '  Oracle  ';
BEGIN
  DBMS_OUTPUT.PUT_LINE(LENGTH(LTRIM(RTRIM(v_word))));
END;
```

---
*End of Practical 4 Summary*
