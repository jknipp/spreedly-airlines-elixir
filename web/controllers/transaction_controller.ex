defmodule SpreedlyAirlinesElixir.TransactionController do
  use SpreedlyAirlinesElixir.Web, :controller

  alias Spreedly

  require Logger

  def index(conn, _params) do
    response = Spreedly.list_transactions()
    txns = []

    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> conn
        |> render("index.html", transactions: Poison.decode!(body)["transactions"])
      _ -> conn 
        |> put_flash(:error, "No transactions found, Spreedly responded with response code #{response.status_code} !")
        |> render("index.html", transactions: txns)
    end
  end

  def show(conn, %{"token" => token}) do
    response = Spreedly.show_transaction(token)
    
    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> conn
        |> render("show.html", transactions: Poison.decode!(body)["transaction"], raw: body)
      _ -> conn 
        |> put_flash(:error, "Transaction not found, Spreedly responded with response code #{response.status_code} !")
        |> render("show.html")
    end
  end
end
