*** Settings ***
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/shippingOptions_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/productdetail_page.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup
Test Setup          Test case Setup
Test Teardown       Test case Teardown
*** Variables ***
*** Test Cases ***
BSG-T136 --- Verify that the system display available shipping methods with costs and estimated delivery times
    [Tags]    High
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

*** Keywords ***
Test case Setup
    Set test case start time

Test case Teardown
    Update test case result to Zephyr Scale
    Close Browser

Test Suite Setup
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup