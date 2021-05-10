defmodule TheMoonDriveWeb.AuctionLive.FormComponent do
  use TheMoonDriveWeb, :live_component

  alias TheMoonDrive.AuctionHouse

  @impl true
  def update(%{auction: auction} = assigns, socket) do
    changeset = AuctionHouse.change_auction(auction)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"auction" => auction_params}, socket) do
    changeset =
      socket.assigns.auction
      |> AuctionHouse.change_auction(auction_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"auction" => auction_params}, socket) do
    save_auction(socket, socket.assigns.action, auction_params)
  end

  defp save_auction(socket, :edit, auction_params) do
    case AuctionHouse.update_auction(socket.assigns.auction, auction_params) do
      {:ok, _auction} ->
        {:noreply,
         socket
         |> put_flash(:info, "Auction updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_auction(socket, :new, auction_params) do
    case AuctionHouse.create_auction(auction_params) do
      {:ok, _auction} ->
        {:noreply,
         socket
         |> put_flash(:info, "Auction created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
