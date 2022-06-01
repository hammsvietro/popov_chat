defmodule PopovChatWeb.RootController do
  use PopovChatWeb, :controller

  def index(conn, _params) do
    json(conn, %{hello: "world"})
  end
end
