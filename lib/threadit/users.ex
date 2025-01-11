defmodule Threadit.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Threadit.Repo

  alias Threadit.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_username(username, opts \\ []) when is_binary(username) do
    include_password = Keyword.get(opts, :include_password, false)

    query =
      case include_password do
        true -> from User, select: [:id, :username, :hashed_password, :inserted_at, :updated_at]
        false -> User
      end

    query
    |> Repo.get_by(username: username)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, %User{} = user} -> {:ok, hide_password(user)}
      error -> error
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, %User{} = user} -> {:ok, hide_password(user)}
      error -> error
    end
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    user
    |> Repo.delete()
    |> case do
      {:ok, %User{} = user} -> {:ok, hide_password(user)}
      error -> error
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def valid_password?(username, password) when is_binary(username) and is_binary(password) do
    user = get_user_by_username(username, include_password: true)

    case user do
      nil ->
        Bcrypt.no_user_verify()

      %User{} = user ->
        Bcrypt.verify_pass(password, user.hashed_password)
    end
  end

  defp hide_password(%User{} = user) do
    %User{user | password: nil, hashed_password: nil}
  end
end
