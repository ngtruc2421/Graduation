*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Resource    ../pages/login_page.resource
Resource    ../pages/home_page.resource
*** Variables ***
${SEARCHBAR_INPUT_ELE}    class=instasearch-term
${SEARCH_BTN_ELE}    class=instasearch-button
@{SEARCHBAR}=    ${SEARCHBAR_INPUT_ELE}    ${SEARCH_BTN_ELE} 
${SUGGESLIST_TITLE}    class=instasearch-group-header   
*** Keywords ***
# Start template [
It should display the search bar on the page
    [Arguments]    ${URL}    @{SEARCH_OBJECT}
    TRY
        Access to url    ${URL}
        Wait until page contain element    ${SEARCH_OBJECT}[0]
        Wait until page contain element    ${SEARCH_OBJECT}[1] 
        Close the web page  
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are the issue on the "Display the search bar on the page" keyword
    END
It should display the search results page
    [Arguments]    ${DATA}
    TRY
        Open the Home Page
        Input value for a field    ${DATA}    ${SEARCHBAR_INPUT_ELE}
        Click on button    ${SEARCH_BTN_ELE}
        Check the text elememt    Search
        Close Browser
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are the issue on the "Search the product with" keyword
    END
The suggestions list should display with 
    [Arguments]    ${TEXT}
    TRY
        Open the Home Page
        Input value for a field    ${TEXT}    ${SEARCHBAR_INPUT_ELE} 
        Wait until page contain element    ${SUGGESLIST_TITLE}
        Close Browser
    EXCEPT    AssertionError
        Run Keyword And Continue On Failure    Log    There are the issue on the "The suggestions list will display with" keyword    
        Fail
    END
# End template ]



It should display the hint text on the search_bar
    TRY
        Wait Until Element Is Visible    ${SEARCHBAR_INPUT_ELE}
        ${RESULT}=    Get Element Attribute    ${SEARCHBAR_INPUT_ELE}    placeholder
        Should Be Equal As Strings    What are you looking for?    ${RESULT}    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are issues on "Display the hint text on the search search_bar" keyword
    END
Get image list
    ${IMG_LIST}=    Create List    
    ${IMG_LIST}=    Get WebElements    class=img-fluid
    ${LENGTH}=    Get Length    ${IMG_LIST}
    ${LENGTH}=    Evaluate    ${LENGTH} - 1
    RETURN    ${LENGTH}
Get description list
    ${DESCRIPTION_LIST}=    Create List    
    ${DESCRIPTION_LIST}=    Get WebElements    class=instasearch-hit-label-secondary.d-block.text-truncate
    ${LENGTH}=    Get Length    ${DESCRIPTION_LIST}
    RETURN    ${LENGTH}
Get title list
    ${TITLE_LIST}=    Create List    
    ${TITLE_LIST}=    Get WebElements    css=span:first-child[class="d-block text-truncate"]
    ${LENGTH}=    Get Length    ${TITLE_LIST}
    RETURN    ${LENGTH}
Checks
    ${IMG}=    Get image list
    ${DESCRIPTION}=    Get description list
    ${TITLE}=    Get title list
    IF    ${IMG} == ${DESCRIPTION} == ${TITLE}    
        RETURN    True
    ELSE
        RETURN    False
    END     
It should display the image, description, and title on suggestion list
    ${CHECK}=    Checks
    Run Keyword If    '${CHECK}'=='True'    Pass Execution    Suggestion list was enough image, description, and title
    ...         ELSE    Fail    Suggestion list is not enough image, description, or title
    
Enters the text on the search bar 
    [Arguments]    ${TEXT} 
    Input value for a field    ${TEXT}    ${SEARCHBAR_INPUT_ELE} 

# Start common keyword [
Search product on the search bar
    [Arguments]    ${TEXT} 
        Input value for a field    ${TEXT}    ${SEARCHBAR_INPUT_ELE}
        Wait until page contain element    css:.instasearch-drop    
        Click on button    ${SEARCH_BTN_ELE}
# End common keyword ]
