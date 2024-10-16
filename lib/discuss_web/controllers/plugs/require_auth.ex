defmodule DiscussWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be signed in to access this page")
      # |> redirect(to: Helpers.topic_path(conn, :index))
      |> redirect(to: "/")
      |> halt()
    end
  end
end
