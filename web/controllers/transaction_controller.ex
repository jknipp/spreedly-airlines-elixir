defmodule SpreedlyAirlinesElixir.TransactionController do
  use SpreedlyAirlinesElixir.Web, :controller

  require Logger

  @spreedly Application.get_env(:spreedly_airlines_elixir, :spreedly)

  def index(conn, _params) do
    response = @spreedly.list_transactions()

    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> conn
        |> render("index.html", transactions: body["transactions"])
      _ -> conn 
        |> put_flash(:error, "No transactions found, Spreedly responded with response code #{response.status_code} !")
        |> render("index.html", transactions: [])
    end
  end

  def show(conn, %{"token" => token}) do
    response = @spreedly.show_transaction(token)

    case response do
      %HTTPoison.Response{status_code: 200, body: body} -> conn
        |> render("show.html", transactions: body["transaction"], raw: Poison.encode!(body))
      _ -> conn 
        |> put_flash(:error, "Transaction not found, Spreedly responded with response code #{response.status_code} for token #{token}!")
        |> render("show.html", raw: [])
    end
  end

end
