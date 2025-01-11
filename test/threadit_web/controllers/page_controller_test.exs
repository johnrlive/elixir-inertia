defmodule ThreaditWeb.PageControllerTest do
  use ThreaditWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200)
  end
end
