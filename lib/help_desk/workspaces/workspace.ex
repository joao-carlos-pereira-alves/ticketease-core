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

  @required_params_create [:title, :description, :responsible_id]
  @required_params_update []

  schema "workspaces" do
    field :title, :string
    field :description, :string
    field :responsible_email, :string
    field :status, Ecto.Enum, values: @workspace_status

    belongs_to :responsible, HelpDesk.Users.User
    has_many :workspace_users, HelpDesk.WorkspaceUsers.WorkspaceUser
    has_many :tickets, HelpDesk.Tickets.Ticket

    timestamps()
  end

  def changeset(params, user_id) do
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> add_responsible_id(user_id)
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
  end

  defp add_responsible_id(%Ecto.Changeset{valid?: true} = changeset, responsible_id) do
    change(changeset, responsible_id: responsible_id)
  end
end
