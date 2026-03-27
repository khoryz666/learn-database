# Practical 8: MongoDB CRUD Operations and Data Types

This practical covers the essential operations for managing data within MongoDB, including Creating, Reading, Updating, and Deleting (CRUD) documents. It also introduces various MongoDB BSON data types and data exportation.

---

## 1. Managing Collections

Collections in MongoDB are analogous to tables in a relational database.

### Basic Database & Collection Commands
*These commands are executed inside the MongoDB Shell (`mongo.exe`).*

- **List all databases**: `show dbs`
- **Switch to a specific database**: `use DatabaseName` *(If it doesn't exist, MongoDB will create it when you first insert data).*
- **List collections in current DB**: `show collections`
- **Create a collection explicitly**: `db.createCollection("CollectionName")`
- **Drop (Delete) a collection**: `db.CollectionName.drop()`

---

## 2. CRUD Operations (Insert, Find, Update, Delete)

### A. Create / Insert Documents
You can insert a single document or an array of documents using the `insert()` method. Data is provided in JSON format.

```javascript
// Inserting multiple documents at once (passing an array of JSON objects)
db.TestingC.insert([
    {
        "FirstName": "Kim",
        "LastName": "White",
        "Gender": "Female",
        "Age": "20",
        "Email": "kimw@gmail.com",
        "Salary": "2000.00"
    },
    {
        "FirstName": "Roslan",
        "LastName": "Hashim",
        "Gender": "Male",
        "Age": "21",
        "Email": "rhashim@gmail.com",
        "Salary": "3000.00"
    }  
]);
```

### B. Read / Find Documents
Retrieves documents from a collection.

- **Find all documents**: `db.TestingC.find()`
- **Find all documents formatted nicely**: `db.TestingC.find().pretty()`
- *(Note: You can pass a query object to `find()` to filter results, e.g., `db.TestingC.find({"Age": "20"})`)*

### C. Update Documents
Updates existing documents in a collection. You must specify a query criteria to identify the document(s), and then specify the update modifiers.

```javascript
db.TestingC.update (
    { "FirstName": "Kim" }, // 1. Query criteria (Find the document where FirstName is Kim)
    {
        // 2. The update operators
        $set: { "Gender": "Male" }, 
        $currentDate: { "lastModified": true }
    }
);
```
- **`$set`**: Modifies the value of an existing field or adds the field if it doesn't exist.
- **`$currentDate`**: Sets the value of a field to the current date/time. Useful for audit tracking.

### D. Delete Documents
Removes documents from a collection that match a specific criteria.

```javascript
// Removes a single document matching the criteria
db.TestingC.deleteOne({ "FirstName": "Ali" });

// To remove all matching documents, you would use deleteMany()
// db.TestingC.deleteMany({ "FirstName": "Ali" });
```

---

## 3. MongoDB Data Types

MongoDB stores documents in BSON (Binary JSON). BSON supports a wider variety of data types than standard JSON.

### Common BSON Data Types:
- String, Integer, Double, Boolean
- Array, Object (Embedded Document)
- Date, Timestamp
- Null, Binary Data, Regular Expression
- **ObjectId**: The 12-byte primary key data type.

### Examples of Specific Data Types:

**1. Binary Data:**
```javascript
var df = BinData(1, "232sa3d323sd232a32sda3sd23a2s1d23s21d3sa");
db.TestingCC.insert({ _id: ObjectId(), comment: "Binary example", valueBinary: df });
```

**2. ObjectId explicitly generated:**
```javascript
var customId = ObjectId();
db.TestingCCC.insert({ _id: customId, Topic: "Data Types" });
```

**3. Dates:**
```javascript
var date1 = Date();          // Returns a string representing the current date
var date2 = new Date();      // Returns a Date object
var date3 = new ISODate();   // Returns an ISODate object
db.TestingCCCC.insert({ Date1: date1, Date2: date2, Date3: date3 });
```

---

## 4. Exporting Data

You can export a MongoDB collection to a CSV or JSON file using the **`mongoexport`** utility.
*Crucial Note: Run `mongoexport` from the system Command Prompt (cmd), NOT from inside the MongoDB Shell.*

**Syntax:**
```bash
mongoexport --db=DatabaseName --collection=CollectionName --type=csv -f field1,field2 --out=C:\path\to\output.csv
```

**Example (Exporting to CSV):**
```bash
mongoexport --db=EmployeeD2 --collection=EmployeeC2 -f FirstName,LastName,Gender,Age,Salary --out=C:\backup.csv
```

- `-f` (or `--fields`): Specifies exactly which fields to include in the exported file.
- `--out`: Specifies the destination file path.

---

## Review Questions

**Difficulty: Low**
1. What command do you type in the Mongo Shell to switch to a database named `InventoryDB`?
2. What command allows you to view the data inside a collection called `Customers` outputted in a clean, readable, formatted fashion?
3. From where must you execute the `mongoexport` command?

**Difficulty: Medium**
4. Write the Mongo Shell command to insert a single document into a collection named `Products` representing a computer desk priced at 150.
5. In an `update` statement, what is the purpose of the `$set` operator? What happens if you try to `$set` a field that does not currently exist in the document?
6. Provide three examples of BSON data types supported by MongoDB that are not natively supported by standard JSON.

**Difficulty: High**
7. Discuss the operational difference between `Date()` and `new Date()` when inserting a timestamp into a MongoDB document using the Mongo Shell.
8. Write a complete command-line instruction to export the `Price` and `ProductName` fields from the `Catalog` collection inside the `StoreDB` database into a text file named `catalog_backup.txt` on your desktop.
9. An administrator uses the `db.Users.update({ "Age": "25" }, { "Status": "Active" })` command without using the `$set` operator. What destructive consequence does this have on the document matching the criteria? Discuss why `$set` is virtually always required for partial updates.

---
*End of Practical 8 Summary*
