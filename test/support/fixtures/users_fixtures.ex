defmodule Threadit.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Threadit.Users` context.
  """

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "username#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "password",
        username: unique_user_username()
      })
      |> Threadit.Users.create_user()

    user
  end
end
