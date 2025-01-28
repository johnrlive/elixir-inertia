defmodule Threadit.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Threadit.Posts.Post
  alias Threadit.Likes.Like

  @derive {Jason.Encoder, only: [:id, :username]}
  schema "users" do
    field :username, :string
    field :hashed_password, :string, load_in_query: false
    field :password, :string, virtual: true

    has_many :posts, Post
    has_many :likes, Like

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:username, min: 3)
    |> validate_format(:username, ~r/^[a-zA-Z0-9_]+$/,
      message: "can only contain letters, numbers, and underscores"
    )
    |> format_username()
    |> unique_constraint(:username)
    |> validate_length(:password, min: 8, max: 72)
    |> hash_password()
  end

  defp format_username(changeset = %Ecto.Changeset{}) do
    case get_change(changeset, :username) do
      nil ->
        changeset

      username ->
        formatted_username =
          username
          |> String.trim()
          |> String.downcase()

        changeset
        |> put_change(:username, formatted_username)
    end
  end

  defp hash_password(changeset = %Ecto.Changeset{}) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        changeset
        |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
    end
  end
end
