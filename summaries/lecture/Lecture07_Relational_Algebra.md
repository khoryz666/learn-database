# Lecture 7: Relational Algebra

This lecture introduces Relational Algebra, the formal mathematical foundation underlying relational databases and SQL Data Manipulation Languages (DML). It shifts the focus from structural design to data retrieval logic.

---

## 1. Introduction to Relational Algebra

**Relational algebra** is a theoretical, procedural query language. It is not specifically user-friendly or implemented "as-is" in database terminals, but rather forms the underlying logic engine that processes SQL queries.

**Key Rule:** Both the operands (inputs) and the results (outputs) are *relations* (tables). Because the output is always a valid relation, operations can be infinitely chained together.

---

## 2. The Five Basic Operations

There are five fundamental operations from which all other database queries are built.

### 1. Selection ($\sigma$ : Sigma)
*Also known as Restriction.*
Extracts specific **rows** from a relation that meet a specific condition (predicate). It is essentially a horizontal filter.
- **Example**: Find all staff earning over 10,000.
- **Syntax**: $\sigma_{\text{salary} > 10000}(\text{Staff})$

### 2. Projection ($\Pi$ : Pi)
Extracts specific **columns** from a relation, discarding all other columns and instantly eliminating any duplicate rows in the final output. It is a vertical filter.
- **Example**: Show only the names and ID numbers of staff.
- **Syntax**: $\Pi_{\text{staffNo}, \text{fName}, \text{lName}}(\text{Staff})$

### 3. Union ($\cup$)
Combines all tuples (rows) from two relations into one single relation, automatically removing duplicates.
- **Constraint**: The two relations must be *union-compatible* (they must have the exact same number of columns with matching data types).
- **Example**: Find all cities that contain either a branch office OR a property for rent.
- **Syntax**: $\Pi_{\text{city}}(\text{Branch}) \cup \Pi_{\text{city}}(\text{PropertyForRent})$

### 4. Set Difference ($-$)
Produces a relation containing all the rows that exist in the *first* relation but perfectly exclude rows found in the *second* relation. 
- **Constraint**: Must be union-compatible.
- **Example**: Find all cities that contain a branch office but DO NOT contain any properties for rent.
- **Syntax**: $\Pi_{\text{city}}(\text{Branch}) - \Pi_{\text{city}}(\text{PropertyForRent})$

### 5. Cartesian Product ($\times$)
Takes two separate relations and combines *every single row* of the first relation with *every single row* of the second relation. If relation A has 10 rows and relation B has 10 rows, the Cartesian Product outputs 100 rows.
- **Syntax**: $\text{Client} \times \text{Viewing}$

---

## 3. Derived Operations

These operations are built by combining the 5 basic operations to make complex queries easier to write conceptually.

### 1. Intersection ($\cap$)
Produces a relation containing only the rows that exist in *both* relation A and relation B.
- Mathematically derived as: $R \cap S \equiv R - (R - S)$

### 2. The Join Operations ($\Join$)
A join is fundamentally a **Cartesian Product followed immediately by a Selection**.

- **Theta Join ($\theta$-join)**: Joins two tables on a specific condition using comparative operators ($<, >, =$).
- **Equijoin**: A specific type of Theta Join where the only operator used is strict equality ($=$).
- **Natural Join**: An Equijoin where the redundant matching column is deleted from the final output (e.g., if you join `Staff` and `Property` on `BranchNo`, `BranchNo` only appears once in the output).
- **Outer Join**: Standard joins only return rows where a match is found. Outer Joins return unmatched rows as well, padding the empty cells with `NULL`s. Can be *Left*, *Right*, or *Full*.
- **Semijoin ($\ltimes$)**: Computes the join, but only outputs columns belonging to the very first relation $R$.

### 3. Division ($\div$)
A complex mathematical operation used to answer "for all" queries.
- **Example**: Find the clients who have viewed *every single* 3-room property in the catalog.
- **Logic**: It divides the set of (Client + Property Viewed) by the set of (All 3-Room Properties). It returns only the Clients who match every permutation of the divisor.

---

## Review Questions

**Difficulty: Low**
1. Which basic Relational Algebra operation creates a "horizontal" subset by filtering rows based on a condition? What is its Greek symbol?
2. Which basic operation creates a "vertical" subset by selecting only specific columns?
3. If Relation A has 5 rows, and Relation B has 4 rows, exactly how many rows will be outputted by a raw Cartesian Product ($A \times B$)?

**Difficulty: Medium**
4. What does it mean for two relations to be "union-compatible"? Why is this necessary for the Set Difference operation?
5. Mathematically explain how a standard "Join" operation is derived from the 5 basic operations. (What two basic operations are executed to create a Join?)
6. Contrast an "Equijoin" with a "Natural Join". How does the physical output differ?

**Difficulty: High**
7. Write the Relational Algebra expression to answer the following: *List the First Name and Last Name of all Employees whose Salary is exactly $50,000*. (Assume the relation is named `Employee`).
8. Discuss the functional difference between an Inner Join and a Left Outer Join. In a database schema connecting `Students` to `Enrolled_Courses`, provide a business scenario where a registrar would specifically request a Left Outer Join rather than an Inner Join.
9. Using the basic Set Difference operation, explain how you would formulate an Intersection query ($A \cap B$) without natively using the Intersection symbol. Why does $A - (A - B)$ mathematically result in the intersection?

---
*End of Lecture 7 Summary*
