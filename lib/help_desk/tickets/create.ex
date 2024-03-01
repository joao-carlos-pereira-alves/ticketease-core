defmodule HelpDesk.Tickets.Create do
  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call(params) do
    params
    |> Ticket.changeset()
    |> Repo.insert()
    |> handle_insert_result()
  end

  defp handle_insert_result({:ok, Ticket}) do
    {:ok, Ticket}
  end

  defp handle_insert_result({:error, changeset}) do
    {:error, changeset}
  end
end
