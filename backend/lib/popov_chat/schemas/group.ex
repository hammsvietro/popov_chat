defmodule PopovChat.Schemas.Group do
  use Ecto.Schema
  import Ecto.Changeset

  defimpl Jason.Encoder, for: PopovChat.Schemas.Group  do
    def encode(value, opts) do
      base = _get_base(value)
      Jason.Encode.map(Map.take(value, base), opts)
    end

    defp _get_base(value) do
      value
        |> Map.to_list()
        |> Enum.map(fn {key, val} -> 
          if is_struct(val, Ecto.Association.NotLoaded) or key == :__meta__ or key == :__struct__ do
            nil
          else
            key
          end
      end)
    end
  end

  schema "groups" do
    field :image, :string
    field :name, :string
    many_to_many :users, PopovChat.Accounts.User,
      join_through: PopovChat.Schemas.UserGroup

    has_many :users_groups, PopovChat.Schemas.UserGroup,
      on_delete: :delete_all

    has_many :messages, PopovChat.Schemas.Message


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
