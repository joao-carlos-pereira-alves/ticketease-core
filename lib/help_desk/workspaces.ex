defmodule HelpDesk.Workspaces do
  alias HelpDesk.Workspaces.Create
  alias HelpDesk.Workspaces.Delete
  alias HelpDesk.Workspaces.Get
  alias HelpDesk.Workspaces.Update

  defdelegate create(params, user_id), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate get_all(user_id, pagination_params), to: Get, as: :get_all
  defdelegate update(params), to: Update, as: :call
end
