# Lecture 4: Database Design Methodology (Part 2)

This lecture transitions from the logical model into Physical Database Design considerations and dives deeply into the critical process of Data Normalization (and intentionally reverting it via De-Normalization).

---

## 1. Physical Database Design

While Logical Design (Lecture 3) asks *what* we are storing, Physical Design focuses on *how* to construct it practically in the target DBMS.

Key steps include:
- **Designing Derived Data**: Decide whether a derived attribute (e.g., `TotalAmount` = `Quantity * Price`) should be physically stored in the database to save calculation time, or mathematically generated on the fly every time it's queried to save disk space.
- **Designing File Organizations & Indexes**: Based on transaction analysis (understanding peak loads, frequent queries), DBAs choose how data is structurally saved on the disk (e.g., Heap, Hash, B+-Tree). They also add **Indexes** (pointers mapping to data, like a book index) to drastically speed up retrieval times.
- **Monitoring Operational Systems**: Measuring performance via *Transaction Throughput*, *Response Time*, and *Disk Storage*.

---

## 2. Advanced Normalization

Normalization is the technique of structuring tables to contain minimal redundancy. This prevents inconsistencies and structural "Anomalies". 

### Why Normalize? (The Three Anomalies)
If multiple distinct themes (e.g., Customer Data AND Order Data) are shoved into a single table, it causes:
1. **Insertion Anomaly**: You cannot insert new data about a product without also entering dummy customer data.
2. **Update Anomaly**: If a product's price changes, you have to find and sequentially update hundreds of separate order rows. 
3. **Deletion Anomaly**: If you delete the only order for a specific product, you unintentionally wipe out the entire product's record (name, finish, price) from the database entirely.

*Solution: Split the table! Separate themes into separate tables.*

### Defining Functional Dependencies
- **Functional Dependency ($A \rightarrow B$)**: If I know the value of $A$ (the *determinant*), I know exactly what the value of $B$ is. (e.g., `StudentID` $\rightarrow$ `StudentName`).
- **Full Functional Dependency**: The attribute depends on the *entire* Primary Key, not just a piece of it.
- **Partial Dependency**: An attribute depends on only a part of a composite primary key.
- **Transitive Dependency**: A non-key attribute conditionally determines another non-key attribute ($A \rightarrow B$ and $B \rightarrow C$).

### The Normal Forms (The Steps of Normalization)

Data is progressively refined through stages known as "Normal Forms":

1. **Unnormalized Form (UNF)**: Raw data containing repeating groups or arrays in a single cell.
2. **First Normal Form (1NF)**: Every row/column intersection contains exactly *one single, atomic value*. No multi-valued attributes are allowed.
3. **Second Normal Form (2NF)**: The table is in 1NF, and there are **no partial dependencies**. (Every non-key attribute is determined by the *whole* primary key). 
4. **Third Normal Form (3NF)**: The table is in 2NF, and there are **no transitive dependencies**. (Non-key columns cannot depend on other non-key columns).
5. **Boyce-Codd Normal Form (BCNF)**: A stricter version of 3NF. *Every determinant must be a candidate key.* (Solves edge cases involving overlapping composite keys).
6. **Fourth Normal Form (4NF)**: The table is in BCNF and contains no multi-valued dependencies.

---

## 3. De-Normalization

**De-Normalization** is the deliberate, controlled introduction of data redundancy into a previously normalized database structure.

**Why intentionally reverse normalization?**
- Highly normalized databases require complex, processor-heavy `JOIN` operations across many tables to view complete reports. 
- *Advantages*: De-normalization reduces the number of joins required and speeds up read/retrieval times significantly.
- *Disadvantages*: Slower `UPDATE` operations (because data is duplicated across places), requires more disk storage, and sacrifices structural flexibility.

---

## Review Questions

**Difficulty: Low**
1. Under physical database design, what is an "Index" and what is its primary purpose?
2. Define what a Functional Dependency is using your own words.
3. If a table contains multiple comma-separated values inside a single column cell, which Normal Form rule is it currently violating?

**Difficulty: Medium**
4. Contrast an Insertion Anomaly with a Deletion Anomaly using a hypothetical table tracking `Authors` and `Books`.
5. What specific type of dependency must be eliminated to move a table from 2NF to 3NF? Give a brief real-world example of this dependency.
6. What is the fundamental difference between standard 3NF and Boyce-Codd Normal Form (BCNF)?

**Difficulty: High**
7. Discuss the architectural trade-offs between Normalization and De-Normalization. If you were building an OLTP (Online Transaction Processing) system for a high-volume retail website where millions of users are writing data simultaneously, would you prefer a highly normalized or de-normalized schema? Justify your choice.
8. Assume a relation `Enrollment (StudentID, CourseID, ProfessorName)`. Every student enrolls in a course. Every course has only one professor. Therefore, `StudentID` and `CourseID` form the composite primary key. However, if you know the `CourseID`, you instantly know the `ProfessorName`. Is this relation in 2NF? Why or why not? What form of dependency is this?
9. When creating the Physical Design, explain why an architect might choose *not* to store a "derived attribute" (like an employee's total years of service based on their hire date) as an actual column in the database, even though it is requested by HR reports frequently. What are the pros and cons?

---
*End of Lecture 4 Summary*
