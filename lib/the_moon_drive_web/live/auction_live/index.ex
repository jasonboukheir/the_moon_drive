defmodule TheMoonDriveWeb.AuctionLive.Index do
  use TheMoonDriveWeb, :live_view

  alias TheMoonDrive.AuctionHouse
  alias TheMoonDrive.AuctionHouse.Auction

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :auctions, list_auctions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Auction")
    |> assign(:auction, AuctionHouse.get_auction!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Auction")
    |> assign(:auction, %Auction{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Auctions")
    |> assign(:auction, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    auction = AuctionHouse.get_auction!(id)
    {:ok, _} = AuctionHouse.delete_auction(auction)

    {:noreply, assign(socket, :auctions, list_auctions())}
  end

  defp list_auctions do
    AuctionHouse.list_auctions()
  end
end
