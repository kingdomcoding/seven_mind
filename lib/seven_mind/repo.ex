defmodule SevenMind.Repo do
  use Ecto.Repo,
    otp_app: :seven_mind,
    adapter: Ecto.Adapters.Postgres
end
