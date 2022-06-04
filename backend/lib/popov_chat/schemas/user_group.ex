defmodule PopovChat.Schemas.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_groups" do
    field :is_admin, :boolean, default: false
    belongs_to :user, PopovChat.Accounts.User
    belongs_to :group, PopovChat.Schemas.Group

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:is_admin])
    |> validate_required([:is_admin])
  end
end
