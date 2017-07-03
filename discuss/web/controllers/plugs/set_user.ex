defmodule Discuss.Plugs.SetUser do
  @moduledoc """
    Plug Responsible for getting the user_id from the session (set after
    OAuth authentication), searching for the user on the database with that
    id and assigning it to 'conn.assigns.user'
  """

  import Plug.Conn

  alias Discuss.Repo
  alias Discuss.User

  @doc "Called once, when the application boots up"
  def init(_params) do
  end

  @doc """
    Called anytime when the Plug runs. Effectively, whenever a request is handled
  """
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user) # Assigns the user to 'conn.assigns.user'

      true -> assign(conn, :user, nil)
    end
  end
end
