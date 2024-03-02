defmodule HelpDesk.Tickets.Ticket do
  @moduledoc """
    Module for the ticket table and its operations.
  """
  @moduledoc since: "1.0.0"

  use Ecto.Schema
  import Ecto.Changeset

  @priorities [:low, :medium, :high]
  @tags [
    :urgent,
    :critical,
    :deadline,
    :new_feature,
    :bug,
    :security,
    :documentation,
    :user_feedback,
    :performance_improvement,
    :integration
  ]
  @ticket_status [
    :open,
    :in_progress,
    :waiting_for_user,
    :waiting_for_third_party,
    :resolved,
    :closed,
    :canceled
  ]

  @required_params_create [:subject, :description, :tags]
  @required_params_update []

  schema "tickets" do
    field :subject, :string
    field :description, :string
    field :status, Ecto.Enum, values: @ticket_status
    field :priority, Ecto.Enum, values: @priorities
    field :tags, {:array, Ecto.Enum}, values: @tags

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
    |> validate_length(:subject, min: 3)
    |> validate_length(:subject, max: 255)
    |> validate_length(:description, min: 3)
  end
end
