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
${CIRCLE_ELE}                      css:.circle
*** Keywords ***
The image "${NAME}" should be displayed in the shopping cart page
    TRY
        Wait until page contain element    css:.img-fluid[alt="Picture of ${NAME}"]
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The image "${NAME}" should be displayed in the shopping cart page
    END

There is 2 product in shopping cart and user is on the Shopping cart page
    TRY
        There is at least 1 product in shopping cart
        Click on the "Go To Cart" button
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in progress verify There is 2 product in shopping cart 
    END

The name "${NAME}" should be displayed in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                RETURN
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The name "${NAME}" should be displayed in shopping cart page
    END

The arrival date of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_DATE}=    Get list WebElements    ${LISTDATE_ELE}
                ${DATE_ELE}=    Get From List    ${LIST_DATE}    ${INDEX}
                Wait until page contain element    ${DATE_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The arrival date of product "${NAME}" should be display in shopping cart page
    END

The Price per item of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_PRICE}=    Get list WebElements    ${LISTPRICE_ELE}
                ${PRICE_ELE}=    Get From List    ${LIST_PRICE}    ${INDEX}
                Wait until page contain element    ${PRICE_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${NAME}" should be display in shopping cart page
    END

The quantity of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_QUANTITY}=    Get list WebElements    ${LIST_QUANTITY_ELE}
                ${QUANTITY_ELE}=    Get From List    ${LIST_QUANTITY}    ${INDEX}
                Wait until page contain element    ${QUANTITY_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${NAME}" should be display in shopping cart page
    END

The Total price for the item of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_TOTAL}=    Get list WebElements    ${LISTTOTAL_ELE}
                ${TOTAL_ELE}=    Get From List    ${LIST_TOTAL}    ${INDEX}
                Wait until page contain element    ${TOTAL_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${NAME}" should be display in shopping cart page
    END

Click on ${BUTTON} button of product "${NAME}" in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
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

Get product quantity of product "${NAME}" in shopping cart page
    TRY
       ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                @{LIST_PRICE}=    Get list WebElements    ${LIST_QUANTITY_ELE}                
                ${quantity_ele}=    Get From List    ${LIST_PRICE}    ${INDEX}
                ${quantity}=    Get Value    ${quantity_ele}
                RETURN    ${quantity}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get product quantity of product "${NAME}" in shopping cart page
    END

Get product price of product "${NAME}" in shopping cart page
    TRY
       ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
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
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get product price of product "${NAME}" in shopping cart page
    END
Get total of product "${NAME}" in shopping cart page 
    TRY
        Wait Until Element Is Visible    ${LISTNAME_ELE}
       ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_TOTAL}=    Get list WebElements    ${LISTTOTAL_ELE}               
                ${TOTAL_ELE}=    Get From List    ${LIST_TOTAL}    ${INDEX}
                # Sleep    3s
                ${TOTAL}=    Wait and get element text    ${TOTAL_ELE}
                ${TOTAL}=    Split String    ${TOTAL}    ${SPACE}
                ${TOTAL}=    Get From List    ${TOTAL}    0
                ${TOTAL}=    Get Substring    ${TOTAL}    1
                RETURN    ${TOTAL}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get total of product "${NAME}" in shopping cart page 
    END

Calculate Total price of product "${NAME}" in shopping cart page
    TRY
      ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        ${TOTAL}=    Set Variable    0    
        FOR    ${element}    IN    @{LIST_NAME}
        ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")   
                ${PRICE}=    Get product price of product "${name_text}" in shopping cart page
                ${QUANTITY}=    Get product quantity of product "${name_text}" in shopping cart page
                ${TOTAL}=    Evaluate    ${TOTAL} + ${PRICE} * ${QUANTITY}
                ${TOTAL}=    Evaluate    round(${TOTAL},2)
                RETURN    ${TOTAL}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END        
            
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Total price of product 
    END
Click the Reduce quantity button of product "${NAME}" in shopping cart page
    TRY
        ${QUANTITY}=   Get product quantity of product "${NAME}" in shopping cart page
        Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY}    
        Click on ${REDUCEQUANTITY_BTN_ELE} button of product "${NAME}" in shopping cart page   
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Reduce quantity button of product "${NAME}"
    END

