defmodule SpreedlyAirlinesElixir.FlightControllerTest do
  use SpreedlyAirlinesElixir.ConnCase, async: true
  use ExUnit.Case, async: true

  setup %{conn: conn} do
    session = Plug.Session.init(store: :cookie, key: "test", signing_salt: "pepper")

    # Setup session for testing
    session_conn = conn
    |> Plug.Session.call(session)
    |> Plug.Conn.fetch_session
    |> put_session(:flight_details, build_purchase_params("valid_token", "true", "true")["flight_form"])

    {:ok, conn: session_conn, spreedly: Application.get_env(:spreedly_airlines_elixir, :spreedly)} 
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

    assert redirected_to(conn) == flight_path(conn, :confirmation)

    conn = get conn, flight_path(conn, :confirmation)
    assert html_response(conn, 200)

    assert conn.resp_body =~ "Successfully purchased "
    assert conn.resp_body =~ "Retain on success? false"
    # Verify delivery = false
  end

  test "makes successful purchase and deliver to receiver only", %{conn: conn} do
    params = build_purchase_params("valid_token", false, true)
    conn = post conn, flight_path(conn, :purchase, params)
    assert redirected_to(conn) == flight_path(conn, :confirmation)

    conn = get conn, flight_path(conn, :confirmation)
    assert html_response(conn, 200)

    assert conn.resp_body =~ "Successfully purchased "
    assert conn.resp_body =~ "Retain on success? false"
    # Verify delivery = false
  end

  test "makes successful purchase and retain payment only", %{conn: conn} do
    params = build_purchase_params("valid_token", true, false)
    conn = post conn, flight_path(conn, :purchase, params)
    assert redirected_to(conn) == flight_path(conn, :confirmation)

    conn = get conn, flight_path(conn, :confirmation)
    assert html_response(conn, 200)

    assert conn.resp_body =~ "Successfully purchased "
    assert conn.resp_body =~ "Retain on success? true"
    # Verify delivered false

  end

  test "makes successful purchase, retain payment, and deliver to receiver", %{conn: conn} do
    params = build_purchase_params("valid_token", true, true)
    conn = post conn, flight_path(conn, :purchase, params)
    assert redirected_to(conn) == flight_path(conn, :confirmation)

    conn = get conn, flight_path(conn, :confirmation)
    assert html_response(conn, 200)
    
    assert conn.resp_body =~ "Successfully purchased "
    assert conn.resp_body =~ "Retain on success? true"

    # Check response for delivered
  end

  test "makes failed purchase", %{conn: conn} do
    params = build_purchase_params("invalid_token")
    conn = post conn, flight_path(conn, :purchase, params)
    assert html_response(conn, 200) =~ "Failed to purchase flight"
  end

  test "show confirmation page", %{conn: conn} do
    conn = get conn, flight_path(conn, :confirmation)
    assert html_response(conn, 200)
    assert conn.resp_body =~ "Flight Info"
  end

  defp build_purchase_params(payment_method_token \\ "valid_token", 
    save_payment_info \\ false, send_to_receiver \\ false) do

    %{"flight_form" => %{ 
      "id" =>  "1",
      "payment_method_token" => payment_method_token,
      "email" => "test@spreedly.com",
      "full_name" => "Jared Knipp",
      "save_payment_info" => "#{save_payment_info}",
      "send_to_receiver" => "#{send_to_receiver}"
      }
    }
  end
end
