defmodule HelpDeskWeb.TicketsControllerTest do
  use HelpDeskWeb.ConnCase
  use ExUnit.Case
  use Bamboo.Test, shared: true

  alias HelpDesk.Tickets
  alias Tickets.Ticke

  describe "create/2" do
    test "successfully creates an ticket", %{conn: conn} do
      params = %{
        subject: "Lorem Ipsum",
        description: "Lorem Ipsum",
        priority: "medium",
        tags: [:urgent, :critical, :deadline]
      }

      response =
        conn
        |> post(~p"/api/v1/tickets", params)
        |> json_response(:created)

      assert %{
               "data" => %{"id" => _id},
               "message" => "Ticket criado com sucesso."
             } = response
    end
  end

  describe "delete/2" do
    setup [:create_ticket]

    test "successfully delete an ticket", %{conn: conn, ticket: ticket} do
      response =
        conn
        |> delete(~p"/api/v1/tickets/#{ticket.id}")
        |> json_response(:ok)

      assert %{
               "data" => %{"id" => _id},
               "message" => "Ticket excluído com sucesso."
             } = response
    end

    defp create_ticket(_) do
      ticket_params = %{
        subject: "Lorem Ipsum",
        description: "Lorem Ipsum",
        priority: "medium",
        tags: [:urgent, :critical, :deadline]
      }

      {:ok, ticket} = HelpDesk.Tickets.create(ticket_params)

      %{ticket: ticket}
    end
  end
end
