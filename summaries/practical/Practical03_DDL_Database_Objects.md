# Practical 3: Using DDL to Create Database Objects

This practical focuses on the Data Definition Language (DDL) commands used to create, modify, and manage essential database objects: Views, Sequences, Synonyms, and Indexes.

---

## 1. Database VIEWS

A View is a logical representation of subsets of data from one or more tables. It acts as a "virtual table".

### Creating and Dropping Views
```sql
-- Create a View
CREATE OR REPLACE VIEW view_name AS source_query;

-- Example
CREATE OR REPLACE VIEW faculty_view AS
SELECT f_id, f_last, f_first, f_mi, loc_id, f_phone, f_rank
FROM faculty;

-- Drop a View
DROP VIEW view_name;
```

### Updatable vs. Non-Updatable Views
Views can generally be used just like tables for `SELECT`, `INSERT`, `UPDATE`, and `DELETE`, provided they meet certain criteria:

**A view is UPDATABLE if:**
- The `SELECT` clause contains only fieldnames (no functions or calculations like `SUM()`).
- There are no `ORDER BY`, `DISTINCT`, or `GROUP BY` clauses, or set operators.
- The `FROM` clause involves a **single base table**, and the query contains a primary key/candidate key of the base relation.

**A view is NOT UPDATABLE if:**
- It involves multiple base tables (joins).
- It contains aggregate functions (e.g., `COUNT(*)`) or calculations (e.g., `price * qty`).

### Special View Options
**1. WITH CHECK OPTION**
Ensures that any `INSERT` or `UPDATE` performed through the view does not create rows that the view itself cannot select.
```sql
CREATE OR REPLACE VIEW location_view3 AS
SELECT * FROM location WHERE bldg_code = 'BUS'
WITH CHECK OPTION;
-- If you try to insert/update a row where bldg_code is 'CR', it will fail.
```

**2. WITH READ ONLY**
Prevents any DML (`INSERT`, `UPDATE`, `DELETE`) operations on the view entirely.
```sql
CREATE OR REPLACE VIEW location_view4 AS
SELECT * FROM location  
WITH READ ONLY;
```

---

## 2. Database SEQUENCES

Sequences are database objects that generate sequential lists of integers. They are primarily used to populate primary key columns automatically (surrogate keys).

### Generating a Sequence
```sql
CREATE SEQUENCE idseq
START WITH 20
MAXVALUE 9999
NOCYCLE;
```
*(Options like `INCREMENT BY`, `MINVALUE`, and `CACHE/NOCACHE` are also available.)*

### Using a Sequence
You extract numbers from a sequence using **Pseudocolumns**:
- `NEXTVAL`: Returns the next available number and advances the sequence.
- `CURRVAL`: Returns the current sequence number (the one last generated in your session). *You must call `NEXTVAL` before calling `CURRVAL` in a new session.*

**Example:**
```sql
INSERT INTO term VALUES (idseq.NEXTVAL, 'FALL 2012', 'CLOSED');
```

**Modifying a Sequence:**
You can alter properties (except `START WITH`).
```sql
ALTER SEQUENCE idseq INCREMENT BY 20 MAXVALUE 999999 NOCACHE NOCYCLE;
```

*Note on Gaps:* Sequence values can have gaps if a transaction rolls back, the system crashes, or the sequence is queried and incremented outside of an insert statement.

---

## 3. Database SYNONYMS

Synonyms provide an alternative, often shorter, name for objects. They are useful to simplify access, hide the original object name and owner, and shorten lengthy code.

### Creating and Dropping Synonyms
```sql
-- Create a synonym
CREATE SYNONYM loc FOR location;

-- Create a PUBLIC synonym (available to all users, requires DBA privilege usually)
CREATE PUBLIC SYNONYM loc_pub FOR location;

-- Drop a synonym
DROP SYNONYM loc;
DROP PUBLIC SYNONYM loc_pub;
```

---

## 4. Database INDEXES

An Index is a database object similar to an index in a book; it is used to speed up data retrieval searches. It uses a `ROWID` column internally to represent the physical location of the record.

- The database automatically creates an index for columns defined as `PRIMARY KEY` or `UNIQUE` constraints.
- While indexes speed up `SELECT` statements, they slow down DML statements (`INSERT`, `UPDATE`, `DELETE`) because the index must also be updated.

### Creating an Index
```sql
-- Single-column index
CREATE INDEX index_name ON tablename(column_name);

-- Example:
CREATE INDEX course_section_max_enrl ON course_section(max_enrl);
```

### Composite Index
Contains multiple sorted columns (up to 16). Useful for queries that frequently filter or join on those specific columns together.
```sql
CREATE INDEX consultant_skill_idx ON consultant_skill(skill_id, certification);
```

### Dropping an Index
```sql
DROP INDEX course_section_max_enrl;
```

### When to Use vs. Not Use Indexes

**USE an index when:**
- The table is large (> 100,000 records).
- The column has a wide range of values (high cardinality).
- Most queries will retrieve less than 2% to 4% of the table's rows.
- The column is frequently used in `WHERE` clauses or joins.

**DO NOT USE an index when:**
- The table is small.
- Queries typically retrieve a large percentage of the table's records (e.g., retrieving 50% of the table).
- The table undergoes frequent `INSERT`, `UPDATE`, or `DELETE` operations.

---

## Review Questions

**Difficulty: Low**
1. What pseudocolumn is used to draw the next available number from an Oracle sequence?
2. What happens automatically when you create a `PRIMARY KEY` constraint on a table regarding indexing?
3. True or False: You can use an `ORDER BY` clause when creating an updatable view.

**Difficulty: Medium**
4. Describe the difference between a view created `WITH CHECK OPTION` and a view created `WITH READ ONLY`.
5. Write the SQL DDL statement to create a sequence named `emp_seq` that starts at 50, increments by 5, and stops generating numbers at 1000 without cycling.
6. A view named `sales_summary_v` was created containing a `GROUP BY` clause. Why will an `INSERT` statement against this view fail?

**Difficulty: High**
7. You are experiencing performance issues with a large `orders` table. You notice that users frequently search for orders placed by a specific customer (`customer_id`) on a specific date (`order_date`). Write the DDL to create an appropriate index to optimize these specific searches. What kind of index is this?
8. Explain three scenarios where gaps might appear in the numbers generated by a database sequence. Is guaranteed sequential numbering without gaps possible using just sequences?
9. A developer runs `ALTER SEQUENCE emp_seq START WITH 1;` but receives an error. Explain why this command fails and what the developer must do to reset the sequence to 1.

---
*End of Practical 3 Summary*
