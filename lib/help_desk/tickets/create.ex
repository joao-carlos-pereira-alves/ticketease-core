defmodule HelpDesk.Tickets.Create do
  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call(params) do
    params
    |> Ticket.changeset()
    |> Repo.insert()
    |> handle_insert_result()
  end

  defp handle_insert_result({:ok, ticket}) do
    send_created_ticket_email(ticket)
    {:ok, ticket}
  end

  defp handle_insert_result({:error, changeset}) do
    {:error, changeset}
  end

  defp send_created_ticket_email(ticket) do
    Ticket.send_created_ticket_email(ticket)
  end
end
