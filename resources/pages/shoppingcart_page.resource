*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/sidebar.resource

*** Variables ***
${LISTNAME_ELE}                    css:.col a[title="Description"]
${LISTDATE_ELE}                    css:.delivery-date
${LISTPRICE_ELE}                   css:.cart-col-price[data-caption="Price"] .price
${LISTTOTAL_ELE}                   css:.cart-col-price[data-caption="Total"] .price
${LIST_QUANTITY_ELE}               css=[id^="itemquantity"]
${SUBTOTAL_ELE}                    css:.cart-summary-subtotal .cart-summary-value
${REMOVE_BTN_ELE}                  css:.ajax-action-link[title="Remove"]
${TOTALPRODUCT_ELE}                css:.shopbar-button-icon .badge-warning[data-bind-to="CartItemsCount"]
${SHIPPING_ELE}                    css:.cart-summary-neg
${TAX_ELE}                         css:.cart-summary-tax .cart-summary-value
${TOTAL_ELE}                       css:.cart-summary-total .cart-summary-value
${CHECKOUT_BTN_ELE}                id:checkout
${DISCOUNT_ELE}                    css:.cart-action.cart-action-coupon
${GIFTCARRD_ELE}                   css:.cart-action.cart-action-giftcard
${DISCOUNTFIELD_ELE}               css:[name="discountcouponcode"]
${GIFTCARDFIELD_ELE}               css:[name="giftcardcouponcode"]
${ESTIMATESHIPPING_BTN_ELE}        css:[name="estimateshipping"]
${ESTIMATESHIPPING_ELE}            css:.cart-action-shipping
${COUNTRYFIELD_ELE}                id:CountryId
${PROVINCEFIELD_ELE}               css:.state-input
${POSTALCODEFIELD_ELE}             id:ZipPostalCode
${CONTINUESHOPPING_BTN_ELE}        css:.btn-continue-shopping
${THROBBER_ELE}                    css:.throbber-flex
*** Keywords ***
The image "${name}" should be displayed in the shopping cart page
    [Documentation]       This keyword is used to verify The image of product should be displayed in the shopping cart page from provided product name
    TRY
        Wait until page contain element    css:.img-fluid[alt="Picture of ${name}"]
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The image "${name}" should be displayed in the shopping cart page
    END

There is 2 product in shopping cart and user is on the Shopping cart page
    [Documentation]       This keyword is used to verify There is 2 product in shopping cart and user is on the Shopping cart page
    TRY
        There is at least 1 product in shopping cart
        Click on the "Go To Cart" button
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in progress verify There is 2 product in shopping cart 
    END

The name "${name}" should be displayed in shopping cart page
    [Documentation]       This keyword is used to verify The name of product should be displayed in shopping cart page from provided product name
    TRY
        ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                RETURN
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The name "${name}" should be displayed in shopping cart page
    END

The arrival date of product "${name}" should be display in shopping cart page
    [Documentation]       This keyword is used to verify The arrival date of product should be display in shopping cart page from provided product name
    TRY
        ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${list_date}=    Get list WebElements    ${LISTDATE_ELE}
                ${date_ele}=    Get From List    ${list_date}    ${index}
                Wait until page contain element    ${date_ele}
                RETURN
            END
            ${index}=    Evaluate    ${index} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The arrival date of product "${name}" should be display in shopping cart page
    END

The Price per item of product "${name}" should be display in shopping cart page
    [Documentation]       This keyword is used to verify The Price per item of product should be display in shopping cart page from provided product name
    TRY
        ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${list_price}=    Get list WebElements    ${LISTPRICE_ELE}
                ${price_ele}=    Get From List    ${list_price}    ${index}
                Wait until page contain element    ${price_ele}
                RETURN
            END
            ${index}=    Evaluate    ${index} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${name}" should be display in shopping cart page
    END

The quantity of product "${name}" should be display in shopping cart page
    [Documentation]       This keyword is used to verify The quantity of product should be display in shopping cart page from provided product name
    TRY
        ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${list_quantity}=    Get list WebElements    ${LIST_QUANTITY_ELE}
                ${quantity_ele}=    Get From List    ${list_quantity}    ${index}
                Wait until page contain element    ${quantity_ele}
                RETURN
            END
            ${index}=    Evaluate    ${index} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${name}" should be display in shopping cart page
    END

The Total price for the item of product "${name}" should be display in shopping cart page
    [Documentation]       This keyword is used to verify The Total price for the item of product should be display in shopping cart page from provided product name
    TRY
        ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${list_total}=    Get list WebElements    ${LISTTOTAL_ELE}
                ${TOTAL_ELE}=    Get From List    ${list_total}    ${index}
                Wait until page contain element    ${TOTAL_ELE}
                RETURN
            END
            ${index}=    Evaluate    ${index} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${name}" should be display in shopping cart page
    END

