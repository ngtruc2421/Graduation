*** Settings ***
Resource    ../keywords/common_keywords.resource
Library    Telnet

*** Variables ***
# ${LOGIN_BTN_ELE}              css:.menubar-link[href="/login?returnUrl=%2F"]
${URL_SIGNIN}                /login
${REGISTER_BTN_ELE}          id:register-button
${URL_REGISTER}              /register
${PAGENAME_TITLE}            Register
${ID_DAYOFBIRTH}             id:DateOfBirth
${CONTINUE_BTN_ELE}          css:.register-continue-button

*** Keywords ***
Open Register page
    [Documentation]       This keyword is used to Open Register page
    Open page    Register    ${PAGE_TITLE_ELE}
    The Register page should be opened
The Register page should be opened
    [Documentation]       This keyword is used to verify The Register page should be opened
    The page should be opened    Register    ${PAGE_TITLE_ELE}
Is reuired field
    [Documentation]       This keyword is used to verify Is reuired field from provided field name
    [Arguments]    ${name}
    TRY
        ${elements}=    Get Element Attribute    xpath=//label[text()="${name}"]     class
        ${status}=    Run Keyword And Return Status    Should Contain    ${elements}    required
        RETURN    ${status} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify is required field    
    END    
  

The "${name}" field should be required
    [Documentation]       This keyword is used to verify The name field should be required from provided field name
    TRY
        ${is_required}=    Is reuired field    ${name}
        Should Be True    ${is_required}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${name} is required field     
    END 


The "${name}" field should not be required
    [Documentation]       This keyword is used to verify The field should not be required from provided field name
    TRY
        ${is_required}=    Is reuired field    ${name}
        Should Not Be True    ${is_required}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${name} is not required field     
    END 
    
The "${name}" field is type free text
    [Documentation]       This keyword is used to verify The name field is type free text from provided field name
    [Arguments]    ${text}
    TRY
        ${locator}=    Get ID field by lable ${name} in register page    
        Input value for a field    ${text}       ${locator}
        ${value}=    Get Value    ${locator}
        Should Be Equal    ${value}    ${text}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${name} is type free text    
    END

    
The "${name}" field is type Dropdown 
    [Documentation]       This keyword is used to verify The name field is type Dropdown from provided field name
    TRY
        ${locator}=    Set Variable    ${ID_DAYOFBIRTH}${name}
        ${element}=    Get WebElement    ${locator}   
        ${tag_name}=    Call Method    ${element}    get_attribute    tagName
        Run Keyword If    '${tag_name}' == 'SELECT'    Log    The element is a dropdown
        Run Keyword Unless    '${tag_name}' == 'select'    Log    The element is not a dropdown
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${name} is type Dropdown     
        
    END
 
Get ID field by lable ${name} in register page
    [Documentation]       This keyword is used to Get ID field by lable in register page from provided lable name
    TRY
        ${xpath}=    Set Variable    //label[text()='${name}']/following-sibling::div[contains(@class, 'col-md-9')]//input
        ${element}=    Get WebElement    ${xpath}
        ${id}=    Call Method    ${element}    get_attribute    id
        RETURN    id:${id}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${name} in register page    
    END
   

Input the "${name}" field with value "${text}" 
    [Documentation]       This keyword is used to Input the name field with value from provided field name and provided value
    TRY
        ${locator}=    Get ID field by lable ${name} in register page
        Input value for a field    ${text}    ${locator}
        ${current_text}=    Get Value    ${locator}
        Should Contain    ${current_text}    ${text}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error when input    
    END


The error "${error}" should not be display
    [Documentation]       This keyword is used to verify The error should not be display from provided error
    TRY
        Page Should Not Contain    ${error}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The error not contain in page     
    END
    

The error "${error}" should be display
    [Documentation]       This keyword is used to verify The error should be display from provided error
    TRY
        Wait Until Page Contains    ${error}
        Page Should Contain    ${error}
    EXCEPT
        Log    The ${error} not contain in page    
        Run Keyword And Continue On Failure    Fail    The ${error} not contain in page     
    END

It should show warning message when user input the "${field_name}" field with specific value 
    [Documentation]       This keyword is used to verify It should show warning message when user input the name field with specific value from provided field name
    [Arguments]      ${text}      ${error}
    TRY
        Input the "${field_name}" field with value "${text}"
        Click the Register button in the Register page
        The error "${error}" should be display
        
    EXCEPT  
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process verify It should show warning message when user input the "${field_name}" field with specific value ${text}        
    END
Click the Register button in the Register page
    [Documentation]       This keyword is used to Click the Register button in the Register page
    TRY
        Click on button    ${REGISTER_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error when click on button    
    END
    

Create Email
    [Documentation]       This keyword is used to Create Email
    TRY
        ${current_hour}=    Get Current Date    result_format=%H
        ${current_minute}=  Get Current Date    result_format=%M
        ${current_second}=  Get Current Date    result_format=%S
        ${unique_email}=    Set Variable    user_${current_hour}${current_minute}${current_second}@gmail.com
        RETURN    ${unique_email}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process ctrate email     
    END 
    

Create Username
    [Documentation]       This keyword is used to Create Username
    TRY
        ${current_hour}=    Get Current Date    result_format=%H
        ${current_minute}=  Get Current Date    result_format=%M
        ${current_second}=  Get Current Date    result_format=%S
        ${unique_email}=    Set Variable    user_${current_hour}${current_minute}${current_second}
        RETURN    ${unique_email}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process create username    
    END

Input on the "Email" field with value created automatic
    [Documentation]       This keyword is used to Input on the "Email" field with value created automatic
    TRY
        ${email}=    Create Email
        Input the "Email" field with value "${email}"
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process input on the "email" field with value created automatic    
    END


Input on the "Username" field with value created automatic
    [Documentation]       This keyword is used to Input on the "Username" field with value created automatic
    TRY
        ${username}=    Create Username
        Input the "Username" field with value "${username}"
        Set Suite Variable    ${USERNAME_INPUT}    ${username}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process input on the "Username" field with value created automatic     
    END


The system should auto-login with username account
    [Documentation]       This keyword is used to The system should auto-login with username account
    TRY
        Wait Until Element Is Visible    css:a.menubar-link>span[title="${USERNAME_INPUT}"]
        Page Should Contain Element    css:a.menubar-link>span[title="${USERNAME_INPUT}"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify      
    END


Select "${value}" from the list "${name}" dropdown
    [Documentation]       This keyword is used to Select value from the list dropdown from provided option and provied list
    TRY
        ${locator}=    Set Variable    ${ID_DAYOFBIRTH}${name}
        Select Option From Dropdown    ${locator}   ${value}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process select "${value}" from the list "${name}" dropdown    
    END
   

Click the Continue button
    [Documentation]       This keyword is used to Click the Continue button
    TRY
        Click on button    ${CONTINUE_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process click the Continue button    
    END 
    