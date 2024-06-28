*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/products_page.resource

*** Variables ***

*** Keywords ***
Click Menu Item "${name}"
    [Documentation]       This keyword is used to Click Menu Item from provided item name
    TRY
        ${name_lower}=    Evaluate     "${name}".lower()
        Click on the web element    css:.megamenu a[href$="/${name_lower}"]
        The type "${name}" page should be opened
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click Menu Item "${name}"
    END

    