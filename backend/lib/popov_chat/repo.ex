defmodule PopovChat.Repo do
  use Ecto.Repo,
    otp_app: :popov_chat,
    adapter: Ecto.Adapters.Postgres
end
