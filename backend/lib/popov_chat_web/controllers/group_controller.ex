defmodule PopovChatWeb.GroupController do
  use PopovChatWeb, :controller 

  def create(conn, body) do
    user = conn.assigns[:current_user]
    {:ok, group} = PopovChat.Groups.create_group(user, body)
    json(conn, %{group: %{
      id: group.id,
      name: group.name,
      image: group.image
    }})
  end

  def list_not_joined(conn, _) do
    user = conn.assigns[:current_user]
    groups = PopovChat.Groups.list_groups_user_has_not_joined(user.id)
    json(conn, groups) 
  end

  def list(conn, _) do
    groups = conn.assigns[:current_user]
      |> PopovChat.Groups.list_groups_user_joined()
      |> Map.get(:groups)

    json(conn, groups) 
  end
end
