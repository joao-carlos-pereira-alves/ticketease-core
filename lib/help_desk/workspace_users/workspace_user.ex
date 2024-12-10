defmodule HelpDesk.WorkspaceUsers.WorkspaceUser do
  @moduledoc """
    Manages the many-to-many association between workspaces and users.

    This module provides functionality to create, update, fetch, and delete associations between workspaces and users.

    ## Usage

    Key functions include:
    - `create/2`: Creates a new association between a workspace and a user.
    - `delete/2`: Deletes an existing association between a workspace and a user.
    - `list_users/1`: Lists all users associated with a specific workspace.
    - `list_workspaces/1`: Lists all workspaces associated with a specific user.
  """
  @moduledoc since: "1.0.0"

  # use Guardian, otp_app: :help_desk
  use Ecto.Schema

  import Ecto.Changeset

  @required_params_create [:workspace_id, :user_id]
  @required_params_update []

  schema "workspace_users" do
    belongs_to :user, HelpDesk.Users.User
    belongs_to :workspace, HelpDesk.Workspaces.Workspace

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
  end
end
