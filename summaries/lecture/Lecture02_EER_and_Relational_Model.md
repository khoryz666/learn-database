# Lecture 2: Data Modelling and Design (Part 2)

This lecture extends the foundational conceptual models from Lecture 1 by introducing the Enhanced Entity Relationship (EER) Model and the logical Relational Database Model.

---

## 1. Enhanced Entity Relationship (EER) Modelling

As data structures become more complex, the basic ER model isn't always sufficient. EER extends the ER model by introducing **Supertypes** and **Subtypes** (also known as Superclasses and Subclasses).

### Why use Supertypes and Subtypes?
Consider an aviation business employing Pilots, Mechanics, and Accountants. 
- If we store all possible characteristics in one massive `EMPLOYEE` entity, non-pilots will have many `NULL` values for fields like `Flight_Hours` or `License_Type`.
- **Entity Supertype**: A generic entity type (`EMPLOYEE`) holding common characteristics (Name, Hire Date).
- **Entity Subtype**: Specialized entity types (`PILOT`, `MECHANIC`) holding attributes unique to that subtype.
- Using this hierarchy avoids unnecessary `NULL`s and allows specific subtypes to participate in unique relationships (e.g., only a `PILOT` can "fly" an airplane).

### Inheritence and Processes
- **Inheritance**: Subtypes automatically inherit all attributes and relationships of their supertype, including the Primary Key.
- **Specialization (Top-Down)**: Identifying a set of subtypes belonging to a supertype.
- **Generalization (Bottom-Up)**: Identifying a generic supertype from a group of existing entity subtypes (e.g., combining Car, Truck, and Motorcycle into a generic "Vehicle" supertype).

### Constraints in EER Hierarchies
A **Subtype Discriminator** is an attribute in the supertype that determines which subtype a specific record belongs to (e.g., an `Employee_Type` column).

1. **Disjoint vs. Overlapping constraints:**
   - **Disjoint Subtypes (`d`)**: An instance of a supertype can belong to *only one* subtype. (e.g., An employee is exclusively either Hourly or Salaried).
   - **Overlapping Subtypes (`o`)**: An instance can belong to *multiple* subtypes simultaneously. (e.g., A university person can be both an Employee and a Student).
2. **Completeness Constraints:**
   - **Partial Completeness**: A supertype *does not have to* belong to any subtype.
   - **Total Completeness**: Every supertype occurrence *must* be a member of at least one subtype.

---

## 2. The Relational Model

Proposed by E.F. Codd in 1970, this is the logical foundation of almost all modern RDBMS. Data is logically structured into relations (tables).

### Terminology Mapping
- **Relation** $=$ Table
- **Tuple** $=$ Row (Record)
- **Attribute** $=$ Column (Field)
- **Domain** $=$ The set of allowable values for an attribute.
- **Degree** $=$ The number of attributes (columns) in a relation.
- **Cardinality** $=$ The number of tuples (rows) in a relation.

**Properties of Relations:**
- Every relation has a distinct name.
- Every cell contains exactly one atomic (single) value.
- There are no duplicate tuples (rows must be distinct).
- The order of attributes or tuples has no significance.

### Relational Schema vs Database Schema
- **Relation schema**: The definition of a single table structure (columns and domains).
- **Relational database schema**: The complete set of relation schemas that make up the whole database.

---

## 3. Relational Keys

Keys are crucial for navigating relationships and ensuring data uniqueness.

- **Superkey**: Any set of attributes that uniquely identifies a row. (Could contain unnecessary columns).
- **Candidate Key**: A *minimal* superkey. Removing any column from a Candidate Key destroys its uniqueness.
- **Primary Key**: The specific Candidate Key chosen by the designer to identify rows. Cannot be NULL.
- **Alternate Key**: Any Candidate Keys that were *not* chosen as the Primary Key.
- **Foreign Key**: An attribute in one table that matches the Candidate Key (usually Primary Key) in another table. This enforces the relationship.
- **Composite Key**: A unique key created by combining two or more attributes.
- **Surrogate Key**: An artificial, system-generated, numeric primary key used when no natural primary key exists.

---

## 4. Database Constraints

Constraints are rules restricting data values to ensure accuracy.

### Integrity Constraints
1. **Entity Integrity**: No attribute of a primary key can be `NULL`. All Primary keys must be unique.
2. **Referential Integrity**: A Foreign Key value must either match a valid, existing Candidate Key value in its home table, or it must be completely `NULL`.
   - *Enforcing Referential Integrity*: If a parent record is deleted or updated, the system can respond via `Cascade Delete/Update` (automatically change child records), `Restrict/No Action` (prevent the deletion), or `Set Null`.

### Meaning of NULL
`NULL` represents an unknown, inapplicable, or exceptional value. It is the absolute *absence* of a value. It is fundamentally different from a zero `0` or an empty space string `" "`, which are actual, calculable values.

---

## 5. Views

- **Base Relation**: A physical table whose tuples are stored on the disk.
- **View**: A virtual table produced dynamically by operations on base relations. 
  - **Advantages**: Provides data independence, customized presentation for different users, and enhanced security (by hiding specific columns/rows).
  - **Disadvantages**: Performance overhead to generate dynamically, and strict limitations on whether you can perform `UPDATE` Operations against them.

---

## Review Questions

**Difficulty: Low**
1. In EER modelling, what does it mean for a subtype to "inherit" from a supertype?
2. What is the mathematical term used in the Relational Model to describe a "Row" of data?
3. State the rule of Entity Integrity regarding Primary Keys.

**Difficulty: Medium**
4. Contrast a Disjoint constraint with an Overlapping constraint in EER modelling. Give a real-world example of an Overlapping constraint.
5. In your own words, explain the difference between a Superkey and a Candidate Key. Why is every Candidate Key a Superkey, but not every Superkey a Candidate Key?
6. Describe a situation where a database designer might choose to implement a Surrogate Key.

**Difficulty: High**
7. Discuss the implications of enforcing Referential Integrity. If a university database has a `Course` table linked to an `Enrollment` table, explain what happens functionally when an administrator deletes a Course using "Restrict" versus "Cascade Delete". Which is safer for historical records?
8. Why does the Relational Model stipulate that the "order of tuples and attributes has no significance"? How does this philosophical design choice differentiate a database Relation from a standard spreadsheet?
9. Explain the concept of `NULL`. If an employee's middle initial field is set to `NULL`, how does the database interpret this compared to if the field contained an empty string `""`?

---
*End of Lecture 2 Summary*
