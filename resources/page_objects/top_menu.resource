*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/products_page.resource

*** Variables ***

*** Keywords ***
Click Menu Item "${NAME}"   
    ${NAME_LOWER}=    Evaluate     "${NAME}".lower()
    Click on the web element    css:.megamenu a[href$="/${NAME_LOWER}"]
    The type "${NAME}" page should be opened
    