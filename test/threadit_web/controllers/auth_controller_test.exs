defmodule ThreaditWeb.AuthControllerTest do
  use ThreaditWeb.ConnCase, async: true

  import Threadit.UsersFixtures

  test "GET /login", %{conn: conn} do
    conn = get(conn, ~p"/login")
    assert html_response(conn, 200)
    assert inertia_component(conn) == "Login"
  end

  test "POST /login with valid credentials", %{conn: conn} do
    user = user_fixture()

    conn =
      post(conn, ~p"/login", %{
        "username" => user.username,
        "password" => "password"
      })

    assert html_response(conn, 302)
    assert get_session(conn, :user_id) == user.id
    assert redirected_to(conn) == ~p"/"
  end

  test "POST /login with invalid credentials", %{conn: conn} do
    conn =
      post(conn, ~p"/login", %{
        "username" => "invalid",
        "password" => "invalid"
      })

    assert get_session(conn, :user_id) == nil
    assert redirected_to(conn) == ~p"/login"
  end

  test "POST /logout", %{conn: conn} do
    conn = post(conn, ~p"/logout")
    assert html_response(conn, 302)
    assert redirected_to(conn) == ~p"/login"
  end
end
