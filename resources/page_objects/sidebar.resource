
*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/home_page.resource
Resource    top_menu.resource
*** Variables ***
${ADDCART_BUTTON_ELE}                             css:a[data-href="/cart/addproductsimple/24?forceredirection=False"]

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
    Click Menu Item "Books"
    Hover Over The product item "Überman: The novel"
    Click on Add Product on Cart button
    Display sizebar "Shopping Cart" tab
    Dislay "Überman: The novel" in shopping cart tab
Display image of product "${NAME}"
    Page Should Contain Element    css:.img-center-container[title="Show details for ${NAME}"]

Display name of product "${NAME}"
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${name}"]


Display quantity of product "${NAME}"
    TRY
            @{LIST}=    Get WebElements    css:.offcanvas-cart-item
        FOR    ${element}    IN    @{LIST}
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                Get value quantity 
        END
    END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END



Get value quantity 
    TRY
        @{LIST}=    Get WebElements    id:item_EnteredQuantity 
        FOR    ${element}    IN    @{LIST}
            ${value}=     Get Value    ${element}
        END

    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get value quantity 
    END

Display price of product "${NAME}"
    TRY
        @{LIST}=    Get WebElements    css:.offcanvas-cart-item
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${class}=    Get Element Attribute    ${element}    class
            ${title}=    Set Variable    a[title="${NAME}"]
            ${name_product}=    Set Variable    ${class} ${title}
            ${text}=    Get Text   css:.${name_product}
            IF    "${text}" == "${NAME}"
                @{LIST_price}=    Get WebElements    css:.price.unit-price           
                ${value}=    Get From List    ${LIST_price}    ${INDEX}
                ${price}=    Get Value   ${value}
                ${price_text}=    Get text    ${value}
                ${price_text}=    Trim data    ${price_text}    excl tax
                ${price_text}=    Trim data    ${price_text}    $
                RETURN    ${price_text}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END

# Get price of ${NAME}
#     @{LIST}=    Get WebElements    css:.price.unit-price 
#     FOR    ${element}    IN    @{LIST}
        
#         ${VALUE}=    Get Text    ${element}
#     END

# Get price
#     [Arguments]    ${INDEX}
#     ${price}=    Get Value    css:.price.unit-price[${INDEX}]
#     RETURN    ${price}



# Example Test
#     ${words}=    Split String    ${string}    ${SPACE}
#     ${first_word}=    Get From List    ${words}    0
#     Log    First word: ${first_word}

# Example Test case
#     ${substring}=    Get Substring    ${string1}    1
#     Log    Substring: ${substring}
Click on the Home page
    Click on the web element    css:.canvas-blocker.canvas-slidable

Trim data
    [Arguments]    ${data}    ${searchString}    
    ${trimmed_string}    Replace String    ${data}    ${searchString}    ${EMPTY}
