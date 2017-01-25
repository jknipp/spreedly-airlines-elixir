Documentation updates:

https://docs.spreedly.com/guides/adding-payment-methods/express/

1) Add Checkout js doc has comma instead of colon
    "full_name", "First Last"

 should be
    "full_name": "First Last"
 

 2) Transactions - List Response body does not match actual Response
 This needs to indicate that a list of transaction elements are returned under `transactions`

 https://docs.spreedly.com/reference/api/v1/#transactions6

 
 3) Express docs should point out that the user should have a hidden form field for the token value
  - probably a good idea to add an example form 


 4) `<input type="submit" value="Enter Payment Info" onclick="SpreedlyExpress.openView();">`
should be changed to type 'button', using 'submit' type will submit the form instead of catching the form submission and delegating to express
see http://stackoverflow.com/questions/932653/how-to-prevent-buttons-from-submitting-forms

`<input type="button" value="Enter Payment Info" onclick="SpreedlyExpress.openView();">`

5) https://docs.spreedly.com/reference/express/v2/#setdisplayoptions
Missing comma following SpreedlyExpress.setDisplayOptions 'sidebar_bottom_description' property

```
SpreedlyExpress.setDisplayOptions({
  "amount": "$9.83",
  "company_name": "Acme Widgets",
  "sidebar_top_description": "Providing quality widgets since 2015",
  "sidebar_bottom_description": "Your order total today"
  "first_name": "First Last"
});
```
should be

```
SpreedlyExpress.setDisplayOptions({
  "amount": "$9.83",
  "company_name": "Acme Widgets",
  "sidebar_top_description": "Providing quality widgets since 2015",
  "sidebar_bottom_description": "Your order total today",
  "first_name": "First Last"
});
```

6) https://docs.spreedly.com/reference/api/v1/#purchase returns 200 not 201