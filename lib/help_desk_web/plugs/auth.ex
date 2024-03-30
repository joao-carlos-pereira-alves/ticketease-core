defmodule HelpDeskWeb.Plugs.Auth do
  import Plug.Conn

  alias HelpDeskWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      case Map.get(data, :user_id) do
        nil ->
          assign(conn, :workspace_id, data.workspace_id)
        user_id ->
          assign(conn, :user_id, user_id)
      end
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.put_view(json: HelpDeskWeb.ErrorJSON)
        |> Phoenix.Controller.render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
