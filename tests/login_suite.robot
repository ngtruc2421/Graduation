*** Settings ***
Resource    ../resources/pages/login_page.resource
Resource    ../configurations/config.resource
Test Teardown    Close Browser
*** Test Cases ***
Verify that user login to the system success
    [Tags]    High
    Access to ${URL_LOGIN}
    Input username    ${USER_NAME_RIGHT}
    Input pass    ${PASS_RIGHT}
    Click the Login button
    Navigate to the Home Page