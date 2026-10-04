# Route

Associates trains with stations and stores stop order, arrival/departure times, and distance information.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `route_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique route-stop identifier |
| `train_id` | INT | NOT NULL, FOREIGN KEY | Train using this route |
| `station_id` | INT | NOT NULL, FOREIGN KEY | Station at which the train stops |
| `arrival_time` | TIME | Nullable | Arrival time at the station |
| `departure_time` | TIME | Nullable | Departure time from the station |
| `stop_no` | INT | NOT NULL | Order of the station in the train route |
| `distance_km` | DECIMAL(8,2) | Nullable | Distance from the route origin in kilometres |

### Primary Key
- `route_id`

### Foreign Keys
- `train_id` → `train(train_id)`
- `station_id` → `station(station_id)`

### Unique Constraints
- Composite unique key: (`train_id`, `station_id`)

This prevents the same station from being added more than once to the same train's route.

### Relationships
- One train can have many route stops.
- One station can be used by many trains.
- `route` therefore acts as the associative table between `train` and `station`.
