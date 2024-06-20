*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/home_page.resource
Resource    ../pages/products_page.resource
Resource    top_menu.resource
Resource    searchBar.resource
Resource    header.resource
Resource    ../pages/searchResult_page.resource
*** Variables ***
${PRODUCT_ELE}                                css:.offcanvas-cart-item
${PRICESIDEBAR_ELE}                                  css:.price.unit-price
${QUANTITYSIDEBAR_ELE}                        css:[name="item.EnteredQuantity"]
${ADDQUANTITY_BUTTON_ELE}                     css:.fa.fa-plus
${REDUCEQUANTITY_BUTTON_ELE}                  css:.fa.fa-minus
${REMOVE_BUTTON_ELE}                          css:.btn.remove.ajax-cart-link
${CHECKOUTSIDEBAR_BUTTON_ELE}                 css:.btn.btn-clear.btn-action
${CHECKOUTCRTPAGE_BUTTON_ELE}                 id:checkout
${SUBTORAL_PRICE_ELE}                         css:.sub-total.price
${TITLE_PRODUCT_ELE}                          css:.name.font-weight-medium
${WISHLIST_TAB_ELE}                           id:wishlist-tab
${LISTTAB_ELE}                                css:.nav-item [role="tab"]
${USERNAME}=                                  0306211267@caothang.edu.vn
${PASSWORD}=                                  Ttkn1234@
${ATRIBUTESPRODUCT_ELE}                       css:.attributes
${GOTOCART_BTN_ELE}                           css:.btn-action[href="/cart"]
*** Keywords ***
Display sidebar "${NAME}" tab
    [Documentation]       This keyword is used to Display sidebar tab from provided item name 
    TRY
        @{LIST}=    Get list WebElements    ${LISTTAB_ELE}
        FOR    ${element}    IN    @{LIST}
            ${class_attribute}=    Get Element Attribute    ${element}    class
            ${is_Active}=    Run Keyword And Return Status    Should Contain    ${class_attribute}    active
            IF    (${is_Active}!= False)
                ${value}=    Wait and get element text    ${element}
                Should Contain    ${value}    ${name}
                RETURN      
            END
        END
        
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Display sidebar ${NAME} tab 
        
    END
The "${NAME}" should show on shopping cart tab
    [Documentation]       This keyword is used to verify The should show on shopping cart tab from provided item name
    TRY
         @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                Page Should Contain Element    ${TITLE_ELE}
                RETURN
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The "${NAME}" should show on shopping cart tab
    END


