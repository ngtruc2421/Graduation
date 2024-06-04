*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/login_page.resource

*** Variables ***
${INFO_MENU_ELE}    id=menubar-my-account
${LOGOUT_OPTION_ELE}    css:a[href="/logout"]
${LOGIN_OPTION_ELE}    id=menubar-my-account
${PROFILE_ELE}    css:a[href="/customer/info"]
${MENUBAR_ELE}        css:a.menubar-link
${MENUBARSPAN_ELE}        css:a.menubar-link>span
*** Keywords ***
Click on the account's name on the top at the corner
    Click on the web element    ${INFO_MENU_ELE}
Select the Log out option
    Click on the web element    ${LOGOUT_OPTION_ELE}
Click on the Log in option on the top of the corner
    ${result}    Get Text    ${LOGIN_OPTION_ELE}
    Should Be Equal As Strings    ${result}    LOG IN
    Click on the web element    ${LOGIN_OPTION_ELE}
Show on the logged in user's name on the top right    
    [Arguments]    ${USERNAME}
    ${LOCATOR}    Set Variable    css:a.menubar-link > span[title="${USERNAME}"]
    ${tem}    Get Text    ${LOCATOR}
    Should Be Equal As Strings    ${USERNAME.upper()}    ${tem.upper()}
    
Check user login
    @{LIST}=    Get WebElements    ${MENUBAR_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST}
        @{LIST_TITLE}=    Get WebElements    ${MENUBARSPAN_ELE} 
        ${TITLE_ELE}=    Get From List    ${LIST_TITLE}    ${INDEX}
        ${TITLE}=    Get Text    ${TITLE_ELE}
        IF    "${TITLE}" == "LOG IN"
            RETURN    ${True}
        END
        ${INDEX}=    Evaluate    ${INDEX} + 1
    END
        RETURN    ${False}