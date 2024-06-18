*** Settings ***
Library     String
Library     DateTime
Library     Collections
Library     RequestsLibrary


*** Variables ***
# ${elapsed}    ${EMPTY}


*** Keywords ***
Get Suite Name
    RETURN    ${SUITE NAME}

Get Test Case Name
    RETURN    ${TEST NAME}

Get Test Case key
    ${test_case_name}=    Get Test Case Name
    ${is_test_case_name_correct_format}=    Should Match Regexp    ${test_case_name}    .*---.*
    ${tc_parts}=    Split String    ${test_case_name}    ---
    ${first_part}=    Replace String    ${tc_parts}[0]    <    ${EMPTY}
    ${last_part}=    Replace String    ${first_part}    >    ${EMPTY}
    ${key_part}=    Strip String    ${last_part}
    ${is_correct_key}=    Should Match Regexp    ${key_part}    BSG-.*
    IF    '${is_correct_key}' == 'None'
        Fatal Error    Test case ID does not exist
    ELSE
        RETURN    ${key_part}
    END

# Stop Execution On Failure
#    [Arguments]    ${condition}
#    IF    ${condition} == True
#    Run Keyword And Return From Test Case    Fail    Test failed
#    END

Get test case status
    RETURN    ${TEST_STATUS}

Get test case message
    RETURN    ${TEST_MESSAGE}

Get current date time
    ${current_time}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    ${current_time}
    RETURN    ${current_time}

Set test case start time
    ${start}=    Get Current Date
    Set Global Variable    ${start}
    RETURN    ${start}

Set test case end time
    ${end}=    Get Current Date
    Set Global Variable    ${end}
    RETURN    ${end}

Get test execution elapsed
    ${end}=    Set test case end time
    ${elapsed_time}=    Subtract Date From Date    ${end}    ${start}
    ${elapsed}=    Evaluate    ${elapsed_time}*1000
    Set Global Variable    ${elapsed}
    RETURN    ${elapsed}

# Set Masked Variables
#    Set Suite Variable    ${ACCESS_TOKEN}    my_secure_access_token
#    Set Suite Variable    ${PASSWORD}    my_secure_password
