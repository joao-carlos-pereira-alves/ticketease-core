defmodule HelpDesk.Tickets.Update do
  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(Ticket, id) do
      nil -> { :error, :not_found}
      ticket -> update(ticket, params)
    end
  end

  defp update(ticket, params) do
    ticket
    |> Ticket.changeset(params)
    |> Repo.update()
    |> handle_updated_result(ticket.status)
  end

  defp handle_updated_result({:ok, ticket}, old_status) do
    send_updated_ticket_email(ticket, old_status)
    {:ok, ticket}
  end

  defp handle_updated_result({:error, changeset}, _) do
    {:error, changeset}
  end

  defp send_updated_ticket_email(ticket, old_status) do
    Ticket.send_updated_ticket_email(ticket, old_status)
  end
end
