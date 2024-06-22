*** Settings ***
Resource    ../keywords/common_keywords.resource

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
    [Arguments]    ${NAME}
    TRY
        ${ELEMENTS}=    Get Element Attribute    xpath=//label[text()="${NAME}"]     class
        ${STATUS}=    Run Keyword And Return Status    Should Contain    ${ELEMENTS}    required
        RETURN    ${STATUS} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify is required field    
    END    
  

The "${NAME}" field should be required
    [Documentation]       This keyword is used to verify The name field should be required from provided field name
    TRY
        ${IS_REQUIRED}=    Is reuired field    ${NAME}
        Should Be True    ${IS_REQUIRED}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${NAME} is required field     
    END 


The "${NAME}" field should not be required
    [Documentation]       This keyword is used to verify The field should not be required from provided field name
    TRY
        ${IS_REQUIRED}=    Is reuired field    ${NAME}
        Should Not Be True    ${IS_REQUIRED}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${NAME} is not required field     
    END 
    
The "${NAME}" field is type free text
    [Documentation]       This keyword is used to verify The name field is type free text from provided field name
    [Arguments]    ${TEXT}
    TRY
        ${locator}=    Get ID field by lable ${NAME} in register page    
        Input value for a field    ${TEXT}       ${LOCATOR}
        ${value}=    Get Value    ${LOCATOR}
        Should Be Equal    ${VALUE}    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${NAME} is type free text    
    END

    
The "${NAME}" field is type Dropdown 
    [Documentation]       This keyword is used to verify The name field is type Dropdown from provided field name
    TRY
        ${LOCATOR}=    Set Variable    ${ID_DAYOFBIRTH}${NAME}
        ${ELEMENT}=    Get WebElement    ${LOCATOR}    
        ${tag_name}=    Call Method    ${ELEMENT}    get_attribute    tagName
        Run Keyword If    '${tag_name}' == 'SELECT'    Log    The element is a dropdown
        Run Keyword Unless    '${tag_name}' == 'select'    Log    The element is not a dropdown
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify ${NAME} is type Dropdown     
        
    END
 
Get ID field by lable ${NAME} in register page
    [Documentation]       This keyword is used to Get ID field by lable in register page from provided lable name
    TRY
        ${XPATH}=    Set Variable    //label[text()='${NAME}']/following-sibling::div[contains(@class, 'col-md-9')]//input
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${ID}=    Call Method    ${ELEMENT}    get_attribute    id
        RETURN    id:${ID}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${NAME} in register page    
    END
   

Input the "${NAME}" field with value "${TEXT}" 
    [Documentation]       This keyword is used to Input the name field with value from provided field name and provided value
    TRY
        ${LOCATOR}=    Get ID field by lable ${NAME} in register page
        Input value for a field    ${TEXT}    ${LOCATOR}
        ${CURRENT_TEXT}=    Get Value    ${LOCATOR}
        Should Contain    ${CURRENT_TEXT}    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error when input    
    END


The error "${ERROR}" should not be display
    [Documentation]       This keyword is used to verify The error should not be display from provided error
    TRY
        Page Should Not Contain    ${ERROR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The error not contain in page     
    END
    

The error "${ERROR}" should be display
    [Documentation]       This keyword is used to verify The error should be display from provided error
    TRY
        Page Should Contain    ${ERROR}
    EXCEPT
        Log    The ${ERROR} not contain in page    
        Run Keyword And Continue On Failure    Fail    The ${ERROR} not contain in page     
    END

It should show warning message when user input the "${FIELD_NAME}" field with specific value 
    [Documentation]       This keyword is used to verify It should show warning message when user input the name field with specific value from provided field name
    [Arguments]      ${TEXT}      ${ERROR}
    TRY
        Input the "${FIELD_NAME}" field with value "${TEXT}"
        Click the Register button in the Register page
        The error "${ERROR}" should be display
    EXCEPT  
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process verify It should show warning message when user input the "${FIELD_NAME}" field with specific value ${text}        
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
        ${CURRENT_HOUR}=    Get Current Date    result_format=%H
        ${CURRENT_MINUTE}=  Get Current Date    result_format=%M
        ${CURRENT_SECOND}=  Get Current Date    result_format=%S
        ${UNIQUE_EMAIL}=    Set Variable    user_${CURRENT_HOUR}${CURRENT_MINUTE}${CURRENT_SECOND}@gmail.com
        RETURN    ${UNIQUE_EMAIL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process ctrate email     
    END 
    

Create Username
    [Documentation]       This keyword is used to Create Username
    TRY
        ${CURRENT_HOUR}=    Get Current Date    result_format=%H
        ${CURRENT_MINUTE}=  Get Current Date    result_format=%M
        ${CURRENT_SECOND}=  Get Current Date    result_format=%S
        ${UNIQUE_EMAIL}=    Set Variable    user_${CURRENT_HOUR}${CURRENT_MINUTE}${CURRENT_SECOND}
        RETURN    ${UNIQUE_EMAIL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process create username    
    END

Input on the "Email" field with value created automatic
    [Documentation]       This keyword is used to Input on the "Email" field with value created automatic
    TRY
        ${EMAIL}=    Create Email
        Input the "Email" field with value "${EMAIL}"
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process input on the "Email" field with value created automatic    
    END


Input on the "Username" field with value created automatic
    [Documentation]       This keyword is used to Input on the "Username" field with value created automatic
    TRY
        ${USERNAME}=    Create Username
        Input the "Username" field with value "${USERNAME}"
        Set Suite Variable    ${USERNAME_INPUT}    ${USERNAME}
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


Select "${VALUE}" from the list "${NAME}" dropdown
    [Documentation]       This keyword is used to Select value from the list dropdown from provided option and provied list
    TRY
        ${LOCATOR}=    Set Variable    ${ID_DAYOFBIRTH}${NAME}
        Select Option From Dropdown    ${LOCATOR}    ${VALUE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process select "${VALUE}" from the list "${NAME}" dropdown    
    END
   

Click the Continue button
    [Documentation]       This keyword is used to Click the Continue button
    TRY
        Click on button    ${CONTINUE_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process click the Continue button    
    END 
    