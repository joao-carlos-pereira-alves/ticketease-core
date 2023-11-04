defmodule QuickStart.Users.Get do
  alias QuickStart.Users.User
  alias QuickStart.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> { :error, :not_found}
      user -> { :ok, user}
    end
  end
end
