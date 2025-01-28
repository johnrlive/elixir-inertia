defmodule Threadit.LikesFixtures do
  alias Threadit.Likes
  alias Threadit.Posts.Post
  alias Threadit.Users.User

  def like_fixture(%User{} = user, %Post{} = post) do
    {:ok, like} = Likes.create_like(user, post.id)
    like
  end
end
