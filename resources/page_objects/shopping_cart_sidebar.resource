*** Settings ***
Resource    ../keywords/common_keywords.resource

*** Variables ***
${ADDCART_BTN_ELE}                             css:a[data-href="/cart/addproductsimple/24?forceredirection=False"]
${SHOPPINGCART_SIDEBAR_ELE}                       css:.title
${SHOPPINGCART_PAGE_ELE}                          css:.page-title
${SHOPPINGCART_ITEM_ELE}                          css:.cart-item-link
${ADDPRODUCT_BTN_ELE}                          css:.btn.ajax-cart-link
${PD_NAME_ELE}                                    css:.pd-name
${SHOPPING_BASKET_BTN_ELE}                        css:.shopbar-button[data-summary-href="/shoppingcart/cartsummary?cart=True"]
*** Keywords ***
Hover Over The product item ${NAME}
    Hover Over Elenment    css:[title="${NAME}"]

Click on Add to Cart button
    Click on button    ${ADDCART_BTN_ELE}

Dislay ${name} in shopping cart tab 
    Wait Until Element Is Visible    css:.offcanvas-cart-items a[title="${name}"]
    Page Should Contain Element    css:.offcanvas-cart-items a[title="${name}"]

Click on the "Shopping Basket" button
    Click on button    ${SHOPPING_BASKET_BTN_ELE}

