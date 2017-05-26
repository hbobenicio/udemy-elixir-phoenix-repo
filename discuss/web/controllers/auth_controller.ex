defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth

  # SCOPE "/auth"
  # GET "/:provider/callback"
  def callback(_conn, _params) do
  end

end
