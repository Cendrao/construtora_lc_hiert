# Construtora LC Hiert

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Deployment

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

### Environment variables

You have to define the following variables:

- SECRET_KEY_BASE
- GUARDIAN_SECRET_KEY

You can use `mix phx.gen.secret` to generate it ☝

- DB_USER
- DB_PASS
- DB_NAME
- DB_PORT
- DB_POOL
