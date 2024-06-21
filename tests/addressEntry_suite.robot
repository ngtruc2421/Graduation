*** Settings ***
Resource    ../resources/pages/addressEntry_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/productdetail_page.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/searchBar.resource
Resource    ../resources/page_objects/header.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup for address entry suite
Test Setup          Test case Setup address entry suite
Test Teardown       Test case Teardown address entry suite
Documentation   This suite cover all test cases related to the user story [BSG-36] - Address Entry Page
 ...           - As a customer,
 ...           - I want to enter and confirm my shipping and billing addresses,
 ...           - So that my order can be delivered to the correct location and I can proceed to the payment step.
*** Variables ***
*** Test Cases ***
BSG-T105 --- Verify that the system should provide input fields for shipping and billing address details
    [Tags]    High    Smoke
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar 
    It should provides input fields for billing address details
    Click on the Next button
    It should provides input fields for shipping address details
    
BSG-T106 --- Verify that the system should be Include options to save addresses for future use
    [Tags]    High    Smoke
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar 
    It should provides input fields for billing address details
    Click on the Next button
    Click on the Smartbear brand
    Select the Shopping Basket option on the header
    Click the "Checkout" button in the sidebar 
    It should be include options to save addresses for future use

BSG-T107 --- Verify that the system should allow using the same address for billing and shipping
    [Tags]    High    Smoke
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar 
    It should provides input fields for billing address details
    Click on the Next button
    Click on the Smartbear brand
    Select the Shopping Basket option on the header
    Click the "Checkout" button in the sidebar 
    It should allow using the same address for billing and shipping

BSG-T108 --- Verify that the system should be validate addresses for completeness and accuracy before proceeding
    #F
    [Tags]    High    Smoke
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar 
    Input data for the "Firstname, Lastname, Address 1, Address 2" fields
    Click on the Next button
    It should validate the address

BSG-T135 --- Verify that the system should be include a "Back" button to return to the Cart page
    [Tags]    High    Smoke
    Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    Click the "Checkout" button in the sidebar 
    Click on the Back button on the Billing page
    It should be include Back button for return to the Cart page

*** Keywords ***
Test case Setup address entry suite
    Set test case start time
    Open the Login page

Test case Teardown address entry suite
    Close the web page
    Update test case result to Zephyr Scale

Test Suite Setup for address entry suite
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup