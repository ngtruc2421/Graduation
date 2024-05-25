*** Settings ***
Resource    ../resources/pages/base_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/register_page.resource
Library    SeleniumLibrary
Test Setup    Open Register page
Test Teardown    Close Browser
*** Test Cases ***
BSG-T2 --- Verify that the user can navigate to the Register page by clicking on the Register button on the Sign-In page 
    [Tags]    High
    [Setup]    Access the Sign In page
    Click the Register button
    The Register page should be opened

BSG-T4 --- Verify that Registration Form includes fields with properties as describe 
    [Tags]    Smoke    High
    # The "Last name" field should not be required
    # # User should be able to input text to "Last name" file
    The "Email" field should be required
    # # User should be able to input text to email files
    # Get Input ID By Last name
    # Input in Last name field with alphabetic characters name

BSG-T6 --- Verify that First Name should accept alphabetic characters only
    [Tags]    High
    Input in "First name" field with alphabetic characters "Kim"
    The error "Data First Name not a valid" should not be display

BSG-T25 --- Verify that Last Name should accept alphabetic characters only
    [Tags]    High
    Input in "Last name" field with alphabetic characters "Kim"
    The error "Data Last Name not a valid" should not be display

BSG-T26 --- Verify that the system displays an error when users input non-alphabetic characters in the First Name field
        [Tags]    High
        [Template]    Input characters non-alphabetic characters in First name field
        ${text}            ${error}
        123                "Data First Name not a valid"
        @@                 "Data First Name not a valid"
        kim123             "Data First Name not a valid"
        kim@@              "Data First Name not a valid"
        @@12               "Data First Name not a valid"


BSG-T27 --- Verify that the system displays an error when users input non-alphabetic characters in the Last Name field
        [Tags]    High
        [Template]    Input characters non-alphabetic characters in Last name field
        ${text}            ${error}
        123                "Data Last Name not a valid"
        @@                 "Data Last Name not a valid"
        kim123             "Data Last Name not a valid"
        kim@@              "Data Last Name not a valid"
        @@12               "Data Last Name not a valid"

