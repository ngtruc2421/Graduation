*** Settings ***
Resource    ../resources/pages/paymentInformation_page.resource
Resource    ../resources/pages/shippingOptions_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/productdetail_page.resource

*** Variables ***
*** Test Cases ***
#BSG-T140 --- Verify that the Payment page will provide secure input fields for credit card details
#BSG-T141 --- Verify that the Payment Page will allow the use of saved payment methods if available
#BSG-T142 --- Verify that the Payment page will be validate payment information before proceeding
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
    