Click the Wishlist tab
    [Documentation]       This keyword is used to Click the Wishlist tab
    TRY
        Click on button    ${WISHLIST_TAB_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Wishlist tab 
    END
There is at least 1 product in shopping cart
    [Documentation]       This keyword is used to verify There is at least 1 product in shopping cart
    TRY
        Open the Home Page
        Search product on the search bar    The Prisoner of Heaven: A Novel
        Hover Over The product item "The Prisoner of Heaven: A Novel" in result page
        Click on the Add product button on search result page
        Display sidebar "Shopping Cart" tab
        The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
        Click on the Home page
        Search product on the search bar    Best Grilling Recipes
        Hover Over The product item "Best Grilling Recipes" in result page
        Click on the Add product button on search result page
        Display sidebar "Shopping Cart" tab
        The "Best Grilling Recipes" should show on shopping cart tab    
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process There is at least 1 product in shopping cart
    END
The image "${NAME}" should be displayed
    [Documentation]       This keyword is used to The image should be displayed from provided product name
    TRY
        Wait until page contain element    css:.img-center-container[title="Show details for ${NAME}"] 
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The image "${NAME}" should be displayed
    END

The name "${NAME}" should be displayed
    [Documentation]       This keyword is used to verify The name should be displayed from provided product name   
    TRY
        Wait until page contain element      css:.offcanvas-cart-items a[title="${NAME}"]  
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The name "${NAME}" should be displayed
    END
    
Get product price "${NAME}"
    [Documentation]       This keyword is used to Get product price from provided product name
    TRY
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                @{LIST_PRICE}=    Get list WebElements    ${PRICESIDEBAR_ELE}               
                ${VALUE}=    Get From List    ${LIST_PRICE}    ${INDEX}
                ${PRICE}=    Wait and get element text    ${value}
                ${PRICE}=    Split String    ${PRICE}    ${SPACE}
                ${PRICE}=    Get From List    ${PRICE}    0
                ${PRICE}=    Get Substring    ${PRICE}    1
                RETURN    ${PRICE}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END


Get product quantity "${NAME}"
    [Documentation]       This keyword is used to Get product quantity from provided product name
    TRY
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                @{LIST_quantities}=    Get list WebElements    ${QUANTITYSIDEBAR_ELE}               
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
    [Documentation]       This keyword is used to verify The quantities should be displayed from provided product name
    TRY
        Get product quantity "${NAME}"
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantities "${NAME}" should be displayed
    END
    

The price"${NAME}" should be displayed
    [Documentation]       This keyword is used to verify The price should be displayed from provided product name
    TRY
        Get product price "${NAME}"
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The price"${NAME}" should be displayed
    END
    

Click on ${BUTTON} button of product "${NAME}"
    [Documentation]       This keyword is used to Click on button of product from provided product name and provided button
    TRY
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
           ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                @{LIST_BUTTON}=    Get list WebElements    ${BUTTON}             
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
    [Documentation]       This keyword is used to Click the Add quantity button of product from provided product name
    TRY
        ${QUANTITY}=   Get product quantity "${NAME}"
        ${SUBTOTAL}=    Get Subtotal shopping cart
        Set Suite Variable    ${SUBTOTALBEFORE}    ${SUBTOTAL}    
        Set Suite Variable    ${QUANTITYAFTER}    ${QUANTITY}    
        Click on ${ADDQUANTITY_BUTTON_ELE} button of product "${NAME}" 
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Add quantity button of product "${NAME}"
    END


Click the Reduce quantity button of product "${NAME}"
    [Documentation]       This keyword is used to Click the Reduce quantity button of product from provided product name
    TRY
        ${QUANTITY}=   Get product quantity "${NAME}"
        ${SUBTOTAL}=    Get Subtotal shopping cart
        Set Suite Variable    ${SUBTOTALBEFORE}    ${SUBTOTAL}   
        Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY}    
        Click on ${REDUCEQUANTITY_BUTTON_ELE} button of product "${NAME}"    
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Reduce quantity button of product "${NAME}"
    END

Click the Remove product button of product "${NAME}"
    [Documentation]       This keyword is used to Click the Remove product button of product from provided product name
    TRY
        Click on ${REMOVE_BUTTON_ELE} button of product "${NAME}"
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Remove product button of product "${NAME}"
    END
    

The product ${NAME} should not show on shopping cart tab
    [Documentation]       This keyword is used to verify The product should not show on shopping cart tab from provided item name
    TRY
        Wait Until Element Is Not Visible    css:.offcanvas-cart-items a[title="${NAME}"]
        Page Should Not Contain Element    css:.offcanvas-cart-items a[title="${NAME}"]

    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The product ${NAME} should not show on shopping cart tab
    END

