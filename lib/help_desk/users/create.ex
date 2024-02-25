defmodule HelpDesk.Users.Create do
  alias HelpDesk.Users.User
  alias HelpDesk.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
