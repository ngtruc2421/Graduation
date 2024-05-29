*** Settings ***
Resource    ../keywords/common_keywords.resource

*** Variables ***
${ADDPRODUCTSEARCH_BTN_ELE}        css:.fa.fa-cart-arrow-down

*** Keywords ***
Click on the Add product button 
    Click on button    ${ADDPRODUCTSEARCH_BTN_ELE}