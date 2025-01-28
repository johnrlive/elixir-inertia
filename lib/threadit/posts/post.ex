defmodule Threadit.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Threadit.Users.User
  alias Threadit.Likes.Like

  @derive {Jason.Encoder,
           only: [:id, :title, :body, :inserted_at, :updated_at, :user, :likes_count]}
  schema "posts" do
    field :title, :string
    field :body, :string
    field :likes_count, :integer, virtual: true, default: 0

    belongs_to :user, User
    has_many :likes, Like

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, min: 1, max: 255)
    |> validate_length(:body, min: 1, max: 5000)
  end
end
