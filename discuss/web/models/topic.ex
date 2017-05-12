defmodule Discuss.Topic do
  use Discuss.Web, :model

  # Maps this model to the 'topics' table.
  # Define the associations with its columns as well.
  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
  
end