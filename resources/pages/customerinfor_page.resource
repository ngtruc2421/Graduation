*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    register_page.resource
Resource    login_page.resource
Resource    ../page_objects/header.resource
*** Variables ***
${DATEOFBIRTH_ELE}                            css:.row.xs-gutters    
${USERNAME}=                                  0306211267@caothang.edu.vn
${PASSWORD}=                                  Ttkn1234@
${SAVE_BTN_ELE}                               css:[name="save-info-button"] 
${LABLELIST_ELE}                              css:.col-form-label                               
*** Keywords ***
Get ID field by lable ${NAME} in customer info page
    [Documentation]       This keyword is used to Get ID field by lable in customer info page from provided lable name
    TRY
        ${XPATH}=    Set Variable    //label[text()='${NAME}']/following-sibling::div[contains(@class, 'col-lg-9')]//input
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${ID}=    Call Method    ${ELEMENT}    get_attribute    id
        RETURN    ${ID}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${NAME} customer info page    
    END

Input the "${NAME}" field with value "${TEXT}" in customer info page
    [Documentation]       This keyword is used to Input the field with value in customer info page from provided field name and provided value
    TRY
        ${LOCATOR}=    Get ID field by lable ${NAME} in customer info page
        Input value for a field    ${TEXT}    id:${LOCATOR}
        ${CURRENT_TEXT}=    Get Value    ${LOCATOR}
        Should Contain    ${CURRENT_TEXT}    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error when input    
    END
Get class field by Username in customer info page
    [Documentation]       This keyword is used to Get class field by Username in customer info page
    TRY
        ${XPATH}=    Set Variable    //label[text()='Username']/following-sibling::div[contains(@class, 'col-lg-9')]//div
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${CLASS}=    Call Method    ${ELEMENT}    get_attribute    class
        RETURN    css:.${CLASS}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get class field by Username in customer info page
    END
   
The "Username" should be display 
    [Documentation]       This keyword is used to verify The "Username" should be display 
    TRY
        ${class}=    Get class field by Username in customer info page
        Wait until page contain element    ${class}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The "Username" should be display 
    END

The "${NAME}" field should be display 
    [Documentation]       This keyword is used to verify The name field should be display from provided field name
    TRY
        ${ID}=    Get ID field by lable ${NAME} in customer info page
        Wait until page contain element    id:${ID}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The "${NAME}" field should be display 
    END


The "DateOdBirth" file should be display 
    [Documentation]       This keyword is used to verify The "DateOdBirth" file should be display 
    TRY
        Wait until page contain element    ${DATEOFBIRTH_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The "DateOdBirth" file should be display 
    END

The Customer info page should be opened 
    [Documentation]       This keyword is used to verify The Customer info page should be opened 
    TRY
        The page should be opened    Customer info    ${PAGE_TITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The Customer info should be opened 
    END

The user is logged in and is now on the Customer Infor page
    [Documentation]       This keyword is used to verify The user is logged in and is now on the Customer Infor page
    TRY
        Open the Login page
        Log in the system    ${USERNAME}    ${PASSWORD}
        Click on the account's name on the top at the corner
        Click on the "My account" in top right
        The Customer info page should be opened 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The user is logged in and is now on the Customer Infor page
    END


Click on the Save button in the Customer infor page
    [Documentation]       This keyword is used to Click on the Save button in the Customer infor page
    TRY
        Click on button    ${SAVE_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is  There is a error happen in process Click on the Save button in the Customer infor page
    END
It should show warning message when user input the "${FIELD_NAME}" field with specific value in customer info page
    [Documentation]       This keyword is used to verify It should show warning message when user input the field with specific value in customer info page from provided text and provided eror
    [Arguments]      ${TEXT}      ${ERROR}
    TRY
        ${LOCATOR}=    Get ID field by lable ${FIELD_NAME} in customer info page
        Clear Element Text    id:${LOCATOR}
        Input the "${FIELD_NAME}" field with value "${TEXT}" in customer info page
        Click on the Save button in the Customer infor page
        The error "${ERROR}" should be display
    EXCEPT  
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process verify It should show warning message when user input the "${FIELD_NAME}" field with specific value ${text}        
    END

Clear all data in required field
    [Documentation]       This keyword is used to Clear all data in required field
    TRY
        ${LOCATOR_FN}=    Get ID field by lable First name in customer info page
        Clear Element Text    id:${LOCATOR_FN}
        ${LOCATOR_LN}=    Get ID field by lable Last name in customer info page
        Clear Element Text    id:${LOCATOR_LN}
        ${LOCATOR_Email}=    Get ID field by lable Email in customer info page
        Clear Element Text    id:${LOCATOR_Email}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify Clear all data in required field
    END 


The "Save" button should be displayed
    [Documentation]       This keyword is used to verify The "Save" button should be displayed
    TRY
        Wait until page contain element    ${SAVE_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The "Save" button should be displayed
    END 
    

Clear data in ${NAME} field 
    [Documentation]       This keyword is used to Clear data in name field from provided field name
    TRY
        ${LOCATOR}=    Get ID field by lable ${NAME} in customer info page
        Clear Element Text    id:${LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Clear data in ${NAME} field 
    END


Is field ${NAME} include asterisk character
    [Documentation]       This keyword is used to verify Is name field include asterisk character from provided field name    
    TRY
        ${ID}=    Get ID field by lable ${NAME} in customer info page
        ${result}=    Execute JavaScript    return window.getComputedStyle(document.querySelector(".required[for='${ID}']"), "::after").getPropertyValue("content");
         ${stripped_result}=    Evaluate    ${result}.strip('"')
        Should Contain    ${stripped_result}    *
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify Is field ${NAME} include asterisk character  
    END

The "${NAME}" field is required 
    [Documentation]       This keyword is used to verifyThe name field is required  from provided field name
    TRY
        ${LIST_LABLE}=    Get list WebElements    ${LABLELIST_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_LABLE}
            ${LABLE}=    Wait and get element text    ${element}
            IF    "${LABLE}" == "${NAME}"
                Is field ${NAME} include asterisk character
                RETURN    
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify
    END
 

The field "Username" is required
    [Documentation]       This keyword is used to verify The field "Username" is required
    TRY
        ${LIST_LABLE}=    Get list WebElements    ${LABLELIST_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_LABLE}
            ${LABLE}=    Wait and get element text    ${element}
            IF    "${LABLE}" == "Username"
                ${ID}=    Set Variable    Username
                ${result}=    Execute JavaScript    return window.getComputedStyle(document.querySelector(".required[for='Username']"), "::after").getPropertyValue("content");
                 ${stripped_result}=    Evaluate    ${result}.strip('"')
                 Should Contain    ${stripped_result}    *
                RETURN    
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The field "Username" is required
    END
    

The message "Customer information has been updated successfully" should be display
    [Documentation]       This keyword is used to verify The message "Customer information has been updated successfully" should be display
    TRY
        Wait Until Page Contains    Customer information has been updated successfully
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The message "Customer information has been updated successfully" should be display
    END 
    