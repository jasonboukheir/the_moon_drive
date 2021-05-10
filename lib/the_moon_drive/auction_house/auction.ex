defmodule TheMoonDrive.AuctionHouse.Auction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auctions" do
    field :buyer, :string
    field :description, :string
    field :ends_at, :utc_datetime
    field :image, :binary
    field :posted_at, :utc_datetime
    field :seller, :string

    timestamps()
  end

  @doc false
  def changeset(auction, attrs) do
    auction
    |> cast(attrs, [:image, :description, :ends_at])
    |> validate_required([:image, :description, :ends_at])
  end
end
