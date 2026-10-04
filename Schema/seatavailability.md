# Seat Availability

Stores the availability status of a seat for a specific journey date.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `availability_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique availability record |
| `seat_id` | INT | NOT NULL, FOREIGN KEY | Seat whose availability is tracked |
| `journey_date` | DATE | NOT NULL | Date for which availability is recorded |
| `status` | VARCHAR(20) | NOT NULL | Availability status such as Available or Booked |

### Primary Key
- `availability_id`

### Foreign Keys
- `seat_id` → `seat(seat_id)`

### Unique Constraints
- Composite unique key: (`seat_id`, `journey_date`)

This ensures that a seat has at most one availability record for a particular journey date.

### Relationships
- Many availability records can belong to one seat, one for each journey date.
