*** Settings ***
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/passwordRecovery_page.resource
Resource    ../resources/page_objects/header.resource
Test Setup    Access to ${URL_LOGIN}
Test Teardown    Close Browser
*** Variables ***
${PASS_RIGHT}=         TranPhuongNgocTruc20042001
${PASS_WRONG}=         TranPhuongNgocTruc200420011
${USER_NAME_RIGHT}=    @trantruc2001
${USER_NAME_WRONG}=    @trantruc
${EMAIL}=              tt1799917@gmail.com

*** Test Cases ***
BSG-T1 --- Verify that there is a page for users log in to the system
    [Tags]    High
    Display the Login page
BSG-T13 --- Verify that the users can use "Remember Me" option
    [Tags]    High
    Input username    ${USER_NAME_RIGHT}
    Input pass    ${PASS_RIGHT}
    Click the "Remember me" option
    Click the Login button
    Click on the account's name on the top at the corner
    Select the Log out option
    Click on the Log in option on the top of the corner
    The system saved the account information    ${USER_NAME_RIGHT}    ${USERNAME_ELE}
    ...    ${PASS_RIGHT}    ${PASSWORD_ELE}
BSG-T15 --- Verify that the system provided a "Forgot Password" link for users who need to reset their password
    [Tags]    High
    Click on the Forgot password link
    Input the email for the Email field    ${EMAIL}
    Click the Submit button
    Users reset password success
BSG-T17 --- Verify that the system will update the login's status when users login success
    [Tags]    High
    Input username    ${USER_NAME_RIGHT}
    Input pass    ${PASS_RIGHT}
    Click the Login button
    Show on the logged in user's name on the top right    ${USER_NAME_RIGHT}
BSG-T29 --- Verify that the system will display the error message when users input invalid email on the Forgot Password page
    [Tags]               Normal
    [Template]           Appear error message when users input invalid email
    User123@gmail.com    Email not found
    @User321gmail.com    'Your email address' is not a valid email address
    !!!@#####            'Your email address' is not a valid email address
    ${EMPTY}             'Your email address' should not be empty

BSG-T32 --- Verify that user can input data for the Username or email field
    [Tags]    High
    Input username    ${USER_NAME_RIGHT}
    Unfocus the field
    The data of the Username or email field is still    ${USER_NAME_RIGHT}    ${USERNAME_ELE}
BSG-T34 --- Verify that user can input data for the Password field
    [Tags]    High
    Input pass    ${PASS_RIGHT}
    Unfocus the field
    The data of the Username or email field is still    ${PASS_RIGHT}    ${PASSWORD_ELE}
