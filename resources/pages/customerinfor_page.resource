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
    TRY
        ${XPATH}=    Set Variable    //label[text()='${NAME}']/following-sibling::div[contains(@class, 'col-lg-9')]//input
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${ID}=    Call Method    ${ELEMENT}    get_attribute    id
        RETURN    ${ID}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${NAME} customer info page    
    END

Input the "${NAME}" field with value "${TEXT}" in customer info page
    TRY
        ${LOCATOR}=    Get ID field by lable ${NAME} in customer info page
        Input value for a field    ${TEXT}    id:${LOCATOR}
        ${CURRENT_TEXT}=    Get Value    ${LOCATOR}
        Should Contain    ${CURRENT_TEXT}    ${TEXT}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error when input    
    END
Get class field by Username in customer info page
    TRY
        ${XPATH}=    Set Variable    //label[text()='Username']/following-sibling::div[contains(@class, 'col-lg-9')]//div
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${CLASS}=    Call Method    ${ELEMENT}    get_attribute    class
        RETURN    css:.${CLASS}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get class field by Username in customer info page
    END
   
The "Username" should be display 
    ${class}=    Get class field by Username in customer info page
    Wait until page contain element    ${class}
The "${NAME}" field should be display 
    ${ID}=    Get ID field by lable ${NAME} in customer info page
    Wait until page contain element    id:${ID}

The "DateOdBirth" file should be display 
    Wait until page contain element    ${DATEOFBIRTH_ELE}

The Customer info should be opened 
    The page should be opened    Customer info    ${PAGE_TITLE_ELE}
The user is logged in and is now on the Customer Infor page
    Open the Login page
    Log in the system    ${USERNAME}    ${PASSWORD}
    Click on the account's name on the top at the corner
    Click on the "My account" in top right
    The Customer info should be opened 

Click on the Save button in the Customer infor page
    TRY
        Click on button    ${SAVE_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is  There is a error happen in process Click on the Save button in the Customer infor page
    END
It should show warning message when user input the "${FIELD_NAME}" field with specific value in customer info page
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
    ${LOCATOR_FN}=    Get ID field by lable First name in customer info page
    Clear Element Text    id:${LOCATOR_FN}
    ${LOCATOR_LN}=    Get ID field by lable Last name in customer info page
    Clear Element Text    id:${LOCATOR_LN}
    ${LOCATOR_Email}=    Get ID field by lable Email in customer info page
    Clear Element Text    id:${LOCATOR_Email}

The "Save" button should be displayed 
    Wait until page contain element    ${SAVE_BTN_ELE}

Clear data in ${NAME} field 
    ${LOCATOR}=    Get ID field by lable ${NAME} in customer info page
    Clear Element Text    id:${LOCATOR}

Is field ${NAME} include asterisk character    
    ${ID}=    Get ID field by lable ${NAME} in customer info page
    ${result}=    Execute JavaScript    return window.getComputedStyle(document.querySelector(".required[for='${ID}']"), "::after").getPropertyValue("content");
     ${stripped_result}=    Evaluate    ${result}.strip('"')
    Should Contain    ${stripped_result}    *
The "${NAME}" field is required 
    ${LIST_LABLE}=    Get list WebElements    ${LABLELIST_ELE}
    ${INDEX}=    Set Variable    0
    FOR    ${element}    IN    @{LIST_LABLE}
        ${LABLE}=    Wait and get element text    ${element}
        IF    "${LABLE}" == "${NAME}"
            Is field ${NAME} include asterisk character
            RETURN    
        END
    END

The field "Username" is required
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