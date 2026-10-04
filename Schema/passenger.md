# Passenger

Stores registration, contact, and authentication information for railway passengers.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `passenger_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique passenger identifier |
| `passenger_name` | VARCHAR(100) | NOT NULL | Full name of the passenger |
| `age` | INT | NOT NULL | Age of the passenger |
| `gender` | VARCHAR(10) | NOT NULL | Gender of the passenger |
| `phone` | VARCHAR(15) | NOT NULL, UNIQUE | Passenger phone number |
| `email` | VARCHAR(100) | NOT NULL, UNIQUE | Passenger email address |
| `password` | VARCHAR(100) | NOT NULL | Passenger login password |

### Primary Key
- `passenger_id`

### Unique Constraints
- `phone`
- `email`

### Relationships
No foreign keys are defined in this table.
