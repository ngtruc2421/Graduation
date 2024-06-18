*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/register_page.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup    Test Suite Setup of register 
Test Setup    Test case Setup of register
Test Teardown    Test case Teardown of register
*** Test Cases ***
BSG-T35 --- Verify that the user can register account successfull when user input all required field
    [Tags]    High    Smoke
    Input on the "Email" field with value created automatic
    Input on the "Username" field with value created automatic
    Input the "Password" field with value "Kimngan12@@" 
    Input the "Confirm password" field with value "Kimngan12@@"
    Click the Register button in the Register page
    Wait Until Page Contains    Your registration completed
    Page Should Contain    Your registration completed
    The system should auto-login with username account

BSG-T26 --- Verify that the system displays an error when users input non-alphabetic characters in the First Name field
    [Tags]    Medium
    # FAIL
    [Template]    It should show warning message when user input the "First name" field with specific value
    123                Data First Name not a valid
    @@                 Data First Name not a valid
    kim123             Data First Name not a valid
    kim@@              Data First Name not a valid
    @@12               Data First Name not a valid
    
BSG-T36 --- Verify that the user can register account successfull when user input all field
    [Tags]    High    
    Input the "First name" field with value "Kim"
    Input the "Last name" field with value "Ngan"
    Select "1" from the list "Day" dropdown
    Select "June" from the list "Month" dropdown
    Select "2003" from the list "Year" dropdown
    Input on the "Email" field with value created automatic
    Input on the "Username" field with value created automatic
    Input the "Password" field with value "Kimngan12@@" 
    Input the "Confirm password" field with value "Kimngan12@@"
    Input the "Company name" field with value "Waverley"
    Click the Register button in the Register page
    Wait Until Page Contains    Your registration completed
    Page Should Contain    Your registration completed
    The system should auto-login with username account

BSG-T2 --- Verify that the user can navigate to the Register page by clicking on the Register button on the Sign-In page 
    [Tags]    High    Smoke
    [Setup]    Access the Sign In page of function register
    Click the Register button
    The Register page should be opened

BSG-T4 --- Verify that Registration Form includes fields with properties as describe 
    [Tags]    High
    The "First name" field should not be required
    The "First name" field is type free text        abc@
    The "Last name" field should not be required
    The "Last name" field is type free text         bcd@
    The "Day" field is type Dropdown
    The "Month" field is type Dropdown
    The "Year" field is type Dropdown
    The "Email" field should be required
    The "Email" field is type free text            abc!@
    The "Username" field should be required
    The "Username" field is type free text            kimngan#$
    The "Password" field should be required
    The "Password" field is type free text            kimngan**%%
    The "Confirm password" field should be required
    The "Confirm password" field is type free text    kimngan*%%    
    The "Company name" field should not be required
    The "Company name" field is type free text         abc&^  
     

BSG-T6 --- Verify that First Name should accept alphabetic characters only
    [Tags]    High
    Input the "First name" field with value "Kim"
    The error "Data First Name not a valid" should not be display

BSG-T25 --- Verify that Last Name should accept alphabetic characters only
    [Tags]    High
    Input the "Last name" field with value "Ngan"
    Click the Register button in the Register page
    The error "Data Last Name not a valid" should not be display
    
BSG-T27 --- Verify that the system displays an error when users input non-alphabetic characters in the Last Name field
    [Tags]    Medium
     # FAIL
    [Template]    It should show warning message when user input the "Last name" field with specific value
    123                Data Last Name not a valid
    @@                 Data Last Name not a valid
    kim123             Data Last Name not a valid
    kim@@              Data Last Name not a valid
    @@12               Data Last Name not a valid


BSG-T8 --- Verify that Email Addresses should be in a valid email fomat 
    [Tags]    High
    Input the "Email" field with value "kimngan1234@gmail.com"
    Click the Register button in the Register page
    The error "'Email' is not a valid email address." should not be display
    
BSG-T28 --- Verify that the system show error when user input email not in a valid email format in the Email Addresses field
    [Tags]    Medium
     # FAIL
    [Template]    It should show warning message when user input the "Email" field with specific value
    kim                               'Email' is not a valid email address.
    kimngan123                        'Email' is not a valid email address.
    kimngan12@                        'Email' is not a valid email address.
    kimngan@gma!il.com                'Email' is not a valid email address.
    kimngan@exam_ple.com              'Email' is not a valid email address.
    kimngan@com                       'Email' is not a valid email address.
    kimngan..name@example.com         'Email' is not a valid email address.
    kimngan@.example.com              'Email' is not a valid email address.
    @example.com                      'Email' is not a valid email address.
    kimngan@example,com               'Email' is not a valid email address.
    kimngan@exam_ple.com              'Email' is not a valid email address.
    .kimngan@example.com              'Email' is not a valid email address.
    kimngan.@example.com              'Email' is not a valid email address.
    kimngan@exam..ple.com             'Email' is not a valid email address.
    kim ngan@example.com              'Email' is not a valid email address.
    kimngan@example .com              'Email' is not a valid email address.
