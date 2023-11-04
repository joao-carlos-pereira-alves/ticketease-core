defmodule QuickStart.Users.Create do
  alias QuickStart.Users.User
  alias QuickStart.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
