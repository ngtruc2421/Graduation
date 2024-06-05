*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/search_bar.resource
*** Variables ***
${FROM_INPUT_ELE}=            id=price-range-from
${TO_INPUT_ELE}=              id=price-range-to
${PRICEFILTER_BTN_ELE}        id=btn-custom-price-range
${CATEGORY_CHECKBOX_ELE}      xpath=//label//span[contains(text(), 'Basketball')]
${PRICE_RADIO_ELE}            xpath=//label//span[contains(text(),'up to $10.00')]
${RATING_RADIO_ELE}           css:div[title="4 stars & more"]
${SELECTEDITEM_ELE}           css:div[class="active-filters-container"] li
${CATEGORY_SELECTED_ELE}      xpath=//div[@data-key="notfeaturedcategoryid"]//input[@checked="checked"]
${RATING_SELECTED_ELE}        xpath=//div[@data-key="rating"]//input[@checked="checked"]
${PRICE_SELECTED_ELE}         xpath=//div[@data-key="price"]//input[@checked="checked"]

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
It should display messages when the product are found
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
Users should view the search results after seleted the view options
    [Arguments]    ${SELECT_VALUE}
    Search product on the search bar    an
    Select Option From Dropdown    id=artlist-action-sort    ${SELECT_VALUE}
    ${SELECTED_VALUE}=    Get Text    css:select>option[selected="selected"]
    Should Be Equal As Strings    ${SELECTED_VALUE}    ${SELECT_VALUE}
Select the checkbox
    [Arguments]    ${LOCATOR}
    Click on the web element    ${LOCATOR}
Display the result after select checkbox
    [Arguments]    ${LOCATOR_ATR}    ${LOCATOR_LIST}
    ${CHECKBOX_VALUE}=    Get Element Attribute    ${LOCATOR_ATR}    value
    ${LST}=    Create List
    ${LST2}=    Create List
    ${LST}=    Get WebElements    ${LOCATOR_LIST}
    ${LENGTH}=    Get Length    ${LST}
    FOR    ${element}    IN    @{LST}
        ${ITEM}=    Get Element Attribute    ${element}    data-key
        Append To List    ${LST2}    ${ITEM}
    END
    FOR    ${element}    IN    @{LST2}       
            Run Keyword If    ${CHECKBOX_VALUE} == ${element}    Pass Execution    Sucessfully
        
    END