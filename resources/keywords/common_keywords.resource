*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pages/paymentInformation_page.resource
*** Variables ***
${PAGE_TITLE_ELE}            css:.page-title
*** Keywords ***
Access to url
    [Documentation]    This keyword to access to a url address by chrome browser
    [Arguments]    ${url}    ${brow}=${BROWSER}
    TRY
        Open Browser    ${url}    ${brow}
        Maximize Browser Window
    EXCEPT   
        Run Keyword And Continue On Failure    Fail    Couldn't access to ${url}
    END

Navigate to URL 
    [Arguments]    ${url}  
    Go To    ${url}

Scroll to 
    [Documentation]    This keyword to scroll the visual to the inputed value
    [Arguments]    ${value}
    TRY
        Execute Javascript    window.scrollBy(0,${value})
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
    [Arguments]    ${locator}
    TRY
        Wait Until Element Is Visible    ${locator}
        Wait Until Element Is Enabled    ${locator}
        Click Element                    ${locator}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the element 
    END
    
Click on button
    [Documentation]    This keyword to click on a button by provided locator
    [Arguments]    ${locator}
        TRY
            Click on the web element    ${locator}
        EXCEPT    
            Run Keyword And Continue On Failure    Fail    Couldn't click on ${locator} button 
        END
    
Input value for a field
    [Documentation]    This keyword input a value for a field by provided value and locator 
    [Arguments]    ${TEXT}    ${locator} 
    TRY
        Wait Until Element Is Visible    ${locator}      
        Clear Element Text               ${locator}
        Input Text    ${locator}    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't input value for the input field  
    END   
    

Check the text elememt
    [Documentation]    This keyword checks a web text element that is display on the webpage
    [Arguments]    ${text}
    TRY
        Wait Until Page Contains    ${text}
        Page Should Contain              ${text}
    EXCEPT    
        Run Keyword And Continue On Failure  Fail    The text isn't display on the page
    END    

Get Page title
    [Documentation]    This keyword gets text of a element by provided locator
    [Arguments]    ${locator}
    TRY
        ${PAGE_TITLE}=    Get Text     ${locator}   
        RETURN    ${PAGE_TITLE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't get the text at this locator
    END

The page should be opened
    [Documentation]    This keyword verifies a webpage that displays
    [Arguments]    ${pagename}    ${locator}
    TRY
        Wait Until Page Contains Element           ${locator}
        ${current_page_title}=    Get Page title    ${locator}     
        Should Contain    ${current_page_title}    ${pagename}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail   Couldn't open the page
    END

Open page
    [Documentation]    This keyword open a webpage
    [Arguments]    ${pagename}    ${locator}
    TRY
        Access to url    ${URL_HOME}
        ${pagename_lower}=    Evaluate    "${pagename}".lower()
        ${URL}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${pagename_lower}
        Go To    ${URL}
        The page should be opened    ${pagename}    ${locator}
    EXCEPT    
        Run Keyword And Continue On Failure   Fail     Couldn't open ${pagename} page    CONTINUE
    END


Select Option From Dropdown
    [Documentation]    This keyword select a option from the dropdown by provided locator and option
    [Arguments]    ${dropdown_locator}    ${option_text}
    TRY
        Select From List By Label    ${dropdown_locator}    ${option_text}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't select the ${option_text} option
    END
Scroll Down in Firefox
    ${total_height}=    Execute JavaScript    return document.documentElement.scrollHeight
    ${viewport_height}=    Execute JavaScript    return window.innerHeight
    ${current_scroll}=    Execute JavaScript    return window.scrollY

    ${scroll_amount}=    Set Variable    700
    ${target_scroll}=    Evaluate    ${current_scroll} + ${scroll_amount}
    
    Run Keyword If    ${target_scroll} > ${total_height} - ${viewport_height}    ${target_scroll}=    Set Variable    ${total_height} - ${VIEWPORT_HEIGHT}
    
    Execute JavaScript    window.scrollTo({ top: ${target_scroll}, behavior: 'smooth' })
Hover Over Elenment
    [Documentation]    This keyword is used to move the mouse to a provided locator
    [Arguments]       ${element}    ${coordinates}=500
    TRY
        IF    ("${BROWSER}"=="Firefox")
            Scroll Down in Firefox
            
        ELSE
            Scroll Element Into View    ${element}
            Execute JavaScript    window.scrollBy(0, ${coordinates})
        END
        ${status}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    "${status}"=="False"
            Run Keyword And Continue On Failure    Fail    No look for element
        ELSE
            Sleep    2s           
            Mouse Over    ${element}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't hover the ${element} element
    END
   
Wait until page contain element
    [Documentation]    This keyword is used to wait and check page contain provided locator
    [Arguments]    ${element}
    TRY
        Wait Until Element Is Visible    ${element}
        Page Should Contain Element    ${element}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't looking for the element
    END   

Get list WebElements
    [Documentation]    This keyword is used to get list web elements from the provided locator
    [Arguments]    ${locator}
    TRY
        Wait Until Element Is Visible    ${locator}
        @{elements}=    Get WebElements    ${locator}
        RETURN     @{elements}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't get list web elements
    END

Wait and get element text
    [Documentation]    This keyword is used to wait and get element text from provided locator
    [Arguments]     ${element}
    TRY
        Wait Until Element Is Visible    ${element}    timeout=10s    
        ${TEXT}=    Get Text    ${element}
        RETURN    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't get element text
    END

Compare two Numbers
    [Documentation]    This keyword is used to compare two numbers from provided locator
    [Arguments]     ${num1}    ${num2} 
    TRY
        ${number1}=    Convert To Number    ${num1}
        ${number2}=    Convert To Number    ${num2}
        Should Be Equal As Numbers    ${number1}    ${number2}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The two numbers are not equal
    END
   
Wait for page loaded
    [Documentation]       This keyword is used to Wait for page loaded from provided locator
    [Arguments]    ${locator}
    TRY
        Wait Until Element Is Visible    ${locator}
        Wait Until Element Is Not Visible    ${locator}
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