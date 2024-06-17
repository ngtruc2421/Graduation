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
BSG-T117 --- Verify that users to increase the quantity of each item using a dropdown or stepper
    [Tags]    High 
    Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
    The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page

BSG-T118 --- Verify that the system automatically updates the total price of the item in real time when the quantity changes
    [Tags]    High 
    Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
    The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page
    The total of product "The Prisoner of Heaven: A Novel" should be equal quantity * price

BSG-T119 --- Verify that the system automatically updates the cart subtotal of the item in real time when the quantity changes
    [Tags]    High
    The Subtotal of all items shopping cart page should be equal total price of product 

BSG-T120 --- Verify that the system Provide an "X" button for each item to remove it from the cart
    [Tags]    High 
    Click on the "X" button of product "The Prisoner of Heaven: A Novel" in the shopping cart page 
    The product "The Prisoner of Heaven: A Novel" should be remove it from the cart

BSG-T121 --- Verify that the system automatically update the cart when an item is removed
    [Tags]    High 
    The total of product should be change when an item is removed

BSG-T122 --- Verify that the system automatically recalculate totals when an item is removed
    [Tags]    High 
    The Subtotal of product should be change when an item is removed

BSG-T123 --- Verify that the system Show a summary section with: Subtotal of all items
    [Tags]    High 
    The Subtotal of all items shopping cart page should be equal total price of product 

BSG-T124 --- Verify that the system Show a summary section with: Shipping costs (initially estimated as $0.00 or dynamically updated if available)
    [Tags]    High 
    The shipping costs should be display 

BSG-T125 --- Verify that the system Show a summary section with: Applicable taxes
    [Tags]    High 
    The Applicable taxes should be display 

BSG-T126 --- Verify that the system Show a summary section with: Grand total (sum of subtotal, shipping, and taxes)
    [Tags]    High 
    The Grand total should be display

BSG-T127 --- Verify that Include a "Checkout" button that takes users to the next step in the checkout process
    [Tags]    High 
    [Setup]    User logged in yet and There is 2 product in shopping cart
    Click on the "Checkout" button in the shopping cart page
    The Billing address page should be opened

BSG-T128 --- Verify that the system Add fields for entering discount codes 
    [Tags]    High 
    Click on the "I have a discount code" option
    The field for entering discount codes should be display

# BSG-T129 --- Verify that the system Apply the discount to the order total and update the displayed totals upon entering a valid code
#     [Tags]    High 






BSG-T150 --- Verify that users to reduce the quantity of each item using a dropdown or stepper
    [Tags]    High
    Click the Reduce quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
    The quantity of product "The Prisoner of Heaven: A Novel" should be reduce when user click on reduce button in shopping cart page

BSG-T151 --- Verify that the system Add field for entering gift cards
    [Tags]    High 
    Click on the "I have a gift card" option
    The field for entering gift cards should be display