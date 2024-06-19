*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    login_page.resource

*** Variables ***
${EMAIL_INPUT_ELE}    id=Email
${SUBMIT_BTN_ELE}    css:input[type="submit"]
${SUCCES_MESSAGE}    Email with instructions has been sent to you
*** Keywords ***
Click the Submit button
    Click on the web element    ${SUBMIT_BTN_ELE}
Input the email for the Email field
    [Arguments]    ${EMAIL}
    Input value for a field    ${EMAIL}    ${EMAIL_INPUT_ELE}
Users reset password success
    Check the text elememt    ${SUCCES_MESSAGE}
Appear error message when users input invalid email
    [Arguments]    ${VALUES}    ${NOTIFICATION}
    Access to url                          ${URL_PASSWORDRECOVERY}
    Input the email for the Email field    ${VALUES}
    Click the Submit button
    Check the text elememt                 ${NOTIFICATION}
    Close the web page