defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  # Execute this Plug only for some actions inside this controller
  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  # GET /topics
  def index(conn, _params) do
    query = from(t in Topic, order_by: t.title)
    topics = Repo.all(query)
    #topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end

  # GET /topics/new
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  # POST /topics
  def create(conn, %{"topic" => topic} = _params) do
    #changeset = Topic.changeset(%Topic{}, topic)
    changeset = conn.assigns.user
    |> build_assoc(:topics)
    |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # GET /topics/:id/edit
  def edit(conn, %{"id" => topic_id} = _params) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  # PATCH /topics/:id
  # PUT /topics/:id
  def update(conn, %{"id" => topic_id, "topic" => topic} = _params) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  # DELETE /topics/:id
  def delete(conn, %{"id" => topic_id} = _params) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

end
