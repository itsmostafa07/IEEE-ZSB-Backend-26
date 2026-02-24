# Part B: Research Questions

## 1. UNION vs UNION ALL — What's Actually the Difference?

### Quick Comparison

| | UNION | UNION ALL |
|---|---|---|
| **Duplicates** | Filters them out | Leaves them in |
| **Speed** | Slower | Noticeably faster |
| **What it does internally** | Sorts results and drops repeated rows | Just stacks both result sets together |
| **RAM usage** | Heavier | Much lighter |
| **Best for** | Strict uniqueness requirements | Cases where every row counts |

### So Why Does UNION Slow Things Down?

Every time you use `UNION`, the database engine has to do a second pass over the combined results — sorting rows and checking for matches it should throw away. It's not a huge deal on small tables, but once you're dealing with hundreds of thousands of rows, that extra step starts to hurt. Think of it like washing the same dishes twice to make sure none are the same.

`UNION ALL` just pours both result sets into one pile and hands it back. No comparison, no cleanup. That's why it can be 40–60% quicker in heavy workloads.

### Seeing It in Action

**With UNION — duplicates get dropped:**
```sql
SELECT StudentID, StudentName FROM Enrolled_Fall
WHERE Major = 'Computer Science'
UNION
SELECT StudentID, StudentName FROM Enrolled_Spring
WHERE Major = 'Computer Science';
-- A student registered in both semesters will only appear once
```

**With UNION ALL — nothing gets filtered:**
```sql
SELECT StudentID, StudentName FROM Enrolled_Fall
WHERE Major = 'Computer Science'
UNION ALL
SELECT StudentID, StudentName FROM Enrolled_Spring
WHERE Major = 'Computer Science';
-- That same student now shows up twice, once per semester
```

### What to Actually Use in Practice

Reach for `UNION ALL` by default. Unless your use case specifically demands that every result is unique, there's no good reason to pay the performance penalty. If you do need unique results, it's worth asking whether you can filter earlier — trimming duplicates in a `WHERE` clause before combining is almost always faster than letting `UNION` clean it up afterward.

---

## 2. Subqueries vs JOINs — Which One Should You Write?

### At a Glance

| | Subqueries | JOINs |
|---|---|---|
| **Speed** | Slower, especially when correlated | Faster in most real-world scenarios |
| **Optimizer friendliness** | Hard to optimize automatically | Much more flexibility for the query planner |
| **How readable it is** | Gets hard to follow when nested | Relationships are explicit and clear |
| **Debugging** | Tedious — layers to unwrap | Easier to break apart and inspect |
| **As data grows** | Can degrade quickly | Much more stable |

### Why the Query Optimizer Prefers JOINs

The database doesn't just run your SQL line by line — it builds an execution plan and tries to find the smartest way to get your data. JOINs give it room to maneuver. It can choose hash joins, merge joins, or nested loops depending on table sizes and index availability.

Subqueries — particularly correlated ones — box the optimizer in. In a correlated subquery, the inner query runs once for every single row in the outer query. On a table with a million rows, that's a million extra executions.

Here's what the same question looks like written both ways:

```sql
-- Subquery version
SELECT BookID, Title
FROM Books
WHERE AuthorID IN (
    SELECT AuthorID
    FROM Authors
    WHERE Country = 'Japan'
);

-- JOIN version, usually quicker
SELECT DISTINCT b.BookID, b.Title
FROM Books b
INNER JOIN Authors a ON b.AuthorID = a.AuthorID
WHERE a.Country = 'Japan';
```

The JOIN also lets you pull in columns from both tables in one go, which the subquery version can't do without restructuring.

### Other Reasons JOINs Are Easier to Live With

When a teammate reads your query six months from now, a JOIN tells the full story — which tables connect, how they relate, what columns are shared. There's no hunting through nested blocks to figure out what the inner query is doing or why.

Execution plans are also far easier to read with JOINs. You can pinpoint exactly which step is slow and go fix it. With subqueries stacked inside each other, reading the plan becomes its own challenge.

### Times When a Subquery Is Actually the Better Choice

There are genuine situations where subqueries shine and forcing a JOIN would make things worse.

**Checking whether something exists:**
```sql
SELECT DoctorID, DoctorName
FROM Doctors d
WHERE EXISTS (
    SELECT 1 FROM Appointments a
    WHERE a.DoctorID = d.DoctorID
    AND a.AppointmentDate = CURDATE()
);
```

This reads naturally — "show me doctors who have appointments today." Converting it to a JOIN adds complexity without any real benefit.

**Filtering on aggregated results** is another good fit. If you need rows where some grouped count or sum meets a threshold, a subquery in the `WHERE` clause can express that more cleanly than a JOIN paired with `HAVING`.

### How to Set This Up Right in Production

Index your join columns — that single habit makes more difference than almost anything else. Choose your join type based on what you actually need: `INNER JOIN` when both sides must match, `LEFT JOIN` when you want rows from the first table even if nothing matches in the second.

And always test with real data volumes before deploying. A query that runs in 200ms on your dev machine can grind to a halt when the table has 20 million rows.

```sql
-- Indexes first
CREATE INDEX idx_appointments_doctor ON Appointments(DoctorID, AppointmentDate);
CREATE INDEX idx_doctors_id ON Doctors(DoctorID);

-- Production-ready query
SELECT d.DoctorID, d.DoctorName, COUNT(a.AppointmentID) AS TodayCount
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
    AND a.AppointmentDate = CURDATE()
GROUP BY d.DoctorID, d.DoctorName
HAVING COUNT(a.AppointmentID) > 0;
```

Write JOINs by default, keep your indexes healthy, and pull out subqueries when the problem genuinely fits them — not just because it seemed easier to nest another `SELECT`.