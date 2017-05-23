defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth

  # SCOPE "/auth"
  # GET "/:provider/callback"
  def callback(conn, params) do
    IO.inspect "++++"
    IO.inspect conn.assigns
    IO.inspect "++++"
    IO.inspect params
    IO.inspect "++++"
  end

end
