defmodule SpreedlyAirlinesElixir.TransactionController do
  use SpreedlyAirlinesElixir.Web, :controller

  require Logger

  @spreedly Application.get_env(:spreedly_airlines_elixir, :spreedly)

  def index(conn, _params) do
    response = @spreedly.list_transactions()

    case response do
      {:ok, body} -> conn
        |> render("index.html", transactions: body["transactions"])
      {:error, body} -> conn 
        |> put_flash(:error, "No transactions found!")
        |> render("index.html", transactions: [])
    end
  end

  def show(conn, %{"token" => token}) do
    response = @spreedly.show_transaction(token)

    case response do
      {:ok, body} -> conn
        |> render("show.html", transactions: body["transaction"], raw: Poison.encode!(body))
      {:error, body} -> conn 
        |> put_flash(:error, "Transaction not found, unable to find token #{token}!")
        |> render("show.html", raw: [])
    end
  end

end
