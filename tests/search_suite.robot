*** Settings ***
Resource    ../resources/pages/searchResult_page.resource
Resource    ../resources/page_objects/searchBar.resource
Resource    ../resources/pages/home_page.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup for search suite
Test Setup          Test case Setup for search suite
Test Teardown       Test case Teardown for search suite
Documentation   This suite cover all test cases related to the user story [BSG-14] - Enhanced Product Search Functionality
 ...           - As a Regular online shopper
 ...           - I want to Efficiently search for products on an e-commerce website
 ...           - So that I can Quickly find and purchase the items I need
*** Variables ***
${PRODUCT_KEYWORD}            an
${PRODUCT_NAME}               Dining table
${PRODUCT_DESCRIPTION}        Save with this set 5%!
${FROM_VALUE}                 1000
${TO_VALUE}                   3000
${TO}                         1
${ERRORFILTER_MESS}           Your search did not match any products.
*** Test Cases ***
BSG-T50 --- Verify that the search bar should be prominently on every page
    [Tags]    High    Smoke
    [Template]    It should display the search bar on the page
    ${URL_PASSWORDRECOVERY}          @{SEARCHBAR}
    ${URL_LOGIN}                     @{SEARCHBAR}
    ${URL_CONTACT}                   @{SEARCHBAR}
    ${URL_BOOKS}                     @{SEARCHBAR}
    ${URL_FURNITURE}                 @{SEARCHBAR}
    ${URL_SPORTS}                    @{SEARCHBAR}
    ${URL_GAMING}                    @{SEARCHBAR}
    ${URL_WATCHES}                   @{SEARCHBAR}
    ${URL_GIFTCARDS}                 @{SEARCHBAR}
    ${URL_WHATNEW}                   @{SEARCHBAR}
    ${URL_RECENTLYVIEWEDPRODUCTS}    @{SEARCHBAR}
    ${URL_COMPAREPRODUCTS}           @{SEARCHBAR}
    ${URL_ABOUTUS}                   @{SEARCHBAR}
    ${URL_DISCLAIMER}                @{SEARCHBAR}
    ${URL_SHIPPINGINFO}              @{SEARCHBAR}
    ${URL_CONDITIONSOFUSE}           @{SEARCHBAR}
BSG-T51 --- Verify that the search bar should be clearly labeled / hint-text
    [Tags]     High
    It should display the hint text on the search_bar 
BSG-T52 --- Verify that user can search the product when enter data into the search bar
    [Tags]     High    Smoke
    [Template]    It should display the search results page
    ${PRODUCT_KEYWORD}
    ${PRODUCT_NAME}
    ${PRODUCT_DESCRIPTION}
BSG-T53 --- Verify that the search function will support auto-suggestions when users enter data for the search bar
    [Tags]    High    Smoke
    [Template]    The suggestions list should display with 
    ${PRODUCT_KEYWORD}
    ${PRODUCT_NAME}
    ${PRODUCT_DESCRIPTION}
BSG-T54 --- Verify that the suggestion list should include the produce image, name, and description
    [Tags]    High    Smoke
    Enters the text on the search bar    ${PRODUCT_KEYWORD}
    It should display the image, description, and title on suggestion list
BSG-T55 --- Verify that each search result display enough information
    [Tags]    High    Smoke
    Search product on the search bar    ${PRODUCT_KEYWORD}
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
    Search product on the search bar            ${PRODUCT_KEYWORD}
    Select the Category checkbox
    It should be display the result after select checkbox    ${CATEGORY_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T58 --- Verify that the search result will update to show only products within the selected a price range when user selects the price range from the price range filter
    [Tags]    High
    Search product on the search bar            ${PRODUCT_KEYWORD}
    Select the Price radio button
    It should be display the result after select checkbox    ${PRICE_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T59 --- Verify that user can enter a custom price range in the " From - to " field
    [Tags]    High
    Search product on the search bar            ${PRODUCT_KEYWORD}    
    Enter a value for the From field            ${FROM_VALUE}
    Enter a value for the To field              ${TO_VALUE}
    The entered values still are have           ${FROM_VALUE}    ${TO_VALUE}
BSG-T60 --- Verify that the search result will update to show only products within the selected a rating range when user selects the rating range from the rating range filter
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
    Select the Rating radio button
    It should be display the result after select checkbox    ${RATING_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T61 --- Verify that the search result will update to show only products when user selects the delivery time range from the delivery time range filter
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD} 
    Click delivery dropdown                     ${DELIVERY_DROPDOWN_ELE}
    Select the Delivery checkbox
    The search results page should be display the result of the filtered option    ${DELIVERY_SELECTED_ELE}    ${DELIVERY_OPTIONS_ELE}    ${OPTION_NAME}

BSG-T62 --- Verify that the search results should be paginated
    [Tags]    High
    Search product on the search bar            ${PRODUCT_KEYWORD}
    The system should be performed paginated
BSG-T63 --- Verify that users should have the option to view a specific number of results per page
    [Tags]    High
    Search product on the search bar            ${PRODUCT_KEYWORD}
    The system should be displays the option to view the results per page

BSG-T64 --- Verify that users should receive clear error messages if no results are found
    [Tags]    High    Smoke
    [Template]    It should display messages when the product are found
    t             The minimum length for the search term is 2 characters.
    !!#@          Your search did not match any products.
    house         Your search did not match any products.

BSG-T65 --- Verify that users should receive clear error messages if no filter results are found
    [Tags]    Medium    Smoke
    Search product on the search bar       ${PRODUCT_KEYWORD}
    Enter a value for the To field         ${TO}
    Click the Custom Range button
    It should display the error message    ${ERRORFILTER_MESS}

*** Keywords ***
Test case Setup for search suite
    Set test case start time
    Open the Home Page

Test case Teardown for search suite
    Update test case result to Zephyr Scale
    Close the web page

Test Suite Setup for search suite
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup