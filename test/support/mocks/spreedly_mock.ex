defmodule Spreedly.Mock do
  require Logger

  def list_transactions() do
    successful_list_response()
  end

  def list_transactions("asc") do
    failed_list_response()
  end

  def show_transaction("valid_token") do
    successful_show_transaction_response()
  end

  def show_transaction("invalid_token") do
    failed_show_transaction_response()
  end

  def create_credit_card(payment_method) do
  end

  # Purchase Only
  def purchase(%Spreedly.Transaction { transaction:  %Spreedly.Payment{
    payment_method_token: "valid_token", retain_on_success: "false" }}) do
    
    successful_purchase_response(false)
  
  end

  # Purchase and save payment
  def purchase(%Spreedly.Transaction { transaction:  %Spreedly.Payment{
    payment_method_token: "valid_token", retain_on_success: "true"  }}) do
  
    successful_purchase_response(true)
  end

  # Failed transaction
  def purchase(%Spreedly.Transaction { transaction:  %Spreedly.Payment{
    payment_method_token: "invalid_token"}}) do
    
    failed_purchase_response()
  end

  def create_receiver(receiver) do
  end

  # 
  def deliver_to_receiver(delivery, receiver_token \\ nil) do 
    successful_purchase_delivery()
  end



  defp successful_list_response do
    %HTTPoison.Response{body: %{"transactions" => [%{"amount" => 147234,
        "api_urls" => [%{"referencing_transaction" => []}],
        "created_at" => "2017-01-25T23:29:06Z", "currency_code" => "USD",
        "description" => "Spreedly Airlines Flight #8756, AMA to CDG",
        "email" => "jared@spreedly.com", "gateway_specific_fields" => nil,
        "gateway_specific_response_fields" => %{},
        "gateway_token" => "EinedeTu7HzwQK38QiWYqxwJzv7",
        "gateway_transaction_id" => "49", "ip" => nil,
        "merchant_location_descriptor" => nil, "merchant_name_descriptor" => nil,
        "message" => "Succeeded!",
        "message_key" => "messages.transaction_succeeded",
        "on_test_gateway" => true, "order_id" => nil,
        "payment_method" => %{"number" => "XXXX-XXXX-XXXX-4444",
            "first_name" => "Jared", "shipping_country" => nil, "company" => nil,
            "month" => 12, "shipping_phone_number" => nil, "year" => 2023,
            "shipping_address2" => nil, "address2" => nil, "errors" => [],
            "last_name" => "Knipp", "country" => nil, "storage_state" => "cached",
            "first_six_digits" => "555555",
            "token" => "6M6sQ3OAqBUWoiMMeOTF7bRw07T", "test" => true,
            "shipping_state" => nil, "shipping_address1" => nil,
            "shipping_city" => nil, "phone_number" => nil, "data" => nil,
            "last_four_digits" => "4444", "payment_method_type" => "credit_card",
            "fingerprint" => "817f6f6012a9f9eab249c5b4f343edc6fb2c", "state" => nil,
            "created_at" => "2017-01-25T23:29:06Z", "address1" => nil,
            "city" => nil, "shipping_zip" => nil, "email" => "jared@spreedly.com"
        }, "payment_method_added" => false,
        "response" => %{"avs_code" => nil, "avs_message" => nil,
            "cancelled" => false, "created_at" => "2017-01-25T23:29:06Z",
            "cvv_code" => nil, "cvv_message" => nil, "error_code" => "",
            "error_detail" => nil, "fraud_review" => nil,
            "message" => "Successful purchase", "pending" => false,
            "result_unknown" => false, "success" => true,
            "updated_at" => "2017-01-25T23:29:06Z"}, "retain_on_success" => true,
        "shipping_address" => %{"address1" => nil, "address2" => nil,
            "city" => nil, "country" => nil, "name" => "Jared Knipp",
            "phone_number" => nil, "state" => nil, "zip" => nil},
        "state" => "succeeded", "succeeded" => true,
        "token" => "AbCfqKD8ri6tq2PCU2xAMKAb1tf",
        "transaction_type" => "Purchase", "updated_at" => "2017-01-25T23:29:06Z"},
        %{"created_at" => "2017-01-25T23:29:06Z", "message" => "Succeeded!",
        "message_key" => "messages.transaction_succeeded",
        "payment_method" => %{"number" => "XXXX-XXXX-XXXX-4444",
            "first_name" => "Jared", "shipping_country" => nil, "company" => nil,
            "month" => 12, "shipping_phone_number" => nil, "year" => 2023,
            "shipping_address2" => nil, "address2" => nil, "errors" => [],
            "last_name" => "Knipp", "country" => nil, "storage_state" => "retained",
            "first_six_digits" => "555555",
            "token" => "6M6sQ3OAqBUWoiMMeOTF7bRw07T", "test" => true,
            "shipping_state" => nil, "shipping_address1" => nil,
            "shipping_city" => nil, "phone_number" => nil, "data" => nil,
            "last_four_digits" => "4444", "payment_method_type" => "credit_card",
            "fingerprint" => "817f6f6012a9f9eab249c5b4f343edc6fb2c", "state" => nil,
            "created_at" => "2017-01-25T23:29:06Z", "address1" => nil,
            "city" => nil, "shipping_zip" => nil, "email" => "jared@spreedly.com",
            "eligible_for_card_updater" => true, "zip" => nil,
            "card_type" => "master", "full_name" => "Jared Knipp",
            "verification_value" => "", "updated_at" => "2017-01-25T23:29:06Z"},
        "retained" => false, "state" => "succeeded", "succeeded" => true,
        "token" => "I4e22M0sgu5jNtYejUzRrDBSxA0",
        "transaction_type" => "AddPaymentMethod",
        "updated_at" => "2017-01-25T23:29:06Z"}
    ]},
    headers: [{"Date", "Wed, 25 Jan 2017 23:38:03 GMT"},
    {"Content-Type", "application/json; charset=utf-8"},
    {"Content-Length", "28137"}, {"Connection", "keep-alive"},
    {"X-Frame-Options", "SAMEORIGIN"}, {"X-XSS-Protection", "1; mode=block"},
    {"X-Content-Type-Options", "nosniff"},
    {"ETag", "W/\"708244c15f24390d8a9a970a61a7c193\""},
    {"Cache-Control", "max-age=0, private, must-revalidate"},
    {"X-Request-Id", "apqvv4d9dotirt75egd0.core_3db715eaab0ca269"},
    {"Server", "nginx"},
    {"Strict-Transport-Security", "max-age=31536000; includeSubdomains;"}],
    status_code: 200}
  end

  defp failed_list_response do
    %HTTPoison.Response{body: %{"transactions" => []},
        headers: [{"Date", "Wed, 25 Jan 2017 23:38:03 GMT"},
        {"Content-Type", "application/json; charset=utf-8"},
        {"Content-Length", "28137"}, {"Connection", "keep-alive"},
        {"X-Frame-Options", "SAMEORIGIN"}, {"X-XSS-Protection", "1; mode=block"},
        {"X-Content-Type-Options", "nosniff"},
        {"ETag", "W/\"708244c15f24390d8a9a970a61a7c193\""},
        {"Cache-Control", "max-age=0, private, must-revalidate"},
        {"X-Request-Id", "apqvv4d9dotirt75egd0.core_3db715eaab0ca269"},
        {"Server", "nginx"},
        {"Strict-Transport-Security", "max-age=31536000; includeSubdomains;"}],
        status_code: 422
    }
  end

  defp successful_show_transaction_response do
    %HTTPoison.Response{body: %{"transaction" => %{"amount" => 147234,
        "api_urls" => [%{"referencing_transaction" => []}],
        "created_at" => "2017-01-25T23:29:06Z", "currency_code" => "USD",
        "description" => "Spreedly Airlines Flight #8756, AMA to CDG",
        "email" => "jared@spreedly.com", "gateway_specific_fields" => nil,
        "gateway_specific_response_fields" => %{},
        "gateway_token" => "EinedeTu7HzwQK38QiWYqxwJzv7",
        "gateway_transaction_id" => "49", "ip" => nil,
        "merchant_location_descriptor" => nil, "merchant_name_descriptor" => nil,
        "message" => "Succeeded!",
        "message_key" => "messages.transaction_succeeded",
        "on_test_gateway" => true, "order_id" => nil,
        "payment_method" => %{"number" => "XXXX-XXXX-XXXX-4444",
        "first_name" => "Jared", "shipping_country" => nil, "company" => nil,
        "month" => 12, "shipping_phone_number" => nil, "year" => 2023,
        "shipping_address2" => nil, "address2" => nil, "errors" => [],
        "last_name" => "Knipp", "country" => nil, "storage_state" => "cached",
        "first_six_digits" => "555555", "token" => "6M6sQ3OAqBUWoiMMeOTF7bRw07T",
        "test" => true, "shipping_state" => nil, "shipping_address1" => nil,
        "shipping_city" => nil, "phone_number" => nil, "data" => nil,
        "last_four_digits" => "4444", "payment_method_type" => "credit_card",
        "fingerprint" => "817f6f6012a9f9eab249c5b4f343edc6fb2c", "state" => nil,
        "created_at" => "2017-01-25T23:29:06Z", "address1" => nil, "city" => nil,
        "shipping_zip" => nil, "email" => "jared@spreedly.com",
        "eligible_for_card_updater" => nil},
        "payment_method_added" => false,
        "response" => %{"avs_code" => nil, "avs_message" => nil,
        "cancelled" => false, "created_at" => "2017-01-25T23:29:06Z",
        "cvv_code" => nil, "cvv_message" => nil, "error_code" => "",
        "error_detail" => nil, "fraud_review" => nil,
        "message" => "Successful purchase", "pending" => false,
        "result_unknown" => false, "success" => true,
        "updated_at" => "2017-01-25T23:29:06Z"}, "retain_on_success" => true,
        "shipping_address" => %{"address1" => nil, "address2" => nil,
        "city" => nil, "country" => nil, "name" => "Jared Knipp",
        "phone_number" => nil, "state" => nil, "zip" => nil},
        "state" => "succeeded", "succeeded" => true,
        "token" => "AbCfqKD8ri6tq2PCU2xAMKAb1tf", "transaction_type" => "Purchase",
        "updated_at" => "2017-01-25T23:29:06Z"}},
    headers: [{"Date", "Thu, 26 Jan 2017 03:22:19 GMT"},
    {"Content-Type", "application/json; charset=utf-8"},
    {"Content-Length", "2058"}, {"Connection", "keep-alive"},
    {"X-Frame-Options", "SAMEORIGIN"}, {"X-XSS-Protection", "1; mode=block"},
    {"X-Content-Type-Options", "nosniff"},
    {"ETag", "W/\"1a89b64c5f4776b2beb18c1d39818377\""},
    {"Cache-Control", "max-age=0, private, must-revalidate"},
    {"X-Request-Id", "apr35ppijkvj66987kig.core_d38aa3567a453950"},
    {"Server", "nginx"},
    {"Strict-Transport-Security", "max-age=31536000; includeSubdomains;"}],
    status_code: 200
    }
  end

  defp failed_show_transaction_response do
    %HTTPoison.Response{body: %{"errors" => [%{"key" => "errors.transaction_not_found",
        "message" => "Unable to find the transaction 1."}]},
        headers: [{"Date", "Thu, 26 Jan 2017 03:25:53 GMT"},
        {"Content-Type", "application/json; charset=utf-8"}, {"Content-Length", "97"},
        {"Connection", "keep-alive"}, {"X-Frame-Options", "SAMEORIGIN"},
        {"X-XSS-Protection", "1; mode=block"}, {"X-Content-Type-Options", "nosniff"},
        {"Cache-Control", "no-cache"},
        {"X-Request-Id", "apr37dtp8n0v22pq9r1g.core_f258d8d8034d63ea"},
        {"Server", "nginx"}], status_code: 404
    }
  end

  defp successful_purchase_response(retain_on_success) do
    %HTTPoison.Response{body: %{"transaction" => %{"amount" => 19212,
      "api_urls" => [%{"referencing_transaction" => []}],
      "created_at" => "2017-01-26T15:43:25Z", "currency_code" => "USD",
      "description" => "Spreedly Airlines Flight #4151, DFW to SFO",
      "email" => "jared@spreedly.com", "gateway_specific_fields" => nil,
      "gateway_specific_response_fields" => %{},
      "gateway_token" => "EinedeTu7HzwQK38QiWYqxwJzv7",
      "gateway_transaction_id" => "64", "ip" => nil,
      "merchant_location_descriptor" => nil, "merchant_name_descriptor" => nil,
      "message" => "Succeeded!",
      "message_key" => "messages.transaction_succeeded",
      "on_test_gateway" => true, "order_id" => nil,
      "payment_method" => %{"number" => "XXXX-XXXX-XXXX-1111",
        "first_name" => "Jared", "shipping_country" => nil, "company" => nil,
        "month" => 12, "shipping_phone_number" => nil, "year" => 2022,
        "shipping_address2" => nil, "address2" => nil, "errors" => [],
        "last_name" => "Knipp", "country" => nil, "storage_state" => "cached",
        "first_six_digits" => "411111", "token" => "Icl8Litme8BEmyi68QgYayRUIoQ",
        "test" => true, "shipping_state" => nil, "shipping_address1" => nil,
        "shipping_city" => nil, "phone_number" => nil, "data" => nil,
        "last_four_digits" => "1111", "payment_method_type" => "credit_card",
        "fingerprint" => "88129468ae4942807b2f654cf0298aec49ab", "state" => nil,
        "created_at" => "2017-01-26T15:43:24Z", "address1" => nil, "city" => nil,
        "shipping_zip" => nil, "email" => "jared@spreedly.com",
        "eligible_for_card_updater" => nil},
      "payment_method_added" => false,
      "response" => %{"avs_code" => nil, "avs_message" => nil,
        "cancelled" => false, "created_at" => "2017-01-26T15:43:25Z",
        "cvv_code" => nil, "cvv_message" => nil, "error_code" => "",
        "error_detail" => nil, "fraud_review" => nil,
        "message" => "Successful purchase", "pending" => false,
        "result_unknown" => false, "success" => true,
        "updated_at" => "2017-01-26T15:43:25Z"}, 
      "retain_on_success" => retain_on_success,
      "shipping_address" => %{"address1" => nil, "address2" => nil,
        "city" => nil, "country" => nil, "name" => "Jared Knipp",
        "phone_number" => nil, "state" => nil, "zip" => nil},
      "state" => "succeeded", "succeeded" => true,
      "token" => "EF8PCpa8M5crWkxEZPjjugU4Rbh", "transaction_type" => "Purchase",
      "updated_at" => "2017-01-26T15:43:25Z"}},
    headers: [{"Date", "Thu, 26 Jan 2017 15:43:25 GMT"},
      {"Content-Type", "application/json; charset=utf-8"},
      {"Content-Length", "2055"}, {"Connection", "keep-alive"},
      {"X-Frame-Options", "SAMEORIGIN"}, {"X-XSS-Protection", "1; mode=block"},
      {"X-Content-Type-Options", "nosniff"}, {"X-Spreedly-Test", "true"},
      {"ETag", "W/\"c827638620c126ecf51e84d9afea7d74\""},
      {"Cache-Control", "max-age=0, private, must-revalidate"},
      {"X-Request-Id", "aprdp1i195khd6f7sa40.core_bc7761988be53a93"},
      {"Server", "nginx"},
      {"Strict-Transport-Security", "max-age=31536000; includeSubdomains;"}],
    status_code: 200}
  end

  defp successful_purchase_delivery() do
    %HTTPoison.Response{body: %{"transaction" => %{"created_at" => "2017-01-26T15:43:25Z",
     "message" => "Succeeded!",
     "payment_method" => %{"number" => "XXXX-XXXX-XXXX-1111",
       "first_name" => "Jared", "shipping_country" => nil, "company" => nil,
       "month" => 12, "shipping_phone_number" => nil, "year" => 2022,
       "shipping_address2" => nil, "address2" => nil, "errors" => [],
       "last_name" => "Knipp", "country" => nil, "storage_state" => "retained",
       "first_six_digits" => "411111", "token" => "Icl8Litme8BEmyi68QgYayRUIoQ",
       "test" => true, "shipping_state" => nil, "shipping_address1" => nil,
       "shipping_city" => nil, "phone_number" => nil, "data" => nil,
       "last_four_digits" => "1111", "payment_method_type" => "credit_card",
       "fingerprint" => "88129468ae4942807b2f654cf0298aec49ab", "state" => nil,
       "created_at" => "2017-01-26T15:43:24Z", "address1" => nil, "city" => nil,
       "shipping_zip" => nil, "email" => "jared@spreedly.com",
       "eligible_for_card_updater" => true, "zip" => nil, "card_type" => "visa",
       "full_name" => "Jared Knipp", "verification_value" => "",
       "updated_at" => "2017-01-26T15:43:25Z"},
     "receiver" => %{"created_at" => "2017-01-25T21:49:18Z",
       "credentials" => nil, "hostnames" => "http://posttestserver.com",
       "receiver_type" => "test", "state" => "retained",
       "token" => "BkB0jqBzB70EpNkBhhBQT88dgJf",
       "updated_at" => "2017-01-25T21:49:18Z"},
     "response" => %{"body" => "Successfully dumped 0 post variables.\nView it at http://www.posttestserver.com/data/2017/01/26/07.43.251430997649\nPost body was 55 chars long.",
       "headers" => "Date: Thu, 26 Jan 2017 15:43:25 GMT\r\nServer: Apache\r\nAccess-Control-Allow-Origin: *\r\nAccess-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept\r\nVary: Accept-Encoding\r\nContent-Length: 142\r\nContent-Type: text/html; charset=UTF-8",
       "status" => 200}, "state" => "succeeded", "succeeded" => true,
     "token" => "NmkEV1axRNJ1Kj5VPcjDcici4p2",
     "transaction_type" => "DeliverPaymentMethod",
     "updated_at" => "2017-01-26T15:43:25Z",
     "url" => "http://posttestserver.com/post.php"}},
  headers: [{"Date", "Thu, 26 Jan 2017 15:43:25 GMT"},
    {"Content-Type", "application/json; charset=utf-8"},
    {"Content-Length", "1791"}, {"Connection", "keep-alive"},
    {"X-Frame-Options", "SAMEORIGIN"}, {"X-XSS-Protection", "1; mode=block"},
    {"X-Content-Type-Options", "nosniff"},
    {"ETag", "W/\"6e411ee1da46257cfb9e42f77a647c0b\""},
    {"Cache-Control", "max-age=0, private, must-revalidate"},
    {"X-Request-Id", "aprdp1k06cbcg02c4gag.core_6c08a69641529721"},
    {"Server", "nginx"},
    {"Strict-Transport-Security", "max-age=31536000; includeSubdomains;"}],
  status_code: 200}

  end

  defp failed_purchase_response do
    %HTTPoison.Response{body: %{"transaction" => %{"amount" => 19212,
        "api_urls" => [%{"referencing_transaction" => []}],
        "created_at" => "2017-01-26T04:16:30Z", "currency_code" => "USD",
        "description" => "Spreedly Airlines Flight #4151, DFW to SFO",
        "email" => "jared@spreedly.com", "gateway_specific_fields" => nil,
        "gateway_specific_response_fields" => %{},
        "gateway_token" => "EinedeTu7HzwQK38QiWYqxwJzv7",
        "gateway_transaction_id" => nil, "ip" => nil,
        "merchant_location_descriptor" => nil, "merchant_name_descriptor" => nil,
        "message" => "Unable to process the purchase transaction.",
        "on_test_gateway" => true, "order_id" => nil,
        "payment_method" => %{"number" => "XXXX-XXXX-XXXX-1881",
        "first_name" => "Jared", "shipping_country" => nil, "company" => nil,
        "month" => 12, "shipping_phone_number" => nil, "year" => 2018,
        "shipping_address2" => nil, "address2" => nil, "errors" => [],
        "last_name" => "Knipp", "country" => nil, "storage_state" => "cached",
        "first_six_digits" => "401288", "token" => "H3R83z0hgzJ4ClZ6cdXo2llwivC",
        "test" => true, "shipping_state" => nil, "shipping_address1" => nil,
        "shipping_city" => nil, "phone_number" => nil, "data" => nil,
        "last_four_digits" => "1881", "payment_method_type" => "credit_card",
        "fingerprint" => "cf2289479816806d613adca3d9605a7cc00f", "state" => nil,
        "created_at" => "2017-01-26T04:16:29Z", "address1" => nil, "city" => nil,
        "shipping_zip" => nil, "email" => "jared@spreedly.com",
        "eligible_for_card_updater" => nil, "zip" => nil},
        "payment_method_added" => false,
        "response" => %{"avs_code" => nil, "avs_message" => nil,
        "cancelled" => false, "created_at" => "2017-01-26T04:16:30Z",
        "cvv_code" => nil, "cvv_message" => nil, "error_code" => "",
        "error_detail" => nil, "fraud_review" => nil,
        "message" => "Unable to process the purchase transaction.",
        "pending" => false, "result_unknown" => false, "success" => false,
        "updated_at" => "2017-01-26T04:16:30Z"}, "retain_on_success" => false,
        "shipping_address" => %{"address1" => nil, "address2" => nil,
        "city" => nil, "country" => nil, "name" => "Jared Knipp",
        "phone_number" => nil, "state" => nil, "zip" => nil},
        "state" => "gateway_processing_failed", "succeeded" => false,
        "token" => "Vd6XGnkKANDBFG7zxs98sOgugSX", "transaction_type" => "Purchase",
        "updated_at" => "2017-01-26T04:16:30Z"}},
    headers: [{"Date", "Thu, 26 Jan 2017 04:16:30 GMT"},
    {"Content-Type", "application/json; charset=utf-8"},
    {"Content-Length", "2084"}, {"Connection", "keep-alive"},
    {"X-Frame-Options", "SAMEORIGIN"}, {"X-XSS-Protection", "1; mode=block"},
    {"X-Content-Type-Options", "nosniff"}, {"X-Spreedly-Test", "true"},
    {"Cache-Control", "no-cache"},
    {"X-Request-Id", "apr3ujbl8iodckkg743g.core_6eb2d0c20d2d9d31"},
    {"Server", "nginx"}], status_code: 422}
  end

end

