*** Settings ***
Resource    ../resources/pages/search_page.resource
Resource    ../resources/page_objects/search_bar.resource
Test Setup    Access to url    ${URL_HOME}
Test Teardown   Close Browser
*** Variables ***
${PRODUCT_KEYWORD}            Sa
${PRODUCT_NAME}        Dining table
${PRODUCT_DESCRIPTION}        Save with this set 5%!

*** Test Cases ***
BSG-T50 --- Verify that the search bar should be prominently on every page
    [Tags]    High    Smoke
    [Template]    Display the search bar on the page
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
    Search product on the search bar    ${PRODUCT_KEYWORD}
    Get suggestion list

