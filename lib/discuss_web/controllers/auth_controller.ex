defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth


  def callback(conn, params) do
    IO.inspect("++++++++++++++++")
    IO.inspect(conn.assigns)
    IO.inspect("++++++++++++++++")
    IO.inspect(params)
    IO.inspect("++++++++++++++++")
  end


end
