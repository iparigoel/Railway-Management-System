# Train

Stores basic information about trains operated by the railway system.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `train_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique train identifier |
| `train_number` | VARCHAR(10) | NOT NULL, UNIQUE | Unique train number |
| `train_name` | VARCHAR(100) | NOT NULL | Name of the train |

### Primary Key
- `train_id`

### Unique Constraints
- `train_number`

### Relationships
- One train can have many `coach` records.
- One train can have many `route` records.
