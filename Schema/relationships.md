# Database Relationships

## 1. Train → Coach

**Relationship:** One-to-Many

```text
train.train_id
      |
      | 1
      |
      | N
coach.train_id
```

One train can contain multiple coaches.

## 2. Coach → Seat

**Relationship:** One-to-Many

```text
coach.coach_id
      |
      | 1
      |
      | N
seat.coach_id
```

One coach can contain multiple seats.

## 3. Seat → Seat Availability

**Relationship:** One-to-Many

```text
seat.seat_id
      |
      | 1
      |
      | N
seatavailability.seat_id
```

A seat can have availability records for multiple journey dates.

The composite unique key `(seat_id, journey_date)` ensures that the same seat cannot have duplicate availability records for the same date.

## 4. Seat → Booking

**Relationship:** One-to-Many

```text
seat.seat_id
      |
      | 1
      |
      | N
booking.seat_id
```

A seat can be referenced by multiple bookings across different journey dates.

## 5. Booking → Cancellation

**Relationship:** One-to-Many in the current schema

```text
booking.booking_id
      |
      | 1
      |
      | N
cancellation.booking_id
```

The database does not enforce one cancellation per booking because `booking_id` is not unique in `cancellation`.

## 6. Booking → Payment

**Relationship:** One-to-Many in the current schema

```text
booking.booking_id
      |
      | 1
      |
      | N
payment.booking_id
```

The schema allows multiple payment records for one booking.

## 7. Train → Route

**Relationship:** One-to-Many

```text
train.train_id
      |
      | 1
      |
      | N
route.train_id
```

A train can have multiple route stops.

## 8. Station → Route

**Relationship:** One-to-Many

```text
station.station_id
      |
      | 1
      |
      | N
route.station_id
```

A station can occur in routes of multiple trains.

## 9. Train ↔ Station

`route` acts as the associative table.

```text
TRAIN 1 ───── N ROUTE N ───── 1 STATION
```

This represents a many-to-many relationship between trains and stations.

## 10. Passenger → Booking

There is **no database foreign-key relationship** in the current schema.

`booking` stores:

```text
passenger_name VARCHAR(100)
```

rather than:

```text
passenger_id INT
```

Therefore, passenger identity is associated by name in application/query logic rather than enforced by the relational database.
