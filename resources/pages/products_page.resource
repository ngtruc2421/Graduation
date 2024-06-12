*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    productdetail_page.resource

*** Variables ***
${ADDCART_BUTTON_ELE}                         css:.fa-cart-arrow-down
${HOMEPAGE_ELE}                               css:.canvas-blocker.canvas-slidable
${PRODUCTLIST_ELE}                            css:.product-list-container .art
${PRODUCTNAME_ELE}                            css:.art-name
*** Keywords ***
Click on Add Product button of product "${NAME}" from type product page
    TRY
        ${LIST_PRODUCT}=    Get list WebElements   ${PRODUCTLIST_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_PRODUCT}
            ${LIST_NAME}=    Get list WebElements    ${PRODUCTNAME_ELE}
            ${NAME_PRODUCT}=    Get From List    ${LIST_NAME}    ${INDEX}
            ${NAME_TEXT}=    Get Text    ${NAME_PRODUCT}
            IF    "${NAME_TEXT}" == "${NAME}"
                ${LIST_ICONS}=    Get WebElements    ${ADDCART_BUTTON_ELE}
                Wait Until Element Is Visible    ${LIST_ICONS}[${INDEX}]   
                Click on Button    ${LIST_iCONS}[${INDEX}]  
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX}+1
        END  
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on Add Product button from product page 
    END
Get Name product "${NAME}" in product page
    ${LIST}=    Get list WebElements   ${PRODUCTLIST_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        ${list}=    Get list WebElements   ${PRODUCTNAME_ELE}  
        ${class}=    Get From List    ${list}    ${INDEX}
        ${name_text}=    Get Text    ${class}
        IF    "${name_text}" == "${NAME}"
            RETURN    ${class}
        END
        ${INDEX}=    Evaluate    ${INDEX}+1
    END    
Hover Over The product item "${NAME}" in product page 
    TRY
        ${PRODUCT}=    Get Name product "${NAME}" in product page
        Wait Until Element Is Visible    ${PRODUCT}
        Hover Over Elenment    ${PRODUCT}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Hover Over The product item "${NAME}" in product page 
    END

Click on the Home page
    TRY
        Wait Until Element Is Visible    ${HOMEPAGE_ELE}  
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
     ${PRODUCT}=    Get Name product "${NAME}" in product page
    Click on button    ${PRODUCT}
    The product detail "${NAME}" page should be opened

Get availability status of the product ${NAME}
    ${LIST}=    Get list WebElements   ${PRODUCTLIST_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        ${list}=    Get list WebElements   ${PRODUCTNAME_ELE}  
        ${class}=    Get From List    ${list}    ${INDEX}
        ${name_text}=    Get Text    ${class}
        IF    "${name_text}" == "${NAME}"
            ${LISTSTATUS}=    Get list WebElements   css:.delivery-time>span[dir="auto"]
            ${CLASS}=    Get From List    ${LISTSTATUS}    ${INDEX}
            ${STATUS}=    Get Text    ${CLASS}
            RETURN    ${STATUS}
        END
        ${INDEX}=    Evaluate    ${INDEX}+1
    END 