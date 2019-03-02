defmodule ConstrutoraLcHiert.Repo do
  use Ecto.Repo,
    otp_app: :construtora_lc_hiert,
    adapter: Ecto.Adapters.Postgres
end
