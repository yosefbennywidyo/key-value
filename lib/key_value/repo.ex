defmodule KeyValue.Repo do
  use Ecto.Repo,
    otp_app: :key_value,
    adapter: Ecto.Adapters.Postgres
end
