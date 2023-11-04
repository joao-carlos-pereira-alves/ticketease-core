defmodule ReservaOnline.Users.Delete do
  alias ReservaOnline.Users.User
  alias ReservaOnline.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> { :error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
