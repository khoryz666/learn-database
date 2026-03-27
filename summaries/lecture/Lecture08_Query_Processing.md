# Lecture 8: Query Processing and Optimization

This lecture covers the internal lifecycle of a database query. It explains exactly what a Database Management System (DBMS) does to transform a human-readable SQL statement into an optimal, machine-executable action plan.

---

## 1. The Four Phases of Query Processing

When a user submits an SQL query, the DBMS processes it through four distinct phases:

### Phase 1: Decomposition (Parsing and Validation)
- The DBMS checks if the query is **syntactically** correct (e.g., spelled `SELECT` right).
- It checks if the query is **semantically** correct (e.g., verifying that the columns requested actually exist in the tables, and that you aren't trying to perform math on a `VARCHAR` column).
- It breaks the high-level SQL down into internal **Relational Algebra**.

### Phase 2: Optimization
- The DBMS analyzes multiple different ways to execute the relational algebra and chooses the most efficient strategy.
- Optimization aims to minimize the usage of system resources (CPU, Memory, and most importantly, Disk I/O).

### Phase 3: Code Generation
- Based on the chosen optimized execution plan, the DBMS generates the actual low-level executable code (access routines) needed to pull the data from the hard drive. 

### Phase 4: Execution
- The runtime processor runs the generated code, pulls the data, and returns the results (or runtime errors) to the user.

---

## 2. Query Optimization Strategies

There are two primary approaches a modern DBMS uses to optimize a query during Phase 2.

1. **Cost-Based Optimization**: The DBMS mathematically calculates the estimated algorithmic cost (disk accesses needed) of several different execution plans and chooses the one with the lowest total cost.
2. **Heuristic Optimization**: The DBMS applies a strict set of rule-based transformations to rewrite the relational algebra into a more efficient shape, regardless of cost estimations.

### Representing Queries: Relational Algebra Trees (RAT)
To perform heuristic optimization, the DBMS maps the query into a **Relational Algebra Tree**.
- Leaf nodes at the bottom represent the raw base tables.
- The root node at the top represents the final result set.
- Data flows upward from the leaves to the root.

---

## 3. Heuristic Transformation Rules

The core objective of Heuristic Optimization is to **shrink the size of intermediate tables as early as possible** so that heavy operations (like Cartesian Products and Joins) process fewer rows.

The DBMS achieves this using mathematical Commutativity and Associativity rules:

1. **Perform Selections (Restrictions) as early as possible**: Move `WHERE` clause filters down the RAT as close to the leaf nodes as possible. Filter out unwanted rows *before* joining tables, not after.
2. **Apply the most restrictive Selection first**: If you have multiple filters, execute the one that eliminates the most rows first (e.g., executing an exact match `=` before a range query `<`).
3. **Perform Projections as early as possible**: Drop unnecessary columns early so they don't take up memory during later Join operations.
4. **Combine Cartesian Products with Selections**: Never perform a raw Cartesian Product if you can avoid it. Combine them immediately with their filter conditions to execute them efficiently as **Joins**.

---

## Review Questions

**Difficulty: Low**
1. List the four consecutive phases of Query Processing.
2. During the "Decomposition" phase, what is the difference between a "Syntax" check and a "Semantic" check?
3. In a Relational Algebra Tree, what do the lowest "leaf" nodes represent?

**Difficulty: Medium**
4. Contrast Cost-Based Optimization with Heuristic Optimization.
5. Why are Cartesian Products considered extremely dangerous to system performance if not properly optimized into Joins?
6. According to the heuristic rules of optimization, why should a Database Management System execute `Selection` operations as early as possible?

**Difficulty: High**
7. Assume Table A has 10,000 rows and Table B has 5,000 rows. You need to join them, but you only want results where `Table A.Status = 'Active'` (which applies to 100 rows). Explain the performance difference (in terms of rows processed) between performing the Join first *then* the Selection, versus performing the Selection first *then* the Join.
8. Describe the "Commutativity of Selection and Projection" heuristic rule. Provide an example of how swapping these two operations conceptually works in the query tree.
9. If an SQL query passes the Decomposition phase natively, what specific types of errors are still capable of being thrown during the Execution phase? Give one example.

---
*End of Lecture 8 Summary*
