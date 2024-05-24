*** Settings ***
Resource    base_page.resource
Library    SeleniumLibrary
*** Variables ***
${LOGIN_BUTTON_ELE}          css:.menubar-link[href="/login?returnUrl=%2F"]
${URL_SIGNIN}                /login
${PAGE_TITLE_ELE}            css:.page-title
${REGISTER_BUTTON_ELE}       css:.btn.register-button[href="/register?returnUrl=%2f"]
${URL_REGISTER}              /register
${PAGENAME_TITLE}            Register
${id_dayofbirth}             id:DateOfBirth

*** Keywords ***
Is reuired field    
    [Arguments]    ${name}
    ${elements}=    Get Element Attribute    xpath=//label[text()="${name}"]     class
    ${status}=    Run Keyword And Return Status    Should Contain    ${elements}    required
    RETURN    ${status}   

The "${name}" field should be required 
    ${is_required}=    Is reuired field    ${name}
    Should Be True    ${is_required}

The "${name}" field should not be required 
    ${is_required}=    Is reuired field    ${name}
    Should Not Be True    ${is_required}

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

