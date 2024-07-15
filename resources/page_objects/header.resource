*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../pages/login_page.resource

*** Variables ***
${INFO_MENU_ELE}                    id=menubar-my-account
${LOGIN_OPTION_ELE}                 id=menubar-my-account
${PROFILE_ELE}                      css:a[href="/customer/info"]
${MENUBAR_ELE}                      css:a.menubar-link
${MENUBARSPAN_ELE}                  css:a.menubar-link>span
${LISTOPTIONACCOUNT_ELE}            css:.dropdown-menu.dropdown-menu-right.show a.dropdown-item 
${SHOPBARCART_OPTION_ELE}           id:shopbar-cart
*** Keywords ***
Click on the account's name on the top at the corner
    [Documentation]       This keyword is used to Click on the account's name on the top at the corner
    TRY
        Click on the web element    ${INFO_MENU_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the account's name on the top at the corner
    END

Select the Log out option
    [Documentation]       This keyword is used to Select the Log out option
    TRY
        Click on the "Log out" in top right
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "Log out" in top right
    END

Click on the Log in option on the top of the corner
    [Documentation]       This keyword is used to Click on the Log in option on the top of the corner
    TRY
        ${result}    Get Text    ${LOGIN_OPTION_ELE}
        Should Be Equal As Strings    ${result}    LOG IN
        Click on the web element    ${LOGIN_OPTION_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the Log in option on the top of the corner
    END

Select the Shopping Basket option on the header
    [Documentation]       This keyword is used to Select the Shopping Basket option on the header
    TRY
        Click on the web element    ${SHOPBARCART_OPTION_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Select the Shopping Basket option on the header
    END

Show on the logged in user's name on the top right 
    [Documentation]       This keyword is used to Show on the logged in user's name on the top right 
    [Arguments]    ${username}
    TRY
        ${locator}    Set Variable    css:a.menubar-link > span[title="${username}"]
        ${tem}    Get Text    ${locator}
        Should Be Equal As Strings    ${username.upper()}    ${tem.upper()}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Show on the logged in user's name on the top right 
    END   

    
Check user login
    [Documentation]       This keyword is used to Check user login
    TRY
        @{list}=    Get WebElements    ${MENUBAR_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list}
            @{list_title}=    Get WebElements    ${MENUBARSPAN_ELE} 
            ${title_ele}=    Get From List    ${list_title}    ${index}
            ${title}=    Get Text    ${title_ele}
            IF    "${title}" == "LOG IN"
            RETURN    ${True}
        END
        ${index}=    Evaluate    ${index} + 1
        END
            RETURN    ${False}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Check user login
        
    END
    
Click on the "${option}" in top right
    [Documentation]       This keyword is used to Click on the "${option}" in top right from provided option
    TRY
        ${list_option}=    Get list WebElements    ${LISTOPTIONACCOUNT_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_option}
            ${option_ele}=    Get From List    ${list_option}    ${index}    
            ${option_name}=    Wait and get element text    ${option_ele}
            IF    ("${option_name}"== "${option}")
                Click on the web element    ${option_ele}
                RETURN
            END
            ${index}=    Evaluate    ${index}+1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the "${option}" in top right
    END
