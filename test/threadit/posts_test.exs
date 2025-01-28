defmodule Threadit.PostsTest do
  use Threadit.DataCase, async: true

  alias Threadit.Posts

  describe "posts" do
    alias Threadit.Posts.Post

    import Threadit.PostsFixtures
    import Threadit.UsersFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      user = user_fixture()
      valid_attrs = %{title: "some title", body: "some body"}

      assert {:ok, %Post{} = post} = Posts.create_post(user, valid_attrs)
      assert post.title == "some title"
      assert post.body == "some body"
      assert post.user_id == user.id
    end

    test "create_post/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(user, @invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{title: "some updated title", body: "some updated body"}

      assert {:ok, %Post{} = updated_post} = Posts.update_post(post, update_attrs)
      assert updated_post.title == "some updated title"
      assert updated_post.body == "some updated body"
      assert updated_post.user_id == post.user_id
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
