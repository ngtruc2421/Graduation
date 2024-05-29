*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/sidebar.resource

Test Setup    There is at least 1 product in shopping cart
Test Teardown    Close Browser
*** Variables ***
${string}    Your string here
${string1}    $1234

*** Test Cases ***
BSG-T37 --- Verify that Users can view the items in their shopping cart at any time by clicking the shopping cart icon
    Click on the "Shopping Basket" button
    Display sizebar "Shopping Cart" tab

BSG-38 --- Verify that The shopping cart view should display a list of items with product images, names, quantities, and prices.
    # Display image of product "Überman: The novel"
    # Display quantity of product "Trainer Ball"
    Display price of product "Überman: The novel"


