defmodule HelpDesk.Users do
  alias HelpDesk.Users.Create
  alias HelpDesk.Users.Delete
  alias HelpDesk.Users.Get
  alias HelpDesk.Users.Update
  alias HelpDesk.Users.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate login(params), to: Verify, as: :call
  defdelegate validation_account(params), to: Verify, as: :call
  defdelegate resend_verification_account_code(params), to: Verify, as: :resend_verification_account_mailer
end
