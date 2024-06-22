*** Settings ***
Resource    ../resources/pages/searchResult_page.resource
Resource    ../resources/page_objects/searchBar.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup for search suite
Test Setup          Test case Setup for search suite
Test Teardown       Test case Teardown for search suite
# Suite Teardown      Test Suite Teardown for search suite

Documentation   This suite cover all test cases related to the user story [BSG-14] - Enhanced Product Search Functionality
 ...           - As a Regular online shopper
 ...           - I want to Efficiently search for products on an e-commerce website
 ...           - So that I can Quickly find and purchase the items I need
*** Test Cases ***
BSG-T50 --- Verify that the search bar should be prominently on every page
    [Tags]    High    Smoke
    [Template]    It should display the search bar on the page
    https://bearstore-testsite.smartbear.com/customer/passwordrecovery          
    https://bearstore-testsite.smartbear.com/login                     
    https://bearstore-testsite.smartbear.com/contactus                   
    https://bearstore-testsite.smartbear.com/books                     
    https://bearstore-testsite.smartbear.com/furniture                 
    https://bearstore-testsite.smartbear.com/sports                    
    https://bearstore-testsite.smartbear.com/gaming                    
    https://bearstore-testsite.smartbear.com/watches                   
    https://bearstore-testsite.smartbear.com/compareproducts          
    https://bearstore-testsite.smartbear.com/shippinginfo              
BSG-T51 --- Verify that the search bar should be clearly labeled / hint-text
    [Tags]     High
    It should display the hint text on the search_bar 
BSG-T52 --- Verify that user can search the product when enter data into the search bar
    [Tags]     High    Smoke
    [Template]    It should display the search results page
    an
    Dining table
    Save with this set 5%!
BSG-T53 --- Verify that the search function will support auto-suggestions when users enter data for the search bar
    [Tags]    High    Smoke
    [Template]    The suggestions list should display with 
    an
    Dining table
    Save with this set 5%!
BSG-T54 --- Verify that the suggestion list should include the produce image, name, and description
    [Tags]    High    Smoke
    Enters the text on the search bar    an
    It should display the image, description, and title on suggestion list
BSG-T55 --- Verify that each search result display enough information
    [Tags]    High    Smoke
    Search product on the search bar    an
    The search result should be display enough information with image, name, rating, and price
BSG-T56 --- Verify that results should be sortable by the selected option
    [Tags]    High    Smoke
    [Template]    Users should view the search results after selected the view options
    Name: A to Z
    Name: Z to A
    Price: Low to High
    Price: High to Low
    Newest Arrivals
BSG-T57 --- Verify that the search result will update to show only products within the selected category when user selects the categories from the category filter
    [Tags]    High    Smoke
    Search product on the search bar            an
    Select the Category checkbox
    It should be display the result after select checkbox    ${CATEGORY_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T58 --- Verify that the search result will update to show only products within the selected a price range when user selects the price range from the price range filter
    [Tags]    High
    Search product on the search bar            an
    Select the Price radio button
    It should be display the result after select checkbox    ${PRICE_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T59 --- Verify that user can enter a custom price range in the " From - to " field
    [Tags]    High
    Search product on the search bar            an    
    Enter a value for the From field            1000
    Enter a value for the To field              3000
    The entered values still are have           1000    3000
BSG-T60 --- Verify that the search result will update to show only products within the selected a rating range when user selects the rating range from the rating range filter
    [Tags]    High    Smoke
    Search product on the search bar            an
    Select the Rating radio button
    It should be display the result after select checkbox    ${RATING_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T61 --- Verify that the search result will update to show only products when user selects the delivery time range from the delivery time range filter
    [Tags]    High    Smoke
    Search product on the search bar            an 
    Click delivery dropdown                     ${DELIVERY_DROPDOWN_ELE}
    Select the Delivery checkbox
    The search results page should be display the result of the filtered option    ${DELIVERY_SELECTED_ELE}    ${DELIVERY_OPTIONS_ELE}    ${OPTION_NAME}

BSG-T62 --- Verify that the search results should be paginated
    [Tags]    High
    Search product on the search bar            an
    The system should be performed paginated
BSG-T63 --- Verify that users should have the option to view a specific number of results per page
    [Tags]    High
    Search product on the search bar            an
    The system should be displays the option to view the results per page

BSG-T64 --- Verify that users should receive clear error messages if no results are found
    [Tags]    High    Smoke
    [Template]    It should display messages when the product are found
    t             The minimum length for the search term is 2 characters.
    !!#@          Your search did not match any products.
    house         Your search did not match any products.

BSG-T65 --- Verify that users should receive clear error messages if no filter results are found
    [Tags]    Medium    Smoke
    Search product on the search bar       an
    Enter a value for the To field         1
    Click the Custom Range button
    It should display the error message    Your search did not match any products.

*** Keywords ***
Test case Setup for search suite
    Set test case start time
    Open the Home Page
Test case Teardown for search suite
    Update test case result to Zephyr Scale
    Clear cookies
    Close the web page
Test Suite Setup for search suite
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup
Test Suite Teardown for search suite
    Close All Browsers