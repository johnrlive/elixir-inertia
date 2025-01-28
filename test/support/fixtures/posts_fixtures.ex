defmodule Threadit.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Threadit.Posts` context.
  """

  import Threadit.UsersFixtures
  alias Threadit.Posts
  alias Threadit.Users.User

  @doc """
  Generate a post.
  """
  def post_fixture() do
    user = user_fixture()

    {:ok, post} =
      user
      |> Posts.create_post(%{
        body: "some body",
        title: "some title"
      })

    Posts.get_post!(post.id)
  end

  def post_fixture(%User{} = user) do
    {:ok, post} =
      user
      |> Posts.create_post(%{
        body: "some body",
        title: "some title"
      })

    Posts.get_post!(post.id)
  end
end
