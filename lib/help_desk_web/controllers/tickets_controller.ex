defmodule HelpDeskWeb.TicketsController do
  use HelpDeskWeb, :controller

  alias HelpDesk.Tickets
  alias Tickets.Ticket

  action_fallback HelpDeskWeb.FallbackController

  def create(conn, params) do
    params_with_workspace_id =
      if Map.has_key?(conn.assigns, :workspace_id) do
        %{workspace_id: workspace_id} = conn.assigns
        Map.put(params, "workspace_id", workspace_id)
      else
        params
      end

    with {:ok, %Ticket{} = ticket} <- Tickets.create(params_with_workspace_id) do
      conn
      |> put_status(:created)
      |> render(:create, ticket: ticket)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Ticket{} = ticket} <- Tickets.delete(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, ticket: ticket)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Ticket{} = ticket} <- Tickets.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, ticket: ticket)
    end
  end

  def index(conn, _) do
    with {:ok, tickets, pagination, offset} <- Tickets.get_by_params(conn.params) do
      conn
      |> put_status(:ok)
      |> render(:get, tickets: tickets, pagination: pagination, offset: offset)
    end
  end

  def update(conn, params) do
    with {:ok, %Ticket{} = ticket} <- Tickets.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, ticket: ticket)
    end
  end
end
