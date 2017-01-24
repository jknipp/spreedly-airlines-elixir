
- Let a user (no need for login functionality, just let anybody do this)
  - Purchase a flight with a test credit card against the Spreedly test gateway (Form)
  - Purchase a flight using PMD that sends the card info to a travel partner like Expedia (using the echo endpoint to mimic an Expedia API call - the request/response format is immaterial).
- If the credit card is expired or invalid in anyway, display an error message back to the user
    - Let the user save their credit card for future payments (checkbox)

2. List all processed transactions
    - Table list of transactions
        - show detail 
        - show transcript?
        