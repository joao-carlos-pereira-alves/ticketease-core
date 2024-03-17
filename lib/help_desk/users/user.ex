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
  alias HelpDeskWeb.Token

  @required_params_create [:name, :password, :email]
  @required_params_update [:totp_secret, :totp_token, :verified]

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :verified, :boolean
    field :totp_secret, :string
    field :totp_token, :string

    has_many :workspace_users, HelpDesk.WorkspaceUsers.WorkspaceUser, on_delete: :delete_all

    timestamps()
  end

  # def changeset(user \\ %__MODULE__{}, params)

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_create)
    |> add_password_hash()
    |> set_totp_validation_token()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params_update)
    |> do_validations(@required_params_update)
  end

  def send_confirmation_email(user) do
    User.confirmation_email(user)
    |> Mailer.deliver_later()
  end

  def resend_confirmation_email(user) do
    User.resend_confirmation_email(user)
    |> Mailer.deliver_later()
  end

  def generate_totp_token, do: Token.generate_totp_token()

  defp do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:name, max: 50)
    |> validate_length(:password, min: 6)
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset

  defp set_totp_validation_token(%Ecto.Changeset{valid?: true} = changeset) do
    %{totp_secret: totp_secret, totp_token: totp_token} = generate_totp_token()
    change(changeset, %{ totp_secret: totp_secret, totp_token: totp_token })
  end

  defp set_totp_validation_token(changeset), do: changeset
end
