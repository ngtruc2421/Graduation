
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
    Click on the Home page
    Hover Over The product item "Cooking for Two"
    Click on Add Product on Cart button
    Display sizebar "Shopping Cart" tab
    Dislay "Cooking for Two" in shopping cart tab
    Click on the Home page
    Click Menu Item "Sports"
    Hover Over The product item "Trainer Ball"
    Click on Add Product on Cart button
    Display sizebar "Shopping Cart" tab
    Dislay "Trainer Ball" in shopping cart tab
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
    
Click on the Home page
    Click on the web element    css:.canvas-blocker.canvas-slidable