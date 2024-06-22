*** Settings ***
Resource    ../resources/pages/paymentInformation_page.resource
Resource    ../resources/pages/shippingOptions_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/productdetail_page.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource

Suite Setup         Test Suite Setup for payment information suite
Test Setup          Test case Setup payment information suite
Test Teardown       Test case Teardown payment information suite
Documentation   This suite cover all test cases related to the user story [BSG-38] - Payment Information Page
 ...           - As a customer,
 ...           - I want to enter my payment information securely,
 ...           - So that I can complete my purchase and be charged correctly.

*** Test Cases ***
BSG-T140 --- Verify that the Payment page will provide secure input fields for credit card details
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    tt1999@gmail.com    12345678
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigate to the Payment page
    Select the Credit card option on the Payment page
    It should displays the Credit card form and the input fields for Credit card option

BSG-T141 --- Verify that the Payment Page will ensure the page is secure by HTTPS compliance
    [Tags]    High
    Open the Login page
    Log in the system    tt1999@gmail.com    12345678
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigate to the Payment page
    The Payment page should be safe
BSG-T142 --- Verify that the Payment page will be validate payment information before proceeding
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    tt1999@gmail.com    12345678
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigate to the Payment page
    Select the Credit card option on the Payment page
    Select the "Master Card" on the "Select your credit card" dropdown field
    Enters the "User normal" on the "Cardholder name" field
    Enters the "9100123322000" on the "Card number" field
    Select the "05" on the "Valid until" month dropdown field
    Select the "2030" on the "Valid until" year dropdown field
    Enters the "123" on the "Card code" field
    Click on the Next button on the Payment page
    It should validate payment information before proceeding
BSG-T143 --- Verify that the Payment page will be include a "Back" button to return to the Shipping Options page
    [Tags]    High
    Open the Login page
    Log in the system    tt1999@gmail.com    12345678
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    Navigate to the Payment page
    The Payement page should be have the Back button for return to the Shipping page

BSG-T144 --- Verify that the system should display the warning message when user inputs incorrect data
    # F
    [Tags]    Medium
    [Template]    It should display the warning message
    ${EMPTY}    4444 5555 5555 5555    1234        'Cardholder name' should not be empty
    //@//@#/    4444 5555 5555 5555    1234        'Cardholder name' should not be special character
    User        4444 5555 5555 555     1234         Wrong card number
    User        4                      1234         Wrong card number
    User        4444 5555 5555 5555    1           'Card code' is not in the correct format
    User        4444 5555 5555 5555    12345       'Card code' is not in the correct format
*** Keywords ***
Test case Setup payment information suite
    Set test case start time

Test case Teardown payment information suite
    Close Browser
    Update test case result to Zephyr Scale

Test Suite Setup for payment information suite
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup