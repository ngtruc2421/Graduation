*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/sidebar.resource
Resource    ../resources/page_objects/header.resource

Test Setup    There is at least 1 product in shopping cart
Test Teardown    Close Browser
*** Variables ***
${USERNAME}=        0306211267@caothang.edu.vn
${PASSWORD}=        Ttkn1234@
*** Test Cases ***
BSG-T37 --- Verify that Users can view the items in their shopping cart at any time by clicking the shopping cart icon
    [Tags]    High    Smoke
    Click on the Home page
    Click on the "Shopping Basket" button
    Display sidebar "Shopping Cart" tab
    The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
    The "Best Grilling Recipes" should show on shopping cart tab
BSG-T38 --- Verify that The shopping cart view should display a list of items with product images, names, quantities, and prices.
    [Tags]    High    Smoke
    The image "Best Grilling Recipes" should be displayed
    The name "Best Grilling Recipes" should be displayed
    The quantities "Best Grilling Recipes" should be displayed
    The price"Best Grilling Recipes" should be displayed

BSG-T39 --- Verify that Users can increase the quantity of each item in their cart directly from the shopping cart view
    [Tags]    High
    Click the Add quantity button of product "Best Grilling Recipes"
    The quantity of product "Best Grilling Recipes" should be increase when user click on add button
    
BSG-T40 --- Verify that Users can reduce the quantity of each item in their cart directly from the shopping cart view
    [Tags]    High
    Click the Reduce quantity button of product "Best Grilling Recipes"
    The quantity of product "Best Grilling Recipes" should be reduce when user click on reduce button

BSG-T41 --- Verify that Users can remove individual items from their shopping cart using a remove (trash can) icon or similar control 
    [Tags]    High
    Click the Remove product button of product "Best Grilling Recipes"
    The product Best Grilling Recipes should not show on shopping cart tab

BSG-T42 --- Verify that Upon removal, the cart should update immediately to reflect the changes
    [Tags]    High
    Click the Remove product button of product "Best Grilling Recipes"
    The product Best Grilling Recipes should not show on shopping cart tab

BSG-T43 --- Verify that Users can proceed to the checkout process from the shopping cart view by clicking the "Checkout" button
    [Tags]    High
    [Setup]    User logged in yet and There is at least 1 product in shopping cart
    Click the "Checkout" button in the sidebar
    The Billing address page should be opened

BSG-T67 --- Verify that when user clicking the "Checkout" button the Sign In page should be open if user not logged in yet
    [Tags]    High
    [Setup]    User not logged in yet and There is at least 1 product in shopping cart
    Click the "Checkout" button in the sidebar 
    The Sign In page should be opened
    Log in the system    ${USERNAME}    ${PASSWORD}
    The Shopping cart page should be opened
BSG-T44 --- Verify that The checkout button should show a summary of the total cost (excluding tax) to provide transparency before finalizing the purchase
    [Tags]    High
    The Subtotal shopping cart should be equal total price of product 

BSG-T45 --- Verify that The cart should display the most current prices and availability status of the items
    [Tags]    High
    The availability status of the product "The Prisoner of Heaven: A Novel" should be display

BSG-T47 --- Verify that Changes in quantity should automatically update the subtotal for that item and the overall cart total
    [Tags]    High
    Click the Reduce quantity button of product "Best Grilling Recipes"
    The quantity of product "Best Grilling Recipes" should be reduce when user click on reduce button
    The total product should be changes after changing the product quantity