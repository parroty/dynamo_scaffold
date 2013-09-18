# Dynamo Scaffold

Sample dynamo project for implementing rails-like scaffold page with REST API backend.
The backend is on ecto (https://github.com/elixir-lang/ecto) and postgres DB.

![htmlimage](https://raw.github.com/parroty/dynamo_scaffold/master/image/dynamo_scaffold.png?w=400&h300)

## Settings

##### Clone repo

```
git clone https://github.com/parroty/dynamo_scaffold
```

##### Create table on postgreSQL
Create table on "ecto_simple" database.
(accessed db is defined in simple.ex as "ecto://postgres:postgres@localhost/ecto_simple").

```sql
CREATE TABLE weather (
  id        SERIAL,
  city      varchar(40),
  temp_lo   integer,
  temp_hi   integer,
  prcp      float
);
```

##### Start server

* `mix deps.get`
* `iex -S mix`

