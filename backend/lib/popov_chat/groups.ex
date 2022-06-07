defmodule PopovChat.Groups do
  import Ecto.Query, warn: false
  alias PopovChat.Repo
  alias PopovChat.Schemas.{Group, UserGroup}
  alias PopovChat.Accounts.User

  @spec create_group(User.t(), any()) :: {:ok, any()}| {:error, any()}
  def create_group(%User{} = user, %{"image" => image_file} = attrs) do
    user
      |> _create_group_multi(attrs)
      |> Repo.transaction()
      |> case do
        {:ok, %{group: group}} -> _post_create_group(group, image_file)
        {:error, _, changeset, _} -> {:error, changeset}
      end
  end


  @spec list_groups_user_has_not_joined(number()) :: list(Group.t())
  def list_groups_user_has_not_joined(user_id) do
    query = 
        from(UserGroup, as: :ug)
          |> join(:left, [ug: user_group], assoc(user_group, :group), as: :group)
          |> where([ug: user_group], user_group.user_id != ^user_id)
          |> select([group: g], %{id: g.id, name: g.name, image: g.image})
          |> group_by([group: g], g.id)
    Repo.all(query)
  end

  @spec list_groups_user_joined(User.t()) :: User.t()
  def list_groups_user_joined(%User{} = user) do
    Repo.preload user, :groups
  end

  @spec group_details(number()) :: Group.t()
  def group_details(group_id) do
    Repo.get(Group, group_id) |> Repo.preload(:users)
  end

  @spec join_group(number(), number()) :: Group.t()
  def join_group(user_id, group_id) do
    UserGroup.changeset(%UserGroup{}, %{
      user_id: user_id,
      group_id: group_id,
      is_admin: false,
    }) |> Repo.insert()
    group_details(group_id)
    
  end

  def get_user_ids_by_group(group_id) do
    query = from u in UserGroup,
              where: u.group_id == ^group_id,
              select: u.user_id
    Repo.all(query)
  end

  defp _create_group_multi(%User{} = user, attrs) do
    Ecto.Multi.new
      |> Ecto.Multi.insert(:group, Group.changeset(%Group{}, attrs))
      |> Ecto.Multi.insert(:user_group, fn %{group: group} -> 
        UserGroup.changeset(%UserGroup{}, %{
          user_id: user.id,
          group_id: group.id,
          is_admin: true,
        })
      end)
  end

  defp _post_create_group(%Group{} = group, %Plug.Upload{} = image_file) do
    case PopovChat.Bucket.upload_image(image_file, group.image) do
      {:ok, _} -> {:ok, group}
      {:error, _} -> {:ok, "Coudldn't upload to s3"}
    end
  end
end
