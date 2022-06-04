defmodule PopovChat.Schemas.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :image, :string
    field :name, :string
    many_to_many :users, PopovChat.Accounts.User,
      join_through: PopovChat.Schemas.UserGroup

    has_many :users_groups, PopovChat.Schemas.UserGroup,
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :image])
    |> validate_required([:name, :image])
  end
end
