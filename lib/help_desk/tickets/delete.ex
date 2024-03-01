defmodule HelpDesk.Tickets.Delete do
  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(Ticket, id) do
      nil -> { :error, :not_found}
      ticket -> Repo.delete(ticket)
    end
  end
end
