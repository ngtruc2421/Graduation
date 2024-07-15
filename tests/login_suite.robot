*** Settings ***
Resource         ../resources/pages/login_page.resource
Resource         ../resources/pages/passwordRecovery_page.resource
Resource         ../resources/page_objects/header.resource
Resource         ../resources/keywords/utils.resource
Resource         ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup         Test Suite Setup for login suite
Test Setup          Test case Setup for login suite
Test Teardown       Test case Teardown for login suite
Documentation        This suite cover all test cases related to the user story [BSG-3] - User Login
...                - As a registered user
...                - I want to log into my account
...                - So that I can access my personalized dashboard and features

*** Variables ***
${PASS_WHITESPACE}           @us   er123

*** Test Cases ***
BSG-T1 --- Verify that there is a page for users log in to the system
    [Tags]    High
    Open the Login page
    It should display the Login page    Sign In
BSG-T3 --- Verify that the system will display the error message when users input incorrect value for the Username or email field and Password field
    #F
    [Tags]    High
    [Template]    It should appear the error message when users input incorrect value for the Username or email field and Password field
    user001@gmail.com       TranPhuongNgocTruc20042001         The email address you entered is not associated with an account
    @user123.gmail.com      TranPhuongNgocTruc20042001         The email you entered is incorrect
    11111.com               TranPhuongNgocTruc20042001         The email you entered is incorrect
    @!!!#@gmail.com         TranPhuongNgocTruc20042001         The email you entered is incorrect
    @trantruc               TranPhuongNgocTruc20042001         The email you entered is incorrect
    ${EMPTY}                TranPhuongNgocTruc20042001         Email and Password are required fields
    tt1799917@gmail.com     @@@!!!###                          The password you entered is incorrect
    tt1799917@gmail.com     1234567                            The password you entered is incorrect
    tt1799917@gmail.com     ${PASS_WHITESPACE}                 The password you entered is incorrect
    tt1799917@gmail.com     ${EMPTY}                           Email and Password are required fields
    ${EMPTY}                ${EMPTY}                           Email and Password are required fields
    

BSG-T13 --- Verify that the users can use "Remember Me" option
    #F
    [Tags]    High
    Open the Login page
    Input username                                        @trantruc2001
    Input pass                                            TranPhuongNgocTruc20042001
    Click the "Remember me" option
    Click the Login button
    Click on the account's name on the top at the corner
    Select the Log out option
    Click on the Log in option on the top of the corner
    The system should save the account information        @trantruc2001    TranPhuongNgocTruc20042001
BSG-T15 --- Verify that the system provided a "Forgot Password" link for users who need to reset their password
    [Tags]    High
    Open the Login page
    Click on the Forgot password link
    Input the email for the Email field    tt1799917@gmail.com
    Click the Submit button
    Users should reset password success
BSG-T17 --- Verify that the system will update the login's status when users login success
    [Tags]    High    Smoke
    Open the Login page
    Input username    @trantruc2001
    Input pass        TranPhuongNgocTruc20042001
    Click the Login button
    Show on the logged in user's name on the top right    @trantruc2001
BSG-T29 --- Verify that the system will display the error message when users input invalid email on the Forgot Password page
    [Tags]                Medium
    [Template]            It should appear error message when users input invalid email
    User123@gmail.com     Email not found
    @User321gmail.com    'Your email address' is not a valid email address
    !!!@#####            'Your email address' is not a valid email address
    ${EMPTY}             'Your email address' should not be empty
BSG-T32 --- Verify that user can input data for the Username or email field
    [Tags]    High    Smoke
    Open the Login page
    Input username                          @trantruc2001
    Unfocus the field
    Username field should input the data    @trantruc2001
BSG-T34 --- Verify that user can input data for the Password field
    [Tags]    High
    Open the Login page
    Input pass                              TranPhuongNgocTruc20042001
    Unfocus the field
    Password field should input the data    TranPhuongNgocTruc20042001
BSG-T49 --- Verify that users can login success into the system
    [Tags]    High
    Open the Login page
    Input username                      @trantruc2001
    Input pass                          TranPhuongNgocTruc20042001
    Click the Login button
    It should log in success            Welcome to our store.

*** Keywords ***
Test case Setup for login suite
    Set test case start time

Test case Teardown for login suite
    Update test case result to Zephyr Scale
    Close the web page

Test Suite Setup for login suite
    Create test cycle at folder    Automation Test
    Log                            This is suite setup

# Open the password recovery page
#     Set test case start time
#     Access to url                      https://bearstore-testsite.smartbear.com/customer/passwordrecovery          