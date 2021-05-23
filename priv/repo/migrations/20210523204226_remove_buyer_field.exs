defmodule TheMoonDrive.Repo.Migrations.RemoveBuyerField do
  use Ecto.Migration

  def change do
    alter table(:auctions) do
      remove :buyer
    end
  end
end
