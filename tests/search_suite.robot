*** Settings ***
Resource    ../resources/pages/search_page.resource
Resource    ../resources/page_objects/search_bar.resource
Test Setup    Access to url    ${URL_HOME}
Test Teardown   Close Browser
*** Variables ***
${PRODUCT_KEYWORD}            an
${PRODUCT_NAME}        Dining table
${PRODUCT_DESCRIPTION}        Save with this set 5%!
${FROM_VALUE}    1000
${TO_VALUE}      3000
*** Test Cases ***
BSG-T50 --- Verify that the search bar should be prominently on every page
    [Tags]    High    Smoke
    [Template]    It should display the search bar on the page
    ${URL_PASSWORDRECOVERY}          @{SEARCHBAR}
    ${URL_LOGIN}                     @{SEARCHBAR}
    ${URL_CONTACT}                   @{SEARCHBAR}
    ${URL_BOOKS}                     @{SEARCHBAR}
    ${URL_HOME}                      @{SEARCHBAR}
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
    [Tags]     High    Smoke
    Access to url    ${URL_HOME}
    ${RESULT}    Observe the search bar
    Display the hint text on the search search_bar    ${RESULT} 
BSG-T52 --- Verify that user can search the product when enter data into the search bar
    [Tags]     High    Smoke
    [Template]    Search the product with
    ${PRODUCT_KEYWORD}
    ${PRODUCT_NAME}
    ${PRODUCT_DESCRIPTION}
BSG-T53 --- Verify that the search function will support auto-suggestions when users enter data for the search bar
    [Tags]    High    Smoke
    [Template]    The suggestions list will display with 
    ${PRODUCT_KEYWORD}
    ${PRODUCT_NAME}
    ${PRODUCT_DESCRIPTION}
BSG-T54 --- Verify that the suggestion list should include the produce image, name, and description
    [Tags]    High    Smoke
    Search product on the search bar    ${PRODUCT_KEYWORD}    ${SEARCH_BTN_ELE}
    Display the suggestion list
BSG-T56 --- Verify that results should be sortable by the selected option
    [Tags]    High    Smoke
    [Template]    Users should view the search results after seleted the view options
    Name: A to Z
    Name: Z to A
    Price: Low to High
    Price: High to Low
    Newest Arrivals
BSG-T57 --- Verify that the search result will update to show only products within the selected category when user selects the categories from the category filter
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
    Select the checkbox                         ${CATEGORY_CHECKBOX_ELE}
    Display the result after select checkbox    ${CATEGORY_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T58 --- Verify that the search result will update to show only products within the selected a price range when user selects the price range from the price range filter
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
    Select the checkbox                         ${PRICE_RADIO_ELE}
    Display the result after select checkbox    ${PRICE_SELECTED_ELE}    ${SELECTEDITEM_ELE}
BSG-T59 --- Verify that user can enter a custom price range in the " From - to " field
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}    
    Enter a value for the From field            ${FROM_VALUE}
    Enter a value for the To field              ${TO_VALUE}
    The entered values still are have           ${FROM_VALUE}    ${TO_VALUE}
BSG-T60 --- Verify that the search result will update to show only products within the selected a rating range when user selects the rating range from the rating range filter
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
    Select the checkbox                         ${RATING_RADIO_ELE}
    Display the result after select checkbox    ${RATING_SELECTED_ELE}    ${SELECTEDITEM_ELE}

BSG-T62 --- Verify that the search results should be paginated
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
    The system performed paginated
BSG-T61 --- Verify that the search result will update to show only products when user selects the delivery time range from the delivery time range filter
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
BSG-T63 --- Verify that users should have the option to view a specific number of results per page
    [Tags]    High    Smoke
    Search product on the search bar            ${PRODUCT_KEYWORD}
    The system displays the option to view the results per page
BSG-T64 --- Verify that users should receive clear error messages if no results are found
    [Tags]    High    Smoke
    [Template]    It should display messages when the product are found
    t            The minimum length for the search term is 2 characters.
    !!#@         Your search did not match any products.
    house        Your search did not match any products.