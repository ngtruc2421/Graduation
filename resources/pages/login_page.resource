*** Settings ***
Resource    ../keywords/common_keywords.resource
*** Variables ***
${LOGINPAGE_TITLE_ELE}          tag=h1
${MESS_SUCCESS_ELE}             css:.h2
${URL_REGISTER}                 register
${REMEMBERME_BTN_ELE}           id=RememberMe
${PASSWORD_ELE}                 css:#Password
${LOGIN_BTN_ELE}                css:.btn-login
${REGISTERLOGINPAGE_BTN_ELE}    css:.register-button
${USERNAME_ELE}                 css:input[id="UsernameOrEmail"]
${FORGOTPASS_LINK_ELE}          css:a[href="/customer/passwordrecovery"]
*** Keywords ***
Input username
    [Arguments]    ${TEXT}
    Input value for a field    ${TEXT}    ${USERNAME_ELE}
Input pass
    [Arguments]    ${TEXT}
    Input value for a field    ${TEXT}    ${PASSWORD_ELE}  
Click the Login button
    Click on button     ${LOGIN_BTN_ELE}
Click the "Remember me" option
    Click on the web element    ${REMEMBERME_BTN_ELE}
Click on the Forgot password link
    Click on the web element    ${FORGOTPASS_LINK_ELE}
Click the Register button
    TRY
        Click on button    ${REGISTERLOGINPAGE_BTN_ELE}
        ${url}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${URL_REGISTER}
        Wait Until Location Contains    ${url}
        The page should be opened    Register
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Click the Register button
    END 

Log in success
    [Arguments]    ${EXPECTED}
    Display the web element    ${EXPECTED}
Display the Login page
    [Arguments]    ${EXPECTED}
    Display the web element    ${EXPECTED}
Unfocus the field
    Click Element    id=content
The data of the Username or email field is still
    [Arguments]    ${TEXT}    ${LOCATOR}
    TRY
        ${tem}    Get Value    ${LOCATOR}
        Should Be Equal As Strings    ${TEXT}    ${tem}  
    EXCEPT    AssertionError
        Log    The text not be equal    ERROR
        Fail    The text not be equal
    END
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

Appear the error message when users input incorrect value for the Username or email field and Password field
    [Arguments]    ${USERNAME_EMAIL}    ${PASS}    ${MESS}
    Input username    ${USERNAME_EMAIL}
    Input pass    ${PASS}
    Click the Login button
    Display the web element    ${MESS}

# Click on the Forgot password link
#     Click on the web element    ${FORGOTPASS_LINK_ELE}
Access the Sign In page 
    Access to url    ${URL_LOGIN}
    Display the Login page    Sign In


