defmodule HelpDesk.Workspaces.Verify do
  alias HelpDesk.Workspaces

  def call(%{"base64" => base64}) do
    case Workspaces.get_by_base64(%{"base64" => base64}) do
      {:ok, workspace} -> {:ok, workspace}
      {:error, _} = error -> error
    end
  end

  def call(_), do: {:error, %{status: :unprocessable_entity, message: "O Parâmetro base64 é obrigatório."}}
  # defp verify(user, password) do
  #   case Argon2.verify_pass(password, user.password_hash) do
  #     true -> {:ok, user}
  #     false -> {:error, %{ status: :unauthorized, message: "Senha incorreta" }}
  #   end
  # end
end
