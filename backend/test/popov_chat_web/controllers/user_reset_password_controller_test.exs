defmodule PopovChatWeb.UserResetPasswordControllerTest do
  use PopovChatWeb.ConnCase, async: true

  alias PopovChat.Accounts
  alias PopovChat.Repo
  import PopovChat.AccountsFixtures

  setup do
    %{user: user_fixture()}
  end

  describe "GET /users/reset_password" do
    test "renders the reset password page", %{conn: conn} do
      conn = get(conn, Routes.user_reset_password_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>Forgot your password?</h1>"
    end
  end
end
