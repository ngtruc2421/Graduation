*** Settings ***
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/shippingOptions_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/productdetail_page.resource
Test Teardown    Close the web page
*** Variables ***
*** Test Cases ***
BSG-T136 --- Verify that the system display available shipping methods with costs and estimated delivery times
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    It should display available options for shipping
BSG-T137 --- Verify that the system allow selection of a shipping method and update the order total accordingly
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    The system should allow select the shipping option
    The system should be update the order total accordingly after user select the shipping option
BSG-T139 --- Verify that the system show a "Back" button to return to the Address Entry page
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    The Shipping page should be Open
    The system should show a "Back" button to return to the Address Entry page
