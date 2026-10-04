# Coach

Stores coaches assigned to trains.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `coach_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique coach identifier |
| `train_id` | INT | NOT NULL, FOREIGN KEY | Train to which the coach belongs |
| `coach_number` | VARCHAR(10) | NOT NULL | Coach number such as S1 or A1 |
| `coach_type` | VARCHAR(50) | NOT NULL | Type of coach, e.g. Sleeper or AC |
| `total_seats` | INT | NOT NULL | Total number of seats in the coach |

### Primary Key
- `coach_id`

### Foreign Keys
- `train_id` → `train(train_id)`

### Relationships
- Many coaches belong to one train.
- One coach can contain many seats.
