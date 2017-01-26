defmodule SpreedlyAirlinesElixir.FlightControllerTest do
  use SpreedlyAirlinesElixir.ConnCase, async: true
  use ExUnit.Case, async: true

  setup do
      {:ok, spreedly: Application.get_env(:spreedly_airlines_elixir, :spreedly)} 
  end

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

  test "renders page not found when id is nonexistent", %{conn: conn} do
    conn = get conn, flight_path(conn, :show, -1)
    assert html_response(conn, 404) =~ "Page not found"
  end

  test "sends 404 id is nonexistent", %{conn: conn} do
    conn = get conn, flight_path(conn, :show, -1)
    assert html_response(conn, 404)
  end

  test "makes successful purchase only", %{conn: conn} do
    params = build_purchase_params()
    conn = post conn, flight_path(conn, :purchase, params)
    assert redirected_to(flight_path(conn, :confirmation))
    # assert html_response(conn, 302) =~ "Successfully purchased"
    # Verify retained = false
    # Verify delivery = false
  end

  test "makes successful purchase and deliver to receiver only", %{conn: conn} do
    params = build_purchase_params("")
    conn = post conn, flight_path(conn, :purchase, params)
    assert html_response(conn, 200) =~ "Successfully purchased"
    # Check response for delivered
    # Verify retained = false
  end

  test "makes successful purchase and retain payment only", %{conn: conn} do
    params = build_purchase_params("")
    conn = post conn, flight_path(conn, :purchase, params)
    assert html_response(conn, 200) =~ "Successfully purchased"

    # Check response for retained
    # Verify delivered false
  end

  test "makes successful purchase, retain payment, and deliver to receiver", %{conn: conn} do
    params = build_purchase_params("")
    conn = post conn, flight_path(conn, :purchase, params)
    assert html_response(conn, 200) =~ "Successfully purchased"
    # Check response for retained
    # Check response for delivered
  end

  test "makes failed purchase", %{conn: conn} do
    params = build_purchase_params("invalid_token")
    conn = post conn, flight_path(conn, :purchase, params)
    assert html_response(conn, 200) =~ "Failed to purchase flight"
  end

  # test "show confirmation page", %{conn: conn} do
  #   conn = get conn, flight_path(conn, :show, -1)
  #   assert html_response(conn, 404)
  # end

  defp build_purchase_params(payment_method_token \\ "valid_token", 
    save_payment_info \\ "false", send_to_receiver \\ "false") do

    %{flight_form: %{ 
      "id": 1,
      "payment_method_token": payment_method_token,
      "email": "test@spreedly.com",
      "save_payment_info": save_payment_info,
      "send_to_receiver": send_to_receiver
      }
    }
  end
end
