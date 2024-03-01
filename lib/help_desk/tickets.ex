defmodule HelpDesk.Tickets do
  alias HelpDesk.Tickets.Create
  alias HelpDesk.Tickets.Delete
  alias HelpDesk.Tickets.Get
  alias HelpDesk.Tickets.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
end
