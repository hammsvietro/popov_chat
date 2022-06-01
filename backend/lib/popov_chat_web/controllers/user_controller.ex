defmodule PopovChatWeb.UserController do
  use PopovChatWeb, :controller
  alias PopovChat.Accounts

  def create(conn, body) do
    {:ok, user} = Accounts.register_user(body)
    {:ok, token} = Accounts.generate_user_session_token(user)
    json(conn, %{success: true, token: token})
  end
end
