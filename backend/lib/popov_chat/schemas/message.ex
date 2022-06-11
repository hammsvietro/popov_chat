defmodule PopovChat.Schemas.Message do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:group_id, :id, :image, :content, :user, :inserted_at]}

  schema "messages" do
    field :content, :string
    field :image, :string
    belongs_to :group, PopovChat.Schemas.Group
    belongs_to :user, PopovChat.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
      |> cast(attrs, [:image, :user_id, :group_id])
      |> put_change(:content, String.trim(attrs["content"]))
      |> validate_required([:content])
  end

end
