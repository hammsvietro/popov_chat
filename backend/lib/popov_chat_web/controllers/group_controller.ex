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

    json(conn, groups) 
  end

  def details(conn, %{"group_id" => group_id}) do
    json(conn, PopovChat.Groups.group_details(group_id))
  end

  def join(conn, %{"group_id" => group_id}) do
    user = conn.assigns[:current_user]
    group = PopovChat.Groups.join_group(user.id, group_id)
    json(conn, group) 
  end
end
