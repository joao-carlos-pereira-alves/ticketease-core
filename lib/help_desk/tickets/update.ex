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
  end
end
