*** Settings ***
Resource    ../keywords/common_keywords.resource
*** Variables ***
${SHOPPING_BASKET_BTN_ELE}                        css:.shopbar-button[data-summary-href="/shoppingcart/cartsummary?cart=True"]
${HOMEPAGE_TITLE_ELE}                            css:.block-title
${PRODUCT_ITEM_ELE}    css:article[data-id="1"]

*** Keywords ***
Open the Home Page
    [Documentation]    This keyword open the Home Page
    TRY
        Access to url    ${URL_HOME}
        The Home page should be open
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process open the Home page
    END
Select a product on the Featured product section
    [Documentation]    This keyword selecting a product on the Featured product section
    TRY
        Hover Over Elenment    ${PRODUCT_ITEM_ELE}    300
        Click on the web element    ${PRODUCT_ITEM_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select a product on the Featured product secsion" keyword 
    END

The Home page should be open
    [Documentation]    This keyword verifies that the Home page should be open
    TRY
        Wait Until Page Contains Element           ${HOMEPAGE_TITLE_ELE}  
        ${current_page_title}=    Get Text    ${HOMEPAGE_TITLE_ELE}   
        Should Contain    ${current_page_title}    Welcome to our store.
    EXCEPT    
        Run Keyword And Continue On Failure    FAIL   The page open failure 
    END

Click on the "Shopping Basket" button
    [Documentation]    This keyword clicking on the "Shopping Basket" button
    TRY
        Wait Until Element Is Visible    ${SHOPPING_BASKET_BTN_ELE}
        Click on button    ${SHOPPING_BASKET_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "Shopping Basket" button
    END
    
Go to the Home Page
    [Documentation]    
    TRY
        Navigate to URL     ${URL_HOME}
        The Home page should be open
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Go to the Home Page
    END
