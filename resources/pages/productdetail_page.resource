*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/sidebar.resource

*** Variables ***
${ADDPRODUCT_BTN_ELE}                         css:.btn.ajax-cart-link
${PRODUCT_TITLE_ELE}                          css:.pd-name
${QUANTITY_ELE}                               css:.form-control.form-control-lg
${INCREASEUANTITY_BTN_ELE}                    css:.fa.fa-plus
${REDUCEQUANTITY_BTN_ELE}                     css:.fa.fa-minus
${PRODUCT_ELE}                                css:.offcanvas-cart-item
${TITLE_PRODUCT_ELE}                          css:.name.font-weight-medium
*** Keywords ***
Click on Add Product button from product detail page
        Click on button    ${ADDPRODUCT_BTN_ELE}
    
The product detail "${NAME}" page should be opened
    ${PRODUCT_NAME}=    Get Text    ${PRODUCT_TITLE_ELE}
    Should Be Equal    ${PRODUCT_NAME}    ${NAME}

Select color "${COLOR}" of product
    Click on the Home page
    Execute JavaScript    window.scrollBy(0, 500)
    # Click Element    css:[data-original-title="${COLOR}"] > span
    Hover Over Elenment    css:.choice-box-label span[data-original-title="Yellow"] .choice-box-element
    Click Element    css:.choice-box-label span[data-original-title="Yellow"] .choice-box-element
    The yellow tick should be display in ${COLOR}
The yellow tick should be display in "${NAME}"
    ${is_visible}=    Execute JavaScript    return window.getComputedStyle(document.querySelector("${NAME}"), "::after").getPropertyValue("content") !== '' && window.getComputedStyle(document.querySelector("${NAME}"), "::after").getPropertyValue("content") !== 'none';
    Should Be True    ${is_visible}

Get quantity of product "${NAME}"
    ${quantity}=    Get Value    ${QUANTITY_ELE}
    RETURN    ${quantity}

Click on Increase quantity button of product "${NAME}" in product detail page
    Hover Over Elenment    ${INCREASEUANTITY_BTN_ELE}
    ${QUANTITY}=   Get quantity of product "${NAME}" 
    Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY}    
    Click on button    ${INCREASEUANTITY_BTN_ELE}
    
Click on Reduce quantity button of produce "${NAME}" in product detail page 
    Hover Over Elenment    ${REDUCEQUANTITY_BTN_ELE}
    ${QUANTITY}=   Get quantity of product "${NAME}" 
    Set Suite Variable    ${QUANTITYBEFORE}    ${QUANTITY} 
    Click on button    ${REDUCEQUANTITY_BTN_ELE}

The quantity of product "${NAME}" in the product detail page should be reduce when user click on reduce button
    TRY
        ${QUANTITYCURRENT}=    Get quantity of product "${NAME}"
        ${RESULT}=    Evaluate    ${QUANTITYBEFORE} - ${QUANTITYCURRENT}
        Should Be Equal As Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be reduce when user click on reduce button
    END


The quantity of product "${NAME}" in the product detail page should be increase when user click on icrease button
    TRY
        ${QUANTITYCURRENT}=    Get quantity of product "${NAME}"
        ${RESULT}=    Evaluate    ${QUANTITYCURRENT} - ${QUANTITYBEFORE}
        Should Be Equal As Numbers    ${RESULT}    1
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The quantity of product "${NAME}" should be increase when user click on add button
    END

Check product "${NAME}" have in shopping cart 
    TRY
        @{LIST}=    Get WebElements    ${PRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}            
            ${LIST_TITLE}=    Get WebElements    ${TITLE_PRODUCT_ELE} 
            ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${TITLE_ELE}   
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
    @{LIST}=    Get WebElements    ${PRODUCT_ELE}
    ${length}=    Get Length    ${LIST}
    ${length}=    Convert To String    ${length}
    ${Status}=    Run Keyword And Return Status    Should Be Equal    ${length}    0
    RETURN    ${Status}
Remove all product in shopping cart
    @{LIST}=    Get WebElements    ${PRODUCT_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        ${LIST_TITLE}=    Get WebElements    ${TITLE_PRODUCT_ELE} 
        ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
        ${TITLE}=    Get Text    ${TITLE_ELE}
        Click the Remove product button of product "${TITLE}"
        ${INDEX}=    Evaluate    ${INDEX}+1
    END
User is the Home Page and There are not product in shopping cart
    Open the Home Page
    Click on the "Shopping Basket" button
    ${STATUS}=    Check list empty
    IF    ("${STATUS}"=="False")
        Remove all product in shopping cart  
    END
    Click on the Home page
User is the Home Page and There are 1 product with quantity is 2 in shopping cart
    Open the Home Page
    Hover Over The product item "Club Lounge Chair" in result page
    Click on the product "Club Lounge Chair"
    Click on Increase quantity button of product "Club Lounge Chair" in product detail page
    The quantity of product "Club Lounge Chair" in the product detail page should be increase when user click on icrease button
    Click on Add Product button from product detail page
    Display sidebar "Shopping Cart" tab
    The "Club Lounge Chair" should show on shopping cart tab
    Click on the Home page

# There are product "${NAME}" quantity added in shopping cart
#     ${QUANTITY}=    Get quantity of product "${NAME}"
#     ${INDEX}=    Set Variable    0
#     TRY
#             IF     ("${STATUS}" == "True")
#                 ${QUANTITYPRODUCTSHOPPINGCART}=    Get product quantity "${NAME}"
#                 ${result}=    Evaluate    ${QUANTITYPRODUCTSHOPPINGCART} - ${QUANTITY}
#                 Should Be Equal As Numbers    ${result}    ${QUANTITYPRODUCT}
#             ELSE
#                 ${QUANTITYPRODUCTSHOPPINGCART}=    Get product quantity "${NAME}"
#                 ${result}=    Evaluate    ${QUANTITYPRODUCTSHOPPINGCART} - ${QUANTITY}
#                 Should Be Equal As Numbers    ${result}    0
#             END
            
#     EXCEPT    
#         Run Keyword And Continue On Failure    Fail    There is a error happen in process Display quantity of product "${NAME}"
#     END