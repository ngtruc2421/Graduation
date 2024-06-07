*** Settings ***
Resource    ../keywords/common_keywords.resource

*** Variables ***
${ADDPRODUCT_BUTTON_ELE}        css:.btn.ajax-cart-link
${PRODUCT_TITLE_ELE}            css:.pd-name
*** Keywords ***
Click on Add Product button from product detail page 
    Click on button    ${ADDPRODUCT_BUTTON_ELE}
    
The product detail "${NAME}" page should be opened
    ${PRODUCT_NAME}=    Get Text    ${PRODUCT_TITLE_ELE}
    Should Be Equal    ${PRODUCT_NAME}    ${NAME}

Select color "${COLOR}" of product
    Execute JavaScript    window.scrollBy(0, 500)
    Click Element    css:[data-original-title="${COLOR}"]
    The yellow tick should be display in ${COLOR}
The yellow tick should be display in ${NAME}
    ${is_visible}=    Execute JavaScript    return window.getComputedStyle(document.querySelector("${NAME}"), "::after").getPropertyValue("content") !== '' && window.getComputedStyle(document.querySelector("${NAME}"), "::after").getPropertyValue("content") !== 'none';
    Should Be True    ${is_visible}