*** Settings ***
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/shippingOptions_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/productdetail_page.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup for shipping options
Test Setup          Test case Setup for shipping options
Test Teardown       Test case Teardown for shipping options
Documentation   This suite cover all test cases related to the user story [BSG-37] - Shipping Options Page
 ...           - As a customer,
 ...           - I want to choose my preferred shipping method,
 ...           - So that I can select an option that best fits my needs for cost and delivery time.
*** Variables ***
*** Test Cases ***
BSG-T136 --- Verify that the system display available shipping methods with costs and estimated delivery times
    [Tags]    High
    Open the Login page
    Log in the system    tt1999@gmail.com    12345678
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    It should display available options for shipping
BSG-T137 --- Verify that the system allow selection of a shipping method and update the order total accordingly
    [Tags]    High    Smoke
    Open the Login page
    Log in the system    tt1999@gmail.com    12345678
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
    Log in the system    tt1999@gmail.com    12345678
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
    The Shipping page should be Open
    The system should show a "Back" button to return to the Address Entry page

*** Keywords ***
Test case Setup for shipping options
    Set test case start time
Test case Teardown for shipping options
    Update test case result to Zephyr Scale
    Close the web page

Test Suite Setup for shipping options
    Create test cycle at folder    Automation Test
    Log    This is suite setup