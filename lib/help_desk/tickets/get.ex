defmodule HelpDesk.Tickets.Get do
  import Ecto.Query

  alias HelpDesk.Tickets.Ticket
  alias HelpDesk.Repo

  def call_by_params(params) do
    query  = apply_filters(params)
    offset = count_items(query)
    query  = paginate(query, params)

    case Repo.all(query) do
      [] -> {:error, :not_found}
      tickets -> {:ok, tickets, params, offset}
    end
  end

  def call(id) do
    case Repo.get(Ticket, id) do
      nil -> {:error, :not_found}
      ticket -> {:ok, ticket}
    end
  end

  defp apply_status_filter(query, status) do
    where(query, [t], t.status == ^status)
  end

  defp apply_tags_filter(query, tags) do
    where(query, [t], fragment("? && ?", ^[tags], t.tags))
  end

  defp apply_search_filter(query, search_term) do
    where(query, [t], ilike(t.subject, ^"%#{search_term}%") or ilike(t.description, ^"%#{search_term}%"))
  end

  defp apply_order(query, order_filter) do
    order_expressions =
      case order_filter do
        nil -> [desc: :inserted_at]
        "inserted_at_asc"  -> [asc: :inserted_at]
        "inserted_at_desc" -> [desc: :inserted_at]
      end

    order_by(query, ^order_expressions)
  end

  defp apply_filters(params) do
    query = from(t in Ticket)

    query =
      case Map.fetch(params, "status") do
        {:ok, status} -> apply_status_filter(query, status)
        :error -> query
      end

    query =
      case Map.fetch(params, "tags") do
        {:ok, tags} -> apply_tags_filter(query, tags)
        :error -> query
      end

    query =
      case Map.fetch(params, "search_term") do
        {:ok, search_term} -> apply_search_filter(query, search_term)
        :error -> query
      end

    query =
      case Map.fetch(params, "workspace_id") do
        {:ok, workspace_id} -> filter_by_workspace_id(query, workspace_id)
        :error -> query
      end

    query = apply_order(query, Map.get(params, "order_by"))

    query
  end

  defp filter_by_workspace_id(query, workspace_id) do
    where(query, [t], t.workspace_id == ^workspace_id)
  end

  defp paginate(query, params) do
    per_page = Map.get(params, "per_page", 5) |> String.to_integer()
    page = Map.get(params, "page", 1) |> String.to_integer()

    offset = (page - 1) * per_page

    limit(query, ^per_page)
    |> offset(^offset)
  end

  defp count_items(query) do
    query
    |> Repo.all()
    |> length()
  end
end
