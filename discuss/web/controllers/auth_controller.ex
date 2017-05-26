defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth

  alias Discuss.User

  # SCOPE "/auth"
  # GET "/:provider/callback"
  def callback(conn, params) do
    %{assigns: %{ueberauth_auth: auth}} = conn
    %{"code" => _, "provider" => provider} = params

    token = auth.credentials.token
    email = auth.info.email

    user_params = %{token: token, email: email, provider: provider}
    changeset = User.changeset(%User{}, user_params)

    
  end

end
