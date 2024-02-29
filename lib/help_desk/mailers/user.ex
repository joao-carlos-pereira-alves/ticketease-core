defmodule HelpDesk.Mailers.User do
  import Bamboo.Email
  import Bamboo.Phoenix

  @from_address "hello@example.com"
  @reply_to_address "reply@example.com"

  def welcome_email(user) do
    html_body = email_body(user)
    base_email() # Build your default email then customize for welcome
    |> to(user.email)
    |> subject("Conta criada com sucesso!")
    |> put_header("Reply-To", @reply_to_address)
    |> html_body(html_body)
    |> text_body("Aproveite para conhecer nosso sistema")
  end

  defp base_email do
    new_email()
    |> from(@from_address) # Set a default from
    |> put_html_layout({HelpDeskWeb.LayoutView, "email.html"}) # Set default layout
    |> put_text_layout({HelpDeskWeb.LayoutView, "email.text"}) # Set default text layout
  end

  defp email_body(user) do
    "
    <p>
      Seja Bem vindo <strong> #{user.name} </strong> ao HelpDesk!
    </p>
    "
  end
end
