# Seat

Stores individual seats within railway coaches.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `seat_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique seat identifier |
| `coach_id` | INT | NOT NULL, FOREIGN KEY | Coach containing the seat |
| `seat_number` | INT | NOT NULL | Seat number within the coach |
| `seat_type` | VARCHAR(20) | NOT NULL | Seat type such as Lower, Middle, or Upper |

### Primary Key
- `seat_id`

### Foreign Keys
- `coach_id` → `coach(coach_id)`

### Relationships
- Many seats belong to one coach.
- One seat can have many `seatavailability` records for different journey dates.
- One seat can be referenced by many bookings.
