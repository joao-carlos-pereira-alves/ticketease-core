defmodule HelpDesk.WorkspaceUsers do
  alias HelpDesk.WorkspaceUsers.Create
  alias HelpDesk.WorkspaceUsers.Delete

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(params), to: Delete, as: :call
end
