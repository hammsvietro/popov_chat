defmodule PopovChatWeb.PageController do
  use PopovChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
