*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pages/base_page.resource
*** Variables ***
${INFO_MENU_ELE}    id=menubar-my-account
${LOGOUT_OPTION_ELE}    css:a[href="/logout"]
${LOGIN_OPTION_ELE}    id=menubar-my-account
*** Keywords ***
Click on the account's name on the top at the corner
    Click on the web element    ${INFO_MENU_ELE}
Select the Log out option
    Click on the web element    ${LOGOUT_OPTION_ELE}
Click on the Log in option on the top of the corner
    ${result}    Get Text    ${LOGIN_OPTION_ELE}
    Should Be Equal As Strings    ${result}    LOG IN
    Click on the web element    ${LOGIN_OPTION_ELE}
    