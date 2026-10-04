# Station

Stores railway station information.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `station_id` | INT | PRIMARY KEY, AUTO_INCREMENT, NOT NULL | Unique station identifier |
| `station_name` | VARCHAR(100) | NOT NULL | Name of the railway station |
| `city` | VARCHAR(100) | NOT NULL | City where the station is located |

### Primary Key
- `station_id`

### Relationships
- One station can appear in many `route` records.
