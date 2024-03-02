defmodule HelpDeskWeb.TicketsJSON do
  alias HelpDesk.Tickets.Ticket

  def create(%{ticket: ticket}) do
    %{
      message: "Ticket criado com sucesso.",
      data: data(ticket)
    }
  end

  def delete(%{ticket: ticket}), do: %{ message: "Ticket excluído com sucesso.", data: data(ticket) }

  def get(%{ticket: ticket}), do: %{ data: data(ticket) }

  def update(%{ticket: ticket}), do: %{ message: "Ticket atualizado com sucesso.", data: data(ticket) }

  defp data(%Ticket{} = ticket) do
    %{
      id: ticket.id
    }
  end
end
