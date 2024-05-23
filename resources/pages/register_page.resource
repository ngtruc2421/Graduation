*** Settings ***
Resource    base_page.resource
Library    SeleniumLibrary
*** Variables ***
${LOGIN_BUTTON_ELE}          css:.menubar-link[href="/login?returnUrl=%2F"]
${URL_SIGNIN}                /login
${PAGE_TITLE_ELE}            css:.page-title
${REGISTER_BUTTON_ELE}       css:.btn.register-button[href="/register?returnUrl=%2f"]
${URL_REGISTER}              /register
${PAGENAME_TITLE}             Register
${id_dayofbirth}                         id:DateOfBirth

*** Keywords ***
The ${name} field is required input
    ${elements}=    Get Element Attribute    css:[for="${name}"]     class
    Should Contain    ${elements}    required
 
The ${name} field is not required input
    ${elements}=    Get Element Attribute    css:[for="${name}"]     class
    Should Not Contain    ${elements}    required

The ${name} field is type free text
    [Arguments]    ${text}
    ${locator}=    Set Variable    id:${name}    
    Input content    ${text}       ${locator}
    ${value}=    Get Value    ${locator}
    Should Be Equal    ${value}    ${text}
The ${name} field is type Dropdown 
    ${locator}=    Set Variable    ${id_dayofbirth}${name}
    ${element}=    Get WebElement    ${locator}    
    ${tag_name}=    Call Method    ${element}    get_attribute    tagName
    Run Keyword If    '${tag_name}' == 'select'    Log    The element is a dropdown
    Run Keyword Unless    '${tag_name}' == 'select'    Log    The element is not a dropdown