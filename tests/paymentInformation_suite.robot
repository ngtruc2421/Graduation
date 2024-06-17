*** Settings ***
Resource    ../resources/pages/paymentInformation_page.resource
Resource    ../resources/pages/shippingOptions_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/productdetail_page.resource
Test Teardown    Close the web page
*** Variables ***
*** Test Cases ***
BSG-T140 --- Verify that the Payment page will provide secure input fields for credit card details
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigative to the Payement page
    Select the Credit card option on the Payment page
    It should displays the Credit card form and the input fields for Credit card option

#BSG-T141 --- Verify that the Payment Page will allow the use of saved payment methods if available

BSG-T142 --- Verify that the Payment page will be validate payment information before proceeding
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigative to the Payement page
    Select the Credit card option on the Payment page
    Select the "Master Card" on the "Select your credit card" dropdown field
    Enters the "User normal" on the "Cardholder name" field
    Enters the "9100123322000" on the "Card number" field
    Select the "05" on the "Valid until" month dropdown field
    Select the "2030" on the "Valid until" year dropdown field
    Enters the "123" on the "Card code" field
    Click on the Next button on the Payement page
    It should validate payment information before proceeding
BSG-T143 --- Verify that the Payment page will be include a "Back" button to return to the Shipping Options page
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigative to the Payement page
    The Payement page should be have the Back button for return to the Shipping page
#BSG-T144 --- Verify that the "Select your credit card" field can select
#     [Tags]    Medium
#BSG-T145 --- Verify that the "Cardholder name" field can enters data
#     [Tags]    Medium
#BSG-T146 --- Verify that the "Card number" field can enters data
#     [Tags]    Medium
#BSG-T147 --- Verify that the "Valid until" field can select the month
#     [Tags]    Medium
#BSG-T148 --- Verify that the "Valid until" field can select the year
#     [Tags]    Medium
#BSG-T149 --- Verify that the "Card code" field can enters data
#     [Tags]    Medium
