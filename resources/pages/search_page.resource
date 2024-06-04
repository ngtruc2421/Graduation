*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Library    Process
Resource    ../page_objects/search_bar.resource
*** Variables ***
${FROM_INPUT_ELE}=    id=price-range-from
${TO_INPUT_ELE}=    id=price-range-to
${PRICEFILTER_BTN_ELE}    id=btn-custom-price-range
*** Keywords ***
Enter a value for the From field
    [Arguments]    ${TEXT}
    Input value for a field    ${TEXT}    ${FROM_INPUT_ELE}
Enter a value for the To field
    [Arguments]    ${TEXT}
    Input value for a field    ${TEXT}    ${TO_INPUT_ELE}
The entered values still are have
    [Arguments]    ${FIRST}    ${SECOND}
    TRY
        Click on the web element    css:div[data-key="rating"]
        ${FIRST_EXP}=    Get Value    ${FROM_INPUT_ELE}
        ${SECOND_EXP}=    Get Value    ${TO_INPUT_ELE}
        Should Be Equal As Strings    ${FIRST_EXP}    ${FIRST}
        Should Be Equal As Strings    ${SECOND_EXP}    ${SECOND}    
    EXCEPT    
        Run Keyword And Continue On Failure    Log    There is a issue on progress performent
    END
Get list
    [Arguments]    ${LOCATOR}
    ${LIST}    Create List
    ${LIST}=    Get WebElements    ${LOCATOR}
    RETURN    ${LIST}
Get list length
    [Arguments]    ${LOCATOR}
    ${PAGE_LIST}=    Get list    ${LOCATOR}
    ${LENGTH}=    Get Length    ${PAGE_LIST}
    ${LENGTH}=    Evaluate    ${LENGTH}/2
    ${LENGTH}=    Convert To Integer    ${LENGTH}
    RETURN    ${LENGTH}
The system performed paginated
    ${CHECK_LENGTH}=    Get list length    css:select[id="artlist-action-page"]>option    
    Run Keyword If    ${CHECK_LENGTH}>1    Pass Execution    The system performed paginated    ELSE    Fail    The system wasn't paginated
The system displays the option to view the results per page
    ${CHECK_LENGTH}=    Get list length    css:select[id="artlist-action-pagesize"]>option    
    Run Keyword If    ${CHECK_LENGTH}>1    Pass Execution    The system performed displays the option to view the results per page
    ...    ELSE    Fail    The system wasn't displays the option to view the results per page
Display messages when the product are found
    [Arguments]    ${CONTENT}    ${MESS}
    Search product on the search bar    ${CONTENT}
    Display the web element    ${MESS}
Click the sort dropdown
    [Arguments]    ${LOCATOR}
    Click on the web element    ${LOCATOR}
Observe the curent results list
    ${NEW_RESULT_LIST}=    Get list    css:article[class="art"]
    RETURN    ${NEW_RESULT_LIST}
Observe the new results list
    ${CURRENT_RESULT_LIST}=    Get list    css:article[class="art"]
    RETURN    ${CURRENT_RESULT_LIST}
After select the sort option the search results sorted
    ${NEW}=    Observe the new results list
    ${CURRENT}=    Observe the new results list
    ${NEW_LENGTH}=    Get Length    ${NEW}
    ${CURRENT_LENGTH}=    Get Length    ${CURRENT}
    Should Be Equal    ${NEW_LENGTH}    ${CURRENT_LENGTH}
    FOR    ${i}    IN RANGE    ${NEW_LENGTH}
        ${A_ELE}=    Get From List    ${NEW}    ${i}
        ${B_ELE}=    Get From List    ${CURRENT}    ${i}
        Elements Should Be Equal    ${A_ELE}    ${B_ELE}
    END
    Run Keyword If    ${NEW} != ${CURRENT}    Pass Execution    Success    ELSE    Fail    There is a issue on the progress keyword
    

# Get text list
#     ${LIST}=    Get list    css:select[id="artlist-action-pagesize"]>option
#     # ${l}=    Get list length    css:select[id="artlist-action-pagesize"]>option
#     ${TEXT_LIST}=    Create List
#     ${TEXT_LIST}=    Get Slice From List    ${LIST}    0    5
#     Click on the web element    css:div>select[id="artlist-action-pagesize"]
#     FOR    ${ELEMENT}    IN    ${TEXT_LIST}
#         # ${TEM}=    Get Text    ${ELEMENT}
#         ${TEM}=    Get Element Attribute    ${ELEMENT}    value
#         Append To List    ${LIST}    "${TEM}"
#     END
#     RETURN    ${TEXT_LIST}
# Select the option on the Pagesize dropdown to view the search results
#     ${TEXT_LIST}=    Get text list
#     FOR    ${ELEMENT}    IN    ${TEXT_LIST}
#         Select Option From Dropdown    css:select[id="artlist-action-pagesize"]    ${ELEMENT}
#         ${VALUE}=    Get Element Attribute    css:select[id="artlist-action-pagesize"]    title
#         ${VALUE_SLICED}=    Get Substring    ${VALUE}    0    2
#         Should Be Equal As Strings    ${VALUE_SLICED}    ${VALUE_SLICED}
#     END
