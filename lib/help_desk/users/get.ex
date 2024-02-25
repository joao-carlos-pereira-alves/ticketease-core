defmodule HelpDesk.Users.Get do
  alias HelpDesk.Users.User
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> { :error, :not_found}
      user -> { :ok, user}
    end
  end
end
