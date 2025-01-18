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

  def register_page(conn, _params) do
    conn
    |> render_inertia("Register")
  end

  def register(conn, params) do
    case Users.create_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:success, "Account created successfully!")
        |> put_session(:user_id, user.id)
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/register")
    end
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: ~p"/login")
  end
end
