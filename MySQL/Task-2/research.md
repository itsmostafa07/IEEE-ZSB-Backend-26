# Research Assignment – SQL Concepts

---

## 1. WHERE vs HAVING

Both `WHERE` and `HAVING` are used to filter data, but they operate at different stages of query execution.

### Comparison Table

| Aspect | WHERE Clause | HAVING Clause |
|--------|--------------|---------------|
| **Execution Stage** | Filters rows **before** grouping | Filters groups **after** GROUP BY |
| **Filters** | Individual records | Aggregated groups |
| **Aggregate Functions** | Cannot use directly | Designed for aggregate conditions |
| **Performance** | More efficient (filters early) | Less efficient (filters later) |
| **When to Use** | Row-level filtering | Group-level filtering |

### Code Example

```sql
-- WHERE example
SELECT EmployeeID, Salary
FROM Employees
WHERE Salary > 5000;

-- HAVING example
SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 5;
```

---

## 2. DELETE vs TRUNCATE vs DROP

These commands remove data but differ in scope and rollback capability.

### Comparison Table

| Command | What It Removes | Can Use WHERE? | Rollback Support | Speed |
|---------|----------------|----------------|------------------|-------|
| **DELETE** | Selected rows | Yes | Yes (inside transaction) | Slower |
| **TRUNCATE** | All rows only | No | Usually No | Very Fast |
| **DROP** | Table + structure | No | No | Fast |

### Explanation

- **DELETE** removes specific rows and can be undone if wrapped in a transaction.
- **TRUNCATE** removes all rows quickly but keeps the table structure.
- **DROP** removes the entire table permanently.

---

## 3. Logical Order of Execution

Although we write queries in this order:

```sql
SELECT ...
FROM ...
WHERE ...
GROUP BY ...
HAVING ...
ORDER BY ...
```

The SQL engine executes them in this logical order:

### Execution Order Table

| Step | Clause | Purpose |
|------|--------|---------|
| **1** | FROM | Load tables and perform joins |
| **2** | WHERE | Filter rows |
| **3** | GROUP BY | Create groups |
| **4** | HAVING | Filter groups |
| **5** | SELECT | Produce final columns |
| **6** | ORDER BY | Sort results |

---

## 4. COUNT(*) vs COUNT(Column_Name)

Both count rows, but they treat NULL values differently.

### Comparison Table

| Function | Counts NULL? | Description |
|----------|--------------|-------------|
| **COUNT(*)** | Yes | Counts all rows |
| **COUNT(column)** | No | Counts only non-NULL values |

### Example

```sql
SELECT COUNT(*) AS TotalRows,
       COUNT(Grade) AS NonNullGrades
FROM Students;
```

If the table has 10 rows and 3 NULL values in Grade:
- COUNT(*) = 10  
- COUNT(Grade) = 7  

---

## 5. CHAR vs VARCHAR

Both store text data but handle storage space differently.

### Comparison Table

| Aspect | CHAR(10) | VARCHAR(10) |
|--------|----------|-------------|
| **Length Type** | Fixed-length | Variable-length |
| **Storage Used** | Always 10 characters | Only actual characters |
| **Padding** | Adds spaces | No padding |
| **Best Use** | Fixed codes | Variable text |

### Example: Storing "Cat"

| Data Type | Stored Value | Space Used |
|------------|-------------|------------|
| **CHAR(10)** | "Cat       " | 10 bytes |
| **VARCHAR(10)** | "Cat" | 3 bytes + small overhead |

---