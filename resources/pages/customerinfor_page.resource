*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    register_page.resource
Resource    login_page.resource
Resource    ../page_objects/header.resource
*** Variables ***
${DATEOFBIRTH_ELE}            css:.row.xs-gutters    
${USERNAME}=                                  0306211267@caothang.edu.vn
${PASSWORD}=                                  Ttkn1234@
*** Keywords ***
Get ID field by lable ${NAME} in customer info page
    TRY
        ${XPATH}=    Set Variable    //label[text()='${NAME}']/following-sibling::div[contains(@class, 'col-lg-9')]//input
        ${ELEMENT}=    Get WebElement    ${XPATH}
        ${ID}=    Call Method    ${ELEMENT}    get_attribute    id
        RETURN    id:${ID}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${NAME} customer info page    
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
    Wait until page contain element    ${ID}

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