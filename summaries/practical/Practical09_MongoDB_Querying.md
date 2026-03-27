# Practical 9: Querying Documents in MongoDB

This practical focuses on retrieving specific data from MongoDB collections using projections, criteria-based filtering, limits, skips, and sorting. All commands are executed within the interactive Mongo Shell.

---

## 1. Creating a Projection

In MongoDB, the `find()` method returns *all* fields of a document by default. **Projection** is the process of selecting only the necessary data rather than returning the entire document.

The `find()` method accepts an optional second parameter (a JSON object) to define the projection.
- Use `1` to show a field.
- Use `0` to hide a field.

**Syntax rules:**
- You generally **cannot mix** `0`s and `1`s in the same projection object.
- The only exception is the `_id` field. The `_id` field is always included by default unless you explicitly set it to `0`.

**Example:** Return only the `title` field from `mycollection`.
```javascript
// The first {} is an empty query criteria (meaning "find all documents")
// The second {} is the projection
db.mycollection.find({}, { "title": 1, "_id": 0 });
```

---

## 2. Querying Based on Criteria

Instead of fetching all documents, you can pass criteria in the first parameter of the `find()` method to filter your results.

**1. Equality Criteria:**
```javascript
db.EmployeeC2.find({ "FirstName": "Grace" }).pretty();
```

**2. Relational Operators:**
MongoDB uses query operators prefixed with a dollar sign `$` to handle comparative logic.
- `$gt`: Greater Than
- `$lt`: Less Than
- `$gte`: Greater Than or Equals
- `$lte`: Less Than or Equals
- `$ne`: Not Equals

**Example Usage:**
```javascript
// Find employees older than 21
db.EmployeeC2.find({ "Age": { $gt: 21 } });

// Find employees who are NOT exactly 21 years old
db.EmployeeC2.find({ "Age": { $ne: 21 } });
```

**Combining Criteria and Projection:**
```javascript
// Find employees 25 or older, but only return their first and last names
db.EmployeeC2.find({ "Age": { $gte: 25 } }, { "FirstName": 1, "LastName": 1, "_id": 0 });
```

---

## 3. Limiting and Skipping Records

### The `limit()` Method
Restricts the number of documents returned by the query.
```javascript
// Return only the first 2 documents that match
db.mycollection.find({}, { "title": 1, "_id": 0 }).limit(2);
```

### The `skip()` Method
Skips a specified number of documents before returning the remaining results. This is heavily used alongside `limit()` for pagination.
```javascript
// Skip the first document, then return the next 1 document
db.mycollection.find({}, { "title": 1, "_id": 0 }).limit(1).skip(1);
```

---

## 4. Sorting Records

Use the `sort()` method to specify the order of returned documents. It accepts a document containing the fields you want to sort by.

- **`1`**: Ascending Order
- **`-1`**: Descending Order

**Example:**
```javascript
// Sort by title in descending order (Z to A)
db.mycollection.find({}, { "title": 1, "_id": 0 }).sort({ "title": -1 });

// Query all docs, project FirstName and Email, and sort by FirstName ascending (A to Z)
db.EmployeeC2.find({}, { "FirstName": 1, "Email": 1, "_id": 0 }).sort({ "FirstName": 1 });
```

---

## Review Questions

**Difficulty: Low**
1. How do you tell the Mongo Shell to exclude the `_id` parameter from your `find()` query results?
2. What does the `$gte` query operator stand for?
3. If you append `.limit(5)` to a `find()` command, what is the maximum number of documents that will be returned?

**Difficulty: Medium**
4. Write a mongo shell query command to find all users in a `Users` collection whose `Role` is "Admin", but only display their `Username` and `Email` fields outputted neatly.
5. In a projection object, why does the syntax `{ "FirstName": 1, "Age": 0 }` cause an error? What is the one exception to this rule?
6. Write a query to find all documents in the `Inventory` collection where the `Stock` is less than 10, skipping the first 3 results.

**Difficulty: High**
7. You are building a web application that displays 20 items per page from a `Products` collection, sorted by price (highest to lowest). Write the exact MongoDB query command required to retrieve the data for **Page 3** of the paginated results.
8. Explain what happens if you combine projection and sorting, but you sort by a field that is *currently excluded* from the projection. Will the query fail, or will it sort accurately without displaying the sorting field?
9. Given the command `db.Orders.find({ "Total": { $ne: 100 } })`, would this command return documents that completely lack the `"Total"` field? Why or why not, based on your understanding of NoSQL schemas?

---
*End of Practical 9 Summary*
