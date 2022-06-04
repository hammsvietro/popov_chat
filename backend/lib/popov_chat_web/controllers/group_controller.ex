defmodule PopovChatWeb.GroupController do
  use PopovChatWeb, :controller 

  def create(conn, opts) do
    json(conn, %{})
  end

  def read_sesh(conn, _) do

    ovo = conn |> fetch_session |> get_session(:ovo) |> IO.inspect()
    json(conn, %{ovo: ovo})

  end
end
