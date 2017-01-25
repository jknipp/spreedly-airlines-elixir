defmodule SpreedlyAirlinesElixir.TransactionView do
  use SpreedlyAirlinesElixir.Web, :view

  def render("scripts.show.html", _assigns) do
    ~s{<script>require("web/static/js/views/transaction/show").JSONFormat.run()</script>}
    |> raw
  end

end
