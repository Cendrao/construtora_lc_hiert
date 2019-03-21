# Construtora LC Hiert

## Installation

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Emails

To test your email messages on development environment you can visit
[`localhost:4000/sent_emails`](http://localhost:4000/sent_emails)


## Deployment

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

#### Environment variables

You have to define the following variables **(Production environment only)**:

- Secret Keys (you can use `mix phx.gen.secret` to generate it):
  - SECRET_KEY_BASE
  - GUARDIAN_SECRET_KEY

- External Services Keys:
  - SENDGRID_API_KEY

- Database configs:
  - DB_USER
  - DB_PASS
  - DB_NAME
  - DB_PORT
  - DB_POOL
