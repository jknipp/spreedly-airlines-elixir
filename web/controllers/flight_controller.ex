defmodule SpreedlyAirlinesElixir.FlightController do
  use SpreedlyAirlinesElixir.Web, :controller

  alias Spreedly.Transaction
  alias Spreedly.Payment

  require Logger
  
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def purchase(conn, %{"flight_form" => flight_params}) do
    flight = find_flight(flight_params["id"])
    transaction = build_transaction(flight, flight_params)

    response = Spreedly.purchase(transaction)

    case response do 

      # re-redirect to show if there was an issue, falsh error messasge
      %HTTPoison.Response{status_code: 200, body: body} -> conn
        |> put_flash(:success, 
          "Successfully purchased #{flight.airline} Flight ##{flight.number}! Spreedly responded w/ #{Poison.decode!(body)["transaction"]["response"]["message"]} ")
        |> put_session(:flight_details, flight_params)
        |> redirect(to: flight_path(conn, :confirmation))
      _ -> 
        conn
        |> put_flash(:error, "Failed to purchase flight. Response from gateway -> #{Poison.decode!(response.body)["transaction"]["message"]}")
        |> render("show.html", id: flight_params["id"], flight: flight)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = find_flight(id)

    case flight do
      nil -> conn |> put_status(:not_found) |> render(SpreedlyAirlinesElixir.ErrorView, "404.html")
      _ -> render(conn, "show.html", [id: id, flight: flight])
    end
  end

  def confirmation(conn, _params) do
    details = get_session(conn, :flight_details)
    flight = find_flight(details["id"])
    user = for {key, val} <- details, into: %{}, do: {String.to_atom(key), val}

    render(conn, "confirmation.html", flight: flight, user: user)
  end 

  defp build_transaction(flight, flight_params) do 
    %Transaction { transaction: 
      %Payment{
        payment_method_token: flight_params["payment_method_token"], 
        amount: trunc(flight.price * 100), 
        email: flight_params["email"],
        retain_on_success: flight_params["save_payment_info"],
        description: "#{flight.airline} Flight ##{flight.number}, #{flight.from} to #{flight.to}"
      }
    }
  end

  defp find_flight(id) do
    SpreedlyAirlinesElixir.FlightView.flights[id]
  end 
end
