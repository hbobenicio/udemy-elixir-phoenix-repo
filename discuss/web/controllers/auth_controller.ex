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

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end

end
