# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Threadit.Repo.insert!(%Threadit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Threadit.{Users, Posts, Likes}

# Store users in a map for easy reference
users =
  [
    %{
      username: "alice",
      password: "password",
      posts: [
        %{
          title: "Hello, Threadit!",
          body: "This is my first post 🚀"
        },
        %{
          title: "Goodbye, Threadit!",
          body: "This is my last post 👋"
        }
      ]
    },
    %{
      username: "bob",
      password: "password",
      posts: [
        %{
          title: "I love Ruby on Rails!",
          body: "It's the best web framework ever 🛤️"
        }
      ]
    },
    %{
      username: "daniel",
      password: "123123123",
      posts: [
        %{
          title: "I love Elixir and Phoenix!",
          body: "These 2 are the most productive tools I've ever used 🔥"
        }
      ]
    }
  ]
  |> Enum.reduce(%{}, fn attrs, acc ->
    {:ok, user} = Users.create_user(attrs)

    posts =
      Enum.map(attrs.posts, fn post_attrs ->
        {:ok, post} = Posts.create_post(user, post_attrs)
        post
      end)

    Map.put(acc, user.username, %{user: user, posts: posts})
  end)

# Create some likes
[
  # Bob likes Alice's first post
  {"bob", "alice", 0},
  # Daniel likes Alice's first post
  {"daniel", "alice", 0},
  # Daniel likes Alice's second post
  {"daniel", "alice", 1},
  # Alice likes Bob's post
  {"alice", "bob", 0},
  # Alice likes Daniel's post
  {"alice", "daniel", 0}
]
|> Enum.each(fn {liker_username, author_username, post_index} ->
  liker = users[liker_username].user
  post = Enum.at(users[author_username].posts, post_index)
  Likes.create_like(liker, post.id)
end)
