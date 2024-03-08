defmodule HelpDeskWeb.Plugs.CORS do
  use Corsica.Router,
    origins: ["http://localhost:4000", "http://localhost:8080", ~r{^https?://(.*\.)?foo\.com$}],
    allow_credentials: true,
    allow_headers: ["content-type", "accept"],
    max_age: 600

  resource "/public/*", origins: "*"
  resource "/*"
end
