*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    productdetail_page.resource

*** Variables ***
${ADDCART_BUTTON_ELE}                         css:.btn.btn-primary.ajax-cart-link.px-sm-2.btn-lg.art-btn.col
${HOMEPAGE_ELE}                               css:.canvas-blocker.canvas-slidable
${PRODUCTLIST_ELE}                                css:.art
${PRODUCTNAME_ELE}                            css:.art-name
*** Keywords ***
Click on Add Product button from type product page 
    TRY
        Click on Button    ${ADDCART_BUTTON_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on Add Product button from product page 
    END
Get Name product "${NAME}"
    ${LIST}=    Get WebElements    ${PRODUCTLIST_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        ${list}=    Get WebElements    ${PRODUCTNAME_ELE}  
        ${class}=    Get From List    ${list}    ${INDEX}
        ${name_text}=    Get Text    ${class}
        IF    "${name_text}" == "${NAME}"
            RETURN    ${class}
        END
        ${INDEX}=    Evaluate    ${INDEX}+1
    END    
Hover Over The product item "${NAME}"
    # Sleep    2s
    TRY
        # Wait Until Element Is Visible    css:.search-page
        ${PRODUCT}=    Get Name product "${NAME}"
        Wait Until Element Is Visible    ${PRODUCT}
        Hover Over Elenment    ${PRODUCT}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Hover Over The product item "${NAME}"
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
     ${PRODUCT}=    Get Name product "${NAME}"
    Click on button    ${PRODUCT}
    The product detail "${NAME}" page should be opened

Get availability status of the product ${NAME}
    ${LIST}=    Get WebElements    ${PRODUCTLIST_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        ${list}=    Get WebElements    ${PRODUCTNAME_ELE}  
        ${class}=    Get From List    ${list}    ${INDEX}
        ${name_text}=    Get Text    ${class}
        IF    "${name_text}" == "${NAME}"
            ${LISTSTATUS}=    Get WebElements    css:.delivery-time>span[dir="auto"]
            ${CLASS}=    Get From List    ${LISTSTATUS}    ${INDEX}
            ${STATUS}=    Get Text    ${CLASS}
            RETURN    ${STATUS}
        END
        ${INDEX}=    Evaluate    ${INDEX}+1
    END 