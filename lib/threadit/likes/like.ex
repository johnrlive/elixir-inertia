defmodule Threadit.Likes.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias Threadit.Posts.Post
  alias Threadit.Users.User

  schema "likes" do
    belongs_to :user, User
    belongs_to :post, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
    |> unique_constraint([:user_id, :post_id], name: :likes_user_id_post_id_index)
  end
end
