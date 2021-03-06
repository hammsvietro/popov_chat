defmodule PopovChat.Repo.Migrations.CreateUsersGroups do
  use Ecto.Migration

  def change do
    create table(:users_groups) do
      add :is_admin, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end

    create index(:users_groups, [:user_id])
    create index(:users_groups, [:group_id])
  end
end
