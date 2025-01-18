defmodule ThreaditWeb.FeedController do
  use ThreaditWeb, :controller

  def feed(conn, _params) do
    conn
    |> render_inertia("Feed")
  end
end
