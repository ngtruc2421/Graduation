*** Settings ***
Resource    ./base_page.resource
Resource    ../../configurations/config.resource
*** Variables ***
${USERNAME_ELE}    css:#UsernameOrEmail
${PASSWORD_ELE}    css:#Password
${MESS_SUCCESS_ELE}    css:.h2
${MESS_FAIL_ELE}    css:.validation-summary-errors
${LOGIN_BTN_ELE}    css:.btn-login
${MESS_SUCCESS}    Welcome to our store.  
${MESS_FAIL}    Login was unsuccessful. Please correct the errors and try again.
${PASS_RIGHT}=         TranPhuongNgocTruc20042001
${PASS_WRONG}=         TranPhuongNgocTruc200420011
${USER_NAME_RIGHT}=    @trantruc2001
${USER_NAME_WRONG}=    @trantruc 
${LOGINPAGE_TITLE_ELE}    tag=h1
${LOGINPAGE_TITLE}    Sign In
${REMEMBERME_BTN_ELE}    id=RememberMe
${INFO_MENU_ELE}    css:span[title="TranTruc007"]
${LOGOUT_OPTION_ELE}    css:a[href="/logout"]
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
