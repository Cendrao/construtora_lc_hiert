# Construtora LC Hiert

|> [construtoralchiert.com.br](https://construtoralchiert.com.br)

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

It will be automatically deployed to production when pushed to master.

### Create a new user

You have to open the console running:
```bash
iex -S mix
```
And then create the user:
```elixir
ConstrutoraLcHiert.Accounts.create_user(%{username: "admin", password: "admin", master: true})
```

#### Environment variables

You have to define the following variables **(Production environment only)**:

- Secret Keys (you can use `mix phx.gen.secret` to generate it):
  - SECRET_KEY_BASE
  - GUARDIAN_SECRET_KEY

- Email Services Keys:
  - SENDGRID_API_KEY

- Database Keys:
  - DATABASE_URL
  - POOL_SIZE: `10`

- AWS S3 Keys
  - S3_BUCKET
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

- Sentry
  - SENTRY_DSN
