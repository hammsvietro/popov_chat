defmodule PopovChatWeb.TokenController do
  use PopovChatWeb, :controller
  alias PopovChat.Accounts
  alias PopovChat.Accounts.User

  def login(conn, %{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email_and_password(email, password)
    generate_token_and_respond(conn, user)
  end

  defp generate_token_and_respond(conn, nil),
    do: json(conn, %{success: false, error: "Invalid credentials, try again."})

  defp generate_token_and_respond(conn, %User{} = user) do

    {:ok, token} = Accounts.generate_user_session_token(user)

    json(conn, %{ success: true, token: token })
  end
end
