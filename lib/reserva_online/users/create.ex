defmodule ReservaOnline.Users.Create do
  alias ReservaOnline.Users.User
  alias ReservaOnline.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
