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
    Input content    ${EMAIL}    ${EMAIL_INPUT_ELE}
Users reset password success
    Display the web element    ${SUCCES_MESSAGE}
Appear error message when users input invalid email
    [Arguments]    ${VALUES}    ${NOTIFICATION}
    Access to ${URL_PASSWORDRECOVERY}
    Input the email for the Email field    ${VALUES}
    Click the Submit button
    Display the web element    ${NOTIFICATION}