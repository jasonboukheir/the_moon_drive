defmodule TheMoonDriveWeb.AuctionLiveTest do
  use TheMoonDriveWeb.ConnCase

  import Phoenix.LiveViewTest

  alias TheMoonDrive.AuctionHouse

  @create_attrs %{buyer: "some buyer", description: "some description", ends_at: "2010-04-17T14:00:00Z", image: "some image", posted_at: "2010-04-17T14:00:00Z", seller: "some seller"}
  @update_attrs %{buyer: "some updated buyer", description: "some updated description", ends_at: "2011-05-18T15:01:01Z", image: "some updated image", posted_at: "2011-05-18T15:01:01Z", seller: "some updated seller"}
  @invalid_attrs %{buyer: nil, description: nil, ends_at: nil, image: nil, posted_at: nil, seller: nil}

  defp fixture(:auction) do
    {:ok, auction} = AuctionHouse.create_auction(@create_attrs)
    auction
  end

  defp create_auction(_) do
    auction = fixture(:auction)
    %{auction: auction}
  end

  describe "Index" do
    setup [:create_auction]

    test "lists all auctions", %{conn: conn, auction: auction} do
      {:ok, _index_live, html} = live(conn, Routes.auction_index_path(conn, :index))

      assert html =~ "Listing Auctions"
      assert html =~ auction.buyer
    end

    test "saves new auction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.auction_index_path(conn, :index))

      assert index_live |> element("a", "New Auction") |> render_click() =~
               "New Auction"

      assert_patch(index_live, Routes.auction_index_path(conn, :new))

      assert index_live
             |> form("#auction-form", auction: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#auction-form", auction: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.auction_index_path(conn, :index))

      assert html =~ "Auction created successfully"
      assert html =~ "some buyer"
    end

    test "updates auction in listing", %{conn: conn, auction: auction} do
      {:ok, index_live, _html} = live(conn, Routes.auction_index_path(conn, :index))

      assert index_live |> element("#auction-#{auction.id} a", "Edit") |> render_click() =~
               "Edit Auction"

      assert_patch(index_live, Routes.auction_index_path(conn, :edit, auction))

      assert index_live
             |> form("#auction-form", auction: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#auction-form", auction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.auction_index_path(conn, :index))

      assert html =~ "Auction updated successfully"
      assert html =~ "some updated buyer"
    end

    test "deletes auction in listing", %{conn: conn, auction: auction} do
      {:ok, index_live, _html} = live(conn, Routes.auction_index_path(conn, :index))

      assert index_live |> element("#auction-#{auction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#auction-#{auction.id}")
    end
  end

  describe "Show" do
    setup [:create_auction]

    test "displays auction", %{conn: conn, auction: auction} do
      {:ok, _show_live, html} = live(conn, Routes.auction_show_path(conn, :show, auction))

      assert html =~ "Show Auction"
      assert html =~ auction.buyer
    end

    test "updates auction within modal", %{conn: conn, auction: auction} do
      {:ok, show_live, _html} = live(conn, Routes.auction_show_path(conn, :show, auction))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Auction"

      assert_patch(show_live, Routes.auction_show_path(conn, :edit, auction))

      assert show_live
             |> form("#auction-form", auction: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#auction-form", auction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.auction_show_path(conn, :show, auction))

      assert html =~ "Auction updated successfully"
      assert html =~ "some updated buyer"
    end
  end
end
