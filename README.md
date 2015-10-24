# Api

Trying to build an API using Elixir and Plug.

## Installation

Clone the project, enter with your shell inside the directory and run:

    $ mix deps.get

You need a postgres DB to run the example:

    1) db user: postgres
    2) db password: postgres
    3) db name: users
    4) db table: users, with two fields (name, surname)

You can then run the application as:

    $ iex -S mix

then go to browser and go to `http://127.0.0.1:4000/users`
You can run the tests as:

    $ mix test

## Improvements to be done

    1) Extract DB configuration
    2) Extract http port
    3) Use a pool_boy to handle db connections
    4) App.users should return not a list but a structure

