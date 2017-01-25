defmodule SpreedlyAirlinesElixir.TransactionController do
  use SpreedlyAirlinesElixir.Web, :controller

  require Logger

  @spreedly Spreedly


  def index(conn, _params) do
    response = @spreedly.list_transactions()
    txns = []

    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> 
        conn
        |> render("index.html", transactions: body["transactions"])
      _ -> 
        conn 
        |> put_flash(:error, "No transactions found, Spreedly responded with response code #{response.status_code} !")
        |> render("index.html", transactions: txns)
    end
  end

  def show(conn, %{"token" => token}, spreedly \\ Spreedly) do
    Logger.warn("trying show")
    response = @spreedly.show_transaction(token)
    Logger.warn("failed  show")
    
    case response do

      %HTTPoison.Response{status_code: 200, body: body} -> conn
        |> render("show.html", transactions: body["transaction"], raw: body)
      _ -> conn 
        |> put_flash(:error, "Transaction not found, Spreedly responded with response code #{response.status_code} for token #{token}!")
        |> render("show.html", raw: [])
    end
  end
end
