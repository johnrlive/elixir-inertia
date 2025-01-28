defmodule Threadit.Likes do
  @moduledoc """
  The Likes context.
  """

  import Ecto.Query, warn: false
  alias Threadit.Repo
  alias Threadit.Likes.Like
  alias Threadit.Posts.Post
  alias Threadit.Users.User

  @doc """
  Returns the number of likes for a post.
  """
  def count_likes(%Post{} = post) do
    Repo.aggregate(from(l in Like, where: l.post_id == ^post.id), :count)
  end

  @doc """
  Returns whether a user has liked a post.
  """
  def liked?(%Post{} = post, %User{} = user) do
    Repo.exists?(from l in Like, where: l.post_id == ^post.id and l.user_id == ^user.id)
  end

  @doc """
  Creates a like.
  """
  def create_like(%User{} = user, post_id) do
    %Like{}
    |> Like.changeset(%{user_id: user.id, post_id: post_id})
    |> Repo.insert()
  end

  @doc """
  Deletes a like.
  """
  def delete_like(%User{} = user, post_id) do
    from(l in Like, where: l.user_id == ^user.id and l.post_id == ^post_id)
    |> Repo.delete_all()
  end
end
