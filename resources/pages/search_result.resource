*** Settings ***
Resource    ../keywords/common_keywords.resource

*** Variables ***
${ADDPRODUCTSEARCH_BTN_ELE}        css:.fa.fa-cart-arrow-down

*** Keywords ***
Click on the Add product button on search result page
    TRY
        Click on button    ${ADDPRODUCTSEARCH_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the Add product button
    END 
    
