defmodule PopovChatWeb.MessageController do
  use PopovChatWeb, :controller

  def list(conn, %{"group_id" => group_id}) do
    chunk = 
      conn.query_params
      |> Map.get("chunk", "0")
      |> Integer.parse()
      |> elem(0)
    messages = PopovChat.Messages.get_group_messages(group_id, chunk)
    json(conn, messages)
  end
end
