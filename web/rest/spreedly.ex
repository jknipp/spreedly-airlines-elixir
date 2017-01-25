defmodule Spreedly do
  use HTTPoison.Base

  require Logger
  
  @endpoint Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:base_url]
  @key Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:env_key]
  @secret Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:access_secret]
  @gateway_token Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:gateway_token]
  @receiver_token Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:receiver_token]

  defmodule Payment do
    @derive [Poison.Encoder]
    defstruct [:payment_method_token, :amount, :email, currency_code: "USD", retain_on_success: false, description: nil ]
  end

  defmodule Transaction do
    @derive [Poison.Encoder]
    defstruct [transaction: %Payment{}]
  end

  def list_transactions() do 
    get!("/v1/transactions.json?order=desc")
  end

  def show_transaction(token) do
    get!("/v1/transactions/#{token}.json")
  end

  def purchase(transaction, gateway_token \\ @gateway_token) do
    post!("/v1/gateways/#{gateway_token}/purchase.json", transaction)
  end

  def create_receiver(receiver) do
    post!("/v1/receivers.json", receiver)
  end

  def deliver_to_receiver(delivery, receiver_token \\ @receiver_token) do 
    post!("/v1/receivers/#{receiver_token}/deliver.json", delivery)
  end

  def create_credit_card(payment_method) do
    post!("/v1/payment_methods.json", payment_method)
  end

  defp headers(username \\ @key, password \\ @secret ) do
    encoded = Base.encode64("#{username}:#{password}")
    [{"Authorization", "Basic #{encoded}"}, {"Content-Type", "application/json"}]
  end

  # HTTPoison 
  def process_url(url) do
    @endpoint <> url
  end
  
  def process_response_body(body) do
    body |> Poison.decode!
  end
  
  def process_request_body(body) do
    body |> Poison.encode!
  end

  def process_request_headers(headers) do
    headers()
  end
end