The quantity of product "${NAME}" should be reduce when user click on reduce button in shopping cart page
    TRY
        ${QUANTITYCURRENT}=    Get product quantity of product "${NAME}" in shopping cart page
        ${RESULT}=    Evaluate    ${QUANTITYBEFORE} - ${QUANTITYCURRENT}
        Compare two Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be reduce when user click on reduce button
    END

Click the Add quantity button of product "${NAME}" in shopping cart page
    TRY
        ${QUANTITY}=   Get product quantity of product "${NAME}" in shopping cart page
        Set Suite Variable    ${QUANTITYAFTER}    ${QUANTITY}    
        Click on ${ADDQUANTITY_BUTTON_ELE} button of product "${NAME}" in shopping cart page
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Add quantity button of product "${NAME}"
    END


The quantity of product "${NAME}" should be increase when user click on add button in shopping cart page
    TRY
        ${QUANTITYCURRENT}=    Get product quantity of product "${NAME}" in shopping cart page
        ${RESULT}=    Evaluate    ${QUANTITYCURRENT} - ${QUANTITYAFTER}
        Should Be Equal As Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be increase when user click on add button
    END

Wait for page loaded
    Wait Until Element Is Visible    ${CIRCLE_ELE}
    Wait Until Element Is Not Visible    ${CIRCLE_ELE}
