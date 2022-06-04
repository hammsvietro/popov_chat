defmodule PopovChat.Schemas.Group do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:image, :name, :users]}

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
    |> cast(attrs, [:name])
    |> put_image_name(attrs)
    |> validate_required([:name, :image])
  end

  defp put_image_name(changeset, %{"image" => file}) do
    file_name = Ecto.UUID.generate() <> file.filename |> PopovChat.Bucket.build_full_url()
    changeset
      |> put_change(:image, file_name)
  end
end
