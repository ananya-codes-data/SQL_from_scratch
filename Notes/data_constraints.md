# Data Constraints

**Data constraints in SQL** are rules applied to table columns to **ensure data accuracy, consistency, and integrity**.

## What are Data Constraints in SQL?

> Data constraints restrict the type of data that can be stored in a table
> **Constraints are rules enforced on table columns to restrict invalid data from being inserted, updated, or deleted.**

They help:

* Prevent **invalid data**
* Maintain **data integrity**
* Enforce **business rules**
* Reduce dependency on application-level validation

## Main Types of Data Constraints

### 1️⃣ `NOT NULL`

Ensures a column **cannot have NULL values**

```sql
name VARCHAR(100) NOT NULL
```

📌 Use when the field is mandatory.

### 2️⃣ `UNIQUE`

Ensures **all values are distinct** in a column.

```sql
email VARCHAR(255) UNIQUE
```

📌 Allows **only one NULL** value in most databases.

### 3️⃣ `PRIMARY KEY`

* Uniquely identifies each row
* Combines **`NOT NULL` + `UNIQUE`**
* Only **one per table**

**Example:**

```sql
employee_id INT PRIMARY KEY
```

or composite key:

```sql
PRIMARY KEY (order_id, product_id)
```

📌 Used as the **main identifier** of a record.

📌 Can be **composite** (multiple columns).

### 4️⃣ `FOREIGN KEY`

Creates a relationship between two tables.

```sql
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
```

📌 Maintains **referential integrity**.

### 5️⃣ `CHECK`

Validates data based on a condition.

```sql
age INT CHECK (age >= 18)
```

📌 Used to enforce business rules.

### 6️⃣ `DEFAULT`

Assigns a default value if none is provided.

```sql
status VARCHAR(20) DEFAULT 'active'
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

### 7️⃣ `AUTO INCREMENT / IDENTITY / SERIAL`

Automatically generates values (DB-specific).

| Database   | Keyword               |
| ---------- | --------------------- |
| MySQL      | `AUTO_INCREMENT`      |
| PostgreSQL | `SERIAL` / `IDENTITY` |
| SQL Server | `IDENTITY`            |

**Example (PostgreSQL):**

```sql
id SERIAL PRIMARY KEY
```

## Example Table Using Constraints

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    age INT CHECK (age >= 18),
    status VARCHAR(20) DEFAULT 'active',
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

## Table-Level vs Column-Level Constraints

| Type         | Applied                   |
| ------------ | ------------------------- |
| Column-level | Directly on a column      |
| Table-level  | Defined after all columns |

### Column-level

```sql
email VARCHAR(255) UNIQUE
```

### Table-level

```sql
UNIQUE (email, phone)
PRIMARY KEY (employee_id, department_id)
```

📌 Table-level is used for **composite constraints**.

## Common Interview Questions & Tips

**Q: Can a table have multiple primary keys?**
❌ No, only one primary key (can be composite).

**Q: Can a foreign key have NULL values?**
✅ Yes, unless `NOT NULL` is specified.

**Q: Difference between UNIQUE and PRIMARY KEY?**

* `PRIMARY KEY` → no NULLs
* `UNIQUE` → allows NULLs (usually)

## One-line Interview Answer

> “SQL constraints are rules that enforce data integrity by restricting what values can be stored in a column or table, such as PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, and DEFAULT.”
