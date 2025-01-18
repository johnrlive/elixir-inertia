defmodule ThreaditWeb.FeedControllerTest do
  use ThreaditWeb.ConnCase, async: true

  import Threadit.UsersFixtures

  setup do
    user = user_fixture()
    conn = session_conn() |> put_session(:user_id, user.id)

    {:ok, conn: conn}
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200)
    assert inertia_component(conn) == "Feed"
  end
end
