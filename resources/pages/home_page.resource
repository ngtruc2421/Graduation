*** Settings ***
Resource    ../keywords/common_keywords.resource
*** Variables ***
${SHOPPING_BASKET_BTN_ELE}                        css:.shopbar-button[data-summary-href="/shoppingcart/cartsummary?cart=True"]
${HOMEPAGE_TITLE_ELE}                            css:.block-title
*** Keywords ***
Open the Home Page
    TRY
        Access to url    ${URL_HOME}
        The Home page should be open
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process open the Home page
    END

The Home page should be open
    TRY
        Wait Until Page Contains Element           ${HOMEPAGE_TITLE_ELE}  
        ${CURRENT_PAGE_TITLE}=    Get Text    ${HOMEPAGE_TITLE_ELE}   
        Should Contain    ${CURRENT_PAGE_TITLE}    Welcome to our store.
    EXCEPT    
        Run Keyword And Continue On Failure    FAIL   The page open failure 
    END

Click on the "Shopping Basket" button
    TRY
        Wait Until Element Is Visible    ${SHOPPING_BASKET_BTN_ELE}
        Click on button    ${SHOPPING_BASKET_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "Shopping Basket" button
    END
    