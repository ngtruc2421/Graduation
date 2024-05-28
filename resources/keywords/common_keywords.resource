*** Settings ***
Resource    ../../configurations/config.resource

*** Keywords ***
Access to ${URL}
    TRY
        Open Browser    ${URL}    ${BROWSER}
        Maximize Browser Window
    EXCEPT   
        Run Keyword If Test Failed    Fail    There is a error happen in process access to ${URL}
    END

Click on the web element
    [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        Wait Until Element Is Enabled    ${LOCATOR}
        Click Element                    ${LOCATOR}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process click on the web element 
    END
    
Click on ${LOCATOR} button
    [Documentation]    This keyword to click on a WebElement by provided locator
        TRY
            Click on the web element    ${LOCATOR}
        EXCEPT    
            Run Keyword If Test Failed    Fail    There is a error happen in process click on ${LOCATOR} button 
        END
    
Input content 
    [Arguments]    ${TEXT}    ${LOCATOR} 
    TRY
        Wait Until Element Is Visible    ${LOCATOR}      
        Clear Element Text               ${LOCATOR}
        Input Text    ${LOCATOR}    ${TEXT}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process input content  
    END   
    

Display the web element
    [Arguments]    ${TEXT}
    TRY
        Page Should Contain              ${TEXT}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process Display the web element
    END    
    

Get Page title
    TRY
        ${page_title}=    Get Text    css:.page-title
        RETURN    ${page_title}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process Get Page title
    END

The ${pagename} page should be opened
    TRY
        Wait Until Page Contains Element           css:.page-title
        ${current_Page_title}=    Get Page title     
        Should Contain    ${current_Page_title}    ${pagename}
    EXCEPT    
        Run Keyword And Continue On Failure    FAIL   The page open failure
        
    END

Open ${pagename} page
    TRY
        Access to ${URL_HOME}
        ${pagename_lower}=    Evaluate    "${pagename}".lower()
        ${url}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${pagename_lower}
        Go To    ${url}
        The ${pagename} page should be opened
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process Open ${pagename} page    CONTINUE
    END


Select Option From Dropdown
    [Arguments]    ${dropdown_selector}    ${option_text}
    TRY
        Select From List By Label    ${dropdown_selector}    ${option_text}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process Select Option From Dropdown
    END
    