Click on ${BUTTON} button of product "${name}" in shopping cart page
    [Documentation]       This keyword is used to Click on button of product in shopping cart page from provided product name and provied name button
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                @{LIST_BUTTON}=    Get list WebElements    ${BUTTON}             
                ${BUTTON_ELE}=    Get From List    ${LIST_BUTTON}    ${INDEX}
                Hover Over Elenment    ${BUTTON_ELE}
                Click on button    ${BUTTON_ELE}
                Exit For Loop
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on add quantity button of product ${name}
    END

Get product quantity of product "${name}" in shopping cart page
    [Documentation]       This keyword is used to Get product quantity of product in shopping cart page from provided product name
    TRY
       ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                @{LIST_PRICE}=    Get list WebElements    ${LIST_QUANTITY_ELE}                
                ${quantity_ele}=    Get From List    ${LIST_PRICE}    ${INDEX}
                ${quantity}=    Get Value    ${quantity_ele}
                RETURN    ${quantity}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get product quantity of product "${name}" in shopping cart page
    END

Get product price of product "${name}" in shopping cart page
    [Documentation]       This keyword is used to Get product price of product in shopping cart page from provided product name
    TRY
       ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                @{LIST_PRICE}=    Get list WebElements    ${LISTPRICE_ELE}                
                ${price_ele}=    Get From List    ${LIST_PRICE}    ${INDEX}
                ${PRICE}=    Wait and get element text    ${price_ele}
                ${PRICE}=    Split String    ${PRICE}    ${SPACE}
                ${PRICE}=    Get From List    ${PRICE}    0
                ${PRICE}=    Get Substring    ${PRICE}    1
                RETURN    ${PRICE}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get product price of product "${name}" in shopping cart page
    END
Get total of product "${name}" in shopping cart page 
    [Documentation]       This keyword is used to Get total of product in shopping cart page from provided product name
    TRY
        Wait Until Element Is Visible    ${LISTNAME_ELE}
       ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${list_total}=    Get list WebElements    ${LISTTOTAL_ELE}               
                ${total_ele}=    Get From List    ${list_total}    ${index}
                # Sleep    3s
                ${total}=    Wait and get element text    ${total_ele}
                ${total}=    Split String    ${total}    ${SPACE}
                ${total}=    Get From List    ${total}    0
                ${total}=    Get Substring    ${total}    1
                RETURN    ${total}
            END
            ${index}=     Evaluate    ${index} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get total of product "${name}" in shopping cart page 
    END

Calculate Total price of product "${name}" in shopping cart page
    [Documentation]       This keyword is used to Calculate Total price of product in shopping cart page from provided product name
    TRY
      ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        ${total}=    Set Variable    0    
        FOR    ${element}    IN    @{list_name}
        ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")   
                ${price}=    Get product price of product "${name_text}" in shopping cart page
                ${quantity}=    Get product quantity of product "${name_text}" in shopping cart page
                ${total}=    Evaluate    ${total} + ${price} * ${quantity}
                ${total}=    Evaluate    round(${total},2)
                RETURN    ${total}
            END
            ${index}=     Evaluate    ${index} + 1
        END        
            
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process total price of product 
    END
Click the Reduce quantity button of product "${name}" in shopping cart page
    [Documentation]       This keyword is used to Click the Reduce quantity button of product in shopping cart page from provided product name
    TRY
        ${quantity}=   Get product quantity of product "${name}" in shopping cart page
        Set Suite Variable    ${QUANTITYBEFORE}    ${quantity}    
        Click on ${REDUCEQUANTITY_BTN_ELE} button of product "${name}" in shopping cart page
        Wait for page loaded in shopping cart page   
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Reduce quantity button of product "${name}"
    END

The quantity of product "${name}" should be reduce when user click on reduce button in shopping cart page
    [Documentation]       This keyword is used to verify The quantity of product should be reduce when user click on reduce button in shopping cart pagefrom provided product name
    TRY
        ${quantitycurrent}=    Get product quantity of product "${name}" in shopping cart page
        ${result}=    Evaluate    ${QUANTITYBEFORE} - ${quantitycurrent}
        Compare two Numbers    ${result}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${name}" should be reduce when user click on reduce button
    END

