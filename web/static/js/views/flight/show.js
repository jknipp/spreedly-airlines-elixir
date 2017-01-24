SpreedlyExpress.init("Ll6fAtoVSTyVMlJEmtpoJV8S", {
    "amount": "$9.83",
    "company_name": "Acme Widgets",
    "sidebar_top_description": "Providing quality widgets since 2015",
    "sidebar_bottom_description": "Your order total today",
    "full_name": "First Last"
    }, {
    "email": "customer@gmail.com"
});

SpreedlyExpress.onPaymentMethod(function(token, paymentMethod) {
    // Send requisite payment method info to backend
    var tokenField = document.getElementById("payment_method_token");

    tokenField.setAttribute("value", token);

    var masterForm = document.getElementById('flight_form');
    masterForm.submit();
});