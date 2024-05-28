*** Settings ***
Resource    ../../configurations/config.resource

*** Keywords ***
Access to url
    [Documentation]    This keyword to access to a url address by chrome browser
    [Arguments]    ${URL}    ${BROW}=${BROWSER}
    TRY
        Open Browser    ${URL}    ${BROW}
        Maximize Browser Window
    EXCEPT   
        Fail    There is a error happen in process access to ${URL}
    END

Click on the web element
    [Documentation]    This keyword to click on the any web elememt by provided locator
    [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        Wait Until Element Is Enabled    ${LOCATOR}
        Click Element                    ${LOCATOR}
    EXCEPT    
        Fail    There is a error happen in process click on the web element 
    END
    
Click on button
    [Documentation]    This keyword to click on a button by provided locator
    [Arguments]    ${LOCATOR}
        TRY
            Click on the web element    ${LOCATOR}
        EXCEPT    
            Fail    There is a error happen in process click on ${LOCATOR} button 
        END
    
Input value for a field
    [Documentation]    This keyword input a value for a field by provided value and locator 
    [Arguments]    ${TEXT}    ${LOCATOR} 
    TRY
        Wait Until Element Is Visible    ${LOCATOR}      
        Clear Element Text               ${LOCATOR}
        Input Text    ${LOCATOR}    ${TEXT}
    EXCEPT    
        Fail    There is a error happen in process input content  
    END   
    

Display the web element
    [Documentation]    This keyword checks a web element that is display on the webpage
    [Arguments]    ${TEXT}
    TRY
        Page Should Contain              ${TEXT}
    EXCEPT    
        Fail    There is a error happen in process Display the web element
    END    
    

Get Page title
    [Documentation]    This keyword gets text of a element by provided locator
    TRY
        ${PAGE_TITLE}=    Get Text    css:.page-title
        RETURN    ${PAGE_TITLE}
    EXCEPT    
        Fail    There is a error happen in process Get Page title
    END

The page should be opened
    [Documentation]    This keyword verifies a webpage that displays
    [Arguments]    ${PAGENAME}
    TRY
        Wait Until Page Contains Element           css:.page-title
        ${CURRENT_PAGE_TITLE}=    Get Page title     
        Should Contain    ${CURRENT_PAGE_TITLE}    ${PAGENAME}
    EXCEPT    
        Fail    The page open failure
        
    END

Open page
    [Documentation]    This keyword open a webpage
    [Arguments]    ${PAGENAME}
    TRY
        Access to url    ${URL_HOME}
        ${PAGENAME_LOWER}=    Evaluate    "${PAGENAME}".lower()
        ${URL}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${PAGENAME_LOWER}
        Go To    ${URL}
        The ${PAGENAME} page should be opened
    EXCEPT    
        Fail    There is a error happen in process Open ${PAGENAME} page
    END


Select Option From Dropdown
    [Documentation]    This keyword select a option from the dropdown by provided locator and option
    [Arguments]    ${DROPDOWN_LOCATOR}    ${OPTION_TEXT}
    TRY
        Select From List By Label    ${DROPDOWN_LOCATOR}    ${OPTION_TEXT}
    EXCEPT    
        Fail    There is a error happen in process Select Option From Dropdown
    END

    