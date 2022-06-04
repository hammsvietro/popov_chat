defmodule PopovChat.Schemas.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:is_admin, :user_id, :group_id]

  schema "users_groups" do
    field :is_admin, :boolean, default: false
    belongs_to :user, PopovChat.Accounts.User
    belongs_to :group, PopovChat.Schemas.Group

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unsafe_validate_user_not_in_group()
  end

  def unsafe_validate_user_not_in_group(changeset) do
    unsafe_validate_unique(changeset, [:user_id, :group_id], PopovChat.Repo)
  end
end
