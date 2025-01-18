defmodule Threadit.AuthFixtures do
  import Phoenix.ConnTest
  import Threadit.UsersFixtures
  import Plug.Conn

  def create_and_login_user(_context) do
    user = user_fixture()

    conn =
      build_conn()
      |> init_test_session(%{})
      |> put_session(:user_id, user.id)

    {:ok, conn: conn, user: user}
  end
end
