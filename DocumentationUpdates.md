# Documentation updates

1. [Add to checkout page javacript has comma instead of colon](https://docs.spreedly.com/guides/adding-payment-methods/express/#add-to-checkout-page)
   ```
   "full_name", "First Last"
   ```
   should be
   ```
   "full_name": "First Last"
   ```

1. [Update Express Form](https://docs.spreedly.com/guides/adding-payment-methods/express/#add-to-checkout-page) 
   ```
   <input type="submit" value="Enter Payment Info" onclick="SpreedlyExpress.openView();">`
   ```
   should be changed to type `button`, using `submit` input type will submit the form instead of catching the form submission and delegating to express [see stackoverflow](http://stackoverflow.com/questions/932653/how-to-prevent-buttons-from-submitting-forms)
   ```
   <input type="button" value="Enter Payment Info" onclick="SpreedlyExpress.openView();">
   ```

1. [Transactions - List Response body does not match actual Response](https://docs.spreedly.com/reference/api/v1/#list44)
   
   The root element listed in the response body is `transaction`.  We need to indicate that a list of transaction elements are returned under the root element `transactions`.

1. [Express docs should indicate the user should have a hidden form field for the payment method token value](https://docs.spreedly.com/guides/adding-payment-methods/express/#executing-the-transaction)
   
   It would be helpful to provide a sample form that the user can use as a template.

1. [List Supported Receivers root element wrong](https://docs.spreedly.com/reference/api/v1/#list-supported-receivers)
   
   The response body root element is listed as `gateways`, this is incorrect, it should be `receivers`

1. [Missing comma following SpreedlyExpress.setDisplayOptions 'sidebar_bottom_description' property](https://docs.spreedly.com/reference/express/v2/#setdisplayoptions)
   ```
   SpreedlyExpress.setDisplayOptions({
      "amount": "$9.83",
      "company_name": "Acme Widgets",
      "sidebar_top_description": "Providing quality widgets since 2015",
      "sidebar_bottom_description": "Your order total today"
      "first_name": "First Last"
   });
   ```
   Should be:
   ```
    SpreedlyExpress.setDisplayOptions({
      "amount": "$9.83",
      "company_name": "Acme Widgets",
      "sidebar_top_description": "Providing quality widgets since 2015",
      "sidebar_bottom_description": "Your order total today",
      "first_name": "First Last"
    });
   ```

1. [Purchase](https://docs.spreedly.com/reference/api/v1/#purchase)

   POST returns 200 not 201

1. [Deliver](https://docs.spreedly.com/reference/api/v1/#deliver)

    POST returns 200 not 201
