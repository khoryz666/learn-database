# UCCD2303 Database Systems: Preparation Advice

Now that all the lecture and practical slide PDFs have been successfully extracted and reformatted into structured Markdown summaries, you have a powerful, unified knowledge base. 

Here is actionable advice on how to use these distinct materials to prepare effectively for both your **Practical Test** and your **Final Exam**.

---

## Part 1: Preparing for the Practical Test

The practical test evaluates your ability to *apply* database knowledge—writing functional code, executing commands, and interacting with interfaces directly.

### Focus Materials
- **`summaries/practical/` Directory**

### Actionable Strategies
1. **Prioritize Syntax Over Theory**: 
   - The practical summaries are intentionally designed to emphasize exact syntax (Oracle SQL, PL/SQL, MongoDB shells, Hadoop HDFS commands). 
   - *Action*: Do not just read the markdown files. Have your SQL Developer, MongoDB Compass, or Hadoop terminal open while reading. Type out every code block provided yourself to build muscle memory.
2. **Master the PL/SQL Core (Practicals 04, 05, 06)**:
   - Oracle PL/SQL is heavily tested in practicals. You must be able to fluently write Anonymous Blocks, Cursors, Procedures, and Triggers from memory.
   - *Action*: Use the code snippets provided in the summaries as templates. Try to rewrite them changing the variable names and logic (e.g., change a `LOOP` to a `WHILE` loop, or rewrite an `AFTER UPDATE` trigger to a `BEFORE INSERT` trigger).
3. **Execute the Review Questions Physically**:
   - At the end of every practical summary, there are difficulty-scaled review questions.
   - *Action*: Treat the Medium and High difficulty questions as mini-practical tests. Set a timer, open a blank text editor, and try to write the raw, syntactically perfect code to solve them before checking your notes.
4. **Distinguish Between Relational and NoSQL Paradigms**:
   - Your test covers both Oracle (Relational) and MongoDB (NoSQL).
   - *Action*: Create a physical cheat-sheet mapping Oracle SQL commands directly to their MongoDB equivalents (e.g., `SELECT * FROM table WHERE x = 1` $\rightarrow$ `db.collection.find({x: 1})`). The summaries for Practical 07-09 explicitly outline these MongoDB commands.

---

## Part 2: Preparing for the Final Exam

The final exam evaluates your conceptual understanding, architectural knowledge, design methodologies, and theoretical foundations.

### Focus Materials
- **`summaries/lecture/` Directory**

### Actionable Strategies
1. **Focus on the "Why", Not the "How"**:
   - The lecture summaries abstract away the raw code to focus on concepts. The final exam will ask *why* a database is structured a certain way, not *how* to type the `CREATE TABLE` command.
   - *Action*: When reviewing, focus heavily on the architectural diagrams discussed (e.g., ANSI-SPARC 3-Level Architecture, Distributed DBMS nodes). Be able to trace the flow of data mentally.
2. **Master Database Design & Normalization (Lectures 02, 03, 04)**:
   - ERD mapping, logical derivations, and Normalization usually form the heaviest weighted questions on final exams.
   - *Action*: Practice taking unnormalized data (UNF) and mapping it all the way to 3NF or BCNF on a whiteboard or blank paper. The step-by-step rules provided in Lecture 4's summary are your exact blueprint. Memorize the definitions of the *Three Anomalies* (Insertion, Update, Deletion).
3. **Trace Transaction Scenarios (Lecture 05 & 06)**:
   - Concurrency control and recovery are core theoretical topics. 
   - *Action*: Draw out timeline scenarios like "Transaction A reads at $t_1$, Transaction B writes at $t_2$...". Practice identifying if a scenario creates a *Dirty Read* or a *Lost Update*. Use the summary notes on 2-Phase Locking (2PL) and Time-Stamping to explain how the DBMS would natively resolve your drawn scenario.
4. **Utilize Relational Algebra as a Logic Puzzle (Lecture 07)**:
   - Relational Algebra questions test pure logic mapping.
   - *Action*: Use the Greek symbols provided in the summary ($\sigma, \Pi, \Join$) to mathematically derive SQL queries. A common exam trick is asking you to rewrite an SQL `SELECT` statement into raw Relational Algebra.
5. **Use the Scaled Review Questions for Active Recall**:
   - *Action*: Use the "Low Difficulty" questions purely for terminology flashcards (e.g., "What does ACID stand for?"). Use the "Medium/High Difficulty" questions for essay-style practice. Force yourself to verbally explain the High Difficulty questions out loud—if you stumble explaining *Eventual Consistency* vs *Strict ACID*, you need to re-read Lecture 11.

---

## Final Checklist
- [ ] Have you successfully run all the code blocks in the `practical/` directory in a live environment?
- [ ] Can you manually normalize a table to 3NF without looking at the Lecture 04 notes?
- [ ] Can you explain the difference between a Relational DB and a NoSQL DB as covered in Lecture 11?

Good luck with your exam preparation! You now have a highly structured, noise-free study environment.
