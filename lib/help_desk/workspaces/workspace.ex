defmodule HelpDesk.Workspaces.Workspace do
  @moduledoc """
    This module manages workspaces within the Help Desk system.
    A workspace is an isolated environment that groups data related to each individual client.
    Each workspace contains specific information for a client, including users, tickets, and authentication tokens for API integrations.

    By using workspaces, the system is able to scale to multiple clients without the need to create separate instances of the project.
    This module provides functionalities for creating, updating, retrieving, and deleting workspaces, ensuring the organization and security of each client's data.
  """
  @moduledoc since: "1.0.0"

  # use Guardian, otp_app: :help_desk
  use Ecto.Schema

  import Ecto.Changeset

  @workspace_status [
    :active,
    :inactive,
    :under_review,
    :on_hold,
    :suspended,
    :in_progress,
    :in_testing,
    :under_maintenance,
    :archived
  ]

  @required_params_create [:title, :responsible_email, :description]
  @required_params_update []

  schema "workspaces" do
    field :title, :string
    field :description, :string
    field :responsible_email, :string
    field :status, Ecto.Enum, values: @workspace_status

    has_many :workspace_users, HelpDesk.WorkspaceUsers.WorkspaceUser
    has_many :tickets, HelpDesk.Tickets.Ticket

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_create)
  end

  def changeset(ticket, params) do
    ticket
    |> cast(params, @required_params_create)
    |> do_validations(@required_params_update)
  end

  defp do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> validate_length(:title, min: 2)
    |> validate_length(:title, max: 255)
    |> validate_format(:responsible_email, ~r/@/)
  end
end
