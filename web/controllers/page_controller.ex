defmodule SpreedlyAirlinesElixir.PageController do
  use SpreedlyAirlinesElixir.Web, :controller

  require Logger


  def index(conn, _params) do
    render conn, "index.html"
  end

end
