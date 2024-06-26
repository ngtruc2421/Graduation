*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    register_page.resource
*** Variables ***
${LOGINPAGE_TITLE_ELE}          tag=h1
${MESS_SUCCESS_ELE}             css:.h2
${URL_REGISTER}                 register
${REMEMBERME_BTN_ELE}           id=RememberMe
${CONTENT_ELE}                   id=content
${PASSWORD_ELE}                 css:#Password
${LOGIN_BTN_ELE}                css:.btn-login
${REGISTERLOGINPAGE_BTN_ELE}    css:.register-button
${USERNAME_ELE}                 css:input[id="UsernameOrEmail"]
${FORGOTPASS_LINK_ELE}          css:a[href="/customer/passwordrecovery"]
${SIGNIN}          Sign In
*** Keywords ***
Input username
    [Documentation]    Inputs the data provided for the Username field 
    [Arguments]    ${text}
    TRY
        Input value for a field    ${text}    ${USERNAME_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail      Input username failed  
    END
Input pass
    [Documentation]    Inputs the data provided for the Password field 
    [Arguments]    ${text}
    TRY
        Input value for a field    ${text}    ${PASSWORD_ELE}  
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Input password failed
    END
Click the Login button
    [Documentation]    Clicking on the Login button on the Login page
    TRY
        Click on button     ${LOGIN_BTN_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't clicking on the Login button
    END
Click the "Remember me" option
    [Documentation]    Clicking on the Remember Me option on the Login page
    TRY
        Click on the web element    ${REMEMBERME_BTN_ELE}       
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't cliking on the Remember me option
    END
Click on the Forgot password link
    [Documentation]    Clicking on the Forgot password link on the Login page
    TRY
        Click on the web element    ${FORGOTPASS_LINK_ELE}
    EXCEPT        
        Run Keyword And Continue On Failure    Fail    Couldn't clicking on the Forgot password link
    END
Click the Register button
    [Documentation]    Clicking on the Register button on the Login page
    TRY
        Click on button    ${REGISTERLOGINPAGE_BTN_ELE}
        ${url}=    Catenate    SEPARATOR=    ${URL_HOME}    ${URL_REGISTER}
        Wait Until Location Contains    ${url}
        The Register page should be opened
    EXCEPT    
        Run Keyword And Continue On Failure   Fail    There is a error happen in process Click the Register button
    END 

It should log in success
    [Documentation]    Verify that users login success?
    [Arguments]    ${expected}
    TRY
        Check the text elememt    ${expected}
        
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Login failed
        
    END
It should display the Login page
    [Documentation]    This keyword verifies that the login page is displayed
    [Arguments]    ${expected}
    TRY
        Check the text elememt    ${expected}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't display the Login page
    END
Unfocus the field
    [Documentation]    This keyword unforcus the input field
    TRY
        Click Element    ${CONTENT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Unfocus failed
    END
Password field should input the data
    [Documentation]    This keyword verifies that users can input data using the provided locator for password field
    [Arguments]    ${text}
    TRY
        ${tem}    Get Value        ${PASSWORD_ELE}
        Should Be Equal As Strings    ${text}    ${tem}  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't input data 
    END
Username field should input the data
    [Documentation]    This keyword verifies that users can input data using the provided locator for username field
    [Arguments]    ${text}
    TRY
        ${tem}    Get Value        ${USERNAME_ELE}
        Should Be Equal As Strings    ${text}    ${tem}  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't input data 
    END
Compare text of input field
    [Documentation]    This keyword get value of the provided locator and compares with the provided text
    [Arguments]    ${text}    ${locator}
    TRY
        ${tem}    Get Value    ${locator}
        Should Be Equal As Strings    ${text}    ${tem.upper()}  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The text couldn't equal
    END
The system should save the account information
    [Documentation]    This keyword verifies that the system save the account information
    [Arguments]     ${username}    ${password}
        TRY
        Compare text of input field    ${username}        ${USERNAME_ELE}  
        Compare text of input field    ${password}        ${PASSWORD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The system don't save the account information
    END

It should appear the error message when users input incorrect value for the Username or email field and Password field
    [Documentation]    This keyword verifies that the error message when users input incorrect value 
    ...                for the Username or email field and Password field
    [Arguments]    ${username_email}    ${pass}    ${mess}
    TRY
        Open the Login page
        Input username    ${username_email}
        Input pass    ${pass}
        Click the Login button
        Check the text elememt    ${mess}
        Close the web page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    It doesn't appear the error message
    END
Log in the system
    [Documentation]    This keyword log in to the system with provided username and password
    [Arguments]    ${username}    ${password}
    TRY
        Input username    ${username}
        Input pass    ${password}
        Click the Login button        
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't login to the system
    END
Access the Sign In page
    [Documentation]    This keyword access to the Sign In page
    TRY
    Access to url    ${URL_LOGIN}
    It should display the Login page    ${SIGNIN}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't access the Sign In page
    END

Open the Login page
    [Documentation]    This keyword access to the Login page
    TRY
        Access to url    ${URL_LOGIN}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't open the Login page
    END
