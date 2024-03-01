defmodule HelpDesk.Tickets.Get do
  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(Ticket, id) do
      nil -> { :error, :not_found}
      ticket -> { :ok, ticket}
    end
  end
end