Click the Add quantity button of product "${name}" in shopping cart page
    [Documentation]       This keyword is used to Click the Add quantity button of product in shopping cart page from provided product name
    TRY
        ${quantity}=   Get product quantity of product "${name}" in shopping cart page
        Set Suite Variable    ${QUANTITYAFTER}    ${quantity}    
        Click on ${ADDQUANTITY_BUTTON_ELE} button of product "${name}" in shopping cart page
        Wait for page loaded in shopping cart page
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Add quantity button of product "${name}"
    END


The quantity of product "${name}" should be increase when user click on add button in shopping cart page
    [Documentation]       This keyword is used to verify The quantity of product should be increase when user click on add button in shopping cart pagefrom provided product name
    TRY
        ${quantitycurrent}=    Get product quantity of product "${name}" in shopping cart page
        ${result}=    Evaluate    ${quantitycurrent} - ${QUANTITYAFTER}
        Should Be Equal As Numbers    ${result}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${name}" should be increase when user click on add button
    END

Wait for page loaded in shopping cart page
    [Documentation]       This keyword is used to verify Wait for page loaded in shopping cart page
    TRY
        Wait for page loaded    ${THROBBER_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Wait for page loaded in shopping cart page
    END

The total of product "${name}" should be equal quantity * price 
    [Documentation]       This keyword is used to verify The total of product should be equal quantity * price from provided product name
    TRY
        ${total}=    Get total of product "${name}" in shopping cart page
        ${total_calculate}=    Calculate Total price of product "${name}" in shopping cart page
        ${total_calculate}=    Convert To String    ${total_calculate}
        Should Be Equal    ${total_calculate}    ${total}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The total of product "${name}" should be equal quantity * price 
    END

Get Subtotal in shopping cart page 
    [Documentation]       This keyword is used to Get Subtotal in shopping cart page 
    TRY
        ${subtotal}    Wait and get element text    ${SUBTOTAL_ELE}
        ${subtotal}=    Split String    ${subtotal}    ${SPACE}
        ${subtotal}=    Get From List    ${subtotal}    0
        ${subtotal}=    Get Substring    ${subtotal}    1
        RETURN    ${subtotal}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Get Subtotal in shopping cart page 
    END
    
Calculate Total price in shopping cart page
    [Documentation]       This keyword is used to Calculate Total price in shopping cart page
    TRY
      ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        ${total}=    Set Variable    0    
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            ${price}=    Get product price of product "${name_text}" in shopping cart page
            ${quantity}=    Get product quantity of product "${name_text}" in shopping cart page
            ${total}=    Evaluate    ${total} + ${price} * ${quantity}
            ${total}=    Evaluate    round(${total},2)
            ${index}=     Evaluate    ${index} + 1
        END        
        RETURN    ${TOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Total price of product 
    END

The Subtotal of all items shopping cart page should be equal total price of product 
    [Documentation]       This keyword is used to verify The Subtotal of all items shopping cart page should be equal total price of product 
    TRY
        ${toatl}=    Get Subtotal in shopping cart page 
        ${subtotal}=    Calculate Total price in shopping cart page
        ${subtotal}=    Convert To String    ${subtotal}
        Should Be Equal    ${subtotal}    ${toatl}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The Subtotal shopping cart page should be equal total price of product 
    END


Click on the "X" button of product "${name}" in the shopping cart page 
    [Documentation]       This keyword is used to Click on the "X" button of product in the shopping cart page from provided product name
    TRY
      ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${index}=    Set Variable    0
        ${total}=    Set Variable    0    
        FOR    ${element}    IN    @{list_name}
        ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${list_remove}=    Get list WebElements    ${REMOVE_BTN_ELE}
                ${removebtn}=    Get From List    ${list_remove}   ${index}   
                Click on button    ${removebtn}
                RETURN
            END
            ${index}=     Evaluate    ${index} + 1
        END        
            
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "X" button of product "${name}" in the shopping cart page 
    END

The product "${name}" should be remove it from the cart
    [Documentation]       This keyword is used to verify The product should be remove it from the cart from provided product name
    TRY
        Wait Until Page Contains    The product has been removed.
        ${list_name}=    Get list WebElements    ${LISTNAME_ELE}
        ${status}=    Set Variable    False
        FOR    ${element}    IN    @{list_name}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${name}")
                ${status}=    Set Variable    True
            END
        END
        Should Not Be True    ${status}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The name "${name}" should be displayed in shopping cart page
    END

Get quantity of product in header
    [Documentation]       This keyword is used to verify Get quantity of product in header
    TRY
        Hover Over Elenment    ${TOTALPRODUCT_ELE}
        ${totalproduct}=    Wait and get element text   ${TOTALPRODUCT_ELE}
        RETURN    ${totalproduct}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify Get total of product in shopping cart page
    END
    

The total of product should be change when an item is removed
    [Documentation]       This keyword is used to verify The total of product should be change when an item is removed
    TRY
        Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page
        ${total_before}=    Get quantity of product in header
        Click the Reduce quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be reduce when user click on reduce button in shopping cart page
        ${total_after}=    Get quantity of product in header
        ${quantity}=    Evaluate    ${total_before} - ${total_after}
        ${quantity}=    Convert To String    ${quantity}
        Should Be Equal    ${quantity}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The total of product should be change when an item is removed
    END

The Subtotal of product should be change when an item is removed
    [Documentation]       This keyword is used to verify The Subtotal of product should be change when an item is removed
   TRY
        Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page
        ${subtotal_before}=    Get Subtotal in shopping cart page
        Click the Reduce quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be reduce when user click on reduce button in shopping cart page
        ${subtotal_after}=    Get Subtotal in shopping cart page
        Should Not Be Equal    ${subtotal_before}    ${subtotal_after}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The total of product shuld be change when an item is removed
    END

The shipping costs should be display 
    [Documentation]       This keyword is used to verify The shipping costs should be display 
    TRY
        Wait until page contain element    ${SHIPPING_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The shipping costs should be display 
    END
    
The Applicable taxes should be display 
    [Documentation]       This keyword is used to verify The Applicable taxes should be display 
    TRY
        Wait until page contain element    ${TAX_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The tax should be display 
    END

The Grand total should be display 
    [Documentation]       This keyword is used to verify The Grand total should be display
    TRY
        Wait until page contain element    ${TOTAL_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Grand total should be display 
    END

User logged in yet and There is 2 product in shopping cart
    [Documentation]       This keyword is used to verify User logged in yet and There is 2 product in shopping cart
    TRY
        User logged in yet and There is at least 1 product in shopping cart
        Click on the "Go To Cart" button
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in progress verify User logged in yet and There is 2 product in shopping cart
    END

Click on the "Checkout" button in the shopping cart page
    [Documentation]       This keyword is used to Click on the "Checkout" button in the shopping cart page
    TRY
        Click on button    ${CHECKOUT_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "Checkout" button in the shopping cart page
    END 

Click on the "I have a discount code" option 
    [Documentation]       This keyword is used to Click on the "I have a discount code" option 
    TRY
        Click on the web element    ${DISCOUNT_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "I have a discount code" option 
    END
    
Click on the "I have a gift card" option 
    [Documentation]       This keyword is used to Click on the "I have a gift card" option 
    TRY
        Click on the web element    ${GIFTCARRD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "I have a gift card" option  
    END

The field for entering discount codes should be display
    [Documentation]       This keyword is used to verify The field for entering discount codes should be display
    TRY
        Wait until page contain element    ${DISCOUNTFIELD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The fields for entering discount codes should be display
    END


The field for entering gift cards should be display
    [Documentation]       This keyword is used to verify The field for entering gift cards should be display
    TRY
        Wait until page contain element    ${GIFTCARDFIELD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The fields for entering discount codes should be display
    END
Click on the "Estimate shipping" option
    [Documentation]       This keyword is used to Click on the "Estimate shipping" option
    TRY
        Click on the web element    ${ESTIMATESHIPPING_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "Estimate shipping" option
    END
The "Estimate shipping" should be visible
    [Documentation]       This keyword is used to verify The "Estimate shipping" should be visible
    TRY
        Wait until page contain element    ${ESTIMATESHIPPING_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The "Estimate shipping" should be visible 
    END
The Country field should be visible
    [Documentation]       This keyword is used to verify The Country field should be visible
    TRY
        Wait until page contain element    ${COUNTRYFIELD_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Country field should be visible
    END
The Provide field should be visible
    [Documentation]       This keyword is used to verify The Provide field should be visible
    TRY
        Wait until page contain element    ${PROVINCEFIELD_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Country field should be visible
    END
The Postal code field should be visible
    [Documentation]       This keyword is used to verify The Postal code field should be visible
    TRY
        Wait until page contain element    ${POSTALCODEFIELD_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Country field should be visible
    END

Click on the "Continue shopping" button in the shopping cart page
    [Documentation]       This keyword is used to Click on the "Continue shopping" button in the shopping cart page
    TRY
        Click on button    ${CONTINUESHOPPING_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "Continue shopping" button in the shopping cart page
    END

Go the Shopping cart page
    [Documentation]       This keyword is used to Go the Shopping cart page
    TRY
        ${url}=    Catenate    SEPARATOR=/    ${URL_HOME}    cart
        Go To    ${url} 
        The page should be opened    Shopping cart     ${PAGE_TITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Go the Shopping cart page
    END 
