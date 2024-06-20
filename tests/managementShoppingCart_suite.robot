*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/shoppingcart_page.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup    Test Suite Setup of management shopping cart in page
Test Setup    Test case Setup of management shopping cart in page
Test Teardown    Test case Teardown of management shopping cart in page
Documentation    This suite cover all test cases related to the user story [BSG-34] - View and manage the items in my shopping cart
          ...    As a Customer, 
          ...    I want to easily view and manage the items in my shopping cart 
          ...    so that I can efficiently proceed with my purchase.
*** Test Cases ***
BSG-T111 --- Verify that Display a list of all items in the cart, each with: A thumbnail image
    [Tags]    High    Smoke
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
    [Tags]    High     Smoke
    Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
    The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page
    The total of product "The Prisoner of Heaven: A Novel" should be equal quantity * price

BSG-T119 --- Verify that the system automatically updates the cart subtotal of the item in real time when the quantity changes
    [Tags]    High    
    The Subtotal of all items shopping cart page should be equal total price of product 

BSG-T120 --- Verify that the system Provide an "X" button for each item to remove it from the cart
    [Tags]    High     Smoke
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
    [Setup]    User logged in yet and There is 2 product in shopping cart of management shopping cart in page
    Click on the "Checkout" button in the shopping cart page
    The Billing address page should be opened

BSG-T128 --- Verify that the system Add fields for entering discount codes 
    [Tags]    High 
    Click on the "I have a discount code" option
    The field for entering discount codes should be display

BSG-T130 --- Verify that the system Provide a link or button for estimating shipping costs
    [Tags]    High
    Click on the "Estimate shipping" option
    The "Estimate shipping" should be visible 
BSG-T131 --- Verify that the system Allow users to enter location details to calculate shipping costs
    [Tags]    High 
    Click on the "Estimate shipping" option
    The Country field should be visible
    The Provide field should be visible
    The Postal code field should be visible
BSG-T32 --- Verify that the system have a "Continue Shopping" button that redirects users back to the product listing page
    [Tags]    High 
    Click on the "Continue shopping" button in the shopping cart page
    The Home page should be open
BSG-T133 --- Verify that Retain items in the cart between sessions, users can to return and see previously added items
    [Tags]    High 
    Go to the Home Page
    Go the Shopping cart page
    The name "The Prisoner of Heaven: A Novel" should be displayed in shopping cart page
    The name "Best Grilling Recipes" should be displayed in shopping cart page
BSG-T134 --- Verify that the system Allow users to enter location details to display shipping costs
    Click on the "Estimate shipping" option
    The Country field should be visible
    The Provide field should be visible
    The Postal code field should be visible
BSG-T150 --- Verify that users to reduce the quantity of each item using a dropdown or stepper
    [Tags]    High
    Click the Reduce quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
    The quantity of product "The Prisoner of Heaven: A Novel" should be reduce when user click on reduce button in shopping cart page

BSG-T151 --- Verify that the system Add field for entering gift cards
    [Tags]    High 
    Click on the "I have a gift card" option
    The field for entering gift cards should be display
*** Keywords ***
Test Suite Setup of management shopping cart in page
    # Create test cycle at folder    Smoke Testing
    Create test cycle at folder     Regression Testing
    Log    This is suite setup
Test case Setup of management shopping cart in page
    Set test case start time
    There is 2 product in shopping cart and user is on the Shopping cart page
Test case Teardown of management shopping cart in page
    Close Browser
    Update test case result to Zephyr Scale

User logged in yet and There is 2 product in shopping cart of management shopping cart in page
    Set test case start time
    User logged in yet and There is 2 product in shopping cart