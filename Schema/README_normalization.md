# Railway Management System — Normalization

This folder contains the normalized SQL design for the Railway Management System.

## Normalization implemented

The database is designed to satisfy:

- **1NF:** Atomic attributes and no repeating groups.
- **2NF:** No partial dependency on a part of a composite candidate key. `seatavailability` uses `(seat_id, journey_date)` as its business-level candidate key.
- **3NF:** No transitive dependency among non-key attributes.

## Main normalization improvement

The original `booking` table stored `passenger_name` directly. The normalized design removes that duplicate attribute and stores `passenger_id` as a foreign key instead:

```text
PASSENGER
---------
passenger_id (PK)
passenger_name
age
gender
phone
email
password

BOOKING
-------
booking_id (PK)
pnr_number
passenger_id (FK)
seat_id (FK)
journey_date
booking_status
```

Passenger details are therefore maintained in one place.

## Final 3NF relations

```text
PASSENGER(passenger_id, passenger_name, age, gender, phone, email, password)
TRAIN(train_id, train_number, train_name)
STATION(station_id, station_name, city)
COACH(coach_id, train_id, coach_number, coach_type, total_seats)
SEAT(seat_id, coach_id, seat_number, seat_type)
ROUTE(route_id, train_id, station_id, arrival_time, departure_time, stop_no, distance_km)
BOOKING(booking_id, pnr_number, passenger_id, seat_id, journey_date, booking_status)
SEATAVAILABILITY(availability_id, seat_id, journey_date, status)
PAYMENT(payment_id, booking_id, payment_date, amount, payment_method, payment_status, transaction_id)
CANCELLATION(cancellation_id, booking_id, cancellation_date, reason, refund_amount)
ADMIN(admin_id, admin_name, email, password, role)
```

## Functional dependencies

```text
passenger_id -> passenger_name, age, gender, phone, email, password
train_id -> train_number, train_name
coach_id -> train_id, coach_number, coach_type, total_seats
seat_id -> coach_id, seat_number, seat_type
(seat_id, journey_date) -> status
booking_id -> pnr_number, passenger_id, seat_id, journey_date, booking_status
payment_id -> booking_id, payment_date, amount, payment_method, payment_status, transaction_id
cancellation_id -> booking_id, cancellation_date, reason, refund_amount
station_id -> station_name, city
route_id -> train_id, station_id, arrival_time, departure_time, stop_no, distance_km
admin_id -> admin_name, email, password, role
```

## Files

- `normalized_schema.sql` — complete SQL schema, sample data, foreign keys, and report views.

## Import

Run `normalized_schema.sql` in MySQL after backing up the existing database. The script recreates the normalized schema and includes sample data based on the uploaded project SQL files.

> Note: The original project may contain application code that expects `booking.passenger_name`. That code must be updated to use `booking.passenger_id` and join with `passenger` when the normalized schema is adopted.
