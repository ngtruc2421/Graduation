*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/login_page.resource

*** Variables ***
${INFO_MENU_ELE}                id=menubar-my-account
${LOGIN_OPTION_ELE}             id=menubar-my-account
${PROFILE_ELE}                  css:a[href="/customer/info"]
${MENUBAR_ELE}                  css:a.menubar-link
${MENUBARSPAN_ELE}              css:a.menubar-link>span
${LISTOPTIONACCOUNT_ELE}        css:.dropdown-menu.dropdown-menu-right.show a.dropdown-item 
*** Keywords ***
Click on the account's name on the top at the corner
    Click on the web element    ${INFO_MENU_ELE}
Select the Log out option
    Click on the "Log out" in top right
Click on the Log in option on the top of the corner
    ${result}    Get Text    ${LOGIN_OPTION_ELE}
    Should Be Equal As Strings    ${result}    LOG IN
    Click on the web element    ${LOGIN_OPTION_ELE}
Select the Shopping Basket option on the header
    Click on the web element    ${SHOPBARCART_OPTION_ELE}
Show on the logged in user's name on the top right    
    [Arguments]    ${USERNAME}
    ${LOCATOR}    Set Variable    css:a.menubar-link > span[title="${USERNAME}"]
    ${tem}    Get Text    ${LOCATOR}
    Should Be Equal As Strings    ${USERNAME.upper()}    ${tem.upper()}
    
Check user login
    TRY
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
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Check user login
        
    END
    
Click on the "${OPTION}" in top right
    ${LIST_OPTION}=    Get list WebElements    ${LISTOPTIONACCOUNT_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST_OPTION}
        ${OPTION_ELE}=    Get From List    ${LIST_OPTION}    ${INDEX}    
        ${OPTION_NAME}=    Wait and get element text    ${OPTION_ELE}
        IF    ("${OPTION_NAME}"== "${OPTION}")
            Click on the web element    ${OPTION_ELE}
            RETURN
        END
        ${INDEX}=    Evaluate    ${INDEX}+1
    END