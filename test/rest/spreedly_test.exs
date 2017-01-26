defmodule SpreedlyTest do
  use SpreedlyAirlinesElixir.ConnCase, async: true
  use ExUnit.Case, async: true

  @moduletag :remote

  alias Spreedly.Transaction
  alias Spreedly.Payment

  require Logger

  setup do
      {:ok, spreedly: Spreedly} 
  end


  @valid_attrs %{"id" => 1}
  @invalid_attrs %{}

  test "lists all transactions", %{spreedly: spreedly} do
    response = spreedly.list_transactions()
    assert {:ok, body} = response, "failed to retrieve transaction list"
  end

  test "shows single transaction", %{spreedly: spreedly} do
    # Will need to create a transaction first for this to work consistently
    response = spreedly.show_transaction("5lS162AC7rJKsV9Fn3mdgQ5JD2x")
    assert {:ok, body} = response, "failed to retrieve transaction list"
  end

  test "sends 404 if transaciton token is nonexistent", %{spreedly: spreedly} do
    response = spreedly.show_transaction(-1)
    assert {:error, body} = response, "did not return not found properly"
  end

  test "creates successful purchase using test card", %{spreedly: spreedly} do
    payment_method_token = create_payment_method_token(good_payment_method(), spreedly)

    transaction = %Transaction{transaction: %Payment{payment_method_token: payment_method_token, amount: "100"}}
    response = spreedly.purchase(transaction)
    assert {:ok, body} = response, "successfully made a purchase"
  end
  
  test "sends 422 if no payment method corresponding to the payment method token", %{spreedly: spreedly} do
    transaction = %Transaction{transaction: %Payment{payment_method_token: "1234", amount: "100"}}
    response = spreedly.purchase(transaction)
    assert {:error, body} = response, "somehow the payment method is on file"
  end


  test "sends unsuccessful purchase using bad test card", %{spreedly: spreedly} do
    payment_method_token = create_payment_method_token(bad_payment_method(), spreedly)

    transaction = %Transaction{transaction: %Payment{payment_method_token: payment_method_token, amount: "100000000"}}
    response = spreedly.purchase(transaction)
    assert {:error, body} = response, "purchase made with bad card failed to process"
    
    assert "Unable to process the purchase transaction." = body["transaction"]["message"]
  end

  test "creates HTTP receiver successfully", %{spreedly: spreedly} do
    payload = build_receiver()
    response = spreedly.create_receiver(payload)
    assert {:ok, body} = response, "failed to create HTTP receiver"
    
    # IO.inspect(body)
    assert "retained" = body["receiver"]["state"]
    assert body["receiver"]["token"] != nil
    assert payload.receiver.hostnames == body["receiver"]["hostnames"]
  end

  test "deliver to HTTP receiver successfully", %{spreedly: spreedly} do
    payment_method_token = create_payment_method_token(good_payment_method(), spreedly)
    payload = build_delivery(payment_method_token)

    response = spreedly.deliver_to_receiver(payload)
    assert  {:ok, body} = response, "failed to send to HTTP receiver"
    
    assert "Succeeded!" = body["transaction"]["message"]
    assert "DeliverPaymentMethod" = body["transaction"]["transaction_type"]
    assert body["transaction"]["token"] != nil
    assert payload.delivery.url == body["transaction"]["url"]
    assert 200 == body["transaction"]["response"]["status"]
  end

  defp create_payment_method_token(payment_method, spreedly) do
    response = spreedly.create_credit_card(payment_method)
    assert  {:ok, body} = response, "did not create card successfully"

    # get payment method token
    body["transaction"]["payment_method"]["token"]
  end


  defp good_payment_method do
    %{ payment_method: %{
        credit_card: %{
          first_name: "Joe",
          last_name: "Jones",
          number: "4111111111111111",
          verification_value: 123,
          month: 3,
          year: 2032
        }
      }
    }
  end

  defp bad_payment_method do
    %{ payment_method: %{
        credit_card: %{
          first_name: "Joe",
          last_name: "Jones",
          number: "4012888888881881",
          verification_value: 123,
          month: 3,
          year: 2032
        }
      }
    }
  end

  defp build_receiver do 
    %{
        receiver: %{
            receiver_type: "test",
            hostnames: "http://posttestserver.com"
        }
    }
  end
  
  defp build_delivery(payment_method_token) do
    %{ delivery: %{
        payment_method_token: payment_method_token,
        url: "http://posttestserver.com/post.php",
        headers: "Content-Type: application/json",
        body: "{ \"flight_id\": \"1\", \"card_number\": \"{{credit_card_number}}\" }"
      }
    }
  end
end
