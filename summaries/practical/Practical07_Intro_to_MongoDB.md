# Practical 7: Introduction to NoSQL and MongoDB

This practical shifts focus from traditional Relational Database Management Systems (RDBMS) like Oracle to NoSQL ("Not Only SQL") databases, specifically focusing on MongoDB.

---

## 1. Introduction to NoSQL and MongoDB

**NoSQL Databases** are non-tabular databases developed to handle Big Data challenges. They store data differently than relational tables, providing flexible schemas, high availability, and easy scaling.

**MongoDB** is an open-source, document-oriented NoSQL database.
- It stores data in JSON/dictionary-like objects (technically BSON - Binary JSON).
- It is highly scalable, agile, and fault-tolerant.
- It uses JavaScript as its querying language.

### Core MongoDB Concepts vs. RDBMS
- **Database**: A physical container for collections.
- **Collection**: A group of MongoDB documents (Equivalent to an RDBMS **Table**). Collections do not enforce a strict schema.
- **Document**: A set of key-value pairs (Equivalent to an RDBMS **Row**). Documents possess a *dynamic schema*, meaning documents in the same collection don't need to have the same fields or data types.

### The `_id` Field
Every document in MongoDB possesses a unique `_id` field acting as a primary key. It is a 12-byte hexadecimal number generated automatically by MongoDB if not provided by the user.

### Advantages of MongoDB
1. **Schema-less**: No complex joins required; dynamic schemas allow for diverse data in the same collection.
2. **Deep query-ability**: Supports dynamic, rich queries nearly as powerful as SQL.
3. **Ease of scale-out**: Built for distributed architectures (auto-sharding).
4. **Faster Access**: Uses internal memory constraints effectively, requiring no complex object-relational mapping.

---

## 2. Using the Mongo Environment

The MongoDB environment comprises sever tools. The core binaries used via the command line are:

### Starting the Server and Shell
1. **`mongod` (Mongo Daemon)**: This executable *starts the MongoDB server* process. It handles data requests, manages data format, and performs background management.
2. **`mongo` (Mongo Shell)**: This is an interactive JavaScript shell interface to MongoDB. It acts as the *client* to interact with the database, test queries, and run JavaScript.

**Example execution in the Mongo Shell:**
```javascript
var myCourse = 'Database Technology';
printjson(myCourse);
```

---

## 3. Importing Data

Data can be imported into MongoDB using either command-line utilities or graphical interfaces.

### A. Importing via Command Line (`mongoimport.exe`)
`mongoimport` allows you to import data from varying formats (like CSV or JSON) directly into a collection.

**Syntax:**
```bash
mongoimport --db database_name --collection collection_name --type csv --headerline --file file_location
```

**Practical Example:**
```bash
mongoimport --db EmployeeD --collection EmployeeC --type csv --headerline --file d:\Employee.csv 
```
- `--type csv`: Indicates the incoming file is a CSV.
- `--headerline`: Tells MongoDB to use the first row of the CSV as the field names (keys) for the documents.

### B. Importing via MongoDB Compass (GUI)
MongoDB Compass is the official Graphical User Interface for MongoDB. It allows users to:
1. Connect to the database visually (e.g., `localhost:27017`).
2. Create Databases and Collections by clicking "Create Database".
3. Visually import data by clicking "Import Data", selecting the JSON/CSV file, and mapping fields.
4. View collections in distinct "List" or "Table" formats, without manipulating the command line.

---

## Review Questions

**Difficulty: Low**
1. What does the acronym "NoSQL" stand for?
2. In MongoDB, what is the equivalent of a traditional RDBMS "Table"?
3. What is the name of the executable file you must run to start the MongoDB server?

**Difficulty: Medium**
4. Describe what is meant by MongoDB having a "dynamic schema". Why is this an advantage for developers over a rigid SQL schema?
5. Write out the command to import a CSV file named `inventory.csv` located on your `C:\` drive into a database named `StoreDB` and a collection named `Products`. Assume the first row contains the column names.
6. What is the default generated `_id` field in MongoDB composed of physically (what do the 12 bytes represent)?

**Difficulty: High**
7. If your application requires intensive, multi-table transactions (e.g., a banking system transferring money between accounts), discuss whether you would choose Oracle or MongoDB, and explain your reasoning based on their architectures.
8. Explain the difference in purpose between `mongod.exe` and `mongo.exe`. Why do you need both?
9. When running `mongoimport`, you decide to omit the `--headerline` flag while importing a CSV file that *does* contain a header row. How will MongoDB structure the resulting documents?

---
*End of Practical 7 Summary*
