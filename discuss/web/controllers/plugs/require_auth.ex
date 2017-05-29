defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn # for halt/1
  import Phoenix.Controller # put_flash/3, redirect

  alias Discuss.Router.Helpers

  def init(_params) do
  end

  def call(conn, params) do
    if conn.assigns[:user] do
      conn # Move on
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end

end
