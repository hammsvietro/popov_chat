defmodule PopovChatWeb.TokenController do
  use PopovChatWeb, :controller
  alias PopovChat.Accounts
  alias PopovChat.Accounts.User
  alias PopovChatWeb.UserAuth

  def login(conn, %{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email_and_password(email, password)
    generate_token_and_respond(conn, user)
  end

  def delete(conn, _) do
    conn
      |> UserAuth.log_out_user()
      |> send_resp(200, "")
  end

  defp generate_token_and_respond(conn, nil),
    do: json(conn, %{success: false, error: "Invalid credentials, try again."})

  defp generate_token_and_respond(conn, %User{} = user) do

    token = Accounts.generate_user_session_token(user)
    base64_encoded_token = Base.url_encode64(token, padding: false)
    conn
    |> UserAuth.write_login_cookies(token)
    |> json(%{success: true, token: base64_encoded_token, user_id: user.id})
  end
end
