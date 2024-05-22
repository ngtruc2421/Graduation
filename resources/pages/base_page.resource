*** Settings ***
Resource    ../../configurations/config.resource
*** Keywords ***
Access to ${URL}
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
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
