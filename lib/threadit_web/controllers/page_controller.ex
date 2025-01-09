defmodule ThreaditWeb.PageController do
  use ThreaditWeb, :controller

  def home(conn, _params) do
    conn
    |> assign_prop(:text, "Hello world from React!")
    |> render_inertia("Home")
  end
end
