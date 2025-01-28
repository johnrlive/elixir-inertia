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

alias Threadit.{Users, Posts}

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
|> Enum.each(fn attrs ->
  {:ok, user} = Users.create_user(attrs)

  Enum.each(attrs.posts, fn post_attrs ->
    Posts.create_post(user, post_attrs)
  end)
end)
