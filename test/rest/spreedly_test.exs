defmodule SpreedlyTest do
  use SpreedlyAirlinesElixir.ConnCase, async: true

  alias Spreedly.Transaction
  alias Spreedly.Payment

  require Logger

  @valid_attrs %{"id" => 1}
  @invalid_attrs %{}

  test "lists all transactions" do
    response = Spreedly.list_transactions()
    assert %HTTPoison.Response{status_code: 200, body: body} = response, "failed to retrieve transaction list"
  end

  test "shows single transaction" do
    # Will need to create a transaction first for this to work consistently
    response = Spreedly.show_transaction("5lS162AC7rJKsV9Fn3mdgQ5JD2x")
    assert %HTTPoison.Response{status_code: 200, body: body} = response, "failed to retrieve transaction list"
  end

  test "sends 404 if transaciton token is nonexistent" do
    response = Spreedly.show_transaction(-1)
    assert %HTTPoison.Response{status_code: 404, body: body} = response, "did not return not found properly"
  end

  test "creates successful purchase using test card" do
    payment_method_token = create_payment_method_token(good_payment_method())

    transaction = %Transaction{transaction: %Payment{payment_method_token: payment_method_token, amount: "100"}}
    response = Spreedly.purchase(transaction)
    assert %HTTPoison.Response{status_code: 200, body: body} = response, "successfully made a purchase"
  end
  
  test "sends 422 if no payment method corresponding to the payment method token" do
    transaction = %Transaction{transaction: %Payment{payment_method_token: "1234", amount: "100"}}
    response = Spreedly.purchase(transaction)
    assert %HTTPoison.Response{status_code: 422, body: body} = response, "somehow the payment method is on file"
  end


  test "sends unsuccessful purchase using bad test card" do
    payment_method_token = create_payment_method_token(bad_payment_method())

    transaction = %Transaction{transaction: %Payment{payment_method_token: payment_method_token, amount: "100000000"}}
    response = Spreedly.purchase(transaction)
    assert %HTTPoison.Response{status_code: 422, body: body} = response, "purchase made with bad card failed to process"
    
    assert "Unable to process the purchase transaction." = body["transaction"]["message"]
  end

  test "creates HTTP receiver successfully" do
    payload = build_receiver()
    response = Spreedly.create_receiver(payload)
    assert %HTTPoison.Response{status_code: 201, body: body} = response, "failed to create HTTP receiver"
    
    IO.inspect(body)
    assert "retained" = body["receiver"]["state"]
    assert body["receiver"]["token"] != nil
    assert payload.receiver.hostnames == body["receiver"]["hostnames"]
  end

  test "deliver to HTTP receiver successfully" do
    payment_method_token = create_payment_method_token(good_payment_method())
    payload = build_delivery(payment_method_token)

    response = Spreedly.deliver_to_receiver(payload)
    assert %HTTPoison.Response{status_code: 200, body: body} = response, "failed to send to HTTP receiver"
    
    assert "Succeeded!" = body["transaction"]["message"]
    assert "DeliverPaymentMethod" = body["transaction"]["transaction_type"]
    assert body["transaction"]["token"] != nil
    assert payload.delivery.url == body["transaction"]["url"]
    assert 200 == body["transaction"]["response"]["status"]
  end

  defp create_payment_method_token(payment_method) do
    response = Spreedly.create_credit_card(payment_method)
    assert %HTTPoison.Response{status_code: 201, body: body} = response, "did not create card successfully"

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
