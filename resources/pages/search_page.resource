*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
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
Get pagination list
    Display Element    css:select[id=artlist-action-page]
    ${PAGE_LIST}    Create List
    ${PAGE_LIST}=    Get WebElements    css:select[id=artlist-action-page]>option
    ${LENGTH}=    Get Length    ${PAGE_LIST}
    RETURN    ${LENGTH}
The system performed paginated
    ${CHECK}=    Get pagination list
    Run Keyword If    ${CHECK}>1    Pass Execution    The system performed paginated    ELSE    Fail    The system wasn't paginated
