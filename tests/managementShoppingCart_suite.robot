*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/shoppingcart_page.resource
Test Setup    There is 2 product in shopping cart
Test Teardown    Close Browser
*** Test Cases ***
BSG-T111 --- Verify that Display a list of all items in the cart, each with: A thumbnail image
    [Tags]    High
    The image "The Prisoner of Heaven: A Novel" should be displayed in the shopping cart page

BSG-T112 --- Verify that Display a list of all items in the cart, each with: Product name
    [Tags]    High
    The name "The Prisoner of Heaven: A Novel" should be displayed in shopping cart page

BSG-T113 --- Verify that Display a list of all items in the cart, each with: Arrival date
    [Tags]    High
    The arrival date of product "The Prisoner of Heaven: A Novel" should be display in shopping cart page

BSG-T114 --- Verify that Display a list of all items in the cart, each with: Price per item
    [Tags]    High
    The Price per item of product "The Prisoner of Heaven: A Novel" should be display in shopping cart page

BSG-T115 --- Verify that Display a list of all items in the cart, each with: Quantity
    [Tags]    High
    The quantity of product "The Prisoner of Heaven: A Novel" should be display in shopping cart page
BSG-T116 --- Verify that Display a list of all items in the cart, each with: Total price for the item
    [Tags]    High
    The Total price for the item of product "The Prisoner of Heaven: A Novel" should be display in shopping cart page