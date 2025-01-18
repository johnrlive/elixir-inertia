defmodule ThreaditWeb.FeedControllerTest do
  use ThreaditWeb.ConnCase, async: true

  test "GET / (unauthenticated)", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 302)
    assert redirected_to(conn) == ~p"/login"
  end
end
