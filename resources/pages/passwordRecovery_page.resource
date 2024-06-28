*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    login_page.resource
Resource    customerinfor_page.resource

*** Variables ***
${RESETPASS_INPUT_ELE}    id=Email
${SUBMIT_BTN_ELE}         css:input[type="submit"]
${SUCCES_MESSAGE}         Email with instructions has been sent to you
*** Keywords ***
Click the Submit button
    [Documentation]    This keyword clicking on the Submit button
    TRY
        Click on the web element    ${SUBMIT_BTN_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The error message isn't displayed the error message
    END

Input the email for the Email field
    [Documentation]    This keyword input email for the Email field
    [Arguments]    ${email}
    TRY
        Input value for a field    ${email}    ${RESETPASS_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The error message isn't displayed the error message
    END

Users should reset password success
    [Documentation]    This keyword verifies that user reset password success
    TRY
        Check the text elememt    ${SUCCES_MESSAGE}        
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The error message isn't displayed the error message
    END
It should appear error message when users input invalid email
    [Documentation]    This keyword verifies that the error message appears
    [Arguments]    ${values}    ${notification}
    TRY
        Open the Password Recovery page
        Input the email for the Email field    ${values}
        Click the Submit button
        Check the text elememt                 ${notification}
        Close the web page        
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The error message isn't displayed the error message
    END
Open the Password Recovery page
    TRY
        Access to url                          ${URL_PASSWORDRECOVERY}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't open the Password Recovery page     
    END