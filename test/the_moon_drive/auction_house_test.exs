defmodule TheMoonDrive.AuctionHouseTest do
  use TheMoonDrive.DataCase

  alias TheMoonDrive.AuctionHouse

  describe "auctions" do
    alias TheMoonDrive.AuctionHouse.Auction

    @valid_attrs %{buyer: "some buyer", description: "some description", ends_at: "2010-04-17T14:00:00Z", image: "some image", seller: "some seller"}
    @update_attrs %{buyer: "some updated buyer", description: "some updated description", ends_at: "2011-05-18T15:01:01Z", image: "some updated image", seller: "some updated seller"}
    @invalid_attrs %{buyer: nil, description: nil, ends_at: nil, image: nil, seller: nil}

    def auction_fixture(attrs \\ %{}) do
      {:ok, auction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AuctionHouse.create_auction()

      auction
    end

    test "list_auctions/0 returns all auctions" do
      auction = auction_fixture()
      assert AuctionHouse.list_auctions() == [auction]
    end

    test "get_auction!/1 returns the auction with given id" do
      auction = auction_fixture()
      assert AuctionHouse.get_auction!(auction.id) == auction
    end

    test "create_auction/1 with valid data creates a auction" do
      assert {:ok, %Auction{} = auction} = AuctionHouse.create_auction(@valid_attrs)
      assert auction.buyer == "some buyer"
      assert auction.description == "some description"
      assert auction.ends_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert auction.image == "some image"
      assert auction.seller == "some seller"
    end

    test "create_auction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AuctionHouse.create_auction(@invalid_attrs)
    end

    test "update_auction/2 with valid data updates the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{} = auction} = AuctionHouse.update_auction(auction, @update_attrs)
      assert auction.buyer == "some updated buyer"
      assert auction.description == "some updated description"
      assert auction.ends_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert auction.image == "some updated image"
      assert auction.seller == "some updated seller"
    end

    test "update_auction/2 with invalid data returns error changeset" do
      auction = auction_fixture()
      assert {:error, %Ecto.Changeset{}} = AuctionHouse.update_auction(auction, @invalid_attrs)
      assert auction == AuctionHouse.get_auction!(auction.id)
    end

    test "delete_auction/1 deletes the auction" do
      auction = auction_fixture()
      assert {:ok, %Auction{}} = AuctionHouse.delete_auction(auction)
      assert_raise Ecto.NoResultsError, fn -> AuctionHouse.get_auction!(auction.id) end
    end

    test "change_auction/1 returns a auction changeset" do
      auction = auction_fixture()
      assert %Ecto.Changeset{} = AuctionHouse.change_auction(auction)
    end
  end
end
