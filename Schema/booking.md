# Booking

Stores passenger railway booking information.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `booking_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique booking identifier |
| `seat_id` | INT | NOT NULL, FOREIGN KEY | Seat assigned to the booking |
| `journey_date` | DATE | NOT NULL | Date of the journey |
| `passenger_name` | VARCHAR(100) | NOT NULL | Name of the passenger making the booking |
| `booking_status` | VARCHAR(20) | NOT NULL, DEFAULT 'Confirmed' | Current booking status |
| `pnr_number` | VARCHAR(10) | UNIQUE | PNR number assigned to the booking |

### Primary Key
- `booking_id`

### Foreign Keys
- `seat_id` → `seat(seat_id)`

### Unique Constraints
- `pnr_number`

### Relationships
- Many bookings can reference a seat.
- A booking can have related payment records.
- A booking can have related cancellation records.

### Important Design Note
The table stores `passenger_name` instead of `passenger_id`. Therefore, there is no enforced foreign-key relationship between `booking` and `passenger`.
