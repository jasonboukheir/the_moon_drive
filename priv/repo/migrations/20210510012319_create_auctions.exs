defmodule TheMoonDrive.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :seller, :string
      add :buyer, :string
      add :image, :binary
      add :description, :string
      add :posted_at, :utc_datetime
      add :ends_at, :utc_datetime

      timestamps()
    end

  end
end
