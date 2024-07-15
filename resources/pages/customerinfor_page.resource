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
Get ID field by lable ${name} in customer info page
    [Documentation]       This keyword is used to Get ID field by lable in customer info page from provided lable name
    TRY
        ${xpath}=    Set Variable    //label[text()='${name}']/following-sibling::div[contains(@class, 'col-lg-9')]//input
        ${element}=    Get WebElement    ${xpath}
        ${id}=    Call Method    ${element}    get_attribute    id
        RETURN    ${id}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${name} customer info page    
    END

Input the "${name}" field with value "${text}" in customer info page
    [Documentation]       This keyword is used to Input the field with value in customer info page from provided field name and provided value
    TRY
        ${locator}=    Get ID field by lable ${name} in customer info page
        Input value for a field    ${text}    id:${locator}
        ${current_text}=    Get Value    ${locator}
        Should Contain    ${current_text}    ${text}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error when input    
    END
Get class field by Username in customer info page
    [Documentation]       This keyword is used to Get class field by Username in customer info page
    TRY
        ${xpath}=    Set Variable    //label[text()='Username']/following-sibling::div[contains(@class, 'col-lg-9')]//div
        ${element}=    Get WebElement    ${xpath}
        ${class}=    Call Method    ${element}    get_attribute    class
        RETURN    css:.${class}
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

The "${name}" field should be display 
    [Documentation]       This keyword is used to verify The name field should be display from provided field name
    TRY
        ${id}=    Get ID field by lable ${name} in customer info page
        Wait until page contain element    id:${id}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify The "${name}" field should be display 
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
It should show warning message when user input the "${field_name}" field with specific value in customer info page
    [Documentation]       This keyword is used to verify It should show warning message when user input the field with specific value in customer info page from provided text and provided eror
    [Arguments]      ${text}      ${error}
    TRY
        ${LOCATOR}=    Get ID field by lable ${field_name} in customer info page
        Clear Element Text    id:${LOCATOR}
        Input the "${field_name}" field with value "${text}" in customer info page
        Click on the Save button in the Customer infor page
        The error "${error}" should be display
    EXCEPT  
        Run Keyword And Continue On Failure   FAIL     There is a error happen in process verify It should show warning message when user input the "${field_name}" field with specific value ${text}        
    END

Clear all data in required field
    [Documentation]       This keyword is used to Clear all data in required field
    TRY
        ${locator_fn}=    Get ID field by lable First name in customer info page
        Clear Element Text    id:${locator_fn}
        ${locator_ln}=    Get ID field by lable Last name in customer info page
        Clear Element Text    id:${locator_ln}
        ${locator_email}=    Get ID field by lable Email in customer info page
        Clear Element Text    id:${locator_email}
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
    

Clear data in "${name}" field 
    [Documentation]       This keyword is used to Clear data in name field from provided field name
    TRY
        ${locator}=    Get ID field by lable ${name} in customer info page
        Clear Element Text    id:${locator}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Clear data in ${name} field 
    END


Is field ${name} include asterisk character
    [Documentation]       This keyword is used to verify Is name field include asterisk character from provided field name    
    TRY
        ${id}=    Get ID field by lable ${name} in customer info page
        ${result}=    Execute JavaScript    return window.getComputedStyle(document.querySelector(".required[for='${id}']"), "::after").getPropertyValue("content");
         ${stripped_result}=    Evaluate    ${result}.strip('"')
        Should Contain    ${stripped_result}    *
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify Is field ${name} include asterisk character  
    END

The "${name}" field is required 
    [Documentation]       This keyword is used to verifyThe name field is required  from provided field name
    TRY
        ${list_lable}=    Get list WebElements    ${LABLELIST_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_lable}
            ${lable}=    Wait and get element text    ${element}
            IF    "${lable}" == "${name}"
                Is field ${name} include asterisk character
                RETURN    
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process verify
    END
 

The field "Username" is required
    [Documentation]       This keyword is used to verify The field "Username" is required
    TRY
        ${list_lable}=    Get list WebElements    ${LABLELIST_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list_lable}
            ${lable}=    Wait and get element text    ${element}
            IF    "${lable}" == "Username"
                ${id}=    Set Variable    Username
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
    