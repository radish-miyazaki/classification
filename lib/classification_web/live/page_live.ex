defmodule ClassificationWeb.PageLive do
  use ClassificationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:upload_file, nil)
      |> assign(:filename, nil)
      |> allow_upload(
        :image,
        accept: ~w(.jpg .jpge .png),
        progress: &handle_progress/3,
        auto_upload: true
      )
    }
  end

  @impl true
  def handle_event("upload", _params, socket) do
    {:noreply, socket}
  end

  def handle_progress(:image, entry, socket)
      when entry.done? == false,
      # ファイルアップロードが完了するまでは何もしない
      do: {:noreply, socket}

  def handler_progress(:image, entry, socket) do
    # アップロードされたファイルを読み込む
    upload_file =
      consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
        File.read(path)
      end)
      |> hd()

    {
      :noreply,
      socket
      |> assign(:upload_file, upload_file)
      |> assign(:filename, entry.client_name)
    }
  end
end
