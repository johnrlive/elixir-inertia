defmodule ThreaditWeb.EnsureAuthenticated do
  use ThreaditWeb, :controller

  alias Threadit.Users

  def init(opts), do: opts

  def call(conn = %Plug.Conn{}, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "Session expired, please log in again.")
        |> redirect(to: ~p"/login")
        |> halt()

      user_id ->
        user = Users.get_user_by_id(user_id)

        conn
        |> assign(:user, user)
        |> assign_prop(:user, user)
    end
  end
end
