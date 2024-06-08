*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/top_menu.resource
Resource    ../resources/pages/products_page.resource
Resource    ../resources/page_objects/sidebar.resource
Test Setup    Open the Home Page
Task Teardown    Close Browser
*** Test Cases ***
Verify that user can add product to shopping cart from type product page
    [Tags]    High
    Click Menu Item "Books"
    Hover Over The product item "Motorcycle Adventures: Riding for travel enduros"
    Click on Add Product button from type product page
    The "Motorcycle Adventures: Riding for travel enduros" should show on shopping cart tab

Verify that user can add product to shopping cart from product detail page
    [Tags]    High
    [Setup]    User is the Home Page and There are 1 product with quantity is 2 in shopping cart
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair"
    Click on the product "Club Lounge Chair"
    Click on Add Product button from product detail page
    Display sidebar "Shopping Cart" tab
    The "Club Lounge Chair" should show on shopping cart tab
    # Select color "Yellow" of product
    # Click on Increase quantity button of product "Club Lounge Chair" in product detail page
    # The quantity of product "Club Lounge Chair" in the product detail page should be increase when user click on icrease button
    # Click on Add Product "Club Lounge Chair" button from product detail page
    # There are product "Club Lounge Chair" quantity added in shopping cart