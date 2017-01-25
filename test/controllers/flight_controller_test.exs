defmodule SpreedlyAirlinesElixir.FlightControllerTest do
  use SpreedlyAirlinesElixir.ConnCase, async: true

  @valid_attrs %{"id" => 1}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, flight_path(conn, :index)
    assert html_response(conn, 200) =~ ~r"Spreedly Airlines Flights"
  end

  test "shows chosen resource", %{conn: conn} do
    flight = 1
    conn = get conn, flight_path(conn, :show, flight)
    assert html_response(conn, 200) =~ "Flight Info"
    assert html_response(conn, 200) =~ "Passenger Info"
  end

  # TODO - FIX THIS TEST
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent :not_found, fn ->
      get conn, flight_path(conn, :show, -1)
    end
  end

  test "sends 404 id is nonexistent", %{conn: conn} do
    conn = get conn, flight_path(conn, :show, -1)
    assert html_response(conn, 404)
  end
end
