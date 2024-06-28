*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pages/paymentInformation_page.resource
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
        Run Keyword And Continue On Failure    Fail    Couldn't access to ${URL}
    END

Navigate to URL 
    [Arguments]    ${URL}  
    Go To    ${URL}

Scroll to 
    [Documentation]    This keyword to scroll the visual to the inputed value
    [Arguments]    ${VALUE}
    TRY
        Execute Javascript    window.scrollBy(0,${VALUE})
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't scroll to the provided value
    END
Close the web page
    [Documentation]    This keyword will close the opened browser
    TRY
        Close Browser
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't close the opened browser
    END
Click on the web element
    [Documentation]    This keyword to click on the any web elememt by provided locator
    [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        Wait Until Element Is Enabled    ${LOCATOR}
        Click Element                    ${LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the element 
    END
    
Click on button
    [Documentation]    This keyword to click on a button by provided locator
    [Arguments]    ${LOCATOR}
        TRY
            Click on the web element    ${LOCATOR}
        EXCEPT    
            Run Keyword And Continue On Failure    Fail    Couldn't click on ${LOCATOR} button 
        END
    
Input value for a field
    [Documentation]    This keyword input a value for a field by provided value and locator 
    [Arguments]    ${TEXT}    ${LOCATOR} 
    TRY
        Wait Until Element Is Visible    ${LOCATOR}      
        Clear Element Text               ${LOCATOR}
        Input Text    ${LOCATOR}    ${TEXT}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't input value for the input field  
    END   
    

Check the text elememt
    [Documentation]    This keyword checks a web text element that is display on the webpage
    [Arguments]    ${TEXT}
    TRY
        Wait Until Page Contains    ${TEXT}
        Page Should Contain              ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure  Fail    The text isn't display on the page
    END    

Get Page title
    [Documentation]    This keyword gets text of a element by provided locator
    [Arguments]    ${LOCATOR}
    TRY
        ${PAGE_TITLE}=    Get Text     ${LOCATOR}   
        RETURN    ${PAGE_TITLE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't get the text at this locator
    END

The page should be opened
    [Documentation]    This keyword verifies a webpage that displays
    [Arguments]    ${PAGENAME}    ${LOCATOR}
    TRY
        Wait Until Page Contains Element           ${LOCATOR}
        ${CURRENT_PAGE_TITLE}=    Get Page title    ${LOCATOR}     
        Should Contain    ${CURRENT_PAGE_TITLE}    ${PAGENAME}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail   Couldn't open the page
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
        Run Keyword And Continue On Failure   Fail     Couldn't open ${pagename} page    CONTINUE
    END


Select Option From Dropdown
    [Documentation]    This keyword select a option from the dropdown by provided locator and option
    [Arguments]    ${DROPDOWN_LOCATOR}    ${OPTION_TEXT}
    TRY
        Select From List By Label    ${DROPDOWN_LOCATOR}    ${OPTION_TEXT}
        ${SELECTED_VALUE}=    Wait and get element text    ${SELECT_OPTION_ELE}
        WHILE    "${SELECTED_VALUE}" != "${OPTION_TEXT}"
            Wait Until Element Contains    ${SELECT_OPTION_ELE}    ${OPTION_TEXT}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't select the ${OPTION_TEXT} option
    END
Scroll Down in Firefox
    ${TOTAL_HEIGHT}=    Execute JavaScript    return document.documentElement.scrollHeight
    ${VIEWPORT_HEIGHT}=    Execute JavaScript    return window.innerHeight
    ${CURRENT_SCROLL}=    Execute JavaScript    return window.scrollY

    ${SCROLL_AMOUNT}=    Set Variable    700
    ${TARGET_SCROLL}=    Evaluate    ${CURRENT_SCROLL} + ${SCROLL_AMOUNT}
    
    Run Keyword If    ${TARGET_SCROLL} > ${TOTAL_HEIGHT} - ${VIEWPORT_HEIGHT}    ${TARGET_SCROLL}=    Set Variable    ${TOTAL_HEIGHT} - ${VIEWPORT_HEIGHT}
    
    Execute JavaScript    window.scrollTo({ top: ${TARGET_SCROLL}, behavior: 'smooth' })
Hover Over Elenment
    [Documentation]    This keyword is used to move the mouse to a provided locator
    [Arguments]       ${ELEMENT}    ${COORDINATES}=500
    TRY
        IF    ("${BROWSER}"=="Firefox")
            Scroll Down in Firefox
            
        ELSE
            Scroll Element Into View    ${ELEMENT}
            Execute JavaScript    window.scrollBy(0, ${COORDINATES})
        END
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    ${ELEMENT}
        IF    "${status}"=="False"
            Run Keyword And Continue On Failure    Fail    No look for element
        ELSE
            Sleep    2s           
            Mouse Over    ${ELEMENT}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't hover the ${ELEMENT} element
    END
   
Wait until page contain element
    [Documentation]    This keyword is used to wait and check page contain provided locator
    [Arguments]    ${ELEMENT}
    TRY
        Wait Until Element Is Visible    ${ELEMENT}
        Page Should Contain Element    ${ELEMENT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't looking for the element
    END   

Get list WebElements
    [Documentation]    This keyword is used to get list web elements from the provided locator
    [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        @{ELEMENTS}=    Get WebElements    ${LOCATOR}
        RETURN     @{ELEMENTS}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't get list web elements
    END

Wait and get element text
    [Documentation]    This keyword is used to wait and get element text from provided locator
    [Arguments]     ${ELEMENT}
    TRY
        Wait Until Element Is Visible    ${ELEMENT}    timeout=10s    
        ${TEXT}=    Get Text    ${ELEMENT}
        RETURN    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't get element text
    END

Compare two Numbers
    [Documentation]    This keyword is used to compare two numbers from provided locator
    [Arguments]     ${NUM1}    ${NUM2} 
    TRY
        ${NUMBER1}=    Convert To Number    ${NUM1}
        ${NUMBER2}=    Convert To Number    ${NUM2}
        Should Be Equal As Numbers    ${NUMBER1}    ${NUMBER2}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The two numbers are not equal
    END
   
Wait for page loaded
    [Documentation]       This keyword is used to Wait for page loaded from provided locator
    [Arguments]    ${LOCATOR}
    TRY
        Wait Until Element Is Visible    ${LOCATOR}
        Wait Until Element Is Not Visible    ${LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Wait for page loaded
    END
Clear cookies 
    [Documentation]       This keyword is used to clear all cookies of the openning browser
    TRY
        Delete All Cookies
        Delete All Sessions
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't clear all cookies of browser
    END

Wait until load object 
    [Documentation]       This keyword is used to Wait until load object from provided locator
    [Arguments]    ${LOCATOR}
    Wait Until Element Is Visible    ${LOCATOR}
    Wait Until Element Is Not Visible    ${LOCATOR}