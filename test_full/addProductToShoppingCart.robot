*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/top_menu.resource
Resource    ../resources/pages/products_page.resource
Resource    ../resources/page_objects/sidebar.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup    Test Suite Setup of addProduct
Test Setup    Test case Setup of addProduct
Test Teardown    Test case Teardown of addProduct
Documentation    This suite cover all test cases related to the user story [BSG-16] - Efficiently Add Products to the Shopping Cart from the Detail Page
          ...    As a user, 
          ...    I want to add a product to my shopping cart directly from the product listing page 
          ...    so that I can quickly select items without navigating to individual product pages.
                    
*** Test Cases ***
BSG-T69 --- Verify that the "Add to Cart" button should be visible
    [Tags]    High
    Open the Home Page
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair" in product page
    Click on the product "Club Lounge Chair"
    The product detail "Club Lounge Chair" page should be opened
    The "Add to Cart" button should be Visible

BSG-T70 --- Verify that The "Add to Cart" button accessible on each product card in the details page
    [Tags]    High    Smoke
    Open the Home Page
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair" in product page
    Click on Add Product button of product "Club Lounge Chair" from type product page 
    The product detail "Club Lounge Chair" page should be opened
BSG-T71 --- Verify that when the "Add to Cart" button is clicked, the product should show on the Shopping Cart
    [Tags]    High
    Open the Home Page
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair" in product page
    Click on the product "Club Lounge Chair"
    The product detail "Club Lounge Chair" page should be opened
    Click on Add Product button from product detail page
    Display sidebar "Shopping Cart" tab
    The "Club Lounge Chair" should show on shopping cart tab

BSG-T72 --- Verify that user can increase product quantity by clicking on the Add button then the total quantity is increase
    [Tags]    High
    Open the Home Page
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair" in product page
    Click on the product "Club Lounge Chair"
    The product detail "Club Lounge Chair" page should be opened
    Click on Increase quantity button of product "Club Lounge Chair" in product detail page
    The quantity of product "Club Lounge Chair" in the product detail page should be increase when user click on icrease button

BSG-T73 --- Verify that Verify that Adjust product quantity by clicking on the +/- then the price should be calculated by Block Pricing
    [Tags]    High
    [Setup]    User is the Product Detail Page 
    [Template]    The price of product "Club Lounge Chair" should be price when user select quantity
    1                 $2,299.90 excl tax
    2                 $1,709.05 excl tax
    3                 $1,709.05 excl tax
    4                 $1,664.08 excl tax
    5                 $1,664.08 excl tax
    6                 $1,619.10 excl tax
    8                 $1,619.10 excl tax

BSG-T104 --- Verify that user can reduce product quantity by clicking on the reduce button then the total quantity is reduce
    [Tags]    High
    Open the Home Page
    Click Menu Item "Furniture"
    Hover Over The product item "Club Lounge Chair" in product page
    Click on the product "Club Lounge Chair"
    The product detail "Club Lounge Chair" page should be opened
    Click on Increase quantity button of product "Club Lounge Chair" in product detail page
    The quantity of product "Club Lounge Chair" in the product detail page should be increase when user click on icrease button
    Click on Reduce quantity button of produce "Club Lounge Chair" in product detail page
    The quantity of product "Club Lounge Chair" in the product detail page should be reduce when user click on reduce button
*** Keywords ***
Test Suite Setup of addProduct
    Create test cycle at folder    Smoke Testing
    Create test cycle at folder     Regression Testing
    Log    This is suite setup
Test case Setup of addProduct
    Set test case start time
Test case Teardown of addProduct
    Close Browser
    Update test case result to Zephyr Scale