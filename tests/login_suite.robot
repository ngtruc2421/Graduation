*** Settings ***
Resource    ../resources/pages/login_page.resource
Resource    ../configurations/config.resource
Resource    ../resources/page_objects/header.resource
Test Setup    Access to ${URL_LOGIN}
Test Teardown    Close Browser
*** Test Cases ***
BSG-T1 --- Verify that there is a page for users log in to the system
    [Tags]    High
    Display the Login page
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
    