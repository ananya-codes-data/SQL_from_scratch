# Data Constraints

**Data constraints in SQL** are rules applied to table columns to **ensure data accuracy, consistency, and integrity**.

## What are Data Constraints in SQL?

> Data constraints restrict the type of data that can be stored in a table.

They help:

* Prevent invalid data
* Enforce business rules
* Maintain relationships between tables

## Main Types of Data Constraints

### 1️⃣ NOT NULL

Ensures a column **cannot have NULL values**

name VARCHAR(100) NOT NULL

📌 Use when the field is mandatory

### 2️⃣ UNIQUE

Ensures **all values are distinct** in a column.

email VARCHAR(255) UNIQUE

📌 Allows **only one NULL** value in most databases

### 3️⃣ PRIMARY KEY

* Uniquely identifies each row
* Combines **`NOT NULL` + `UNIQUE`**
* Only **one per table**

```sql
employee_id INT PRIMARY KEY
```

📌 Can be **composite** (multiple columns).

---

### 4️⃣ FOREIGN KEY

Creates a relationship between two tables.

FOREIGN KEY (department_id)
REFERENCES departments(department_id)

📌 Maintains **referential integrity**.

### 5️⃣ CHECK

Validates data based on a condition.

age INT CHECK (age >= 18)

📌 Used to enforce business rules.

### 6️⃣ DEFAULT

Assigns a default value if none is provided.

status VARCHAR(20) DEFAULT 'active'
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

## Example Table Using Constraints

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

## Table-Level vs Column-Level Constraints

| Type         | Applied                   |
| ------------ | ------------------------- |
| Column-level | Directly on a column      |
| Table-level  | Defined after all columns |

**Table-level example:**

PRIMARY KEY (employee_id, department_id)

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

### 6️⃣ `DEFAULT`

Assigns a **default value** when none is provided.

**Example:**

```sql
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

📌 Reduces missing data.

---

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

---

## Table-Level vs Column-Level Constraints

### Column-level:

```sql
email VARCHAR(255) UNIQUE
```

### Table-level:

```sql
UNIQUE (email, phone)
```

📌 Table-level is used for **composite constraints**.

## Common Interview Traps ⚠️

* ❌ Thinking `PRIMARY KEY` allows NULL → **it doesn’t**
* ❌ Confusing `UNIQUE` with `PRIMARY KEY`
* ❌ Forgetting `CHECK` exists
* ❌ Not knowing composite keys
