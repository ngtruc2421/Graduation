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
        Run Keyword And Continue On Failure    Fail    There is a error happen in process access to ${URL}
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
            Run Keyword If Test Failed    Fail    There is a error happen in process click on ${LOCATOR} button 
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
    

Get Page title
    [Documentation]    This keyword gets text of a element by provided locator
    TRY
        ${PAGE_TITLE}=    Get Text    css:.page-title
        RETURN    ${PAGE_TITLE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get Page title
    END

The page should be opened
    [Documentation]    This keyword verifies a webpage that displays
    [Arguments]    ${PAGENAME}
    TRY
        Wait Until Page Contains Element           css:.page-title
        ${CURRENT_PAGE_TITLE}=    Get Page title     
        Should Contain    ${CURRENT_PAGE_TITLE}    ${PAGENAME}
    EXCEPT    
        Run Keyword And Continue On Failure    FAIL   The page open failure
        
    END

Open page
    [Documentation]    This keyword open a webpage
    [Arguments]    ${PAGENAME}
    TRY
        Access to url    ${URL_HOME}
        ${PAGENAME_LOWER}=    Evaluate    "${PAGENAME}".lower()
        ${URL}=    Catenate    SEPARATOR=/    ${URL_HOME}    ${PAGENAME_LOWER}
        Go To    ${URL}
        The page should be opened    ${PAGENAME}
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
    [Arguments]       ${element}
    Execute JavaScript    window.scrollBy(0, 500);
    Mouse Over    ${element}    

# Display sizebar tab 
    # [Arguments]    ${NAME}
    # TRY
    #     @{LIST_TAB_NAME}=    Get WebElements    css:.nav-item [role="tab"] [class="title"]
    #     FOR    ${element}    IN    @{LIST_TAB_NAME}
    #         ${tabName}=     Get Value    ${element}
    #         IF      "${tabName}" == "${NAME}"
    #             get ekemnt theo index
    #             get attribuet 
    #             check attibulet list contian active 
    #         ELSE
                
    #         END
            
    #     END

    #     @{LIST}=    Get WebElements    css:.nav-item [role="tab"] 
        
    #     FOR    ${ELEMENT}    IN    @{LIST}
            
    #         ${NAMEASD}=    Get Value    ${ELEMENT}
    #         ${CLASS_ATTRIBUTE}=    Get Element Attribute    ${ELEMENT}    class
    #         ${IS_ACTIVE}=    Run Keyword And Return Status    Should Contain    ${class_atTribute}    ${NAME}
    #         IF    (${IS_ACTIVE}!= False)
    #             ${VALUE}=    Get Text    ${ELEMENT}
    #             Should Contain    ${NAME}    ${VALUE}      
    #             RETURN      
    #         END
    #     END
    #     Run Keyword And Continue On Failure   FAIL    There is a error happen in process Display sizebar ${NAME} tab 
        
    # EXCEPT    
    #     Run Keyword And Continue On Failure   FAIL    There is a error happen in process Display sizebar ${NAME} tab 
        
    # END