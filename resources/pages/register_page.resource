*** Settings ***
Resource    ../keywords/common_keywords.resource

*** Variables ***
${LOGIN_BTN_ELE}          css:.menubar-link[href="/login?returnUrl=%2F"]
${URL_SIGNIN}                /login
${PAGE_TITLE_ELE}            css:.page-title
${REGISTER_BTN_ELE}          id:register-button
${URL_REGISTER}              /register
${PAGENAME_TITLE}            Register
${id_dayofbirth}             id:DateOfBirth
${CONTINUE_BTN_ELE}          css:.register-continue-button

*** Keywords ***
Is reuired field
    [Arguments]    ${name}
    TRY
        ${elements}=    Get Element Attribute    xpath=//label[text()="${name}"]     class
        ${status}=    Run Keyword And Return Status    Should Contain    ${elements}    required
        RETURN    ${status} 
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process verify is required field    
    END    
  

The "${name}" field should be required
    TRY
        ${is_required}=    Is reuired field    ${name}
        Should Be True    ${is_required}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process verify ${name} is required field     
    END 


The "${name}" field should not be required
    TRY
        ${is_required}=    Is reuired field    ${name}
        Should Not Be True    ${is_required}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process verify ${name} is not required field     
    END 
    
The "${name}" field is type free text
    [Arguments]    ${text}
    TRY
        ${locator}=    Get ID field by lable ${name}    
        Input content    ${text}       ${locator}
        ${value}=    Get Value    ${locator}
        Should Be Equal    ${value}    ${text}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process verify ${name} is type free text    
    END

    
The "${name}" field is type Dropdown 
    TRY
        ${locator}=    Set Variable    ${id_dayofbirth}${name}
        ${element}=    Get WebElement    ${locator}    
        ${tag_name}=    Call Method    ${element}    get_attribute    tagName
        Run Keyword If    '${tag_name}' == 'select'    Log    The element is a dropdown
        Run Keyword Unless    '${tag_name}' == 'select'    Log    The element is not a dropdown
    EXCEPT   
        Run Keyword If Test Failed    Fail    There is a error happen in process verify ${name} is type Dropdown     
        
    END
 
Get ID field by lable ${name}
    TRY
        ${xpath}=    Set Variable    //label[text()='${name}']/following-sibling::div[contains(@class, 'col-md-9')]//input
        ${element}=    Get WebElement    ${xpath}
        ${id}=    Call Method    ${element}    get_attribute    id
        RETURN    id:${id}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process Get ID field by lable ${name}    
    END
   

Input the "${name}" field with value "${text}" 
    TRY
        ${locator}=    Get ID field by lable ${name}
        Input content    ${text}    ${locator}
        ${current_Text}=    Get Value    ${locator}
        Should Contain    ${current_Text}    ${text}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error when input    
    END


The error "${error}" should not be display
    TRY
        Page Should Not Contain    ${error}
    EXCEPT    
        Run Keyword If Test Failed    Fail    The error not contain in page     
    END
    

The error "${error}" should be display
    TRY
        Page Should Contain    ${error}
    EXCEPT
        Log    The ${error} not contain in page    
        Run Keyword If Test Failed    Fail    The ${error} not contain in page     
    END

It should show warning message when user input the "${field_name}" field with specific value 
    [Arguments]      ${text}      ${error}

    TRY
        Input the "${field_name}" field with value "${text}"
        Click the Register button in the Register page
        The error "${error}" should be display
    EXCEPT  
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process verify It should show warning message when user input the "${field_name}" field with specific value ${text}        
    END
Click the Register button in the Register page
    TRY
        Click on ${REGISTER_BTN_ELE} button
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error when click on button    
    END
    

Create Email
    TRY
        ${current_hour}=    Get Current Date    result_format=%H
        ${current_minute}=  Get Current Date    result_format=%M
        ${current_second}=  Get Current Date    result_format=%S
        ${unique_email}=    Set Variable    user_${current_hour}${current_minute}${current_second}@gmail.com
        RETURN    ${unique_email}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process ctrate email     
    END 
    

Create Username
    TRY
        ${current_hour}=    Get Current Date    result_format=%H
        ${current_minute}=  Get Current Date    result_format=%M
        ${current_second}=  Get Current Date    result_format=%S
        ${unique_email}=    Set Variable    user_${current_hour}${current_minute}${current_second}
        RETURN    ${unique_email}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process create username    
    END

Input on the "Email" field with value created automatic
    TRY
        ${email}=    Create Email
        Input the "Email" field with value "${email}"
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process input on the "Email" field with value created automatic    
    END


Input on the "Username" field with value created automatic
    TRY
        ${username}=    Create Username
        Input the "Username" field with value "${username}"
        Set Suite Variable    ${USERNAME}    ${username}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process input on the "Username" field with value created automatic     
    END

Is auto-login with username account
    TRY
        Wait Until Element Is Visible    css:a.menubar-link>span[title="${USERNAME}"]
        Page Should Contain Element    css:a.menubar-link>span[title="${USERNAME}"]
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process verify is auto-login with username account     
    END


Select "${value}" from the list "${name}" dropdown
    TRY
        ${locator}=    Set Variable    ${id_dayofbirth}${name}
        Select Option From Dropdown    ${locator}    ${value}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process select "${value}" from the list "${name}" dropdown    
    END
   

Click the Continue button
    TRY
        Click on ${CONTINUE_BTN_ELE} button
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process click the Continue button    
    END 
    