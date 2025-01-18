defmodule ThreaditWeb.EnsureAuthenticated do
  use ThreaditWeb, :controller

  def init(opts), do: opts

  def call(conn = %Plug.Conn{}, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "Session expired, please log in again.")
        |> redirect(to: ~p"/login")
        |> halt()

      user_id ->
        conn
        |> assign(:user_id, user_id)
    end
  end
end
