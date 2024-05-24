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
    The "Last name" field should not be required
    # User should be able to input text to "Last name" file
    The "Email" field should be required
    # User should be able to input text to email file