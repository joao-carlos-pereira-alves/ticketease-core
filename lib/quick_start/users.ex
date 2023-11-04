defmodule QuickStart.Users do
  alias QuickStart.Users.Create
  alias QuickStart.Users.Delete
  alias QuickStart.Users.Get
  alias QuickStart.Users.Update
  alias QuickStart.Users.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate login(params), to: Verify, as: :call
end
