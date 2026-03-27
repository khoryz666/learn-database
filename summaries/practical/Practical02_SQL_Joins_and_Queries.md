# Practical 2: Using SQL Queries to Join and View Data

This practical covers the vital concepts and syntax required to retrieve data from multiple tables simultaneously using Joins, Subqueries (nested queries), and Set Operators. It focuses on both standard SQL:1999 syntax and Oracle's proprietary syntax.

---

## 1. Joining Multiple Tables

A **Join** is used to combine columns from one or more tables based on the values of the common columns between related tables.

### Ambiguous Column Names
When joining tables, if both tables share a column name, you must **qualify** the column name with the table name or a **table alias** (e.g., `e.department_id` instead of just `department_id`).

### A. Inner Joins (Equijoins)
Inner joins return only the rows that have matching values in both tables.

**1. `NATURAL JOIN` (SQL:1999)**
Automatically joins tables based on *all* columns with the same name and data type in both tables.
```sql
SELECT l.city, d.department_name
FROM locations l NATURAL JOIN departments d;
```

**2. `JOIN ... USING` (SQL:1999)**
Used when columns have the same name but you only want to join on specific ones.
*Important Setup Note: Do NOT use a table alias or prefix on the column specified in the `USING` clause.*
```sql
SELECT l.city, d.department_name
FROM locations l JOIN departments d USING (location_id);
```

**3. `JOIN ... ON` (SQL:1999)**
Allows you to specify exactly which columns to join. It is the most flexible approach and makes code easy to understand.
```sql
SELECT e.last_name, d.department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id;
```
*Oracle Proprietary Syntax Equivalent:*
```sql
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
```

### B. Self Joins
A Self Join is joining a table to itself. This is useful for hierarchical data (e.g., finding an employee's manager in an `employees` table).
```sql
SELECT worker.last_name AS emp, manager.last_name AS mgr
FROM employees worker JOIN employees manager 
ON (worker.manager_id = manager.employee_id);
```
*(Note: You cannot use `USING` for a self join because the joining columns have different names.)*

### C. Nonequijoins
A join condition containing an operator other than equality (`=`), such as `BETWEEN`.
```sql
SELECT e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j 
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;
```

### D. Outer Joins
Outer joins return the matched rows from an inner join, *plus* the unmatched rows from one or both tables.

**1. Left Outer Join** (Returns all rows from the Left table, even if there are no matches in the Right table)
```sql
-- SQL:1999
SELECT e.last_name, d.department_name
FROM employees e LEFT OUTER JOIN departments d ON (e.department_id = d.department_id);

-- Oracle Proprietary (Put the (+) on the side that lacks data)
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);
```

**2. Right Outer Join** (Returns all rows from the Right table)
```sql
-- SQL:1999
SELECT e.last_name, d.department_name
FROM employees e RIGHT OUTER JOIN departments d ON (e.department_id = d.department_id);

-- Oracle Proprietary
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;
```

**3. Full Outer Join** (Returns all rows from both tables, matched and unmatched)
```sql
-- SQL:1999
SELECT e.last_name, d.department_name
FROM employees e FULL OUTER JOIN departments d ON (e.department_id = d.department_id);
```

### E. Cross Joins (Cartesian Products)
Returns the Cartesian product of rows from tables in the join (every row in the first table is joined to every row in the second table). Occurs when a join condition is omitted or invalid.
```sql
-- SQL:1999
SELECT last_name, department_name FROM employees CROSS JOIN departments;

-- Oracle Proprietary
SELECT last_name, department_name FROM employees, departments;
```

---

## 2. Nested Queries (Subqueries)

An inner query (or subquery) returns a value that is used by the outer query.

**Guidelines:**
- Enclose subqueries in parentheses `()`.
- Place subqueries on the right side of the comparison condition.
- Use single-row operators (`=`, `>`, `<`) with single-row subqueries.
- Use multiple-row operators (`IN`, `ANY`, `ALL`) with multiple-row subqueries.

**Example: Subquery using `IN`**
Retrieve students who have been enrolled in the same course section as 'Amanda Mobley'.
```sql
SELECT DISTINCT s_last, s_first
FROM student JOIN enrollment ON student.s_id = enrollment.s_id
WHERE c_sec_id IN (
    SELECT c_sec_id
    FROM student JOIN enrollment ON student.s_id = enrollment.s_id
    WHERE s_last = 'Mobley' AND s_first = 'Amanda'
);
```

---

## 3. Set Operators

Set operators combine the results of two or more independent `SELECT` statements into a single result set.

1. **UNION**: Combines results horizontally and **suppresses duplicate values**.
2. **UNION ALL**: Combines results horizontally and **includes duplicate values**.
3. **INTERSECT**: Returns only the rows that exist in **both** query results (the overlap).
4. **MINUS**: Returns the distinct rows present in the first query but **absent** from the second query.

**Example: INTERSECT**
Return names of consultants who worked on project ID 5 AND have expertise with skill ID 1.
```sql
SELECT c_last FROM consultant JOIN project_consultant USING (c_id) WHERE p_id = 5
INTERSECT
SELECT c_last FROM consultant JOIN consultant_skill USING (c_id) WHERE skill_id = 1;
```

**Example: MINUS**
Return faculty who taught in 'BUS' building, but whose offices are NOT in 'BUS'.
```sql
SELECT f_first, f_last FROM faculty JOIN course_section USING (f_id) JOIN location ON course_section.loc_id = location.loc_id WHERE bldg_code = 'BUS'
MINUS
SELECT f_first, f_last FROM faculty JOIN location USING (loc_id) WHERE bldg_code = 'BUS';
```

---

## Review Questions

**Difficulty: Low**
1. What is the fundamental difference between an `INNER JOIN` and a `LEFT OUTER JOIN`?
2. When creating a `JOIN ... USING` statement, can you prefix the specified column with a table alias? Why or why not?
3. Which set operator would you use if you wanted to combine two query results, but maintain all duplicate records?

**Difficulty: Medium**
4. Write an SQL statement using Oracle Proprietary Syntax (with the `(+)` operator) to perform a **Right Outer Join** between `Projects (p)` and `Employees (e)`, matching on `dept_id`. Assume you want all Projects, even ones without Employees.
5. In your own words, describe what happens if you forget to include a `WHERE` or `ON` join condition when joining two tables containing 10 rows and 5 rows, respectively. What is the result called, and how many rows will be returned?
6. Write a subquery to find all employees whose salary is greater than the average salary of all employees in the company.

**Difficulty: High**
7. You are tasked with finding customers who have made purchases in Category A, but have *never* made a purchase in Category B. Explain how you would structure this query using set operators (`UNION`, `INTERSECT`, `MINUS`).
8. Why can't a `NATURAL JOIN` or `JOIN ... USING` be utilized effectively when performing a Self Join? What syntax must be used instead?
9. When utilizing a multiple-row subquery, under what circumstances would you use the `> ANY` operator versus the `> ALL` operator? Provide a practical business scenario for both.

---
*End of Practical 2 Summary*
