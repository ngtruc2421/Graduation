*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/products_page.resource

*** Variables ***

*** Keywords ***
Click Menu Item "${NAME}"
    [Documentation]       This keyword is used to Click Menu Item from provided item name
    TRY
        ${NAME_LOWER}=    Evaluate     "${NAME}".lower()
        Click on the web element    css:.megamenu a[href$="/${NAME_LOWER}"]
        The type "${NAME}" page should be opened
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click Menu Item "${NAME}"
    END

    