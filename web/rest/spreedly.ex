defmodule Spreedly do
  # use HTTPoison.Base

  require Logger
  
  @base_url Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:base_url]
  @key Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:env_key]
  @secret Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:access_secret]
  @gateway Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:gateway_token]

  defmodule Payment do
    @derive [Poison.Encoder]
    defstruct [:payment_method_token, :amount, :email, currency_code: "USD", retain_on_success: false, description: nil ]
  end

  defmodule Transaction do
    @derive [Poison.Encoder]
    defstruct [transaction: %Payment{}]
  end

  def list_transactions() do 
    process_get("/v1/transactions.json?order=desc")
  end

  def show_transaction(token) do
    url = "/v1/transactions/#{token}.json"
    process_get(url)
  end

  def purchase(transaction, gateway_token \\ @gateway) do
    url = "#{@base_url}/v1/gateways/#{gateway_token}/purchase.json"
     
    result = HTTPoison.post!(url, Poison.encode!(transaction), headers())
    %HTTPoison.Response{status_code: status_code, body: body} = result
  end

  def send_to_receiver() do 

  end

  def create_credit_card(payment_method) do
    url = "#{@base_url}/v1/payment_methods.json"
     
    Logger.warn(Poison.encode!(payment_method))
    result = HTTPoison.post!(url, Poison.encode!(payment_method), headers())
    %HTTPoison.Response{status_code: status_code, body: body} = result
  end

  defp process_get(url) do
    result = HTTPoison.get!("#{@base_url}#{url}", headers())
    %HTTPoison.Response{status_code: status_code, body: body} = result
  end

  defp headers do
    [auth_header(), {"Content-Type", "application/json"}]
  end

  defp auth_header(username \\ @key, password \\ @secret ) do
    encoded = Base.encode64("#{username}:#{password}")
    {"Authorization", "Basic #{encoded}"}
  end

end
