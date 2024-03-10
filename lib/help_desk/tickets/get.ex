defmodule HelpDesk.Tickets.Get do
  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call do
    case Repo.all(Ticket) do
      [] -> {:error, :not_found}
      tickets -> {:ok, tickets}
    end
  end

  def call(id) do
    case Repo.get(Ticket, id) do
      nil -> { :error, :not_found}
      ticket -> { :ok, ticket}
    end
  end
end
