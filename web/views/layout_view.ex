defmodule SpreedlyAirlinesElixir.LayoutView do
  use SpreedlyAirlinesElixir.Web, :view

  def flash_messages(conn, key) do
    case get_flash(conn, key) do
      [_ | _] = messages -> messages
      nil -> []
      message -> [message]
    end
  end
end
