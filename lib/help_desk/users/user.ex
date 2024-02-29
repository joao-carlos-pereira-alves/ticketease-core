defmodule HelpDesk.Users.User do
  @moduledoc """
    This module contains the methods responsible for user/authentication management.
  """
  @moduledoc since: "1.0.0"

  use Ecto.Schema
  import Ecto.Changeset

  require Logger
  alias HelpDesk.Mailers.User
  alias HelpDesk.Mailer

  @required_params_create [:name, :password, :email]
  @required_params_update [:name, :email]

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string

    timestamps()
  end

  # def changeset(user \\ %__MODULE__{}, params)

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_create)
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_update)
    |> add_password_hash()
  end

  def send_confirmation_email(user) do
    User.welcome_email(user)
    |> Mailer.deliver_later()
  end

  defp do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> unique_constraint(:email)
    |> validate_length(:name, min: 3)
    |> validate_length(:name, max: 50)
    |> validate_format(:email, ~r/@/)
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset
end
