defmodule HelpDeskWeb.Plugs.Auth do
  import Plug.Conn

  alias HelpDeskWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      assign(conn, :user_id, data.user_id)
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
