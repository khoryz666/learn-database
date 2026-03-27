# Lecture 9: Distributed DBMS (DDBMS)

This lecture moves away from single-server architectures to explore Distributed Database Management Systems (DDBMS), where data is physically scattered across multiple computer networks but logically appears as one single database to the end-user.

---

## 1. DDBMS Concepts and Architectures

A **Distributed Database** is a collection of logically-interrelated shared data physically distributed over a computer network. A **DDBMS** is the software that manages this data and makes the physical distribution entirely transparent (invisible) to the user.

### Homogeneous vs Heterogeneous
- **Homogeneous DDBMS**: Every site runs the exact same DBMS software (e.g., all Oracle). Easy to design and manage.
- **Heterogeneous DDBMS**: Sites run entirely different DBMS products (e.g., Oracle, MySQL, SQL Server) on potentially different hardware OS. This requires "Gateways" to translate languages and protocols between the differing nodes.

### Parallel DBMS
Distinct from a distributed database, a Parallel DBMS links multiple smaller processors and hard disks tightly together (usually in the same server rack) to process a single query in parallel. Architectures include:
- Shared Memory
- Shared Disk
- Shared Nothing

---

## 2. Distributed Database Design

When architecting a DDBMS, data doesn't just sit in one block; it must be broken apart and placed strategically on the network to maximize performance and availability. This is handled via three concepts:

### A. Fragmentation
Breaking a single relation into smaller sub-relations. Why fragment? So data is stored physically closer to the users who need it most, and sensitive data isn't broadcast to sites that don't need it.
- **Horizontal Fragmentation**: Grouping *rows* using the Relational Algebra *Selection* operation. (e.g., All "London" staff rows to the UK server, all "New York" staff rows to the US server).
- **Vertical Fragmentation**: Grouping *columns* using the Relational Algebra *Projection* operation. (e.g., Only the "Salary" column is stored on the HR server).
- **Correctness Rules**: Any valid fragmentation must ensure:
  1. *Completeness*: No data is lost in the split.
  2. *Reconstruction*: You must be able to mathematically re-combine the fragments.
  3. *Disjointness*: Data shouldn't be awkwardly duplicated (except for Primary Keys in Vertical fragmentation).

### B. Allocation (Distribution)
Deciding the strategy for where to place the data chunks:
- **Centralized**: All data stays on one single server.
- **Partitioned**: Each fragment is assigned exclusively to one specific site.
- **Complete Replication**: A full, entire copy of the database is maintained on *every single server* on the network. Excellent for reading speed and reliability, terrible for update speeds.

---

## 3. Transparencies in a DDBMS

The golden rule of a DDBMS is that users should never know it is distributed. The system must provide several "Transparencies":

### 1. Distribution Transparency
Users should be totally unaware of where data is physically located or how it is fragmented. 
- *Location Transparency*: The user queries a table without needing to write `FROM TableX AT SITE 3`.

### 2. Transaction Transparency
If a global transaction updates data across 3 separate servers in different countries, it must be subdivided into 3 local "subtransactions". 
- *Failure Transparency*: The DDBMS must guarantee Atomicity across the network. If Server 1 and Server 2 commit their subtransactions, but Server 3's network crashes, the DDBMS must automatically force Server 1 and Server 2 to roll back their data so the global database remains consistent.

### 3. Performance Transparency
The Distributed Query Processor (DQP) must automatically analyze network speeds and dynamically decide the cheapest, fastest server node to execute a query on to avoid dragging heavy data across slow Wide Area Networks (WAN).

---

## Review Questions

**Difficulty: Low**
1. Define the primary goal of a Distributed DBMS (DDBMS) from the perspective of an end-user running an application.
2. What is the fundamental difference between a Homogeneous DDBMS and a Heterogeneous DDBMS?
3. Which Relational Algebra operation is fundamentally used to create a Vertical Fragment?

**Difficulty: Medium**
4. Briefly explain the three "Correctness of Fragmentation" rules (Completeness, Reconstruction, Disjointness).
5. If a multinational corporation implements "Complete Replication" allocation across 10 global servers, what happens to the read performance and the update performance compared to a Centralized database?
6. Describe "Failure Transparency" in a DDBMS. Why is ensuring Atomicity significantly harder in a distributed environment than a centralized one?

**Difficulty: High**
7. Discuss the exact difference between a Distributed DBMS and a Parallel DBMS containing a "Shared Nothing" architecture.
8. Assume you have an `Employee` table. Give a concrete example of a "Mixed Fragmentation" strategy applied to this table.
9. An application submits a complex join query to a DDBMS. The Distributed Query Processor (DQP) analyzes the request. Discuss the three specific algorithmic "costs" the DQP calculates to determine which physical site should do the processing.

---
*End of Lecture 9 Summary*
