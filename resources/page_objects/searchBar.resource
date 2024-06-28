*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Resource    ../pages/login_page.resource
Resource    ../pages/home_page.resource
*** Variables ***
${SEARCHBAR_INPUT_ELE}    class=instasearch-term
${SEARCH_BTN_ELE}    class=instasearch-button
@{SEARCHBAR}=        ${SEARCHBAR_INPUT_ELE}    ${SEARCH_BTN_ELE} 
${SUGGESLIST_TITLE}    class=instasearch-group-header   
*** Keywords ***
# Start template [
It should display the search bar on the page
    [Arguments]    ${url}
    TRY
        Access to url    ${url}
        Wait until page contain element    ${SEARCHBAR_INPUT_ELE}
        Wait until page contain element    ${SEARCH_BTN_ELE}
        Close the web page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are the issue on the "Display the search bar on the page" keyword
    END
It should display the search results page
    [Arguments]    ${data}
    TRY
        # Open the Home Page
        Input value for a field    ${data}    ${SEARCHBAR_INPUT_ELE}
        Click on button    ${SEARCH_BTN_ELE}
        Check the text elememt    Search
        # Close the web page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are the issue on the "Search the product with" keyword
    END
The suggestions list should display with 
    [Arguments]    ${text}
    TRY
        # Open the Home Page
        Input value for a field    ${text}    ${SEARCHBAR_INPUT_ELE} 
        Wait until page contain element    ${SUGGESLIST_TITLE}
        # Close the web page
    EXCEPT    AssertionError
        Run Keyword And Continue On Failure    Log    There are the issue on the "The suggestions list will display with" keyword    
        Fail
    END
# End template ]



It should display the hint text on the search_bar
    TRY
        Wait Until Element Is Visible    ${SEARCHBAR_INPUT_ELE}
        ${result}=    Get Element Attribute    ${SEARCHBAR_INPUT_ELE}    placeholder
        Should Be Equal As Strings    What are you looking for?    ${result}    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are issues on "Display the hint text on the search search_bar" keyword
    END
Get image list
    ${img_list}=    Create List    
    ${img_list}=    Get WebElements    class=img-fluid
    ${length}=    Get Length    ${img_list}
    ${length}=    Evaluate    ${length} - 1
    RETURN    ${length}
Get description list
    ${description_list}=    Create List    
    ${description_list}=    Get WebElements    class=instasearch-hit-label-secondary.d-block.text-truncate
    ${length}=    Get Length    ${description_list}
    RETURN    ${length}
Get title list
    ${title_list}=    Create List    
    ${title_list}=    Get WebElements    css=span:first-child[class="d-block text-truncate"]
    ${length}=    Get Length    ${title_list}
    RETURN    ${length}
Checks
    ${img}=    Get image list
    ${description}=    Get description list
    ${title}=    Get title list
    IF    ${img} == ${description} == ${title}    
        RETURN    True
    ELSE
        RETURN    False
    END     
It should display the image, description, and title on suggestion list
    ${check}=    Checks
    Run Keyword If    '${check}'=='True'    Pass Execution    Suggestion list was enough image, description, and title
    ...         ELSE    Fail    Suggestion list is not enough image, description, or title
    
Enters the text on the search bar 
    [Arguments]    ${text} 
    Input value for a field    ${text}    ${SEARCHBAR_INPUT_ELE} 

# Start common keyword [
Search product on the search bar
    [Arguments]    ${text} 
        Input value for a field    ${text}    ${SEARCHBAR_INPUT_ELE}
        Click on button    ${SEARCH_BTN_ELE}
# End common keyword ]
