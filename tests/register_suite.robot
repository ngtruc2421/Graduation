*** Settings ***
Resource    ../resources/pages/base_page.resource
Resource    ../resources/pages/login_page.resource
Resource    ../resources/pages/register_page.resource
Library    SeleniumLibrary
Test Setup    Open Register page
Test Teardown    Close web
*** Test Cases ***
BSG-T2 --- Verify that the user can navigate to the Register page by clicking on the Register button on the Sign-In page 
    [Tags]    High
    [Setup]    Access the Sign In page
    Click the Register button
    The Register page should be opened

BSG-T4 --- Verify that Registration Form includes fields with properties as describe 
    #  The Username field is required input
    # The LastName field is type free text    kimngan@@
    The Day field is type Dropdown


