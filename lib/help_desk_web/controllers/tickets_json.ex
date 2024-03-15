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
  def get(%{tickets: tickets, pagination: pagination, offset: offset}), do: %{ data: data(tickets), pagination: pagination(offset, pagination)  }

  def update(%{ticket: ticket}), do: %{ message: "Ticket atualizado com sucesso.", data: data(ticket) }

  defp data(tickets) when is_list(tickets) do
    Enum.map(tickets, &data/1)
  end

  defp data(%Ticket{} = ticket) do
    %{
      id: ticket.id,
      subject: ticket.subject,
      description: ticket.description,
      status: ticket.status,
      priority: ticket.priority,
      tags: ticket.tags,
      answer_description: ticket.answer_description,
      created_at: ticket.inserted_at
    }
  end

  defp pagination(offset, pagination) do
    %{
      total: offset,
      per_page: pagination["per_page"],
      page: pagination["page"]
    }
  end
end
