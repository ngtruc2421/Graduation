
*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/home_page.resource
Resource    top_menu.resource
Resource    search_bar.resource
*** Variables ***
${ADDCART_BUTTON_ELE}                         css:.btn.btn-primary.ajax-cart-link.px-sm-2.btn-lg.art-btn.col
${PRODUCT_ELE}                                css:.offcanvas-cart-item
${PRICE_ELE}                                  css:.price.unit-price
${QUANTITY_ELE}                               css:[name="item.EnteredQuantity"]
${ADDQUANTITY_BUTTON_ELE}                     css:.fa.fa-plus

*** Keywords ***
Display sizebar "${NAME}" tab    
    TRY
        @{LIST}=    Get WebElements    css:.nav-item [role="tab"]

        FOR    ${element}    IN    @{LIST}
            ${class_attribute}=    Get Element Attribute    ${element}    class
            ${is_Active}=    Run Keyword And Return Status    Should Contain    ${class_attribute}    active
            IF    (${is_Active}!= False)
                ${value}=    Get Text    ${element}
                Should Contain    ${value}    ${name}
                RETURN      
            END
        END
        
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Display sizebar ${NAME} tab 
        
    END

Hover Over The product item "${name}"
    Hover Over Elenment    css:[title="${name}"]

Dislay "${name}" in shopping cart tab 
    Wait Until Element Is Visible    css:.offcanvas-cart-items a[title="${name}"]
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${name}"]
Click on Add Product on Cart button 
    Click on Button    ${ADDCART_BUTTON_ELE}
There is at least 1 product in shopping cart
    Open the Home Page
    Search product on the search bar    The Prisoner of Heaven: A Novel
    Hover Over The product item "The Prisoner of Heaven: A Novel"
    Click on Add Product on Cart button 
    Display sizebar "Shopping Cart" tab
    Dislay "The Prisoner of Heaven: A Novel" in shopping cart tab
    Click on the Home page
    Search product on the search bar    Best Grilling Recipes
    Hover Over The product item "Best Grilling Recipes"
    Click on Add Product on Cart button 
    Display sizebar "Shopping Cart" tab
    Dislay "Best Grilling Recipes" in shopping cart tab
    
The image "${NAME}" should be displayed
    Page Should Contain Element    css:.img-center-container[title="Show details for ${NAME}"]

The name "${NAME}" should be displayed
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${name}"]
Display quantity of product "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                @{LIST_quantities}=    Get WebElements    ${QUANTITY_ELE}               
                ${quantity_ele}=    Get From List    ${LIST_quantities}    ${INDEX}
                ${quantity}=    Get Value    ${quantity_ele}
                RETURN    ${quantity}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END

Get product price "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                @{LIST_price}=    Get WebElements    ${PRICE_ELE}               
                ${value}=    Get From List    ${LIST_price}    ${INDEX}
                ${price}=    Get text    ${value}
                ${price}=    Split String    ${price}    ${SPACE}
                ${price}=    Get From List    ${price}    0
                ${price}=    Get Substring    ${price}    1
                RETURN    ${price}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END
Click on the Home page
    Click on the web element    css:.canvas-blocker.canvas-slidable

Trim data
    [Arguments]    ${data}    ${searchString}    
    ${trimmed_string}    Replace String    ${data}    ${searchString}    ${EMPTY}


Get product quantity "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                @{LIST_quantities}=    Get WebElements    ${QUANTITY_ELE}               
                ${quantity_ele}=    Get From List    ${LIST_quantities}    ${INDEX}
                ${quantity}=    Get Value    ${quantity_ele}
                RETURN    ${quantity}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END
The quantities "${NAME}" should be displayed
    Get product quantity "${NAME}"

The price"${NAME}" should be displayed
    Get product price "${NAME}"

Click on add quantity button of product "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                @{LIST_ADDBUTTONQUANTITY}=    Get WebElements    ${ADDCART_BUTTON_ELE}               
                ${ADDBUTTON_ELE}=    Get From List    ${LIST_ADDBUTTONQUANTITY}    ${INDEX}
                Hover Over Elenment    ${ADDBUTTON_ELE}
                Click on button    ${ADDBUTTON_ELE}
                Exit For Loop
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on add quantity button of product ${NAME}
    END

