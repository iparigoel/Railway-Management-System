# Admin

Stores administrator and manager login accounts.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `admin_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique admin identifier |
| `admin_name` | VARCHAR(100) | NOT NULL | Name of the administrator |
| `email` | VARCHAR(100) | NOT NULL, UNIQUE | Admin email address |
| `password` | VARCHAR(255) | NOT NULL | Admin login password |
| `role` | VARCHAR(50) | NOT NULL, DEFAULT 'ADMIN' | Role assigned to the account |

### Primary Key
- `admin_id`

### Unique Constraints
- `email`

### Relationships
No foreign keys are defined in this table.
