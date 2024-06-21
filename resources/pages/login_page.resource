*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    register_page.resource
*** Variables ***
${LOGINPAGE_TITLE_ELE}          tag=h1
${MESS_SUCCESS_ELE}             css:.h2
${URL_REGISTER}                 register
${REMEMBERME_BTN_ELE}           id=RememberMe
${PASSWORD_ELE}                 css:#Password
${LOGIN_BTN_ELE}                css:.btn-login
${REGISTERLOGINPAGE_BTN_ELE}    css:.register-button
${USERNAME_ELE}                 css:input[id="UsernameOrEmail"]
${FORGOTPASS_LINK_ELE}          css:a[href="/customer/passwordrecovery"]
*** Keywords ***
Input username
    [Documentation]    Inputs the data provided for the Username field 
    [Arguments]    ${TEXT}
    TRY
        Input value for a field    ${TEXT}    ${USERNAME_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail      Input username failed  
    END
Input pass
    [Documentation]    Inputs the data provided for the Password field 
    [Arguments]    ${TEXT}
    TRY
        Input value for a field    ${TEXT}    ${PASSWORD_ELE}  
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
    [Arguments]    ${EXPECTED}
    TRY
        Check the text elememt    ${EXPECTED}
        
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Login failed
        
    END
It should display the Login page
    [Documentation]    This keyword verifies that the login page is displayed
    [Arguments]    ${EXPECTED}
    TRY
        Check the text elememt    ${EXPECTED}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't display the Login page
    END
Unfocus the field
    [Documentation]    This keyword unforcus the input field
    TRY
        Click Element    id=content
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Unfocus failed
    END
It should input the data
    [Documentation]    This keyword verifies that users can input data using the provided locator
    [Arguments]    ${TEXT}    ${LOCATOR}
    TRY
        ${TEM}    Get Value    ${LOCATOR}
        Should Be Equal As Strings    ${TEXT}    ${TEM}  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't input data 
    END
Compare text of input field
    [Documentation]    This keyword get value of the provided locator and compares with the provided text
    [Arguments]    ${TEXT}    ${LOCATOR}
    TRY
        ${TEM}    Get Value    ${LOCATOR}
        Should Be Equal As Strings    ${TEXT}    ${TEM.upper()}  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The text couldn't equal
    END
The system should save the account information
    [Documentation]    This keyword verifies that the system save the account information
    [Arguments]     ${USERNAME}    ${USERNAME_LOCATOR}    ${PASSWORD}    ${PASSWORD_LOCATOR}
        TRY
        Compare text of input field    ${USERNAME}    ${USERNAME_LOCATOR}  
        Compare text of input field    ${PASSWORD}    ${PASSWORD_LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The system don't save the account information
    END

It should appear the error message when users input incorrect value for the Username or email field and Password field
    [Documentation]    This keyword verifies that the error message when users input incorrect value 
    ...                for the Username or email field and Password field
    [Arguments]    ${USERNAME_EMAIL}    ${PASS}    ${MESS}
    TRY
        Open the Login page
        Input username    ${USERNAME_EMAIL}
        Input pass    ${PASS}
        Click the Login button
        Check the text elememt    ${MESS}
        Close the web page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    It doesn't appear the error message
    END
Log in the system
    [Documentation]    This keyword log in to the system with provided username and password
    [Arguments]    ${USERNAME}    ${PASSWORD}
    TRY
        Input username    ${USERNAME}
        Input pass    ${PASSWORD}
        Click the Login button        
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't login to the system
    END
Access the Sign In page
    [Documentation]    This keyword access to the Sign In page
    TRY
    Access to url    ${URL_LOGIN}
    It should display the Login page    Sign In
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
