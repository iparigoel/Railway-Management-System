# Railway Management System — Database Schema

This folder contains the database schema documentation for the Railway Management System.

## Database

**Database name:** `railwayreservationsystem`  
**Database engine:** MySQL 

## Tables

1. `passenger` — stores passenger registration and login information.
2. `admin` — stores administrator and manager accounts.
3. `train` — stores train details.
4. `coach` — stores coaches belonging to trains.
5. `seat` — stores seats belonging to coaches.
6. `seatavailability` — stores seat availability for a particular journey date.
7. `booking` — stores passenger booking information.
8. `cancellation` — stores cancelled booking details and refunds.
9. `payment` — stores payment transactions for bookings.
10. `station` — stores railway station information.
11. `route` — maps trains to stations and stores stop/timing/distance information.

## Relationship Overview

```text
TRAIN
  |
  | 1 : N
  v
COACH
  |
  | 1 : N
  v
SEAT
  |   |  \ 1 : N
  |   v
  | SEATAVAILABILITY
  |
  | 1 : N
  v
BOOKING
  |   |  \ 1 : N
  |   v
  | PAYMENT
  |
  | 1 : N
  v
CANCELLATION

TRAIN 1 : N ROUTE N : 1 STATION

PASSENGER
  |
  | logical association through passenger_name
  v
BOOKING

ADMIN
  |
  | independent authentication/role table
  v
System Administration
```

> Note: `booking` does not contain a `passenger_id` foreign key. It stores `passenger_name` as text, so the relationship between `passenger` and `booking` is not enforced by a database foreign key.

## Table Summary

| Table | Primary Key | Foreign Keys |
|---|---|---|
| `passenger` | `passenger_id` | None |
| `admin` | `admin_id` | None |
| `train` | `train_id` | None |
| `coach` | `coach_id` | `train_id` → `train.train_id` |
| `seat` | `seat_id` | `coach_id` → `coach.coach_id` |
| `seatavailability` | `availability_id` | `seat_id` → `seat.seat_id` |
| `booking` | `booking_id` | `seat_id` → `seat.seat_id` |
| `cancellation` | `cancellation_id` | `booking_id` → `booking.booking_id` |
| `payment` | `payment_id` | `booking_id` → `booking.booking_id` |
| `station` | `station_id` | None |
| `route` | `route_id` | `train_id` → `train.train_id`, `station_id` → `station.station_id` |

