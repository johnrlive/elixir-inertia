defmodule ThreaditWeb.AuthController do
  use ThreaditWeb, :controller

  alias Threadit.Users

  def login_page(conn, _params) do
    conn
    |> render_inertia("Login")
  end

  def login(conn, %{"username" => username, "password" => password}) do
    case Users.valid_password(username, password) do
      {:ok, user} ->
        conn
        |> put_flash(:success, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: ~p"/")

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: ~p"/login")
    end
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: ~p"/login")
  end
end
