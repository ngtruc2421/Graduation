*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/home_page.resource
Resource    top_menu.resource
Resource    search_bar.resource
Resource    header.resource
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
${SUBTORAL_PRICE_ELE}                         css:.sub-total.price
${TITLE_PRODUCT_ELE}                          css:.name.font-weight-medium
${WISHLIST_TAB_ELE}                           id:wishlist-tab
${LISTTAB_ELE}                                css:.nav-item [role="tab"]
${HOMEPAGE_ELE}                               css:.canvas-blocker.canvas-slidable
${USERNAME}=                                  0306211267@caothang.edu.vn
${PASSWORD}=                                  Ttkn1234@
*** Keywords ***
Display sidebar "${NAME}" tab    
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
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Display sidebar ${NAME} tab 
        
    END

Hover Over The product item "${name}"
    Hover Over Elenment    css:[title="${name}"]

The "${NAME}" should show on shopping cart tab
    Wait Until Element Is Visible    css:.offcanvas-cart-items a[title="${NAME}"]
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]
Click on Add Product on Cart button 
    Click on Button    ${ADDCART_BUTTON_ELE}
Click the Wishlist tab 
    Click on button    ${WISHLIST_TAB_ELE}
There is at least 1 product in shopping cart
    Open the Home Page
    Search product on the search bar    The Prisoner of Heaven: A Novel
    Hover Over The product item "The Prisoner of Heaven: A Novel"
    Click on Add Product on Cart button 
    Display sidebar "Shopping Cart" tab
    The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
    Click on the Home page
    Search product on the search bar    Best Grilling Recipes
    Hover Over The product item "Best Grilling Recipes"
    Click on Add Product on Cart button 
    Display sidebar "Shopping Cart" tab
    The "Best Grilling Recipes" should show on shopping cart tab
    # Click the Wishlist tab
    # Display sidebar "Wishlist" tab
The image "${NAME}" should be displayed
    Page Should Contain Element    css:.img-center-container[title="Show details for ${NAME}"]

The name "${NAME}" should be displayed
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]
Get product price "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                @{LIST_PRICE}=    Get WebElements    ${PRICE_ELE}               
                ${VALUE}=    Get From List    ${LIST_PRICE}    ${INDEX}
                ${PRICE}=    Get text    ${value}
                ${PRICE}=    Split String    ${PRICE}    ${SPACE}
                ${PRICE}=    Get From List    ${PRICE}    0
                ${PRICE}=    Get Substring    ${PRICE}    1
                RETURN    ${price}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END
Click on the Home page
    Click on the web element    ${HOMEPAGE_ELE}    

Trim data
    [Arguments]    ${data}    ${searchString}    
    ${trimmed_string}    Replace String    ${data}    ${searchString}    ${EMPTY}

Get product quantity "${NAME}"
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
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
           ${LIST_TITLE}=    Get WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
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
    ${QUANTITY}=   Get product quantity "${NAME}"
    ${SUBTOTAL}=    Get Subtotal shopping cart
    Set Suite Variable    ${SUBTOTALBEFORE}    ${SUBTOTAL}    
    Set Suite Variable    ${QUANTITYAFTER}    ${QUANTITY}    
    Click on ${ADDQUANTITY_BUTTON_ELE} button of product "${NAME}"

Click the Reduce quantity button of product "${NAME}"
    ${QUANTITY}=   Get product quantity "${NAME}"
    ${SUBTOTAL}=    Get Subtotal shopping cart
    Set Suite Variable    ${SUBTOTALBEFORE}    ${SUBTOTAL}   
    Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY}    
    Click on ${REDUCEQUANTITY_BUTTON_ELE} button of product "${NAME}"

Click the Remove product button of product "${NAME}"
    Click on ${REMOVE_BUTTON_ELE} button of product "${NAME}"

The product ${NAME} should not show on shopping cart tab
    Wait Until Element Is Not Visible    css:.offcanvas-cart-items a[title="${NAME}"]
    Page Should Not Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]

Click the "Checkout" button in the sidebar 
    Click on button    ${CHECKOUTSIDEBAR_BUTTON_ELE}

