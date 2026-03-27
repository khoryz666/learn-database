# Lecture 11: Database Engines, NoSQL, and Big Data

This lecture traces the historical evolution of database engines and explains why the modern era of the internet necessitated the creation of entirely new, non-relational database structures (NoSQL) to handle Big Data.

---

## 1. The Three Database Revolutions

The history of database technology is divided into three major eras:

### Era 1: Pre-Relational (1950 - 1972)
- **Hierarchical Model**: Organized data in a strict tree-like structure (Parent/Child records). Extremely fast for data retrieval and great for replacing paper systems, but terrible at representing complex relationships.
- **Network Model**: Improved upon the hierarchical model by allowing a child record to have multiple parent records, introducing the concept of *Entities* and flexible relationships.

### Era 2: Relational (1972 - 2000)
- The dominant system for decades. Data is stored in strict **Tables**, **Records**, and **Fields**.
- Introduced standard SQL for querying.
- Highly prioritized logical **Relationships** (1:1, 1:Many, Many:Many) and strict structural constraints to ensure absolute data consistency.

### Era 3: The Next Generation / NoSQL (2000 - Present)
- The rise of "Web 2.0" (social media, user-generated content) created a massive influx of unstructured data that rigidly-structured relational tables simply could not process fast enough.
- This birthed **NoSQL** ("Not Only SQL") databases designed for massive horizontal scalability, flexibility (no rigid schemas), and 24/7 availability across distributed networks.

---

## 2. Big Data and Hadoop

**Big Data** refers to collections of data growing so exponentially huge and complex that traditional relational management tools cannot process them. Big Data is defined by the **5 V's**:
1. **Volume**: The sheer massive quantity of data.
2. **Velocity**: The rapid rate/speed at which new data is entering the system.
3. **Variety**: The variations in data structure (structured, semi-structured, unstructured).
4. **Veracity**: The trustworthiness, quality, and accuracy of the data.
5. **Value**: The ability to transform massive raw data into actionable business insight.

**Hadoop**: The de facto standard Java framework for Big Data. It stores and processes massive datasets by distributing the workload across clusters of cheap, inexpensive commodity servers using the Hadoop Distributed File System (HDFS).

---

## 3. Transaction Models: ACID vs. BASE

The biggest architectural difference between Relational (SQL) and NoSQL databases is how they handle transactions.

- **SQL guarantees ACID**:
  - *Atomicity, Consistency, Isolation, Durability.* (Absolute consistency at all times).
- **NoSQL guarantees BASE**:
  - **B**asically **A**vailable: The system will literally always respond, even if partially failed.
  - **S**oft State: The state of the data can change independently without user interaction.
  - **E**ventual Consistency: The database prioritizes speed. It does *not* guarantee instant consistency across all network nodes at the exact moment of a transaction. Instead, it simply promises that "eventually," all nodes will synchronize and agree on the data.

---

## 4. NoSQL Data Models

Because NoSQL abandons standard relational tables, it organizes data using four primary models:

### 1. Key-Value (KV) Databases
- **Concept**: The most simple NoSQL structure. Data is stored as a collection of Key-Value pairs inside "buckets". 
- **Detail**: The Key acts as an ID. The database does not attempt to "understand" the Value; it just stores the blob (which could be an image, text, or XML).

### 2. Document-Based Databases
- **Concept**: A sub-type of KV. The Value component is strictly a tagged document formatted in JSON, BSON, or XML.
- **Detail**: Unlike raw KV databases, Document databases *do* understand the internal contents of the document, allowing you to query specific JSON fields. (e.g., MongoDB).

### 3. Column-Based Databases
- **Concept**: Instead of storing data row-by-row physically on a disk (*Row-centric storage*), it stores strictly by columns (*Column-centric storage*).
- **Detail**: In a massive database, if a query only wants to see the "City" and "State" of 10 million users, a relational database must read all 10 million entire rows. A column-based database only reads the single, continuous data block containing the "City" and "State" columns, saving massive amounts of disk I/O.

### 4. Graph-Based Databases
- **Concept**: Based entirely on mathematical graph theory. Stores rich relationships as a collection of **Nodes** (entities like people) and **Edges** (the relationships connecting the nodes).
- **Detail**: Eliminates the need for mathematically complex SQL `JOIN`s. Perfectly suited for mapping Social Networks, logistics routing, and dating apps. (e.g., Neo4j).

---

## Review Questions

**Difficulty: Low**
1. Name the 5 V's that characterize Big Data.
2. In the history of databases, which architectural model was characterized by organizing data in a strict "tree-like" structure?
3. What does "NoSQL" stand for?

**Difficulty: Medium**
4. Contrast the NoSQL "BASE" transaction model with the standard relational "ACID" model. Specifically, explain what "Eventual Consistency" means.
5. Discuss the primary difference between a simple Key-Value (KV) Database and a Document-Based Database.
6. Why did the advent of "Web 2.0" force the software industry to invent NoSQL databases, abandoning traditional Relational models for specific tasks?

**Difficulty: High**
7. Assume an international bank is processing billions of financial transactions a day. Despite the massive Volume and Velocity of this data, explain why the bank's core ledger system absolutely *cannot* be migrated to a standard NoSQL database utilizing the BASE transaction model.
8. Explain the physical storage difference between Row-centric storage and Column-centric storage. Give an example of a specific `SELECT` query that would run vastly faster on a Column-Based Database than a Relational Database.
9. You are tasked with building the backend for a new professional networking application (similar to LinkedIn) where the primary feature relies on instantly finding "Friends of Friends" up to 4 degrees of separation. Which of the 4 NoSQL Data Models is mathematically best suited for this, and why? Give specific terminology related to that model in your answer.

---
*End of Lecture 11 Summary*
