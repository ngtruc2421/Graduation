*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/sidebar.resource
Resource    shoppingcart_page.resource

*** Variables ***
${ADDPRODUCT_BTN_ELE}                         css:.btn.ajax-cart-link
${PRODUCT_TITLE_ELE}                          css:.pd-name
${QUANTITY_ELE}                               css:.form-control.form-control-lg
${INCREASEUANTITY_BTN_ELE}                    css:.fa.fa-plus
${REDUCEQUANTITY_BTN_ELE}                     css:.fa.fa-minus
${PRODUCT_ELE}                                css:.offcanvas-cart-item
${TITLE_PRODUCT_ELE}                          css:.name.font-weight-medium
${PRICE_ELE}                                  css:.pd-price
${ADDTOLIST_BTN_ELE}                          css:a[title="Add to wishlist"]
${COMPARE_BTN_ELE}                            css:a[title="Add to compare list"]
*** Keywords ***
Click on Add Product button from product detail page
    [Documentation]       This keyword is used to Click on Add Product button from product detail page
    TRY
        Click on button    ${ADDPRODUCT_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on Add Product button from product detail page
    END
    
Click on Add to List button from product detail page
    [Documentation]       This keyword is used to Click on Add to List button from product detail page
    TRY
        Click on button    ${ADDTOLIST_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on Add to List button from product detail page
    END
    
Click on Compare button from product detail page
    [Documentation]       This keyword is used to Click on Compare button from product detail page
    TRY
        Click on button    ${COMPARE_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on Compare button from product detail page
    END
    
The product detail "${NAME}" page should be opened
    [Documentation]       This keyword is used to verify The product detail name page should be opened from provided page name
    TRY
        ${PRODUCT_NAME}=    Wait and get element text    ${PRODUCT_TITLE_ELE}
        Should Be Equal    ${PRODUCT_NAME}    ${NAME}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The product detail "${NAME}" page should be opened
    END

Get quantity of product "${NAME}"
    [Documentation]       This keyword is used to Get quantity of product from provided product name
    TRY
        Wait Until Element Is Visible    ${QUANTITY_ELE}
        ${quantity}=    Get Value    ${QUANTITY_ELE}
        RETURN    ${quantity}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get quantity of product "${NAME}"
    END


Click on Increase quantity button of product "${NAME}" in product detail page
    [Documentation]       This keyword is used to Click on Increase quantity button of product name in product detail page from provided product name
    TRY
        Hover Over Elenment    ${INCREASEUANTITY_BTN_ELE}
        ${QUANTITY}=   Get quantity of product "${NAME}" 
        Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY}    
        Click on button    ${INCREASEUANTITY_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on Increase quantity button of product "${NAME}" in product detail page
    END

Click on Reduce quantity button of produce "${NAME}" in product detail page 
    [Documentation]       This keyword is used to Click on Reduce quantity button of product name in product detail page from provided product name
    TRY
        Hover Over Elenment    ${REDUCEQUANTITY_BTN_ELE}
        ${QUANTITY}=   Get quantity of product "${NAME}" 
        Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY} 
        Click on button    ${REDUCEQUANTITY_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on Reduce quantity button of produce "${NAME}" in product detail page 
    END


The quantity of product "${NAME}" in the product detail page should be reduce when user click on reduce button
    [Documentation]       This keyword is used to verify The quantity of product name in the product detail page should be reduce when user click on reduce button from provided product name
    TRY
        ${QUANTITYCURRENT}=    Get quantity of product "${NAME}"
        ${RESULT}=    Evaluate    ${QUANTITYBEFORE} - ${QUANTITYCURRENT}
        Compare two Numbers    ${RESULT}   1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be reduce when user click on reduce button
    END


The quantity of product "${NAME}" in the product detail page should be increase when user click on icrease button
    [Documentation]       This keyword is used to verify The quantity of product name in the product detail page should be increase when user click on icrease button from provided product name
    TRY
        ${QUANTITYCURRENT}=    Get quantity of product "${NAME}"
        ${RESULT}=    Evaluate    ${QUANTITYCURRENT} - ${QUANTITYBEFORE}
        Compare two Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be increase when user click on add button
    END

Check product "${NAME}" have in shopping cart 
    [Documentation]       This keyword is used to Check product have in shopping cart from provided product name
    TRY
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get list WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Wait and get element text    ${TITLE_ELE}   
            IF    "${TITLE}" == "${NAME}"
                RETURN    ${True}
            ELSE
                RETURN    ${False}
            END
            ${INDEX}=     Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
    END
Check list empty
    [Documentation]       This keyword is used to Check list empty
    TRY
        @{LIST}=    Get list WebElements    ${PRODUCT_ELE}
        ${length}=    Get Length    ${LIST}
        ${length}=    Convert To String    ${length}
        ${Status}=    Run Keyword And Return Status    Should Be Equal    ${length}    0
        RETURN    ${Status}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Check list empty
    END


User is the Home Page and There are 1 product with quantity is 2 in shopping cart
    [Documentation]       This keyword is used to verify User is the Home Page and There are 1 product with quantity is 2 in shopping cart
    TRY
        Open the Home Page
        Click Menu Item "Furniture"
        Hover Over The product item "Club Lounge Chair" in product page
        Click on the product "Club Lounge Chair"
        Click on Increase quantity button of product "Club Lounge Chair" in product detail page
        The quantity of product "Club Lounge Chair" in the product detail page should be increase when user click on icrease button
        Click on Add Product button from product detail page
        Display sidebar "Shopping Cart" tab
        The "Club Lounge Chair" should show on shopping cart tab
        Click on the Home page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify User is the Home Page and There are 1 product with quantity is 2 in shopping cart
    END


User is the Product Detail Page 
    [Documentation]       This keyword is used to verify User is the Product Detail Page 
    TRY
        Open the Home Page
        Click Menu Item "Furniture"
        Hover Over The product item "Club Lounge Chair" in product page
        Click on the product "Club Lounge Chair"
        The product detail "Club Lounge Chair" page should be opened
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify User is the Product Detail Page 
    END


The "Add to Cart" button should be Visible
    [Documentation]       This keyword is used to verify The "Add to Cart" button should be Visible
    TRY
        Wait Until Element Is Visible    ${ADDPRODUCT_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The "Add to Cart" button should be Visible
    END


Get price of product "${NAME}" in detail page
    [Documentation]       This keyword is used to Get price of product name in detail page from provided product name
    TRY
        Wait Until Element Is Visible    ${PRICE_ELE}
        ${PRICE}=    Wait and get element text    ${PRICE_ELE}
        RETURN    ${PRICE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get price of product "${NAME}" in detail page
    END


Compare price 
    [Documentation]       This keyword is used to Compare price from 2 provided value
    [Arguments]     ${NAME}    ${PRICING}
    TRY
        ${price}=    Get price of product "${NAME}" in detail page
        Should Be Equal    ${price}    ${PRICING}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Compare price 
    END

Adjust quantity of product ${NAME}
    [Documentation]       This keyword is used to Adjust quantity of product from provided product name
    [Arguments]    ${QUANTITY}
    TRY
            ${QUANTITY_CURENT}=    Get quantity of product "${NAME}"
        IF   ("${QUANTITY_CURENT}"<"${QUANTITY}") 
            FOR    ${i}    IN RANGE    ${QUANTITY_CURENT}    ${QUANTITY}
                Click on Increase quantity button of product "${NAME}" in product detail page
                The quantity of product "${NAME}" in the product detail page should be increase when user click on icrease button
            END
            ${QUANTITY_CURENT}=    Get quantity of product "${NAME}"
            RETURN      ${QUANTITY_CURENT} 
        ELSE IF     ("${QUANTITY_CURENT}">"${QUANTITY}") 
            FOR    ${i}    IN RANGE    ${QUANTITY}    ${QUANTITY_CURENT}
                Click on Reduce quantity button of produce "${NAME}" in product detail page
                The quantity of product "${NAME}" in the product detail page should be reduce when user click on reduce button
            END
            ${QUANTITY_CURENT}=    Get quantity of product "${NAME}"
            RETURN      ${QUANTITY_CURENT} 
        ELSE
            RETURN      ${QUANTITY_CURENT}  
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Adjust quantity of product ${NAME}
    END


The price of product "${NAME}" should be price when user select quantity
    [Documentation]       This keyword is used to verify The price of product name should be price when user select quantity from provided product name
    [Arguments]      ${QUANTITY}      ${PRICE}
    TRY
        ${QUANTITY_CURENT}=    Adjust quantity of product ${NAME}    ${QUANTITY} 
        Scroll Element Into View    ${PRICE_ELE}
        Compare price    ${NAME}    ${PRICE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The price of product "${NAME}" should be price when user select quantity
    END

Get class dropdown field by lable ${NAME}
    [Documentation]       This keyword is used to Get class dropdown field by lable from provided lable name
    TRY
        ${XPATH}=    Set Variable    //label[text()='${NAME}']/following-sibling::div[contains(@class, 'choice-control')]
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${class}=    Call Method    ${ELEMENT}    get_attribute    class
        RETURN    css:.${class}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get class dropdown field by lable ${NAME}
    END

    