defmodule PopovChatWeb.UserController do
  use PopovChatWeb, :controller
  alias PopovChat.Accounts

  def create(conn, body) do
    case Accounts.register_user(body) do 
      {:ok, user} -> token = Accounts.generate_user_session_token(user)
        conn
          |> PopovChatWeb.UserAuth.write_login_cookies(token)
          |> json(%{success: true, token: Base.url_encode64(token, padding: false), user_id: user.id})
      {:error, changeset} -> conn
        |> put_status(400)
        |> json(JaSerializer.EctoErrorSerializer.format(changeset.errors))
    end
  end
end
