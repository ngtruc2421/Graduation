*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Resource    ../pages/login_page.resource
*** Variables ***
${SEARCHBAR_INPUT_ELE}    class=instasearch-term
${SEARCH_BTN_ELE}    class=instasearch-button
@{SEARCHBAR}=    ${SEARCHBAR_INPUT_ELE}    ${SEARCH_BTN_ELE} 
${SUGGESLIST_TITLE}    class="instasearch-group-header"   
*** Keywords ***
# Start template [
Display the search bar on the page
    [Arguments]    ${URL}    @{SEARCH_OBJECT}
    TRY
        Access to url    ${URL}
        Display Element    ${SEARCH_OBJECT}[0]
        Display Element    ${SEARCH_OBJECT}[1] 
        Close the web page  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are the issue on the "Display the search bar on the page" keyword
    END
Search the product with
    [Arguments]    ${DATA}
    TRY
        Input value for a field    ${DATA}    ${SEARCHBAR_INPUT_ELE}
        Click on button    ${SEARCH_BTN_ELE}
        Display the web element    Search
        Close the web page 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are the issue on the "Search the product with" keyword
    END
The suggestions list will display with 
    [Arguments]    ${TEXT}
    TRY
        Input value for a field    ${TEXT}    ${SEARCHBAR_INPUT_ELE} 
        Display element    ${SUGGESLIST_TITLE}
        Close the web page
    EXCEPT    AssertionError
        Run Keyword And Continue On Failure    Log    There are the issue on the "The suggestions list will display with" keyword    
        Fail
    END
# End template ]



Display the hint text on the search search_bar
    [Arguments]    ${RESULT}
    TRY
        Should Be Equal As Strings    What are you looking for?    ${RESULT}    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are issues on "Display the hint text on the search search_bar" keyword
    END
Observe the search bar 
    TRY
        Wait Until Element Is Visible    ${SEARCHBAR_INPUT_ELE}
        ${ATTRIBUTE}=    Get Element Attribute    ${SEARCHBAR_INPUT_ELE}    placeholder
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are issues on "Observe the search bar" keyword
    END
    RETURN    ${ATTRIBUTE}
# Display the produce image, name, and description on the suggestion product
Get suggestion list
    ${SUGGGES_LST}    Create List
    ${SUGGESLIST_LIST}=    Get WebElements    css:ul.instasearch-hits li
    ${length}    Get Length    ${SUGGESLIST_LIST}
        FOR    ${element}    IN    @{SUGGESLIST_LIST}
            ${PRODUCT}=    Get Text    ${element}
            Append To List    ${SUGGGES_LST}    ${PRODUCT}           
        END

    RETURN    ${SUGGGES_LST}    



# Start common keyword [
Search product on the search bar
    [Arguments]    ${TEXT}    ${CONDITION}=${None} 
    IF    ${CONDITION}!=${None}
        Input value for a field    ${TEXT}    ${SEARCHBAR_INPUT_ELE}
        Click Button    ${SEARCH_BTN_ELE}
    ELSE
        Input value for a field    ${TEXT}    ${SEARCHBAR_INPUT_ELE} 
    END


# End common keyword ]
