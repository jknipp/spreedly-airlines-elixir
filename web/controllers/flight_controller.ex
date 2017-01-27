defmodule SpreedlyAirlinesElixir.FlightController do
  use SpreedlyAirlinesElixir.Web, :controller

  require Logger
  require Spreedly

  @spreedly Application.get_env(:spreedly_airlines_elixir, :spreedly)

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def purchase(conn, %{"flight_form" => params}) do
    flight_id = params["id"]
    flight = find_flight(flight_id)

    response = make_purchase(flight, params)
    delivery_response = deliver_to_receiver(params["send_to_receiver"], params["payment_method_token"], flight_id)

    case response do 
      {:ok, body} -> conn
        |> put_flash(:success, 
          "Successfully purchased #{flight.airline} Flight ##{flight.number}! Spreedly responded w/ #{body["transaction"]["response"]["message"]} ")
        |> put_session(:flight_details, params)
        |> redirect(to: flight_path(conn, :confirmation))
      {:error, body} -> conn
        |> put_flash(:error, "Failed to purchase flight. Response from Spreedly -> #{body["transaction"]["message"]}")
        |> render("show.html", id: params["id"], flight: flight)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = find_flight(id)

    case flight do
      nil -> conn 
        |> put_status(:not_found) 
        |> render(SpreedlyAirlinesElixir.ErrorView, "404.html")
      _ -> render(conn, "show.html", [id: id, flight: flight])
    end
  end

  def confirmation(conn, _params) do
    details = get_session(conn, :flight_details)
    flight = find_flight(details["id"])
    user = for {key, val} <- details, into: %{}, do: {String.to_atom(key), val}

    render(conn, "confirmation.html", flight: flight, user: user)
  end 


  def make_purchase(flight, params) do
    build_transaction(flight, params) |> @spreedly.purchase()
  end

  def deliver_to_receiver("true", payment_method_token, flight_id) do
    build_delivery(payment_method_token, flight_id) |> @spreedly.deliver_to_receiver()
  end

  def deliver_to_receiver(_deliver, _payment_method_token, _flight_id), do: Logger.debug "Skipping delivery"
  
  defp build_transaction(flight, params) do 
    %Spreedly.Transaction { transaction: 
      %Spreedly.Payment{
        payment_method_token: params["payment_method_token"], 
        amount: trunc(flight.price * 100), 
        email: params["email"],
        retain_on_success: params["save_payment_info"],
        description: "#{flight.airline} Flight ##{flight.number}, #{flight.from} to #{flight.to}"
      }
    }
  end

  defp build_delivery(payment_method_token, id) do
    %{ delivery: %{
        payment_method_token: payment_method_token,
        url: "http://posttestserver.com/post.php",
        headers: "Content-Type: application/json",
        body: "{ \"flight_id\": \"#{id}\", \"card_number\": \"{{credit_card_number}}\" }"
      }
    }
  end 

  defp find_flight(id) do
    SpreedlyAirlinesElixir.FlightView.flights[id]
  end 
end
