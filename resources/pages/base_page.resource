*** Settings ***
Library    SeleniumLibrary
Resource    ../../configurations/config.resource
*** Keywords ***
Access to ${URL}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Close web
    Close Browser
Click on the web element
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${LOCATOR}
    Wait Until Element Is Enabled    ${LOCATOR}
    Click Element                    ${LOCATOR}
Click on ${LOCATOR} button
    Click on the web element    ${LOCATOR}
Input content 
    [Arguments]    ${TEXT}    ${LOCATOR}    
    Wait Until Element Is Visible    ${LOCATOR}      
    Clear Element Text               ${LOCATOR}
    Input Text    ${LOCATOR}    ${TEXT}

Display the web element
    [Arguments]    ${TEXT}    
    Page Should Contain              ${TEXT}

Get Page title
    ${page_title}=    Get Text    css:.page-title
    RETURN    ${page_title}
The ${pagename} page should be opened
    Wait Until Page Contains Element           css:.page-title
    ${current_Page_title}=    Get Page title     
    Should Contain    ${current_Page_title}    ${pagename}
Open ${pagename} page
    Access to ${URL_HOME}
    ${pagename_lower}=    Evaluate    "${pagename}".lower()
    ${url}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${pagename_lower}
    Go To    ${url}
    The ${pagename} page should be opened