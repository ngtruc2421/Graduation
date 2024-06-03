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
${REDUCEQUANTITY_BUTTON_ELE}                  css:.fa.fa-minus
${REMOVE_BUTTON_ELE}                          css:.btn.remove.ajax-cart-link
${CHECKOUTSIDEBAR_BUTTON_ELE}                 css:.btn.btn-clear.btn-action
${CHECKOUTCRTPAGE_BUTTON_ELE}                 id:checkout
${URL_LOGIN_CHECKOUT}                         ${URL_HOME}/login?checkoutAsGuest=True&returnUrl=%2Fcart
${SUBTORAL_PRICE_ELE}                             css:.sub-total.price
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

Dislay "${NAME}" in shopping cart tab 
    Wait Until Element Is Visible    css:.offcanvas-cart-items a[title="${NAME}"]
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]
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
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]
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

Click on ${BUTTON} button of product "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                @{LIST_BUTTON}=    Get WebElements    ${BUTTON}             
                ${BUTTON_ELE}=    Get From List    ${LIST_BUTTON}    ${INDEX}
                Hover Over Elenment    ${BUTTON_ELE}
                Click on button    ${BUTTON_ELE}
                Exit For Loop
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on add quantity button of product ${NAME}
    END

Click the Add quantity button of product "${NAME}"
    Click on ${ADDQUANTITY_BUTTON_ELE} button of product "${NAME}"

Click the Reduce quantity button of product "${NAME}"
    Click on ${REDUCEQUANTITY_BUTTON_ELE} button of product "${NAME}"

Click the Remove product button of product "${NAME}"
    Click on ${REMOVE_BUTTON_ELE} button of product "${NAME}"

The product ${NAME} should not be display
    Wait Until Element Is Not Visible    css:.offcanvas-cart-items a[title="${NAME}"]
    Page Should Not Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]

Click the "Checkout" button in the sidebar 
    Click on button    ${CHECKOUTSIDEBAR_BUTTON_ELE}

The Shopping cart page should be opened
    ${Login}=    Set Variable    Login
    ${is_login}=    Run Keyword And Return Status    Page Should Contain Element    css:a.menubar-link>span[title="${Login}"]
    IF    (${is_login}==True)
        Access to url    ${URL_LOGIN_CHECKOUT}
        Input username    0306211267@caothang.edu.vn 
        Input pass    Ttkn1234@
        Click the Login button
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE}
    ELSE
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE}
    END
Click the "Checkout" button in the Shopping cart page 
    Click on button    ${CHECKOUTCRTPAGE_BUTTON_ELE}

The Billing address page should be opened 
    The page should be opened    Billing address    ${PAGE_TITLE_ELE}

Get Subtotal shopping cart 
    ${SUBTOTAL}=    Get Text    ${SUBTORAL_PRICE_ELE}
    ${SUBTOTAL}=    Split String    ${SUBTOTAL}    ${SPACE}
    ${SUBTOTAL}=    Get From List    ${SUBTOTAL}    0
    ${SUBTOTAL}=    Get Substring    ${SUBTOTAL}    1
    RETURN    ${SUBTOTAL}

Calculate Total price of product 
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        ${Total}=    Set Variable    0    
        FOR    ${element}    IN    @{LIST}
            ${class}=    Get Element Attribute    ${element}    class
            ${LIST_TITLE}=    Get WebElements    css:.name.font-weight-medium
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${TITLE_ELE}    
            ${price}=    Get product price "${TITLE}"
            ${quantity}=    Get product quantity "${TITLE}"
            ${Total}=    Evaluate    ${Total} + ${price} * ${quantity}
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Total price of product 
    END