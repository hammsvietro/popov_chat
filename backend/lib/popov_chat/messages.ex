defmodule PopovChat.Messages do
  alias PopovChat.Schemas.Message
  alias PopovChat.Repo
  import Ecto.Query, warn: false

  @per_chunk 30

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
          _notify_user(message, user_id)
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

  def get_group_messages(group_id, chunk) do
    from(m in Message,
      where: m.group_id == ^group_id,
      limit: @per_chunk,
      offset: ^(@per_chunk * chunk),
      order_by: [desc: m.inserted_at],
      join: u in assoc(m, :user),
      preload: [user: u]
    ) |> Repo.all
  end

end
