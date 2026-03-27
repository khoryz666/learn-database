# Lecture 6: Database Backup and Recovery

This lecture details how a Database Management System (DBMS) protects data against hardware, software, and human failures, ensuring that the database remains in a consistent and durable state.

---

## 1. High-Level Database Modules

To manage operations safely, a DBMS relies on four interconnected modules:
1. **Transaction Manager**: Coordinates the start, commit, and abort of transactions.
2. **Buffer Manager**: Handles the efficient transfer of data between disk storage and main memory (RAM).
3. **Scheduler / Lock Manager**: Enforces concurrency control algorithms to ensure transactions are isolated and serializable.
4. **Recovery Manager**: Ensures the database is restored back to a consistent state if a failure occurs mid-transaction.

---

## 2. Backup Categories and Types

### Backup Modes
- **Offline (Cold / Consistent) Backup**: The database is shut down cleanly before the backup begins. The files cannot change during backup.
- **Online (Hot / Inconsistent) Backup**: The database remains operational. It is "inconsistent" because transactions are actively modifying the data while it copies. This requires the database to use an "ARCHIVELOG" mode to track ongoing changes.

### Backup Levels
- **Full Backup**: A complete copy of the entire database.
- **Incremental Backup**: Copies only the data blocks that have changed since the previous backup.
  - *Cumulative*: Copies everything changed since the last *Full (Level 0)* backup.
  - *Differential*: Copies everything changed since the last *Incremental* backup.

---

## 3. Categories of Failure

The Recovery Manager must handle various types of failure scenarios:
1. **Statement Failure**: A single SQL operation fails (e.g., trying to insert text into a numeric column).
2. **User Process Failure**: A single user session crashes or abnormally disconnects.
3. **Network Failure**: A loss of connectivity between the client and the database server.
4. **User Error**: A user inadvertently deletes critical data or drops a table.
5. **Instance Failure**: The database server software shuts down unexpectedly (e.g., power outage or hardware crash).
6. **Media Failure**: Physical destruction or corruption of the hard disks storing the database files.

---

## 4. Recovery Facilities

To recover from the failures above, a DBMS uses three primary tools:

### A. The Log File (Redo Log)
A chronological record of every data change made to the database. It contains:
- Transaction Identifiers
- **Before-images**: The state of the data *before* the transaction modified it (used for UNDO/Rollback).
- **After-images**: The state of the data *after* the transaction modified it (used for REDO/Rollforward).

### B. Checkpointing
Reading through an entire log file from the beginning of time after a crash is impossible. A **Checkpoint** is a deliberate synchronization point where the DBMS forces all modified data currently sitting in memory buffers to be written out safely to the physical disk. A checkpoint record is written to the log summarizing all currently active transactions.
- *If a failure occurs*, the DBMS only needs to search the log backward until it hits the most recent Checkpoint to know what was safely saved.

### C. The Recovery Manager Algorithm
Upon crash recovery, using the latest Checkpoint, the Recovery Manager applies two rules:
1. **REDO (Forward Recovery)**: If a transaction officially *Committed* since the last checkpoint, but its data wasn't pushed to disk before the crash, the manager uses the log's *After-images* to recreate those changes.
2. **UNDO (Backward Recovery)**: If a transaction was *Active* at the exact time of the crash (did not commit), the manager uses the log's *Before-images* to roll back any partial changes it made.

---

## 5. Main Recovery Approaches

How exactly the DBMS handles writing data to the disk determines how complex recovery will be. 

### 1. Deferred Update
Updates are **not written** to the actual database until the transaction officially issues a `COMMIT`.
- *Failure before Commit*: The transaction hasn't touched the actual database yet, so **No UNDO is required**.
- *Failure after Commit*: The transaction might not have reached the physical disk yet, so a **REDO is required**.

### 2. Immediate Update
Updates are written to the actual database immediately as they occur, even before the transaction commits.
- *Write-Ahead Log Protocol*: This approach is only safe because of a strict rule: **The Log File must be written to disk BEFORE the actual database is updated.**
- *Failure before Commit*: Because partial updates sit in the database, **UNDO is required**.
- *Failure after Commit*: Just like deferred updates, **REDO is required**.

### 3. Shadow Paging
The DBMS maintains two page tables: a *Current Page* table and a *Shadow Page* table. During a transaction, all updates are recorded in the Current Page table. If the transaction commits, the Current Page literally becomes the new Shadow Page. If it aborts, the Current Page is simply discarded, and the system reverts flawlessly to the unchanged Shadow Page. No logs are needed for transaction undos.

---

## Review Questions

**Difficulty: Low**
1. Which core database module is primarily responsible for generating the Before and After logs?
2. Briefly describe the difference between a "Cold" database backup and a "Hot" database backup.
3. In the context of database logs, what is a "Before-image" used for?

**Difficulty: Medium**
4. Contrast a Full Backup with a Cumulative Incremental Backup. What specific advantage does Incremental backup offer?
5. If a database is using the "Deferred Update" recovery approach, why is an UNDO operation mathematically unnecessary if a system crashes mid-transaction?
6. Explain the purpose of a "Checkpoint". How does it reduce the amount of time a database takes to restart and recover after an Instance Failure (power outage)?

**Difficulty: High**
7. Discuss the "Write-Ahead Log Protocol" used in Immediate Update environments. If a DBMS broke this rule and updated the internal database tables *before* writing the Before-Image to the log file, exactly what catastrophic event would occur upon a power failure?
8. Categorize a scenario where a Junior DBA accidentally runs a `DROP TABLE INVENTORY;` command on production. Which of the 6 categories of failure is this? Could the DBMS instantly use the Log File to reverse this automatically upon system restart? Why or why not?
9. Compare and contrast the operations performed by the Recovery Manager during "Forward Recovery" (REDO) versus "Backward Recovery" (UNDO) in terms of which image types are read from the transaction log and applied to the database.

---
*End of Lecture 6 Summary*