The total of product "${NAME}" should be equal quantity * price 
    TRY
        Wait for page loaded
        ${TOTAL}=    Get total of product "${NAME}" in shopping cart page
        ${TOTAL_CALCULATE}=    Calculate Total price of product "${NAME}" in shopping cart page
        ${TOTAL_CALCULATE}=    Convert To String    ${TOTAL_CALCULATE}
        Should Be Equal    ${TOTAL_CALCULATE}    ${TOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The total of product "${NAME}" should be equal quantity * price 
    END

Get Subtotal in shopping cart page 
    TRY
        ${SUBTOTAL}    Wait and get element text    ${SUBTOTAL_ELE}
        ${SUBTOTAL}=    Split String    ${SUBTOTAL}    ${SPACE}
        ${SUBTOTAL}=    Get From List    ${SUBTOTAL}    0
        ${SUBTOTAL}=    Get Substring    ${SUBTOTAL}    1
        RETURN    ${SUBTOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Get Subtotal in shopping cart page 
    END
    
Calculate Total price in shopping cart page
    TRY
      ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        ${TOTAL}=    Set Variable    0    
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            ${PRICE}=    Get product price of product "${name_text}" in shopping cart page
            ${QUANTITY}=    Get product quantity of product "${name_text}" in shopping cart page
            ${TOTAL}=    Evaluate    ${TOTAL} + ${PRICE} * ${QUANTITY}
            ${TOTAL}=    Evaluate    round(${TOTAL},2)
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END        
        RETURN    ${TOTAL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Total price of product 
    END

The Subtotal of all items shopping cart page should be equal total price of product 
    TRY
        ${TOATL}=    Get Subtotal in shopping cart page 
        ${SUBTOTAL}=    Calculate Total price in shopping cart page
        ${SUBTOTAL}=    Convert To String    ${SUBTOTAL}
        Should Be Equal    ${SUBTOTAL}    ${TOATL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The Subtotal shopping cart page should be equal total price of product 
    END


Click on the "X" button of product "${NAME}" in the shopping cart page 
    TRY
      ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        ${TOTAL}=    Set Variable    0    
        FOR    ${element}    IN    @{LIST_NAME}
        ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_REMOVE}=    Get list WebElements    ${REMOVE_BTN_ELE}
                ${REMOVEBTN}=    Get From List    ${LIST_REMOVE}   ${INDEX}   
                Click on button    ${REMOVEBTN}
                RETURN
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END        
            
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "X" button of product "${NAME}" in the shopping cart page 
    END

The product "${NAME}" should be remove it from the cart
    TRY
        Wait Until Page Contains    The product has been removed.
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${STATUS}=    Set Variable    False
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Wait and get element text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${STATUS}=    Set Variable    True
            END
        END
        Should Not Be True    ${STATUS}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The name "${NAME}" should be displayed in shopping cart page
    END

Get quantity of product in header
    TRY
        ${TOTALPRODUCT}=    Get Text    ${TOTALPRODUCT_ELE}
        RETURN    ${TOTALPRODUCT}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify Get total of product in shopping cart page
    END
    

The total of product should be change when an item is removed
    TRY
        Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page
        ${TOTAL_BEFORE}=    Get quantity of product in header
        Click the Reduce quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be reduce when user click on reduce button in shopping cart page
        ${TOTAL_AFTER}=    Get quantity of product in header
        ${QUANTITY}=    Evaluate    ${TOTAL_BEFORE} - ${TOTAL_AFTER}
        ${QUANTITY}=    Convert To String    ${QUANTITY}
        Should Be Equal    ${QUANTITY}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The total of product shuld be change when an item is removed
    END

The Subtotal of product should be change when an item is removed
   TRY
        Click the Add quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be increase when user click on add button in shopping cart page
        ${SUBTOTAL_BEFORE}=    Get Subtotal in shopping cart page
        Click the Reduce quantity button of product "The Prisoner of Heaven: A Novel" in shopping cart page
        The quantity of product "The Prisoner of Heaven: A Novel" should be reduce when user click on reduce button in shopping cart page
        ${SUBTOTAL_AFTER}=    Get Subtotal in shopping cart page
        Should Not Be Equal    ${SUBTOTAL_BEFORE}    ${SUBTOTAL_AFTER}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The total of product shuld be change when an item is removed
    END

The shipping costs should be display 
    TRY
        Wait until page contain element    ${SHIPPING_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The shipping costs should be display 
    END
    
The Applicable taxes should be display 
    TRY
        Wait until page contain element    ${TAX_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The tax should be display 
    END

The Grand total should be display 
    TRY
        Wait until page contain element    ${TOTAL_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Grand total should be display 
    END

User logged in yet and There is 2 product in shopping cart
    TRY
        User logged in yet and There is at least 1 product in shopping cart
        Click on the "Go To Cart" button
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in progress verify User logged in yet and There is 2 product in shopping cart
    END

Click on the "Checkout" button in the shopping cart page
    TRY
        Click on button    ${CHECKOUT_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "Checkout" button in the shopping cart page
    END 

Click on the "I have a discount code" option 
    TRY
        Click on the web element    ${DISCOUNT_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "I have a discount code" option 
    END
    
Click on the "I have a gift card" option 
    TRY
        Click on the web element    ${GIFTCARRD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "I have a gift card" option  
    END

The field for entering discount codes should be display
    TRY
        Wait until page contain element    ${DISCOUNTFIELD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The fields for entering discount codes should be display
    END


The field for entering gift cards should be display
    TRY
        Wait until page contain element    ${GIFTCARDFIELD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The fields for entering discount codes should be display
    END
Click on the "Estimate shipping" option
    TRY
        Click on the web element    ${ESTIMATESHIPPING_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "Estimate shipping" option
    END
The "Estimate shipping" should be visible 
    TRY
        Wait until page contain element    ${ESTIMATESHIPPING_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The "Estimate shipping" should be visible 
    END
The Country field should be visible
    TRY
        Wait until page contain element    ${COUNTRYFIELD_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Country field should be visible
    END
The Provide field should be visible
    TRY
        Wait until page contain element    ${PROVINCEFIELD_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Country field should be visible
    END
The Postal code field should be visible
    TRY
        Wait until page contain element    ${POSTALCODEFIELD_ELE}
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Country field should be visible
    END

Click on the "Continue shopping" button in the shopping cart page
    TRY
        Click on button    ${CONTINUESHOPPING_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click on the "Continue shopping" button in the shopping cart page
    END

Open the Shopping cart page 
    Open page    Cart    ${PAGE_TITLE_ELE}
    The page should be opened    Shopping cart     ${PAGE_TITLE_ELE}