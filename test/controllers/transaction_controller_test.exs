defmodule SpreedlyAirlinesElixir.TransactionControllerTest do
  use SpreedlyAirlinesElixir.ConnCase
  
  import Mock

  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, transaction_path(conn, :index)
    assert html_response(conn, 200) =~ "View Latest Transactions"
  end

  describe "transaction detail" do
    # test "shows chosen resource", %{conn: conn} do
    #   transaction = Repo.insert! %Transaction{}
    #   conn = get conn, transaction_path(conn, :show, transaction)
    #   assert html_response(conn, 200) =~ "Show transaction"
    # end

    # test "renders transaction not found when id is nonexistent" do
    #   with_mock Spreedly, [show_transaction: fn(token) -> SpreedlyMock.show_transaction(token) end] do
    #     conn = get conn, transaction_path(conn, :show, -1)
    #     assert html_response(conn, 200) =~ "Transaction not found"
    #   end
    # end

    # test "renders transaction not found when id is nonexistent 2" do
    #   conn = get conn, transaction_path(conn, :show, -1, SpreedlyMock)
    #   assert html_response(conn, 200) =~ "Transaction not found"

    # end
  end



end
