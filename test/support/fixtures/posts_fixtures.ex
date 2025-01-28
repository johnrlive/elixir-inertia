defmodule Threadit.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Threadit.Posts` context.
  """

  import Threadit.UsersFixtures
  alias Threadit.Posts

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> then(&Posts.create_post(user, &1))

    Posts.get_post!(post.id)
  end
end
