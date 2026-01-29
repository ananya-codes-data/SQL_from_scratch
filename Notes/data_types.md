# Data Types

In **SQL**, **data types** define **what kind of data a column can store** — numbers, text, dates, etc.

## What are Data Types in SQL?

Data types specify:

* **Type of value** (number, text, date)
* **Range of values**
* **Storage size**
* **Operations allowed on the data**

📌 *Example:* You wouldn’t store a date in a text column.

## Main Categories of SQL Data Types

### 1️⃣ Numeric Data Types

Used to store **numbers**

#### a. Integer Types

| Data Type         | Description               |
| ----------------- | ------------------------- |
| `INT` / `INTEGER` | Whole numbers             |
| `SMALLINT`        | Smaller range of integers |
| `BIGINT`          | Very large integers       |

**Example:**

```sql
age INT,
order_count BIGINT
```

#### b. Decimal / Floating-Point Types

Used for **numbers with decimals**

| Data Type                         | Description                       |
| --------------------------------- | --------------------------------- |
| `DECIMAL(p, s)` / `NUMERIC(p, s)` | Exact precision (used in finance) |
| `FLOAT`, `REAL`, `DOUBLE`         | Approximate values                |

**Example:**

```sql
salary DECIMAL(10,2),
rating FLOAT
```

📌 **Interview tip:**

> Use `DECIMAL` for **money**, not `FLOAT`.

### 2️⃣ Character / String Data Types

Used to store **text**

| Data Type    | Description            |
| ------------ | ---------------------- |
| `CHAR(n)`    | Fixed-length string    |
| `VARCHAR(n)` | Variable-length string |
| `TEXT`       | Large text             |

**Example:**

```sql
name VARCHAR(100),
description TEXT
```

📌 **Interview tip:**

> `VARCHAR` is preferred over `CHAR` unless fixed length is required.

### 3️⃣ Date & Time Data Types

Used to store **dates and timestamps**

| Data Type                  | Description             |
| -------------------------- | ----------------------- |
| `DATE`                     | Stores date only        |
| `TIME`                     | Stores time only        |
| `TIMESTAMP`                | Date + time             |
| `TIMESTAMPTZ` (PostgreSQL) | Timestamp with timezone |

**Example:**

```sql
order_date DATE,
created_at TIMESTAMP
```

### 4️⃣ Boolean Data Type

Used to store **true/false values**

```sql
BOOLEAN
```

**Example:**

```sql
is_active BOOLEAN
```

Possible values:

* `TRUE`
* `FALSE`
* `NULL`

### 5️⃣ Binary Data Types (less common)

Used to store **images, files, raw data**

| Data Type            | Description         |
| -------------------- | ------------------- |
| `BLOB`               | Binary Large Object |
| `BYTEA` (PostgreSQL) | Binary data         |

### 6️⃣ Special / Advanced Data Types (DB-specific)

#### PostgreSQL Examples:

| Data Type        | Use                           |
| ---------------- | ----------------------------- |
| `UUID`           | Unique identifiers            |
| `JSON` / `JSONB` | Store JSON data               |
| `ARRAY`          | Multiple values in one column |
| `ENUM`           | Fixed set of values           |

**Example:**

```sql
status ENUM('active','inactive'),
metadata JSONB
```

## Simple Interview Answer

> “SQL data types define the kind of data a column can store, such as numeric, string, date-time, and boolean values. Choosing the correct data type helps with data integrity, performance, and storage efficiency.”

## Common Interview Follow-ups

* Difference between `CHAR` and `VARCHAR`
* `FLOAT` vs `DECIMAL`
* Why use `TIMESTAMP` instead of `VARCHAR`
* `NULL` vs `0`
