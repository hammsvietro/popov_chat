defmodule PopovChatWeb.ChatChannel do
  use PopovChatWeb, :channel

  @impl true
  def join("chat:"<> _user_id, _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("message", payload, socket) do
    message = %{"content" => payload["content"], "group_id" => payload["groupId"], "user_id" => socket.assigns.current_user.id}
    PopovChat.Messages.handle_new_message(message)
    {:noreply, socket}
  end
end
