# Api

Trying to build an API using Elixir and Plug.

## Installation

Clone the project, enter with your shell inside the directory and run:

    $ mix deps.get

You need a postgres DB to run the example:

```sql
CREATE USER postgres WITH CREATEDB PASSWORD 'postgres';
CREATE DATABASE users;
GRANT ALL PRIVILEGES ON DATABASE users TO postgres;
\c users;
CREATE TABLE users(name varchar NOT NULL,surname varchar NOT NULL);
GRANT ALL PRIVILEGES ON TABLE users TO postgres;
```

You can then run the application as:

    $ iex -S mix

then go to browser and go to `http://127.0.0.1:4000/users`
You can run the tests as:

    $ mix test

## Improvements to be done

    1) Extract http port
    2) Use a pool_boy to handle db connections
    3) App.users should return not a list but a structure

