defmodule SevenMindWeb.ContentManager.Setup.Redoc do
  defdelegate init(opts), to: Redoc.Plug.RedocUI
  defdelegate call(conn, opts), to: Redoc.Plug.RedocUI
end
