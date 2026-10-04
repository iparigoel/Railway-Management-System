# Payment

Stores payment transactions associated with railway bookings.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `payment_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique payment identifier |
| `booking_id` | INT | NOT NULL, FOREIGN KEY | Booking for which payment was made |
| `payment_date` | DATETIME | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Date and time of payment |
| `amount` | DECIMAL(10,2) | NOT NULL | Payment amount |
| `payment_method` | VARCHAR(30) | NOT NULL | Method such as UPI, Card, or Net Banking |
| `payment_status` | VARCHAR(20) | NOT NULL | Payment status such as SUCCESS or PENDING |
| `transaction_id` | VARCHAR(50) | UNIQUE | Unique transaction reference |

### Primary Key
- `payment_id`

### Foreign Keys
- `booking_id` → `booking(booking_id)`

### Unique Constraints
- `transaction_id`

### Relationships
- A payment belongs to a booking.
- The schema permits multiple payment records for the same booking.
