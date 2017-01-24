var environment_key = "VoypMN17B1VZQcWsxkoKIW2hvbU";

SpreedlyExpress.init(environment_key, {
    "sidebar_top_description": "Crash free since 2003", 
    "sidebar_bottom_description": "Passenger flight total",
    "submit_label": "Purchase Flight"
    }, {
    "email": null 
});

SpreedlyExpress.onPaymentMethod(function(token, paymentMethod) {
    // Send requisite payment method info to backend
    var tokenField = document.getElementById("flight_form_payment_method_token");

    tokenField.setAttribute("value", token);

    var masterForm = document.getElementById('flight_form');
    masterForm.submit();
});

/* Set Spreedly express options */
function handlePurchase() {
    // TODO pull these from a JSON service, so we can guarantee the values aren't being manipulated
    var airline = document.getElementById("airline").innerHTML;
    var flight_number = document.getElementById("flight_number").innerHTML;
    var flight_info = document.getElementById("flight_info").innerHTML;
    var total = document.getElementById("total").innerHTML;
    var full_name = document.getElementById("flight_form_full_name").value;
    var email = document.getElementById("flight_form_email").value;
    
    SpreedlyExpress.setDisplayOptions({
        "amount": total, 
        "company_name": airline, 
        "sidebar_bottom_description": "Passenger flight total for flight " + flight_number + ", " + flight_info,
        "full_name": full_name 
    });

    SpreedlyExpress.setPaymentMethodParams({
        "email": email
    });

    SpreedlyExpress.openView();
};

