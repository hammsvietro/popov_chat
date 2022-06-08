defmodule PopovChat.Messages do
  alias PopovChat.Schemas.Message
  alias PopovChat.Repo

  def handle_new_message(message) do
    message
      |> _add_message
      |> _notify_new_message
  end

  defp _add_message(message) do
    %Message{}
      |> Message.changeset(message)
      |> Repo.insert!()
      |> Repo.preload(:user)
  end

  defp _notify_new_message(%Message{} = message) do
    IO.inspect(message)
    message.group_id
      |> PopovChat.Groups.get_user_ids_by_group
      |> Enum.each(fn user_id -> 
        if user_id != message.user_id do
          _notify_user(message, user_id)
        end
      end)
    message
  end

  defp _notify_user(%Message{} = message, user_id) do
    stringified_user_id = to_string(user_id)
    PopovChatWeb.Endpoint.broadcast!(
      "chat:"<>stringified_user_id, 
      "message",
      message
    )
  end

end
