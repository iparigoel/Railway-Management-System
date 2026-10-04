# Cancellation

Stores cancellation information for bookings, including cancellation date, reason, and refund amount.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `cancellation_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique cancellation identifier |
| `booking_id` | INT | NOT NULL, FOREIGN KEY | Booking that was cancelled |
| `cancellation_date` | DATE | NOT NULL | Date on which cancellation occurred |
| `reason` | VARCHAR(200) | Nullable | Reason for cancellation |
| `refund_amount` | DECIMAL(10,2) | DEFAULT 0.00 | Amount refunded to the passenger |

### Primary Key
- `cancellation_id`

### Foreign Keys
- `booking_id` → `booking(booking_id)`

### Relationships
- A cancellation belongs to a booking.
- The current schema does not define `booking_id` as UNIQUE, so multiple cancellation records can technically reference the same booking.
