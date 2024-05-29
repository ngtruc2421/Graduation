*** Settings ***
Resource    ../keywords/common_keywords.resource
*** Variables ***
${SHOPPING_BASKET_BTN_ELE}                        css:.shopbar-button[data-summary-href="/shoppingcart/cartsummary?cart=True"]

*** Keywords ***
Open the Home Page
    Access to url    ${URL_HOME}
    The Home page should be opened
The Home page should be opened
    TRY
        Wait Until Page Contains Element           css:.block-title
        ${CURRENT_PAGE_TITLE}=    Get Text    css:.block-title 
        Should Contain    ${CURRENT_PAGE_TITLE}    Welcome to our store.
    EXCEPT    
        Run Keyword And Continue On Failure    FAIL   The page open failure 
    END

Click on the "Shopping Basket" button
    Click on button    ${SHOPPING_BASKET_BTN_ELE}