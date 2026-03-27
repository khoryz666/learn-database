# Lecture 5: Transaction Management (Part 1)

This lecture introduces the concept of database transactions and the mechanisms used to ensure data remains accurate and consistent when multiple users access the database simultaneously (Concurrency Control).

---

## 1. Introduction to Transactions

A **Transaction** is a logical unit of work performed on a database. It can consist of a single SQL statement or a series of complex Read and Write operations. The goal of a transaction is to transform the database from one consistent state to another.

### Transaction Outcomes
A transaction can only end in one of two ways:
1. **Committed**: The transaction completes successfully. The new consistent state is saved permanently. A committed transaction cannot be aborted.
2. **Aborted**: The transaction fails. The database is **Rolled Back** (undone) to the consistent state it was in exactly before the transaction started.

### ACID Properties
Every reliable database transaction must possess the four ACID properties:
- **Atomicity**: The "All or Nothing" rule. Either the entire transaction happens, or none of it happens.
- **Consistency**: The transaction must respect data integrity rules (e.g., you cannot transfer money out of an account causing it to drop below a required zero balance).
- **Isolation**: Incomplete transaction states should remain entirely invisible to other simultaneous transactions.
- **Durability**: Once a transaction Commits, its changes are permanent and must survive system failures or power outages.

---

## 2. Concurrency Control

**Concurrency Control** is the process of managing simultaneous operations without letting them interfere with one another. If left unmanaged, concurrent queries run the risk of creating incorrect data.

### Three Severe Concurrency Problems
1. **Lost Update Problem**: User A reads a value. User B reads the same value. User A updates the value and saves. User B immediately updates the value and saves, permanently overwriting (losing) User A's update.
2. **Uncommitted Dependency (Dirty Read) Problem**: Transaction A updates a value but hasn't committed yet. Transaction B reads this new "dirty" value and uses it in a calculation. Transaction A then Aborts and rolls back. Transaction B is now using fictitious data.
3. **Inconsistent Analysis (Fuzzy Read) Problem**: Transaction A is generating a multi-row summary report. In the middle of running the report, Transaction B secretly updates one of those rows. Transaction A's final report is mathematically incorrect because the underlying data changed mid-calculation.

---

## 3. Serializability 

To prevent these problems, DBMSs use scheduling. 
- A **Serial Schedule** processes transactions strictly one by one. This is perfectly safe, but incredibly slow.
- A **Nonserial Schedule** interleaves operations. The goal of the DBMS is to find nonserial schedules that equal the result of a serial schedule. This is called **Serializability**.

### Conflict Serializability and Precedence Graphs
To determine if an interleaved schedule is safe, we check for conflicts (e.g., Transaction A writes to a cell that Transaction B wants to read).

We can visualize these dependencies using a **Precedence Graph**. Nodes represent transactions, and directed arrows represent dependencies (e.g., T2 read data written by T1). If the resulting Precedence Graph forms a **cycle** (a closed loop), the schedule is *not serializable* and will cause corruption.

---

## 4. Concurrency Control Techniques (Pessimistic)

Most modern DBMSs are "pessimistic", meaning they assume conflicts are highly likely to happen, so they restrict access aggressively upfront.

### Technique 1: Locking
A transaction claims a "lock" on a piece of data to deny other transactions access.
- **Shared (Read) Lock**: Allows the transaction to read the data. Other transactions can also place Shared Locks on the same data simultaneously.
- **Exclusive (Write) Lock**: Allows the transaction to both read and update the data. **No other transaction** can access the data until the lock is released.

#### Two-Phase Locking (2PL)
To guarantee serializability, transactions follow 2PL protocols involving two phases:
1. **Growing Phase**: The transaction acquires all the locks it needs. It *cannot release* any locks.
2. **Shrinking Phase**: The transaction releases locks. It *cannot acquire* any new locks.

#### Deadlocks
A **Deadlock** is a permanent impasse where Transaction A has locked Item X and is waiting for Item Y, while Transaction B has locked Item Y and is waiting for Item X. 
- **Prevention**: Uses timestamps. (e.g., "Wait-Die" where an older transaction waits for a younger one, but a younger transaction is instantly killed/aborted rather than wait for an older one).
- **Detection**: The DBMS builds a **Wait-For-Graph (WFG)**. Similar to a precedence graph, if the WFG has a cycle, a deadlock exists, and the DBMS must forcibly abort one of the transactions.

### Technique 2: Timestamping
Instead of using physical locks (which avoids deadlocks completely), the DBMS gives every transaction a unique global Timestamp. 
- Operations are resolved based on age: Older transactions receive priority in conflicts.
- If a conflict occurs violating the timestamp order, the younger transaction is aborted, rolled back, given a brand new timestamp, and restarted.

---

## Review Questions

**Difficulty: Low**
1. What do the letters in the ACID acronym stand for regarding transactions?
2. What are the two possible outcomes of a transaction?
3. In a Locking currency control system, what is the difference between a Shared Lock and an Exclusive Lock?

**Difficulty: Medium**
4. Describe the "Dirty Read" (Uncommitted Dependency) problem using a theoretical banking database scenario. Include two transactions in your explanation.
5. In Two-Phase Locking (2PL), if a transaction enters the "Shrinking Phase," what action is it explicitly forbidden from performing?
6. An administrator runs a diagnostic Wait-For-Graph (WFG) and discovers a cycle between Transaction 41, Transaction 42, and Transaction 49. What does this cycle mathematically prove about the state of the database?

**Difficulty: High**
7. Discuss the fundamental difference between the "Locking" and "Timestamping" concurrency control techniques. Why does the Timestamping technique completely eliminate the possibility of Deadlocks?
8. Compare the concepts of a "Serial Schedule" and "Conflict Serializability". Why do modern enterprise Database Management Systems virtually never use strict Serial Schedules for handling transactions?
9. Explain the "Wait-Die" method of Deadlock Prevention. If Transaction A started at 1:00 PM and Transaction B started at 1:05 PM, what happens if Transaction B attempts to claim a lock currently held by Transaction A?

---
*End of Lecture 5 Summary*
