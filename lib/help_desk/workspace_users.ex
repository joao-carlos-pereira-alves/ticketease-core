defmodule HelpDesk.WorkspaceUsers do
  alias HelpDesk.WorkspaceUsers.Create
  alias HelpDesk.WorkspaceUsers.Delete
  alias HelpDesk.WorkspaceUsers.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(params), to: Delete, as: :call
  defdelegate get(params), to: Get, as: :call
  defdelegate get_all(current_user_id), to: Get, as: :get_all
end