Click the "Checkout" button in the sidebar 
    [Documentation]       This keyword is used to Click the "Checkout" button in the sidebar
    TRY
        Click on button    ${CHECKOUTSIDEBAR_BUTTON_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the "Checkout" button in the sidebar 
    END
    

The Shopping cart page should be opened
    [Documentation]       This keyword is used to verify The Shopping cart page should be opened
    TRY
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The Shopping cart page should be opened
    END
    
Click the "Checkout" button in the Shopping cart page
    [Documentation]       This keyword is used to Click the "Checkout" button in the Shopping cart page
    TRY
        Click on button    ${CHECKOUTCRTPAGE_BUTTON_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the "Checkout" button in the Shopping cart page
    END 

The Billing address page should be opened
    [Documentation]       This keyword is used to verify The Billing address page should be opened
    TRY
        The page should be opened    Billing address    ${PAGE_TITLE_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The Billing address page should be opened 
    END



Get Subtotal shopping cart 
    [Documentation]       This keyword is used to Get Subtotal shopping cart 
    TRY
        ${SUBTOTAL}=    Wait and get element text    ${SUBTORAL_PRICE_ELE}
        ${SUBTOTAL}=    Split String    ${SUBTOTAL}    ${SPACE}
        ${SUBTOTAL}=    Get From List    ${SUBTOTAL}    0
        ${SUBTOTAL}=    Get Substring    ${SUBTOTAL}    1
        RETURN    ${SUBTOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Get Subtotal shopping cart 
    END


Calculate Total price of product 
    [Documentation]       This keyword is used to Calculate Total price of product 
    TRY
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        ${TOTAL}=    Set Variable    0    
        FOR    ${element}    IN    @{LIST}
            ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}    
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
    [Documentation]       This keyword is used to verify The Subtotal shopping cart should be equal total price of product 
    TRY
        ${SUBTOTAL}=    Get Subtotal shopping cart
        ${TOTAL}=    Calculate Total price of product
        ${TOTAL}=    Convert To String    ${TOTAL}
        Should Be Equal    ${SUBTOTAL}    ${TOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The Subtotal shopping cart should be equal total price of product 
    END

Is user not logged in yet
    [Documentation]       This keyword is used to verify Is user not logged in yet
    TRY
        ${IS_LOGIN}=    Check user login
        Should Be True    ${IS_LOGIN}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Is user not logged in yet
    END 
    

User not logged in yet and There is at least 1 product in shopping cart
    [Documentation]       This keyword is used to verify User not logged in yet and There is at least 1 product in shopping cart
    TRY
        Open the Home Page
        Is user not logged in yet 
        Search product on the search bar    The Prisoner of Heaven: A Novel
        Hover Over The product item "The Prisoner of Heaven: A Novel" in result page
        Click on the Add product button on search result page 
        Display sidebar "Shopping Cart" tab
        The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
        Click on the Home page
        Search product on the search bar    Best Grilling Recipes
        Hover Over The product item "Best Grilling Recipes" in result page
        Click on the Add product button on search result page
        Display sidebar "Shopping Cart" tab
        The "Best Grilling Recipes" should show on shopping cart tab    
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process User not logged in yet and There is at least 1 product in shopping cart
    END


User logged in yet and There is at least 1 product in shopping cart
    [Documentation]       This keyword is used to verify User logged in yet and There is at least 1 product in shopping cart
    TRY
        Access the Sign In page
        Log in the system    ${USERNAME}    ${PASSWORD}
        Search product on the search bar    The Prisoner of Heaven: A Novel
        Hover Over The product item "The Prisoner of Heaven: A Novel" in result page
        Click on the Add product button on search result page 
        Display sidebar "Shopping Cart" tab
        The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
        Click on the Home page
        Search product on the search bar    Best Grilling Recipes
        Hover Over The product item "Best Grilling Recipes" in result page
        Click on the Add product button on search result page 
        Display sidebar "Shopping Cart" tab
        The "Best Grilling Recipes" should show on shopping cart tab    
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process User logged in yet and There is at least 1 product in shopping cart
    END

The Sign In page should be opened
    [Documentation]       This keyword is used to verify The Sign In page should be opened
    TRY
        Go To    ${URL_LOGIN_CHECKOUT}
        The page should be opened    Sign In    ${PAGE_TITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The Sign In page should be opened
    END


Get total product in ${name}
    [Documentation]       This keyword is used to Get total product from provided product name
    TRY
        @{LIST}=    Get list WebElements    ${LISTTAB_ELE}   
        FOR    ${element}    IN    @{LIST}
            ${class_attribute}=    Get Element Attribute    ${element}    class
            ${is_Active}=    Run Keyword And Return Status    Should Contain    ${class_attribute}    active
            IF    (${is_Active}!= False)
                ${value}=    Wait and get element text    ${element}
                ${is_contain}=    Run Keyword And Return Status    Should Contain    ${value}    ${name}
                IF    (${is_contain}!= False)
                     ${cart_items_count}=    Get Element Attribute    xpath://*[@class='title' and text()='${name}']/following-sibling::*[@class='badge badge-pill label-cart-amount badge-warning']    data-bind-to
                    ${TOTAL}=    Wait and get element text    css:.badge.badge-warning[data-bind-to="${cart_items_count}"]
                    RETURN    ${TOTAL}
                END   
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Get total product in ${name}
    END

    
The quantity of product "${NAME}" should be reduce when user click on reduce button
    [Documentation]       This keyword is used to verify The quantity of product should be reduce when user click on reduce button from provided product name
    TRY
        ${QUANTITYCURRENT}=    Get product quantity "${NAME}"
        ${RESULT}=    Evaluate    ${QUANTITYBEFORE} - ${QUANTITYCURRENT}
        Compare two Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be reduce when user click on reduce button
    END


The quantity of product "${NAME}" should be increase when user click on add button
    [Documentation]       This keyword is used to verify The quantity of product should be increase when user click on add button from provided product name
    TRY
        ${QUANTITYCURRENT}=    Get product quantity "${NAME}"
        ${RESULT}=    Evaluate    ${QUANTITYCURRENT} - ${QUANTITYAFTER}
        Should Be Equal As Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be increase when user click on add button
    END


The total product should be changes after changing the product quantity
    [Documentation]       This keyword is used to verify The total product should be changes after changing the product quantity
    TRY
        ${TOTAL}=    Calculate Total price of product
        ${TOTAL}=    Convert To String    ${TOTAL}
        Should Not Be Equal    ${SUBTOTALBEFORE}    ${TOTAL}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The total product should be changes after changing the product quantity
    END

The availability status of the product "${NAME}" should be display
    [Documentation]       This keyword is used to verify The availability status of the product should be display from provided product name
    TRY
        ${STATUS_TITLE}=    Get availability status of the product ${NAME}
        Click on the "Shopping Basket" button  
        Wait Until Element Is Visible    ${PRODUCT_ELE}
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
           ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                ${is_contain}=    Get Element Attribute    ${TITLE_ELE}    class 

               ${is_containstatus}=    Run Keyword And Return Status    Element Should Contain    ${is_contain}    css:.delivery-time
               IF    ("${is_containstatus}"=="True")
                   ${text}=    Wait and get element text     css:.delivery-time
                   Should Be Equal    ${text}    ${STATUS_TITLE}
                ELSE
                    Run Keyword And Continue On Failure    Fail    There is a error happen in process The availability status of the product "${NAME}" should be display
               END
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process The availability status of the product "${NAME}" should be display
    END

There are 2 product in shopping cart
    [Documentation]       This keyword is used to verify There are 2 product in shopping cart
    TRY
        Open the Home Page
        Search product on the search bar    The Prisoner of Heaven: A Novel
        Hover Over The product item "The Prisoner of Heaven: A Novel" in result page
        Click on the Add product button on search result page
        Display sidebar "Shopping Cart" tab
        The "The Prisoner of Heaven: A Novel" should show on shopping cart tab
        Click on the Home page
        Search product on the search bar    Best Grilling Recipes
        Hover Over The product item "Best Grilling Recipes" in result page
        Click on the Add product button on search result page
        Display sidebar "Shopping Cart" tab
        The "Best Grilling Recipes" should show on shopping cart tab
        Click on the Home page
        Click Menu Item "Books"
        Hover Over The product item "The Prisoner of Heaven: A Novel" in product page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify There are 2 product in shopping cart
    END


Click on the "Go To Cart" button
    [Documentation]       This keyword is used to Click on the "Go To Cart" button
    TRY
        Click on button    ${GOTOCART_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "Go To Cart" button
    END
