*** Settings ***
Library    SeleniumLibrary
Resource    base_page.resource
Library    SeleniumLibrary
Library    ../../.venv/Lib/site-packages/robot/libraries/XML.py
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

The "${name}" field is type free text
    [Arguments]    ${text}
    ${locator}=    Get Input ID By ${name}    
    Input content    ${text}       ${locator}
    ${value}=    Get Value    ${locator}
    Should Be Equal    ${value}    ${text}
    
The "${name}" field is type Dropdown 
    ${locator}=    Set Variable    ${id_dayofbirth}${name}
    ${element}=    Get WebElement    ${locator}    
    ${tag_name}=    Call Method    ${element}    get_attribute    tagName
    Run Keyword If    '${tag_name}' == 'select'    Log    The element is a dropdown
    Run Keyword Unless    '${tag_name}' == 'select'    Log    The element is not a dropdown

Check If Input Is Alphabetic
    [Arguments]    ${input}
    ${pattern}=    Set Variable    ^[A-Za-z]+$
    ${result}=    Run Keyword And Return Status    Should Match Regexp    ${input}    ${pattern}
    ${status}=    Run Keyword And Return Status    Should Be True    ${result}
    RETURN    ${status}    
Get Input ID By ${name}
    ${xpath}=    Set Variable    //label[text()='${name}']/following-sibling::div[contains(@class, 'col-md-9')]//input
    ${element}=    Get WebElement    ${xpath}
    ${id}=    Call Method    ${element}    get_attribute    id
    RETURN    ${id}
Input in "${name}" field with alphabetic characters ${text}
    ${locator}=    Get Input ID By ${name}
    Input content    ${text}    ${locator}
    ${is_alphabetic}=    Check If Input Is Alphabetic    ${text}
    Should Be True    ${is_alphabetic}

Input the "${name}" field with characters other than the alphabetic character ${text}
     ${locator}=    Get Input ID By ${name}
    Input content    ${text}    ${locator}
    Wait Until Element Is Visible    ${text}
    ${is_alphabetic}=    Check If Input Is Alphabetic    ${text}
    Should Not Be True    ${is_alphabetic}

The error "${error}" should not be display
    Page Should Not Contain    ${error}

The error "${error}" should be display
    Page Should Contain    ${error}

Input characters non-alphabetic characters in First name field
    [Arguments]    ${text}    ${error}
    TRY
        Input the "First name" field with characters other than the alphabetic character ${text}
        The error ${error} should be display
    EXCEPT    AssertionError
        Log    Input characters are not just letters    ERROR
        Fail    Input characters are not just letters
    END


Input characters non-alphabetic characters in Last name field
    [Arguments]    ${text}    ${error}
    TRY
        Input the "Last name" field with characters other than the alphabetic character ${text}
        The error ${error} should be display
    EXCEPT   AssertionError
        Log    Input characters are not just letters    ERROR
        Fail    Input characters are not just letters
    END