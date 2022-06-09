defmodule PopovChatWeb.ChatChannel do
  use PopovChatWeb, :channel

  @impl true
  def join("chat:"<> _user_id, _payload, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("message", payload, socket) do
    message = %{"content" => payload["content"], "group_id" => payload["groupId"], "user_id" => socket.assigns.current_user.id}
    IO.inspect(message)
    PopovChat.Messages.handle_new_message(message)
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
