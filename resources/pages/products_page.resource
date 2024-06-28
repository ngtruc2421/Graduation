*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    productdetail_page.resource

*** Variables ***
${ADDCART_BUTTON_ELE}                         css:.fa-cart-arrow-down
${HOMEPAGE_ELE}                               css:.canvas-blocker.canvas-slidable
${PRODUCTLIST_ELE}                            css:.product-list-container .art
${PRODUCTNAME_ELE}                            css:.art-name
*** Keywords ***
Click on Add Product button of product "${name}" from type product page
    [Documentation]       This keyword is used to Click on Add Product button of product from type product page from provided product name
    TRY
        ${list_product}=    Get list WebElements   ${PRODUCTLIST_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_product}
            ${list_name}=    Get list WebElements    ${PRODUCTNAME_ELE}
            ${name_product}=    Get From List    ${list_name}    ${index}
            ${name_text}=    Get Text    ${name_product}
            IF    "${name_text}" == "${name}"
                ${list_icons}=    Get WebElements    ${ADDCART_BUTTON_ELE}
                Wait Until Element Is Visible    ${list_icons}[${index}]   
                Click on Button    ${list_icons}[${index}]  
                RETURN
            END
            ${index}=    Evaluate    ${index}+1
        END  
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on Add Product button from product page 
    END
Get Name product "${name}" in product page
    [Documentation]       This keyword is used to Get Name product name in product page from provided product name
    TRY
            ${list}=    Get list WebElements   ${PRODUCTLIST_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list}
            ${list2}=    Get list WebElements   ${PRODUCTNAME_ELE}  
            ${class}=    Get From List    ${list2}    ${index}
            ${name_text}=    Get Text    ${class}
            IF    "${name_text}" == "${name}"
                RETURN    ${class}
            END
            ${index}=    Evaluate    ${index}+1
        END 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify  Name product "${NAME}" in product page
    END
   
Hover Over The product item "${name}" in product page 
    [Documentation]       This keyword is used to Hover Over The product item in product page  from provided item name
    TRY
        ${product}=    Get Name product "${name}" in product page
        Wait Until Element Is Visible    ${product}
        Hover Over Elenment    ${product}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Hover Over The product item "${name}" in product page 
    END

Click on the Home page
    [Documentation]       This keyword is used to Click on the Home page
    TRY
        Wait Until Element Is Visible    ${HOMEPAGE_ELE}  
        Click on the web element    ${HOMEPAGE_ELE}    
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the Home page
    END

The type "${name}" page should be opened
    [Documentation]       This keyword is used to verify The type page should be opened from provided page name
    TRY
        The page should be opened    ${name}    ${PAGE_TITLE_ELE}
    EXCEPT 
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The type "${name}" page should be opened  
    END 
    
Click on the product "${name}"
    [Documentation]       This keyword is used to Click on the product from provided product name
    TRY
        ${product}=    Get Name product "${name}" in product page
        Click on button    ${product}
        The product detail "${name}" page should be opened
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the product "${name}"
    END


Get availability status of the product ${name}
    [Documentation]       This keyword is used to Get availability status of the product name from provided product name
    TRY
        ${list}=    Get list WebElements   ${PRODUCTLIST_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list}
            ${list2}=    Get list WebElements   ${PRODUCTNAME_ELE}  
            ${class}=    Get From List    ${list2}    ${index}
            ${name_text}=    Get Text    ${class}
            IF    "${name_text}" == "${name}"
                ${liststatus}=    Get list WebElements   css:.delivery-time>span[dir="auto"]
                ${class2}=    Get From List    ${liststatus}    ${index}
                ${status}=    Get Text    ${class2}
                RETURN    ${status}
            END
            ${index}=    Evaluate    ${index}+1
        END 
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get availability status of the product ${name}
    END
