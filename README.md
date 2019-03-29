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

This app is on Heroku: [construtora-lc-hiert.herokuapp.com](https://construtora-lc-hiert.herokuapp.com/)
It will be automatically deployed to production when pushed to master.

#### Environment variables

You have to define the following variables **(Production environment only)**:

- Secret Keys (you can use `mix phx.gen.secret` to generate it):
  - SECRET_KEY_BASE
  - GUARDIAN_SECRET_KEY

- External Services Keys:
  - SENDGRID_API_KEY

- Database configs:
  - DATABASE_URL
  - POOL_SIZE
