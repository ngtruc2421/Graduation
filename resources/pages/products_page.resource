*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    productdetail_page.resource

*** Variables ***
${ADDCART_BUTTON_ELE}                         css:.btn.btn-primary.ajax-cart-link.px-sm-2.btn-lg.art-btn.col
${HOMEPAGE_ELE}                               css:.canvas-blocker.canvas-slidable
*** Keywords ***
Click on Add Product button from type product page 
    TRY
        Click on Button    ${ADDCART_BUTTON_ELE}
    EXCEPT    message
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on Add Product button from product page 
    END
Get Name product "${NAME}"
    ${LIST}=    Get WebElements    css:.art
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        ${list}=    Get WebElements    css:.art-name
        ${class}=    Get From List    ${list}    ${INDEX}
        ${name_text}=    Get Text    ${class}
        IF    "${name_text}" == "${NAME}"
            RETURN    ${class}
        END
        ${INDEX}=    Evaluate    ${INDEX}+1
    END    
Hover Over The product item "${NAME}"
    TRY
        ${PRODUCT}=    Get Name product "${NAME}"
        Hover Over Elenment    ${PRODUCT}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Hover Over The product item "${NAME}"
    END

Click on the Home page
    TRY
        Click on the web element    ${HOMEPAGE_ELE}    
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the Home page
    END

The type "${NAME}" page should be opened
    TRY
        The page should be opened    ${NAME}    ${PAGE_TITLE_ELE}
    EXCEPT 
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The type "${NAME}" page should be opened  
    END 
    
Click on the product "${NAME}"
     ${PRODUCT}=    Get Name product "${NAME}"
    Click on button    ${PRODUCT}
    The product detail "${NAME}" page should be opened
