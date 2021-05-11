defmodule TheMoonDrive.Repo.Migrations.RemovePostedAtField do
  use Ecto.Migration

  def change do
    alter table(:auctions) do
      remove :posted_at
    end
  end
end
