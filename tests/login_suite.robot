*** Settings ***
Resource    ../resources/pages/login_page.resource
Resource    ../configurations/config.resource
Test Setup    Access to ${URL_LOGIN}
Test Teardown    Close Browser
*** Test Cases ***
BSG-T1 --- Verify that there is a page for users log in to the system
    [Tags]    High
    Display the Login page
BSG-T32 --- Verify that user can input data for the Username or email field
    [Tags]    High
    Input username    ${USER_NAME_RIGHT}