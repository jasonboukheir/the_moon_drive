defmodule TheMoonDriveWeb.AuctionLive.Show do
  use TheMoonDriveWeb, :live_view

  alias TheMoonDrive.AuctionHouse

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:auction, AuctionHouse.get_auction!(id))}
  end

  defp page_title(:show), do: "Show Auction"
  defp page_title(:edit), do: "Edit Auction"
end
