*** Settings ***
Resource    ../resources/page_objects/currencyDropdown.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/header.resource
Resource    ../resources/pages/productdetail_page.resource
Test Teardown    Close the web page
*** Variables ***
*** Test Cases ***
BSG-T95 --- Verify that there is a currency dropdown
    Open the Home Page
    It should display the currency dropdown
BSG-T96 --- Verify that the currency dropdown should be display enough data source
    Open the Home Page
    Click on the Currency dropdown
    It should display four optionS including USD, GBP, AUD, CAD
BSG-T97 --- Verify that the currency dropdown should be display the default value
    Open the Home Page
    Click on the Currency dropdown
    It should display default a any currency value
BSG-T98 --- Verify that the selected currency should display on all product prices on the Listing page
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select the Watches tab
    All product on Listing page should change currency type    ${RESULTS_WATCHES_TAB_ELE}
BSG-T99 --- Verify that the selected currency should load on all product price on Detail page
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product secsion
    It should changes the curency on the Detail page

BSG-T100 --- Verify that the selected currency should load on all product price on Shopping cart
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product secsion
    Click on Add Product button from product detail page
    It should changes the currency on the Shopping cart
    
BSG-T101 --- Verify that the selected currency should load on all product price on Wishlist page
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product secsion
    Click on Add to List button from product detail page
    It should changes the currency on the Wishlist tab
BSG-T102 --- Verify that the selected currency should load on all product price on Compare page
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    Select a product on the Featured product secsion
    Click on Compare button from product detail page
    It should changes the currency on the Compare tab
BSG-T103 --- Verify that the currency value on the product should change in real time when the user changes the currency type
    Open the Home Page
    Click on the Currency dropdown
    Select the Pound Sterling option on the Currency dropdown
    It should change in real time when the user changes the currency type
    
