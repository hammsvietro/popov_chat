defmodule PopovChat.Schemas.Message do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:image, :content, :user, :inserted_at]}

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
      |> cast(attrs, [:content, :image, :user_id, :group_id])
      |> validate_required([:content])
  end

end
