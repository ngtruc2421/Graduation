*** Settings ***
Library     json
Library     RequestsLibrary
Library     Collections
Library    ../../.venv/Lib/site-packages/robot/libraries/OperatingSystem.py
Resource    utils.resource
Resource    ../../configurations/api_credentials.resource


*** Variables ***
${ZS_URL}           https://api.zephyrscale.smartbear.com/v2
${Content_Type}     application/json
${PROJECT_KEY}          BSG

*** Keywords ***
Get curent cycle key
    RETURN    ${cycle_key}

Update test case result to Zephyr Scale
    Get test execution elapsed
    Create test execution result

################################# API support keywords ######################################

########## TEST CASES APIS ##########

Get all test cases
    Create new session
    ${response}=    GET On Session    mysession    /testcases
    Log    ${response.status_code}
    Log    ${response.content}

Get test cases by ID
    [Arguments]    ${test_case_id}
    Create new session
    ${response}=    GET On Session    mysession    /testcases/${test_case_id}
    Log    ${response.status_code}
    Log    ${response.content}
    Delete All Sessions

########## TEST CYCLE APIS ##############

Create test cycle at folder
    [Arguments]    ${folder_name}
    ${endpoint}=    Set Variable    /testcycles
    ${cycle_name}=    Generate test cycle name
    ${folder_id}=    Get test cycle folder ID by name    ${folder_name}
    &{payload}=    Create Dictionary
    ...    name= ${cycle_name}
    ...    projectKey=${PROJECT_KEY}
    ...    folderId=${folder_id}
    ${response}=    Call POST request    ${endpoint}    &{payload}
    ${cycle_key}=    Set Variable    ${response.json()}[key]
    Set Global Variable    ${cycle_key}

Generate test cycle name
    ${current_suite_name}=    Get Suite Name
    ${current_date_time}=    Get current date time
    ${cycle_name}=    Set Variable    ${current_suite_name} - ${current_date_time}
    RETURN    ${cycle_name}

Create test cycle folder
    [Arguments]    ${name}
    ${endpoint}=    Set Variable    /folders
    ${folder_name}=    Set Variable    ${name}
    ${folder_type}=    Set Variable    TEST_CYCLE
    &{payload}=    Create Dictionary
    ...    projectKey=${PROJECT_KEY}
    ...    name=${folder_name}
    ...    folderType=${folder_type}
    ${response}=    Call POST request    ${endpoint}    &{payload}
    ${folder_id}=    Set Variable    ${response.json()}[id]
    RETURN    ${folder_id}

########## TEST FOLDER APIS #############

Get all folders test cycle
    ${endpoint}=    Set Variable    /folders?folderType=TEST_CYCLE
    ${response}=    Call GET request    ${endpoint}
    @{values}=    Set Variable    ${response.json()}[values]
    RETURN    @{values}

Get test cycle folder ID by name
    [Arguments]    ${folder_name}
    @{foler_list}=    Get all folders test cycle
    FOR    ${element}    IN    @{foler_list}
        ${current_folder_name}=    set Variable    ${element['name']}
        IF    "${current_folder_name}" == "${folder_name}"
            ${current_folder_id}=    set Variable    ${element['id']}
            RETURN    ${current_folder_id}
        END
    END
    ${folder_id}=    Create test cycle folder    ${folder_name}
    IF    "${folder_id}" != "None"    RETURN    ${folder_id}
    Run Keyword    Fatal Error    No folder found

########## TEST EXECUTION APIS ##########

Create test execution result
    ${endpoint}=    Set Variable    /testexecutions
    ${cycle_key}=    Get curent cycle key
    ${test_case_key}=    Get Test Case key
    ${test_case_status}=    Get test case status
    ${execution_time}=    Get Variable Value    ${elapsed}
    ${environment_name}=    Set Variable    UAT
    ${comment}=    Get test case message
    &{payload}=    Create Dictionary
    ...    projectKey=${PROJECT_KEY}
    ...    testCycleKey=${cycle_key}
    ...    testCaseKey=${test_case_key}
    ...    statusName=${test_case_status}
    ...    executionTime=${execution_time}
    ...    environmentName=${environment_name}
    ...    comment=${comment}
    ${response}=    Call POST request    ${endpoint}    &{payload}
    Delete All Sessions
########## COMMON APIS SUPPORT ##############
Get API Access Token
    ${API_ACCESS_TOKEN}=    Get Environment Variable    ZEPHYR_SCALE_TOKEN
    [Return]    ${API_ACCESS_TOKEN}
Create new session
    Set Log Level    NONE    # disable logging
    ${API_ACCESS_TOKEN}=    Get API Access Token
    ${headers}=    Create Dictionary    Content-Type=${Content_Type}    Authorization=Bearer ${API_ACCESS_TOKEN}
    Create Session    mysession    ${ZS_URL}    headers=${headers}
    Set Log Level    INFO    # enable logging

Call GET request
    [Arguments]    ${endpoint}
    Create new session
    ${response}=    GET On Session    mysession    ${endpoint}
    RETURN    ${response}

Call POST request
    [Arguments]    ${endpoint}    &{payload}
    Create new session
    ${payload_json}=    Evaluate    json.dumps($payload, ensure_ascii=False)
    ${response}=    POST On Session    mysession    ${endpoint}    data=${payload_json}
    RETURN    ${response}
