defmodule PopovChat.Schemas.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :image, :string
    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :image])
    |> validate_required([:content, :image])
  end
end
