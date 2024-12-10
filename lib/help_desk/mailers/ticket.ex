defmodule HelpDesk.Mailers.Ticket do
  import Bamboo.Email
  import Bamboo.Phoenix

  alias HelpDesk.Repo

  # System.get_env("FROM_ADDRESS_SMTP")
  @from_address "hello@example.com"
  # System.get_env("REPLY_TO_ADDRESS_SMTP")
  @reply_to_address "reply@example.com"

  def created(ticket) do
    workspace = get_workspace(ticket)
    responsible = get_responsible(workspace)
    html_body = created_email_body(ticket, workspace)
    email = responsible.email
    subject = ticket.subject

    # Build your default email then customize for welcome
    base_email()
    |> to(email)
    |> subject("Novo chamado criado")
    |> put_header("Reply-To", @reply_to_address)
    |> html_body(html_body)
    |> text_body(subject)
  end

  def updated(ticket, old_status) do
    workspace = get_workspace(ticket)
    responsible = get_responsible(workspace)
    new_status = translate_ticket_status(ticket.status)
    old_status = translate_ticket_status(old_status)
    html_body = updated_email_body(ticket, workspace, old_status)
    email = responsible.email

    description_mailer =
      if old_status === new_status,
        do: "Comentário alterado",
        else: "Status alterado de #{old_status} para #{new_status}"

    # Build your default email then customize for welcome
    base_email()
    |> to(email)
    |> subject("Chamado atualizado")
    |> put_header("Reply-To", @reply_to_address)
    |> html_body(html_body)
    |> text_body(description_mailer)
  end

  defp base_email do
    new_email()
    # Set a default from
    |> from(@from_address)
    # Set default layout
    |> put_html_layout({HelpDeskWeb.LayoutView, "ticket.html"})
    # Set default text layout
    |> put_text_layout({HelpDeskWeb.LayoutView, "ticket.text"})
  end

  defp created_email_body(ticket, workspace) do
    priority = translate_priority(ticket.priority)
    tags = Enum.map(ticket.tags, &translate_tag/1)
    status = translate_ticket_status(ticket.status)

    "<h2>Novo Chamado Criado</h2>
    <p><strong>Título:</strong> #{ticket.subject}</p>
    <p><strong>Descrição:</strong> #{ticket.description}</p>
    <p><strong>Área de Trabalho:</strong> #{workspace.title}</p>
    <p><strong>Prioridade:</strong> #{priority}</p>
    <p><strong>Tags:</strong> #{Enum.join(tags, ", ")}</p>
    <p><strong>Status:</strong> #{status}</p>"
  end

  defp updated_email_body(ticket, workspace, old_status) do
    status = translate_ticket_status(ticket.status)
    status_change_info = if status === old_status do
                           "<p><strong>Status:</strong> #{status}</p>"
                         else
                           "<p><strong>Status Anterior:</strong> #{old_status}</p>
                            <p><strong>Novo Status:</strong> #{status}</p>"
                         end

    "<h2>Chamado Atualizado</h2>
     <p><strong>Título:</strong> #{ticket.subject}</p>
     <p><strong>Área de Trabalho:</strong> #{workspace.title}</p>
     #{status_change_info}
     <p><strong>Comentário:</strong> #{ticket.answer_description}</p>"
  end

  defp get_workspace(ticket) do
    [workspace] =
      Ecto.assoc(ticket, :workspace)
      |> Repo.all()

    workspace
  end

  defp get_responsible(workspace) do
    workspace = Repo.preload(workspace, :responsible)
    workspace.responsible
  end

  defp translate_priority(priority) do
    case priority do
      :low -> "Baixa"
      :medium -> "Média"
      :high -> "Alta"
      _ -> "Prioridade Desconhecida"
    end
  end

  defp translate_tag(tag) do
    case tag do
      :urgent -> "Urgente"
      :critical -> "Crítico"
      :deadline -> "Prazo"
      :new_feature -> "Nova Funcionalidade"
      :bug -> "Bug"
      :security -> "Segurança"
      :documentation -> "Documentação"
      :user_feedback -> "Feedback do Usuário"
      :performance_improvement -> "Melhoria de Performance"
      :integration -> "Integração"
      _ -> "Tag Desconhecida"
    end
  end

  defp translate_ticket_status(status) do
    case status do
      :open -> "Aberto"
      :in_progress -> "Em Progresso"
      :waiting_for_user -> "Aguardando Usuário"
      :waiting_for_third_party -> "Aguardando Terceiros"
      :resolved -> "Resolvido"
      :closed -> "Fechado"
      :canceled -> "Cancelado"
      _ -> "Aberto"
    end
  end
end
