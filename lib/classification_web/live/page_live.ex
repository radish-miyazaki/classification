defmodule ClassificationWeb.PageLive do
  use ClassificationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> allow_upload(:image, accept: ~w(.jpg .jpge .png))
    }
  end

  @impl true
  def handle_event("upload", _params, socket) do
    {:noreply, socket}
  end
end
