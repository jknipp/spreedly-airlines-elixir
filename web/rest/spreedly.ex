defmodule Spreedly do
  use HTTPoison.Base

  require Logger
  
  @base_url Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:base_url]
  @key Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:env_key]
  @secret Application.get_env(:spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint)[:access_secret]

  # def process_url(url) do
  #   @base_url <> url
  # end

  # def process_response_body(body) do
  #   body
  #   |> Poison.decode!
  #   |> Map.take(@expected_fields)
  #   |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  # end

  def list_transactions() do 
    result = HTTPoison.get!("#{@base_url}/v1/transactions.json?order=desc", headers)
    #Logger.info "Request = {get, #{url}, #{inspect headers}}" 
    %HTTPoison.Response{status_code: status_code, body: body} = result
  end

  def show_transaction(token) do
    url = "#{@base_url}/v1/transactions/#{token}.json"

    result = HTTPoison.get!(url, headers)
    %HTTPoison.Response{status_code: status_code, body: body} = result
  end

  def purchase(gateway_token, transaction) do
    url = "#{@base_url}/v1/gateways/#{gateway_token}.purchase.json"

    # Todo 
    result = HTTPoison.post!(url, headers)
    %HTTPoison.Response{status_code: status_code, body: body} = result
  end

  def send_to_receiver() do 

  end

  defp headers do
    [auth_header, {"Content-Type", "application/json"}]
  end

  defp auth_header(username \\ @key, password \\ @secret ) do
    encoded = Base.encode64("#{username}:#{password}")
    {"Authorization", "Basic #{encoded}"}
  end
end
