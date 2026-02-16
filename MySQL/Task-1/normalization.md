# Legacy Data Restructuring Plan
---

## What is Database Normalization?

Database normalization is a database design approach that aims to improve database structure. It is the process of dividing large complex tables into smaller, more manageable units to avoid duplication and inconsistencies when updating.

The main goal is to:
- Ensure a particular piece of data is stored in only one place
- Establish logical links between data sets
- Ensure primary keys are the only identifiers for a row

---

## Data Dependency Terms

To properly normalize, it is essential to understand the relationship between data points. When we say "A determines B" (A → B), we mean that:
- A particular input for A will always produce the same output for B
- B cannot exist or change independently of A

Generally, we are concerned with three specific types of data dependency:

1. **Full Dependency**: Data depends on the entire unique identifier (Primary Key)
2. **Partial Dependency**: Data depends on only a part of a composite key
3. **Transitive Dependency**: Data depends on a value that is not a primary key

---

## The Stages of Normalization

We will go through the usual levels of normalization:
- **0NF**: A flat file with lists in cells and repeating groups
- **1NF**: Each cell must contain only one value (Atomicity)
- **2NF**: Each cell must contain a value related to the entire Primary Key (No partial dependencies)
- **3NF**: Non-key data cannot determine non-key data

---

# Applied Normalization: Legacy_Data

## Initial Raw Table: Student_Grade_Report

| Student_Name | Student_Phone | Student_Address | Course_Title | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
|--------------|---------------|----------------|-------------|----------------|----------------|--------------|-------|
|              |               |                |             |                |                |              |       |

**Identifier:** Composite Key `(Student_Name + Course_Title)`

---

## Phase 1: First Normal Form (1NF)

**Problem Identified:** The phone column has a list of numbers separated by commas, which is not atomic
**Solution:** Break out the numbers into a sub-table so each row has one number

### Normailized 1NF Tables:

**Grade_Report**
| Student_Name | Student_Address | Course_Title | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
|--------------|----------------|-------------|----------------|----------------|--------------|-------|
|              |                |             |                |                |              |       |

**Student_Mobile**
| Student_Name | Contact_Number |
|--------------|---------------|
|              |               |

*Every attribute is now atomic, containing only single values*

---

## Phase 2: Second Normal Form (2NF)

**Identified Issue:** The address is related to the Student, but not the Course they are taking
**Resolution:** Break out static student profiles into a separate entity

### Normailized 2NF Tables:

**Student_Grades**
| Student_Name | Course_Title | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
|--------------|-------------|----------------|----------------|--------------|-------|
|              |             |                |                |              |       |

**Student_Location**
| Student_Name | City | Street | Postal_Code |
|--------------|------|--------|--------------|
|              |      |        |             |

**Student_Mobile**
| Student_Name | Contact_Number |
|--------------|---------------|
|              |               |

*Partial key dependencies have been resolved*

---

## Phase 3: Third Normal Form (3NF)

**Identified Issues:**
- The Building is determined by the Department, not the Instructor
- The Department is determined by the Instructor, not the Course

**Resolution:** Normalize Faculty and Department data into reference tables

### Final 3NF Schema:

**Student_Grades**
| Student_Name (PK, FK) | Course_Title (PK) | Instructor_Name (FK) | Grade |
|-----------------------|-------------------|--------------------|-------|
|                       |                   |                    |       |

**Faculty_Instructor**
| Instructor_Name (PK) | Instructor_Dept (FK) |
|---------------------|---------------------|
|                     |                     |

**Department_Locations**
| Instructor_Dept (PK) | Dept_Building |
|---------------------|--------------|
|                     |              |

**Student_Location**
| Student_Name | City | Street | Postal_Code |
|--------------|------|--------|--------------|
|              |      |        |             |

**Student_Mobile**
| Student_Name (PK, FK) | Contact_Number (PK) |
|-----------------------|---------------------|
|                       |                     |

*Transitive dependencies removed; schema is now optimized*