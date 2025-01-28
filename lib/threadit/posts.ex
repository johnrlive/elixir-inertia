defmodule Threadit.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Threadit.Repo

  alias Threadit.Posts.Post
  alias Threadit.Users.User

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    from(p in Post,
      join: u in assoc(p, :user),
      left_join: l in assoc(p, :likes),
      group_by: [p.id, u.id],
      select_merge: %{likes_count: count(l.id)},
      preload: [user: u]
    )
    |> Repo.all()
  end

  def list_liked_posts(%User{} = user) do
    from(p in Post,
      join: l in assoc(p, :likes),
      join: u in assoc(p, :user),
      where: l.user_id == ^user.id,
      preload: [user: u]
    )
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    from(p in Post,
      join: u in assoc(p, :user),
      left_join: l in assoc(p, :likes),
      where: p.id == ^id,
      group_by: [p.id, u.id],
      select_merge: %{likes_count: count(l.id)},
      preload: [user: u]
    )
    |> Repo.one!()
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_post(%User{} = user, attrs \\ %{}) do
    %Post{user_id: user.id}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
