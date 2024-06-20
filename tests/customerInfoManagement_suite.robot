*** Settings ***
Resource    ../resources/keywords/common_keywords.resource
Resource    ../resources/pages/customerinfor_page.resource
Resource    ../resources/keywords/zephyr_scale_integrate.resource
Suite Setup    Test Suite Setup of customer infor
Test Setup    Test case Setup of customer infor
Test Teardown    Test case Teardown of customer infor
Documentation    This suite cover all test cases related to the user story [BSG-25] - Customer info management
          ...    As a customer, 
          ...    I want to enter and update my personal and company information in a form 
          ...    so that I can maintain accurate and up-to-date details in the system.
*** Test Cases ***
BSG-T77 --- Verify that The form should include fields for first name, last name, date of birth, email, username, and company name
    [Tags]    High    Smoke
    The "First name" field should be display 
    The "Last name" field should be display
    The "DateOdBirth" file should be display
    The "Email" field should be display
    The "Username" should be display 
    The "Company name" field should be display

BSG-T78 --- Verify that First name is mandatory field
    [Tags]    High
    The "First name" field should be required

BSG-T79 --- Verify that Date of birth should be entered using a drop-down for day, month, and year to ensure correct format
    [Tags]    High
    The "Day" field is type Dropdown
    The "Month" field is type Dropdown
    The "Year" field is type Dropdown

BSG-T80 --- Verify that The system should validate the email format
    [Tags]    High
    [Template]    It should show warning message when user input the "Email" field with specific value in customer info page
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

BSG-T81 --- Verify that Mandatory fields should be highlighted if left empty upon submission attempt
    [Tags]    High    
    Clear all data in required field
    Click on the Save button in the Customer infor page
    The error "'First name' should not be empty." should be display    
    The error "'Last name' should not be empty." should be display    
    The error "'Email' should not be empty." should be display    

BSG-T82 --- Verify that A clear message should appear indicating which fields need correction if there are validation errors
    [Tags]    High
    [Template]    It should show warning message when user input the "Email" field with specific value in customer info page
    InvalidEmail              'Email' is not a valid email address.

BSG-T83 --- Verify that The company name field is optional and should not prevent form submission if left empty
    [Tags]    High
    The "Company name" field should not be required

BSG- T84 --- Verify that A "Save" button should be prominently displayed at the bottom of the form
    [Tags]    High
    The "Save" button should be displayed 

BSG-T85 --- Verify that On clicking "Save," the system should validate all input fields
    [Tags]    High
    Clear all data in required field
    Click on the Save button in the Customer infor page
    The error "'First name' should not be empty." should be display    
    The error "'Last name' should not be empty." should be display    
    The error "'Email' should not be empty." should be display
BSG-T86 --- Verify that If validation is successful, the information should be saved, and a success message should be displayed
    [Tags]    High
    Input the "Company name" field with value "WaverSoftware" in customer info page
    Click on the Save button in the Customer infor page
    The message "Customer information has been updated successfully" should be display

BSG-87 --- Verify that If there are validation errors, the form should highlight the errors and provide appropriate messages to guide the user in correcting them
    [Tags]    High
    [Template]    It should show warning message when user input the "Email" field with specific value in customer info page
    InvalidEmail              'Email' is not a valid email address.

BSG-T88 --- Verify that After saving the form, users should receive a confirmation message that their information has been saved successfully
    [Tags]    High
    Input the "Company name" field with value "WaverSoftware" in customer info page
    Click on the Save button in the Customer infor page
    The message "Customer information has been updated successfully" should be display

BSG-T89 --- Verify that If the save action fails, a clear error message should be displayed explaining what went wrong and how to rectify it
    [Tags]    High
    Clear data in "Email" field
    Click on the Save button in the Customer infor page
    The error "'Email' should not be empty." should be display    

BSG-T91 --- Verify that Input fields should be appropriately labeled, and required fields marked with an asterisk (*)
    [Tags]    High
    The "First name" field is required
    The "Last name" field is required
    The "Email" field is required
    The field "Username" is required
BSG-T92 --- Verify that Last name is mandatory field
    [Tags]    High
    The "Last name" field should be required

BSG-T93 --- Verify that Email is mandatory field
    [Tags]    High
    The "Email" field should be required

BSG-T94 --- Verify that Username is mandatory field
    [Tags]    High
    The field "Username" is required

*** Keywords ***
Test Suite Setup of customer infor
    Create test cycle at folder    Smoke Testing
    Create test cycle at folder     Regression Testing
    Log    This is suite setup
Test case Setup of customer infor
    Set test case start time
    The user is logged in and is now on the Customer Infor page
Test case Teardown of customer infor
    Close Browser
    Update test case result to Zephyr Scale
