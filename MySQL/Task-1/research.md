# Database Systems Analysis & Research
---

## 1. System Architecture: DBMS vs RDBMS

| Comparison Point | DBMS (Database Management System) | RDBMS (Relational DBMS) |
| :--- | :--- | :--- |
| **Storage Structure** | Saves data in navigational trees or flat files. | Saves data in **tables** with strict rows and columns. |
| **Data Connections** | Does not support relationships; data is isolated. | Supports **Foreign Keys** to link tables together. |
| **Data Redundancy** | High redundancy; same data repeats in multiple files. | **Normalization** reduces redundancy to a minimum. |
| **Integrity Rules** | No constraints; allows bad or missing data. | Enforces **Referential Integrity** and data types. |
| **Transaction Safety** | Rarely ACID compliant; risky for critical data. | Fully **ACID compliant** (Atomicity, Consistency, Isolation, Durability). |
| **Query Method** | Requires proprietary programming for access. | Uses standardized **SQL** commands. |
| **Typical Usage** | Simple directories, XML files, single-user apps. | Banking, University systems, Enterprise apps. |

---

## 2. SQL Functional Categories: DDL vs DML

### Data Definition Language (DDL)

**Core Function:** Focuses on the **Container**. It defines or modifies the structure of the database objects (Schema).

**Primary Operations:**
- `CREATE`: Builds new tables or databases.
- `ALTER`: Modifies existing table structures (e.g., adding a column).
- `DROP`: Deletes the entire table structure.
- `TRUNCATE`: Wipes all data but keeps the structure.

**Practical Example:**
```sql
CREATE TABLE Course_Catalog (
    Course_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT
);
```

## DML (Data Manipulation Language)

- **Primary Purpose:** Primary Scope: Manages the Records. These commands handle the actual data values populated within the schema (the "contents").
- **Common Commands:** 
- `INSERT`: Adds new records to a table.
- `UPDATE`: Modifies existing records.
- `DELETE`: Removes specific records.
- `SELECT`: Retrieves data for analysis.


**Example:**

```sql
INSERT INTO Students (CourseID, Title, Credits)
VALUES (1, 'Backend', 7);
```

---

## Why is normalization important in large systems?
Normalization is the systematic refinement of database tables to minimize redundancy and dependency. In complex environments like a university system, it is critical for the following reasons:  

- **Efficiency & Organization** :
  - It transforms a chaotic, flat dataset into a logical relational structure. By ensuring data exists in only one place, it significantly reduces storage costs and simplifies maintenance.
- **Organizes data into relational tables**, making the database easier to manage.  
- **Preventing Logical Inconsistencies (Anomalies)** :
  - **Insertion anomaly:** Adding new data may force duplicate or unnecessary entries.  
  - **Deletion anomaly:** Deleting a record might unintentionally remove other important data.  
  - **Modification anomaly:** Updating a value in one row can affect other rows.  
