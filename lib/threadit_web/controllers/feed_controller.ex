defmodule ThreaditWeb.FeedController do
  use ThreaditWeb, :controller

  alias Threadit.Posts

  def feed(conn, _params) do
    posts = Posts.list_posts()

    conn
    |> assign_prop(:posts, posts)
    |> render_inertia("Feed")
  end
end
