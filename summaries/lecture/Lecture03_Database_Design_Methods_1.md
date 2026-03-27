# Lecture 3: Database Design Methodology (Part 1)

This lecture introduces the formal procedures for designing a database from scratch, positioning database design within the broader Information Systems Development Lifecycle. It focuses primarily on mapping a Conceptual Data Model (ERD) into a Logical Data Model (Relational Schema).

---

## 1. Information Systems Development Lifecycle

Database design isn't done in a vacuum; it is part of a larger systems development process containing several phases:

1. **Database Planning**: Defining the mission statement, objectives, and required resources.
2. **Requirements Collection and Analysis**: Understanding what data is used and how the enterprise operates.
3. **DBMS Selection (Optional)**: Choosing the right software (e.g., Oracle vs. MySQL) based on criteria.
4. **Application Design**: Designing the UI and application programs that interact with the database.
5. **Prototyping**: Building *Horizontal* (many visual features, non-working) or *Vertical* (few features, fully working) prototypes for user testing.
6. **Implementation**: The actual programming and physical realization of the database.
7. **Data Conversion and Loading**: Transferring existing data from old legacy systems to the new one.
8. **Testing**: Aimed strictly at finding errors, not proving the software is perfect.
9. **Operational Maintenance**: Monitoring performance and tuning/upgrading as needed over time.

---

## 2. The Three Phases of Database Design

The actual database design process is split into three highly distinct phases:

1. **Conceptual Database Design**: Creating a model (typically an ERD) that is completely independent of all physical considerations and any specific DBMS. It focuses purely on business requirements.
2. **Logical Database Design**: Translating the conceptual model into a specific data model (like the Relational Model). It is still independent of the target DBMS software (e.g., it outlines tables and foreign keys, but not specific SQL `VARCHAR2` constraints).
3. **Physical Database Design**: Describing the actual implementation on physical storage using SQL. This involves defining base relations, file organizations, and indexes specific to a chosen DBMS (like Oracle).

---

## 3. Creating the Logical Data Model (Deriving Relations)

The core technical aspect of this lecture is **Step 2.1**: Translating the structures inside your Conceptual Model (ERD) into standard Relational tables (Logical Model). 

There are strict, predictable rules for deriving relations based on the type of entity or relationship:

### 1. Strong vs Weak Entities
- **Strong Entity**: Create a relation (table) containing all simple attributes. Provide it a standard Primary Key.
- **Weak Entity**: Create a relation. Its Primary Key will be partially or fully derived from the primary key of its *owner* entity.

### 2. One-to-Many (1:\*) Binary Relationships
- The entity on the "One" side is the **Parent**.
- The entity on the "Many" side is the **Child**.
- *Rule:* Take a copy of the Parent's Primary Key and post it into the Child's relation to act as a **Foreign Key**.

### 3. One-to-One (1:1) Binary Relationships
Handling 1:1 relationships requires looking closely at *Participation Constraints* (Mandatory vs. Optional).

- **(a) Mandatory on BOTH sides**: Combine both entities into a single relation. Choose one specific Primary Key, make the other an Alternate Key.
- **(b) Mandatory on ONE side**: The entity with *Optional* participation becomes the **Parent**. The entity with *Mandatory* participation becomes the **Child**. Post the Parent's Primary Key into the Child as a Foreign Key.
- **(c) Optional on BOTH sides**: Designation is essentially arbitrary based on business context. Whichever entity feels closer to being mandatory is designated as the Parent.

### 4. Many-to-Many (\*:\*) Binary Relationships
- You cannot handle this simply by posting foreign keys.
- *Rule:* You must create a **Brand New Relation** (table) solely to represent the relationship. 
- Post a copy of the Primary Keys from both participating entities into this new relation. These two Foreign Keys combine to form a **Composite Primary Key** for the new table.

### 5. Multi-Valued Attributes
- A single cell in a relational database cannot hold multiple values.
- *Rule:* Create a **New Relation** to represent the multi-valued attribute. Post the Primary Key of the original entity into this new table as a Foreign Key. Combine this Foreign Key with the attribute itself to form a new Composite Primary Key.

---

## Review Questions

**Difficulty: Low**
1. Name the three distinct phases of Database Design. Which phase is the first to actually implement physical SQL statements?
2. In the Systems Development Lifecycle, what is the core purpose of the "Testing" phase?
3. When mapping a simple One-to-Many (`1:*`) relationship, into which table do you place the Foreign Key?

**Difficulty: Medium**
4. Contrast a *Horizontal Prototype* with a *Vertical Prototype* during the application development phase.
5. You have a `1:1` relationship between `Employee` and `CompanyCar`. Every company car *must* be assigned to an employee (mandatory), but not every employee gets a company car (optional). According to logical mapping rules, which entity is the Parent, and where does the Foreign Key go?
6. Explain why a Many-to-Many (`*:*`) relationship mathematically requires the creation of a brand new, third "linking" table, rather than simply placing foreign keys in the existing tables.

**Difficulty: High**
7. Discuss the philosophical necessity of separating the "Conceptual Database Design" from the "Logical Database Design". Why not skip straight to assigning tables and foreign keys based on business interviews?
8. Assume you have a `Student` entity with a multi-valued attribute called `Phone_Numbers`. Based on the derivation rules, describe exactly the schema of the new relation you must create to handle these multiple numbers, including explicitly defining its Primary Key.
9. If two entities have a `1:1` relationship and *both* have Mandatory participation, the derivation rule states you should combine them into a single relation. What are the potential data redundancy or structural drawbacks of this rule if one entity has 50 unique attributes and the other has only 2?

---
*End of Lecture 3 Summary*
