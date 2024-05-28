*** Settings ***
Resource    ../keywords/common_keywords.resource
*** Variables ***
${USERNAME_ELE}    css:input[id="UsernameOrEmail"]
${PASSWORD_ELE}    css:#Password
${MESS_SUCCESS_ELE}    css:.h2
${MESS_FAIL_ELE}    css:.validation-summary-errors
${LOGIN_BTN_ELE}    css:.btn-login
${MESS_SUCCESS}    Welcome to our store.  
${MESS_FAIL}    Login was unsuccessful. Please correct the errors and try again.
${LOGINPAGE_TITLE_ELE}    tag=h1
${LOGINPAGE_TITLE}    Sign In
${REMEMBERME_BTN_ELE}    id=RememberMe
${FORGOTPASS_LINK_ELE}    css:a[href="/customer/passwordrecovery"]
${REGISTERLOGINPAGE_BTN_ELE}    css:.register-button
${URL_REGISTER}        register
*** Keywords ***
Input username
    [Arguments]    ${TEXT}
    Input content    ${TEXT}    ${USERNAME_ELE}
Input pass
    [Arguments]    ${TEXT}
    Input content    ${TEXT}    ${PASSWORD_ELE}  
Click the Login button
    Click on ${LOGIN_BTN_ELE} button
Display the Home Page
    Display the web element    ${MESS_SUCCESS}
Display the Login page
    Display the web element    Sign In
Unfocus the field
    Click Element    id=content
The data of the Username or email field is still
    [Arguments]    ${TEXT}    ${LOCATOR}
    Compare text    ${TEXT}    ${LOCATOR}
Click the "Remember me" option
    Click on the web element    ${REMEMBERME_BTN_ELE}
Compare text
    [Arguments]    ${TEXT}    ${LOCATOR}
    TRY
        ${tem}    Get Value    ${LOCATOR}
        Should Be Equal As Strings    ${TEXT}    ${tem.upper()}  
    EXCEPT    AssertionError
        Log    The text not be equal    ERROR
        Fail    The text not be equal
    END
The system saved the account information
    [Arguments]     ${USERNAME}    ${USERNAME_LOCATOR}    ${PASSWORD}    ${PASSWORD_LOCATOR}
    Compare text    ${USERNAME}    ${USERNAME_LOCATOR}  
    Compare text    ${PASSWORD}    ${PASSWORD_LOCATOR}
Click on the Forgot password link
    Click on the web element    ${FORGOTPASS_LINK_ELE}

Click the Register button
    TRY
        Click on ${REGISTERLOGINPAGE_BTN_ELE} button
        ${url}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${URL_REGISTER}
        Wait Until Location Contains    ${url}
        The Register page should be opened
    EXCEPT    
        Fail    There is a error happen in process Click the Register button
    END 
Access the Sign In page 
    Access to ${URL_LOGIN}
    Display the Login page
