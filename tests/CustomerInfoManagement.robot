*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/customerinfor_page.resource
Test Setup    The user is logged in and is now on the Customer Infor page
Test Teardown    Close Browser
*** Test Cases ***
BSG-T77 --- Verify that The form should include fields for first name, last name, date of birth, email, username, and company name
    [Tags]    High
    The "First name" field should be display 
    The "Last name" field should be display
    The "DateOdBirth" file should be display
    The "Email" field should be display
    The "Username" should be display 
    The "Company name" field should be display

# BSG-T78 --- Verify that First name is mandatory fields and must be filled before submission
#     [Tags]    High
