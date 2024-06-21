*** Settings ***
Resource    ../resources/page_objects/currencyDropdown.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/header.resource
Resource    ../resources/pages/productdetail_page.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup for currency suite
Test Setup          Test case Setup for currency suite
Test Teardown       Test case Teardown for currency suite
Documentation   This suite cover all test cases related to the user story [BSG-24] - Management currency type
...            - As a user
...            - I want to select the currency type
...            - So that I can be aware of the product in the selected currency
*** Test Cases ***
BSG-T95 --- Verify that there is a currency dropdown
    [Tags]    High
    Open the Home Page
    It should display the currency dropdown
BSG-T96 --- Verify that the currency dropdown should be display enough data source
    [Tags]    High
    Open the Home Page
    Click on the Currency dropdown
    It should display four optionS including USD, GBP, AUD, CAD
BSG-T97 --- Verify that the currency dropdown should be display the default value
    [Tags]    High
    Open the Home Page
    Click on the Currency dropdown
    It should display default a any currency value
BSG-T98 --- Verify that the selected currency should display on all product prices on the Listing page
    [Tags]    High    Smoke
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select the Watches tab
    All product on Listing page should change currency type
BSG-T99 --- Verify that the selected currency should load on all product price on Detail page
    [Tags]    High    Smoke
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product section
    It should changes the currency on the Detail page

BSG-T100 --- Verify that the selected currency should load on all product price on Shopping cart
    [Tags]    High    Smoke
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product section
    Click on Add Product button from product detail page
    It should changes the currency on the Shopping cart
    
BSG-T101 --- Verify that the selected currency should load on all product price on Wishlist page
    [Tags]    High    Smoke
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product section
    Click on Add to List button from product detail page
    It should changes the currency on the Wishlist tab
BSG-T102 --- Verify that the selected currency should load on all product price on Compare page
    [Tags]    High    Smoke
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product section
    Click on Compare button from product detail page
    It should changes the currency on the Compare tab
BSG-T103 --- Verify that the currency value on the product should change in real time when the user changes the currency type
    [Tags]    High
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    It should change in real time when the user changes the currency type
    
*** Keywords ***
Test case Setup for currency suite
    Set test case start time

Test case Teardown for currency suite
    Close Browser
    Update test case result to Zephyr Scale

Test Suite Setup for currency suite
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup