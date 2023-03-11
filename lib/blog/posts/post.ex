defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :description, :string
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :slug, :description])
    |> validate_required([:title, :content, :slug, :description])
    |> update_change(:slug, &replace_reserved/1)
    |> unique_constraint(:slug)
  end

  def replace_reserved(slug) do
    String.to_charlist(slug)
    |> Enum.map(fn c -> if(URI.char_unreserved?(c), do: c, else: ?_) end)
    |> List.to_string()
  end
end
