defmodule SpreedlyAirlinesElixir.TransactionControllerTest do
  use SpreedlyAirlinesElixir.ConnCase
  use ExUnit.Case, async: true

  setup do
      {:ok, spreedly: Application.get_env(:spreedly_airlines_elixir, :spreedly)} 
  end

  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, transaction_path(conn, :index)
    # IO.inspect conn.resp_body
    assert html_response(conn, 200) =~ "View Latest Transactions"
    assert conn.resp_body =~ "Transaction Type"
    assert conn.resp_body =~ "Detail"
  end
  
  test "lists no entries found on index", %{conn: conn} do
    conn = get conn, transaction_path(conn, :index)
    assert html_response(conn, 200) =~ "No transactions found"
  end

  test "shows chosen resource", %{conn: conn} do
    conn = get conn, transaction_path(conn, :show, "valid_token")
    assert html_response(conn, 200) =~ "Transaction detail"
    assert conn.resp_body =~ "transaction_type"
    assert conn.resp_body =~ "on_test_gateway"
  end

  test "renders transaction not found when id is nonexistent", %{conn: conn} do
    conn = get conn, transaction_path(conn, :show, "invalid_token")
    assert html_response(conn, 200) =~ "Transaction not found"
  end

end