BSG-T11 --- Password must be at least 8 characters long and include a mix of upper and lower case letters, numbers, and special characters.
    [Tags]        High
    Input the "Password" field with value "Kimngan1234@"
    Click the Register button in the Register page
    The error "Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters" should not be display

BSG-T30 --- Verify that Password not accept when not satisfy the condition at least 8 characters long and include a mix of upper and lower case letters, numbers, and special characters
    [Tags]    Medium
     # FAIL
    [Template]    It should show warning message when user input the "Password" field with specific value
    Kimnga@                Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    kimngan1234            Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    kimngan@@              Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    kimngan12@             Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    KIMNGAN12@             Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    KIMNGAN@@              Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    KIMNGAN1234            Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    Kimngan1234            Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters
    Kimngan@@              Password need long of less than 8 characters and include a mix of upper and lower case letters, numbers, and special characters

BSG-T14 --- Verify that Confirm Password must match the Password field
    [Tags]    High
    Input the "Password" field with value "Kimngan12@@"
    Input the "Confirm password" field with value "Kimngan12@@"
    The error "The password and confirmation password do not match." should not be display

BSG-T31 --- Verify that Confirm Password show error when not match the Password field
    [Tags]    Medium
    Input the "Password" field with value "Kimngan12@@"
    Input the "Confirm password" field with value "Kimngan1234@@"
    Click the Register button in the Register page
    Wait Until Page Contains    The password and confirmation password do not match.
    The error "The password and confirmation password do not match." should be display
    

BSG-T16 --- Verify that the system Display appropriate error messages for: Empty fields
    [Tags]    High
    Click the Register button in the Register page
    The error "'Email' should not be empty." should be display    
    The error "'Password' should not be empty." should be display    
    The error "'Confirm password' should not be empty." should be display

    Input on the "Email" field with value created automatic
    Input the "Password" field with value "Kimngan12@@" 
    Input the "Confirm password" field with value "Kimngan12@@" 
    Click the Register button in the Register page
    The error "Username is not provided" should be display

BSG-T21 --- Verify that On successful registration, the user should receive a confirmation with the message “Your registration completed“ on the Register page.
    [Tags]    High
    Input on the "Email" field with value created automatic
    Input on the "Username" field with value created automatic
    Input the "Password" field with value "Kimngan12@@" 
    Input the "Confirm password" field with value "Kimngan12@@"
    Click the Register button in the Register page
    Wait Until Page Contains    Your registration completed
    Page Should Contain    Your registration completed

BSG-T22 --- Verify that The user is auto-login with a created account
    [Tags]    High
    Input on the "Email" field with value created automatic
    Input on the "Username" field with value created automatic
    Input the "Password" field with value "Kimngan12@@" 
    Input the "Confirm password" field with value "Kimngan12@@"
    Click the Register button in the Register page
    Wait Until Page Contains    Your registration completed
    The system should auto-login with username account


BSG-T23 --- Verify that The user can click on the Continue button to navigate to the register page to create a new account
    [Tags]    High
     # FAIL
    Input on the "Email" field with value created automatic
    Input on the "Username" field with value created automatic
    Input the "Password" field with value "Kimngan12@@" 
    Input the "Confirm password" field with value "Kimngan12@@"
    Click the Register button in the Register page
    Wait Until Page Contains    Your registration completed
    Page Should Contain    Your registration completed
    The system should auto-login with username account
    Click the Continue button
    The Register page should be opened

BSG-T18 --- Verify that the system Display appropriate error messages for: Invalid email format
    [Tags]    High
    [Template]    It should show warning message when user input the "Email" field with specific value
    InvalidEmail              'Email' is not a valid email address.

BSG-T20 --- Verify that the system Display appropriate error messages for: Password not meeting complexity requirements
    [Tags]    High
     # FAIL
    [Template]    It should show warning message when user input the "Password" field with specific value
    InvalidPassword                Password not meeting complexity requirements

BSG-T19 --- Verify that the system Display appropriate error messages for: Password and Confirm Password mismatch
    [Tags]    Medium
    Input the "Password" field with value "Kimngan12@@"
    Input the "Confirm password" field with value "Kimngan1234@@"
    Click the Register button in the Register page
    Wait Until Page Contains    The password and confirmation password do not match.
    The error "The password and confirmation password do not match." should be display
*** Keywords ***
Test Suite Setup of register 
    # Create test cycle at folder    Smoke Testing
    Create test cycle at folder    Regression Testing
    Log    This is suite setup
Test case Setup of register
    Set test case start time
    Open Register page
Test case Teardown of register
    Close Browser
    Update test case result to Zephyr Scale

Access the Sign In page of function register
    Set test case start time
    Access the Sign In page