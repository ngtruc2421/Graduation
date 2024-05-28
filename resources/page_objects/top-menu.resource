*** Settings ***
Resource    ../keywords/common_keywords.resource

*** Variables ***

*** Keywords ***
Click Menu Item ${name}   
    ${name}=    Evaluate     "${name}".lower()
    Wait Until Element Is Visible    css:.megamenu a[href="/${name}"]
    Click on the web element    css:.megamenu a[href="/${name}"]

    