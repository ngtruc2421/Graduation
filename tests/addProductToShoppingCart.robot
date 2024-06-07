*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/top_menu.resource
Resource    ../resources/pages/products_page.resource
Resource    ../resources/page_objects/sidebar.resource
Test Setup    Open the Home Page
*** Test Cases ***
Verify that user can add product to shopping cart from type product page
    [Tags]    High
    Click Menu Item "Books"
    Hover Over The product item "Motorcycle Adventures: Riding for travel enduros"
    Click on Add Product button from type product page
    The "Motorcycle Adventures: Riding for travel enduros" should show on shopping cart tab

Verify that user can add product to shopping cart from product detail page
    [Tags]    High
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair"
    Click on the product "Club Lounge Chair"
    # Click on Add Product button from product detail page
    # Display sidebar "Shopping Cart" tab
    # The "Club Lounge Chair" should show on shopping cart tab
    Select color "Yellow" of product