The Shopping cart page should be opened
    The page should be opened    Shopping cart    ${PAGE_TITLE_ELE}
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
        ${TOTAL}=    Set Variable    0    
        FOR    ${element}    IN    @{LIST}
            ${LIST_TITLE}=    Get WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${TITLE_ELE}    
            ${PRICE}=    Get product price "${TITLE}"
            ${QUANTITY}=    Get product quantity "${TITLE}"
            ${TOTAL}=    Evaluate    ${TOTAL} + ${PRICE} * ${QUANTITY}
            ${TOTAL}=    Evaluate    round(${TOTAL},2)
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
            RETURN    ${TOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Total price of product 
    END

The Subtotal shopping cart should be equal total price of product 
    ${SUBTOTAL}=    Get Subtotal shopping cart
    ${TOTAL}=    Calculate Total price of product
    ${TOTAL}=    Convert To String    ${TOTAL}
    Should Be Equal    ${SUBTOTAL}    ${TOTAL}
Is user not logged in yet 
    ${IS_LOGIN}=    Check user login
    Should Be True    ${IS_LOGIN}

User not logged in yet and There is at least 1 product in shopping cart
    Open the Home Page
    Is user not logged in yet 
    Search product on the search bar    The Prisoner of Heaven: A Novel
    Hover Over The product item "The Prisoner of Heaven: A Novel"
    Click on Add Product on Cart button 
    Display sidebar "Shopping Cart" tab
    The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
    Click on the Home page
    Search product on the search bar    Best Grilling Recipes
    Hover Over The product item "Best Grilling Recipes"
    Click on Add Product on Cart button 
    Display sidebar "Shopping Cart" tab
    The "Best Grilling Recipes" should show on shopping cart tab

User logged in yet and There is at least 1 product in shopping cart
    Access the Sign In page
    Log in the system    ${USERNAME}    ${PASSWORD}
    Search product on the search bar    The Prisoner of Heaven: A Novel
    Hover Over The product item "The Prisoner of Heaven: A Novel"
    Click on Add Product on Cart button 
    Display sidebar "Shopping Cart" tab
    The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
    Click on the Home page
    Search product on the search bar    Best Grilling Recipes
    Hover Over The product item "Best Grilling Recipes"
    Click on Add Product on Cart button 
    Display sidebar "Shopping Cart" tab
    The "Best Grilling Recipes" should show on shopping cart tab
The Sign In page should be opened
    Go To    ${URL_LOGIN_CHECKOUT}
    The page should be opened    Sign In    ${PAGE_TITLE_ELE}

Get total product in ${name}
    @{LIST}=    Get WebElements    ${LISTTAB_ELE}   
        FOR    ${element}    IN    @{LIST}
            ${class_attribute}=    Get Element Attribute    ${element}    class
            ${is_Active}=    Run Keyword And Return Status    Should Contain    ${class_attribute}    active
            IF    (${is_Active}!= False)
                ${value}=    Get Text    ${element}
                ${is_contain}=    Run Keyword And Return Status    Should Contain    ${value}    ${name}
                IF    (${is_contain}!= False)
                     ${cart_items_count}=    Get Element Attribute    xpath://*[@class='title' and text()='${name}']/following-sibling::*[@class='badge badge-pill label-cart-amount badge-warning']    data-bind-to
                    ${TOTAL}=    Get Text    css:.badge.badge-warning[data-bind-to="${cart_items_count}"]
                    RETURN    ${TOTAL}
                END   
            END
        END
    
The quantity of product "${NAME}" should be reduce when user click on reduce button
    ${QUANTITYCURRENT}=    Get product quantity "${NAME}"
    ${RESULT}=    Evaluate    ${QUANTITYBEFORE} - ${QUANTITYCURRENT}
    Should Be Equal As Numbers    ${RESULT}    1

The quantity of product "${NAME}" should be increase when user click on add button
    ${QUANTITYCURRENT}=    Get product quantity "${NAME}"
    ${RESULT}=    Evaluate    ${QUANTITYCURRENT} - ${QUANTITYAFTER}
    Should Be Equal As Numbers    ${RESULT}    1

The total product should be changes after changing the product quantity
    ${TOTAL}=    Calculate Total price of product
    ${TOTAL}=    Convert To String    ${TOTAL}
    Should Not Be Equal    ${SUBTOTALBEFORE}    ${TOTAL}