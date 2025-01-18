defmodule ThreaditWeb.FeedControllerTest do
  use ThreaditWeb.ConnCase, async: true

  setup {Threadit.AuthFixtures, :create_and_login_user}

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200)
    assert inertia_component(conn) == "Feed"
  end
end
