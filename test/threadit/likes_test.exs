defmodule Threadit.LikesTest do
  use Threadit.DataCase, async: true

  alias Threadit.Likes

  import Threadit.PostsFixtures
  import Threadit.UsersFixtures

  describe "likes" do
    setup do
      user = user_fixture()
      post = post_fixture()
      %{user: user, post: post}
    end

    test "count_likes/1 returns the number of likes for a post", %{user: user, post: post} do
      assert Likes.count_likes(post) == 0

      {:ok, _like} = Likes.create_like(user, post.id)

      assert Likes.count_likes(post) == 1
    end

    test "liked?/2 returns whether a user has liked a post", %{user: user, post: post} do
      refute Likes.liked?(post, user)

      {:ok, _like} = Likes.create_like(user, post.id)

      assert Likes.liked?(post, user)
    end

    test "create_like/2 creates a like", %{user: user, post: post} do
      assert {:ok, like} = Likes.create_like(user, post.id)
      assert like.user_id == user.id
      assert like.post_id == post.id
    end

    test "create_like/2 prevents duplicate likes", %{user: user, post: post} do
      assert {:ok, _like} = Likes.create_like(user, post.id)
      assert {:error, changeset} = Likes.create_like(user, post.id)
      assert "has already been taken" in errors_on(changeset).user_id
    end

    test "delete_like/2 deletes a like", %{user: user, post: post} do
      {:ok, _like} = Likes.create_like(user, post.id)
      assert Likes.liked?(post, user)

      {1, nil} = Likes.delete_like(user, post.id)
      refute Likes.liked?(post, user)
    end

    test "delete_like/2 is idempotent", %{user: user, post: post} do
      assert {0, nil} = Likes.delete_like(user, post.id)
    end
  end
end
