defmodule ReservaOnline.Users do
  alias ReservaOnline.Users.Create
  alias ReservaOnline.Users.Delete
  alias ReservaOnline.Users.Get
  alias ReservaOnline.Users.Update
  alias ReservaOnline.Users.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate login(params), to: Verify, as: :call
end
