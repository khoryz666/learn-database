# Lecture 1: Introduction to Data Modelling and Design

This lecture introduces fundamental database concepts, underlying architectures, and the beginnings of Data Modelling using the Entity-Relationship (ER) Model. The focus here is on conceptual understanding rather than code syntax.

---

## 1. Database Concepts

It is important to understand the hierarchy of information processing:
- **Data**: Raw material or facts (e.g., a list of dates).
- **Information**: Processed, organized data that is meaningful to an audience.
- **Knowledge**: Understanding what information is required and what it means in context.

### The Problem with File-Based Systems
Before databases, data was often stored in disparate computer files. This led to:
- Data separation, isolation, and duplication.
- Data dependence (programs were tightly coupled to how data was physically stored).
- Incompatible file formats.

### What is a Database and DBMS?
- **Database**: A shared, persistent collection of logically related data, designed to meet the information needs of an organization. It includes *Metadata* (data about data).
- **DBMS (Database Management System)**: A software system that enables users to define, create, maintain, and control access to the database (e.g., Oracle, MySQL).

**DBMS Advantages & Disadvantages:**
- **Pros**: Controls redundancy, improves data consistency/integrity, enhances security, enables data sharing, and allows economy of scale.
- **Cons**: High complexity, large hardware/software footprint, expensive setup/conversion costs, and a centralized point of failure.

### Roles in a Database Environment
1. **DBA / Data Administrator**: Manages the technical implementation vs. high-level planning.
2. **Database Designers**: 
   - *Logical*: Focuses on identifying data, relationships, and constraints.
   - *Physical*: Focuses on how the logical design is physically stored.
3. **Application Developers**: Build programs interacting with the database.
4. **End-Users**: Naïve (unfamiliar with DBMS) vs. Sophisticated (familiar with DBMS tools).

---

## 2. Three-Level ANSI-SPARC Architecture

To ensure data independence—so changes to physical storage don't break applications—the database architecture is divided into three distinct levels:

1. **External Level**: The user's specific view of the database. Only shows relevant data.
2. **Conceptual Level**: The community view. Describes *what* data is stored globally and the logical relationships.
3. **Internal Level**: The physical representation on the computer. Describes exactly *how* the data is stored on disk.

*Note on Schemas vs Instance:* The **Schema** is the static description/blueprint of the database, while the **Instance** is the actual data present at a specific moment in time.

### Database Languages
- **DDL (*Data Definition Language*)**: Used to define and modify the database schema (e.g., creating tables).
- **DML (*Data Manipulation Language*)**: Used to process data (insert, update, delete). Can be procedural (tells the system *how* to get data) or non-procedural (tells the system *what* data gets retrieved).

---

## 3. Database Architectures

Databases run on various architectural models depending on organizational needs.

1. **Teleprocessing (1970s)**: A single massive mainframe handles everything; users connect via "dumb terminals."
2. **File-Server (1980s)**: A central file server holds the database files, but the DBMS software runs on each individual client workstation. This causes heavy network traffic.
3. **Client-Server (Two-Tier)**: 
   - **Client**: Handles the User Interface and business logic.
   - **Server**: Handles data storage and database management logic.
4. **Three-Tier Architecture**: Adds a middle layer. 
   - Client (UI) $\rightarrow$ Application Server (Business Logic) $\rightarrow$ Database Server (Storage).
5. **Distributed DBMS**: A logically interrelated database physically distributed over a network, managed seamlessly as if it were a single database.
6. **Data Warehouse**: A consolidated, historic view of corporate data drawn from various operational sources, designed specifically for complex query analysis and decision making (not for daily transaction processing).

---

## 4. Entity-Relationship (ER) Model

Conceptual Modeling maps out the data requirements independent of any specific DBMS software. The ER Model is a top-down approach representing:
- **Entities**: Important objects or concepts (e.g., `Student`, `Course`).
- **Attributes**: Properties of those entities (e.g., `student_id`, `name`).
- **Relationships**: How entities interact with each other (e.g., a Student *enrolls in* a Course).

**Notation Standard:** 
In course evaluations (quizzes, exams), **Crow's Foot Notation** is the expected standard for drawing ER diagrams. (It uses symbols resembling crow's feet to represent "many" relationships).

---

## Review Questions

**Difficulty: Low**
1. What is the fundamental difference between Data and Information?
2. Define "Metadata" in the context of a database.
3. Name the three levels of the ANSI-SPARC Database Architecture.

**Difficulty: Medium**
4. Contrast the role of a Logical Database Designer with that of a Physical Database Designer.
5. What is the primary problem with a "File-Server" architecture (from the 1980s) compared to a true "Client-Server" architecture regarding network traffic?
6. Provide an example of an operation that would be executed using DDL versus an operation executed using DML.

**Difficulty: High**
7. Discuss the concept of "Data Independence" provided by the three-level ANSI-SPARC architecture. Why is it crucial that the External level is separated from the Internal level?
8. Explain the difference between a Distributed DBMS and Distributed Processing. If a company has a centralized database in New York, but users in London access it over the internet to run reports, is this a Distributed DBMS? Why or why not?
9. A Data Warehouse is described as being "subject-oriented, integrated, time-variant, and nonvolatile." Based on these characteristics, why would you *not* use a Data Warehouse to process live, second-by-second ATM withdrawal transactions?

---
*End of Lecture 1 Summary*
