# lib/i18n_with_phoenix_web/plugs/locale.ex

defmodule HelpDeskWeb.Plugs.Locale do
  import Plug.Conn

  def init(default_locale), do: default_locale
end
