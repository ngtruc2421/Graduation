*** Settings ***
Resource    ../../configurations/config.resource
*** Variables ***
${PAGE_TITLE_ELE}            css:.page-title
*** Keywords ***
Access to url
    [Documentation]    This keyword to access to a url address by chrome browser
    [Arguments]    ${URL}    ${BROW}=${BROWSER}
    TRY
        Open Browser    ${URL}    ${BROW}
        Maximize Browser Window
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    There is a error happen in process access to ${URL}
    END
Close the web page
    TRY
        Close Browser
    EXCEPT
        Run Keyword And Continue On Failure    Fail
    END
Click on the web element
    [Documentation]    This keyword to click on the any web elememt by provided locator
    [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        Wait Until Element Is Enabled    ${LOCATOR}
        Click Element                    ${LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process click on the web element 
    END
    
Click on button
    [Documentation]    This keyword to click on a button by provided locator
    [Arguments]    ${LOCATOR}
        TRY
            Click on the web element    ${LOCATOR}
        EXCEPT    
            Run Keyword And Continue On Failure    Fail    There is a error happen in process click on ${LOCATOR} button 
        END
    
Input value for a field
    [Documentation]    This keyword input a value for a field by provided value and locator 
    [Arguments]    ${TEXT}    ${LOCATOR} 
    TRY
        Wait Until Element Is Visible    ${LOCATOR}      
        Clear Element Text               ${LOCATOR}
        Input Text    ${LOCATOR}    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process input content  
    END   
    

Display the web element
    [Documentation]    This keyword checks a web element that is display on the webpage
    [Arguments]    ${TEXT}
    TRY
        Page Should Contain              ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure  Fail    There is a error happen in process display the web element
    END    
Display Element
    [Arguments]     ${LOCATOR}
    TRY
    Wait Until Element Is Visible    ${LOCATOR}
    Page Should Contain Element    ${LOCATOR} 
    EXCEPT
    Run Keyword And Continue On Failure    Log    There is a issue on the display element progress
    END  

Get Page title
    [Arguments]    ${LOCATOR}
    [Documentation]    This keyword gets text of a element by provided locator
    TRY
        ${PAGE_TITLE}=    Get Text     ${LOCATOR}   
        RETURN    ${PAGE_TITLE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get Page title
    END

The page should be opened
    [Documentation]    This keyword verifies a webpage that displays
    [Arguments]    ${PAGENAME}    ${LOCATOR}
    TRY
        Wait Until Page Contains Element           ${LOCATOR}
        ${CURRENT_PAGE_TITLE}=    Get Page title    ${LOCATOR}     
        Should Contain    ${CURRENT_PAGE_TITLE}    ${PAGENAME}
    EXCEPT    
        Run Keyword And Continue On Failure    FAIL   The page open failure
        
    END

Open page
    [Documentation]    This keyword open a webpage
    [Arguments]    ${PAGENAME}    ${LOCATOR}
    TRY
        Access to url    ${URL_HOME}
        ${PAGENAME_LOWER}=    Evaluate    "${PAGENAME}".lower()
        ${URL}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${PAGENAME_LOWER}
        Go To    ${URL}
        The page should be opened    ${PAGENAME}    ${LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process Open ${pagename} page    CONTINUE
    END


Select Option From Dropdown
    [Documentation]    This keyword select a option from the dropdown by provided locator and option
    [Arguments]    ${DROPDOWN_LOCATOR}    ${OPTION_TEXT}
    TRY
        Select From List By Label    ${DROPDOWN_LOCATOR}    ${OPTION_TEXT}
    EXCEPT    
        Run Keyword If Test Failed    Fail    There is a error happen in process Select Option From Dropdown
    END

Hover Over Elenment
    [Documentation]    This keyword is used to move the mouse to a provided locator
    [Arguments]       ${ELEMENT}
    Scroll Element Into View    ${ELEMENT}
    Execute JavaScript    window.scrollBy(0, 500)
    ${status}=    Run Keyword And Return Status    Element Should Be Visible    ${ELEMENT}
    IF    "${status}"=="False"
        Run Keyword And Continue On Failure    Fail    No look for element
    ELSE
        Mouse Over    ${ELEMENT}
    END
        
Wait until page contain element
    [Documentation]    This keyword is used to wait and check page contain provided locator
    [Arguments]    ${ELEMENT}
    TRY
        Wait Until Element Is Visible    ${ELEMENT}
        Page Should Contain Element    ${ELEMENT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    No look for element
    END   

Get list WebElements
    [Documentation]    This keyword is used to get list WebElements from the provided locator
     [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        @{ELEMENTS}=    Get WebElements    ${LOCATOR}
        RETURN     @{ELEMENTS}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Get list WebElements
    END

Wait and get element text
    [Documentation]    This keyword is used to wait and get element text from provided locator
    [Arguments]     ${ELEMENT}
    TRY
        Wait Until Element Is Visible    ${ELEMENT}    timeout=5s
        ${TEXT}=    Get Text    ${ELEMENT}
        RETURN    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Wait and get element text
    END

Compare two Numbers
    [Documentation]    This keyword is used to Compare two Numbers from provided locator
    [Arguments]     ${NUM1}    ${NUM2} 
    TRY
        ${NUMBER1}=    Convert To Number    ${NUM1}
        ${NUMBER2}=    Convert To Number    ${NUM2}
        Should Be Equal As Numbers    ${NUMBER1}    ${NUMBER2}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Compare two Numbers
    END
   
