defmodule SpreedlyAirlinesElixir.FlightController do
  use SpreedlyAirlinesElixir.Web, :controller

  require Logger
  
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def purchase_flight(conn, %{"flight_form" => flight_params}) do
    
    # Handle error conditions
    render(conn, "show.html")
    
  end


  # def new(conn, _params) do
  #   changeset = Flight.changeset(%Flight{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"flight" => flight_params}) do
  #   changeset = Flight.changeset(%Flight{}, flight_params)

  #   case Repo.insert(changeset) do
  #     {:ok, _flight} ->
  #       conn
  #       |> put_flash(:info, "Flight created successfully.")
  #       |> redirect(to: flight_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    flights = SpreedlyAirlinesElixir.FlightView.flights
    flight = flights[id]

    case flight do
      nil -> conn |> put_status(:not_found) |> render(SpreedlyAirlinesElixir.ErrorView, "404.html")
      _ -> render(conn, "show.html", [id: id, flight: flight])
    end
  end

end
