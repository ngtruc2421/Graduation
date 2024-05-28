*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/page_objects/shopping_cart_sidebar.resource

Test Setup    Open the Home Page
Test Teardown    Close Browser

*** Test Cases ***
BSG-T37 --- Verify that Users can view the items in their shopping cart at any time by clicking the shopping cart icon
    Click on the "Shopping Basket" button
    Display sizebar tab    ghi