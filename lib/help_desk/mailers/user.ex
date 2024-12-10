defmodule HelpDesk.Mailers.User do
  import Bamboo.Email
  import Bamboo.Phoenix

  @from_address "hello@example.com" # System.get_env("FROM_ADDRESS_SMTP")
  @reply_to_address "reply@example.com" # System.get_env("REPLY_TO_ADDRESS_SMTP")

  def confirmation_email(user) do
    html_body = email_body(user)
    base_email() # Build your default email then customize for welcome
    |> to(user.email)
    |> subject("Conta criada com sucesso!")
    |> put_header("Reply-To", @reply_to_address)
    |> html_body(html_body)
    |> text_body("Aproveite para conhecer nosso sistema")
  end

  def resend_confirmation_email(user) do
    html_body = resend_confirmation_email_body(user)

    base_email() # Build your default email then customize for welcome
    |> to(user.email)
    |> subject("Confirme sua conta!")
    |> put_header("Reply-To", @reply_to_address)
    |> html_body(html_body)
    |> text_body("Novo token de confirmação solicitado")
  end

  defp base_email do
    new_email()
    |> from(@from_address) # Set a default from
    |> put_html_layout({HelpDeskWeb.LayoutView, "email.html"}) # Set default layout
    |> put_text_layout({HelpDeskWeb.LayoutView, "email.text"}) # Set default text layout
  end

  def email_body(user) do
    "<p>Olá <strong>#{user.name}</strong>,</p>
    <p>Seja muito bem-vindo ao <strong>Ticket Ease</strong>! Estamos felizes em tê-lo(a) conosco.</p>
    <p>A partir de agora, você faz parte da nossa comunidade e estamos aqui para oferecer todo o suporte necessário para que sua experiência seja excelente.</p>
    <p>Para começar, utilize o token de acesso abaixo para desbloquear todos os recursos e funcionalidades disponíveis em nossa plataforma:</p>
    <p>Token de Acesso: <strong>#{user.totp_token}</strong></p>
    <p>Estamos ansiosos para vê-lo(a) explorando nossos recursos e, caso tenha alguma dúvida ou precise de ajuda, não hesite em nos contatar.</p>
    <p>Seja bem-vindo(a) e aproveite!</p
    <p>Atenciosamente,<br>Equipe do <strong>Ticket Ease</strong></p>"
  end

  def resend_confirmation_email_body(user) do
    "<p>Olá <strong>#{user.name}</strong>,</p>
    <p>Recebemos uma solicitação para reenviar seu token de confirmação.</p>
    <p>Aqui está o seu novo token de confirmação:</p>
    <p><strong>#{user.totp_token}</strong></p>
    <p>Por favor, utilize este token para confirmar sua identidade.</p>
    <p>Se você não solicitou este token, por favor, entre em contato conosco imediatamente.</p>
    <p>Obrigado!</p>"
  end
end
