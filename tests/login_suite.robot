*** Settings ***
Resource         ../resources/pages/login_page.resource
Resource         ../resources/pages/passwordRecovery_page.resource
Resource         ../resources/page_objects/header.resource
Resource    ../resources/keywords/utils.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup
Test Setup          Test case Setup
Test Teardown       Test case Teardown
Documentation    This suite cover all test cases related to the user story [BSG-3] - User Login
...            - As a registered user
...            - I want to log into my account
...            - So that I can access my personalized dashboard and features

*** Variables ***
${USER_NAME_WRONG}=          @trantruc
${PASS_WHITESPACE}           @us   er123
${USER_NAME_RIGHT}=          @trantruc2001
${EMAIL_NOTREGISTER}         user001@gmail.com
${EMAIL_REGISTERED}=         tt1799917@gmail.com
${PASS_RIGHT}=               TranPhuongNgocTruc20042001
${PASS_WRONG}=               TranPhuongNgocTruc200420011
${EMAIL_INCORRECT_MESS}      The email you entered is incorrect
${PASS_INCORRECT_MESS}       The password you entered is incorrect    
${EMPTY_MESS}                Email and Password are required fields
${EMAIL_NOTREGISTER_MESS}    The email address you entered is not associated with an account
${MESS_FAIL}                 Login was unsuccessful. Please correct the errors and try again.
${MESS_SUCCESS}              Welcome to our store.  
${LOGINPAGE_TITLE}           Sign In

*** Test Cases ***
BSG-T1 --- Verify that there is a page for users log in to the system
    [Tags]    High
    Open the Login page
    It should display the Login page    ${LOGINPAGE_TITLE}
BSG-T3 --- Verify that the system will display the error message when users input incorrect value for the Username or email field and Password field
    [Tags]    High
    [Template]    It should appear the error message when users input incorrect value for the Username or email field and Password field
    ${EMAIL_NOTREGISTER}    ${PASS_RIGHT}         ${EMAIL_NOTREGISTER_MESS}
    @user123.gmail.com      ${PASS_RIGHT}         ${EMAIL_INCORRECT_MESS}
    11111.com               ${PASS_RIGHT}         ${EMAIL_INCORRECT_MESS}
    @!!!#@gmail.com         ${PASS_RIGHT}         ${EMAIL_INCORRECT_MESS}
    ${USER_NAME_WRONG}      ${PASS_RIGHT}         ${EMAIL_INCORRECT_MESS}
    ${EMPTY}                ${PASS_RIGHT}         ${EMPTY_MESS}
    ${EMAIL_REGISTERED}     @@@!!!###             ${PASS_INCORRECT_MESS}
    ${EMAIL_REGISTERED}     1234567               ${PASS_INCORRECT_MESS}
    ${EMAIL_REGISTERED}     ${PASS_WHITESPACE}    ${PASS_INCORRECT_MESS}
    ${EMAIL_REGISTERED}     ${EMPTY}              ${EMPTY_MESS}
    ${EMPTY}                ${EMPTY}              ${EMPTY_MESS}
    

BSG-T13 --- Verify that the users can use "Remember Me" option
    [Tags]    High
    Open the Login page
    Input username    ${USER_NAME_RIGHT}
    Input pass    ${PASS_RIGHT}
    Click the "Remember me" option
    Click the Login button
    Click on the account's name on the top at the corner
    Select the Log out option
    Click on the Log in option on the top of the corner
    The system should save the account information    ${USER_NAME_RIGHT}    ${USERNAME_ELE}
    ...    ${PASS_RIGHT}    ${PASSWORD_ELE}
BSG-T15 --- Verify that the system provided a "Forgot Password" link for users who need to reset their password
    [Tags]    High
    Open the Login page
    Click on the Forgot password link
    Input the email for the Email field    ${EMAIL_REGISTERED}
    Click the Submit button
    Users should reset password success
BSG-T17 --- Verify that the system will update the login's status when users login success
    [Tags]    High    Smoke
    Open the Login page
    Input username    ${USER_NAME_RIGHT}
    Input pass    ${PASS_RIGHT}
    Click the Login button
    Show on the logged in user's name on the top right    ${USER_NAME_RIGHT}
BSG-T29 --- Verify that the system will display the error message when users input invalid email on the Forgot Password page
    [Tags]               Medium
    [Template]           It should appear error message when users input invalid email
    User123@gmail.com    Email not found
    @User321gmail.com    'Your email address' is not a valid email address
    !!!@#####            'Your email address' is not a valid email address
    ${EMPTY}             'Your email address' should not be empty

BSG-T32 --- Verify that user can input data for the Username or email field
    [Tags]    High    Smoke
    Open the Login page
    Input username    ${USER_NAME_RIGHT}
    Unfocus the field
    It should input the data    ${USER_NAME_RIGHT}    ${USERNAME_ELE}
BSG-T34 --- Verify that user can input data for the Password field
    [Tags]    High    Smoke
    Open the Login page
    Input pass    ${PASS_RIGHT}
    Unfocus the field
    It should input the data    ${PASS_RIGHT}    ${PASSWORD_ELE}
BSG-T49 --- Verify that users can login success into the system
    [Tags]    High    Smoke
    Open the Login page
    Input username            ${USER_NAME_RIGHT}
    Input pass                ${PASS_RIGHT}
    Click the Login button
    It should log in success            ${MESS_SUCCESS}

*** Keywords ***
Test case Setup
    Set test case start time
Test case Teardown
    Update test case result to Zephyr Scale
    Close the web page

Test Suite Setup
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup