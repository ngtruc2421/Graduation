*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/searchBar.resource
Library    ../../../Graduation_thesis/resources/pages/base_page.resource
Resource    ../pages/home_page.resource
*** Variables ***
${ADDPRODUCTSEARCH_BTN_ELE}        css:.fa.fa-cart-arrow-down
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
${DELIVERY_SELECTED_ELE}      xpath=//div[@data-key="deliveryid"]//input[@checked="checked"]
${DELIVERY_CHECKBOX_ELE}      xpath=//label//span[contains(text(),'available and ready to ship')]
${DELIVERY_DROPDOWN_ELE}      css:.facet-group a[href="#facet-body-deliveryid"]
${DELIVERY_OPTIONS_ELE}       css:div[class="art-delivery-info"] span[class="delivery-time"]
${OPTION_NAME}                available and ready to ship
${SEARCH_RESULT_ELE}          css:article:first-of-type[class="art"]
${IMAGE_ELE}                  class=art-picture-block
${NAME_ELE}                   class=art-name
${PRICE_ELE}                  class=art-price-block
${RATING_ELE}                 class=rating
${RATINGBOX_ELE}              id=content
${SELECT_OPTION_ELE}          css:select>option[selected="selected"]
${ACTION_sORT_ELE}            id=artlist-action-sort
${ACTION_PAGE_ELE}            css:select[id="artlist-action-page"]>option
${ACTION_PAGESIZE_ELE}        css:select[id="artlist-action-pagesize"]>option
${DATAKEY_RATING}             css:div[data-key="rating"]
*** Keywords ***
Click on the Add product button on search result page
    TRY
        Click on button    ${ADDPRODUCTSEARCH_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the Add product button
    END 
    
Enter a value for the From field
    [Arguments]    ${TEXT}
    Input value for a field    ${TEXT}    ${FROM_INPUT_ELE}
Enter a value for the To field
    [Arguments]    ${TEXT}
    Input value for a field    ${TEXT}    ${TO_INPUT_ELE}
Click the Custom Range button
    Click on the web element    ${PRICEFILTER_BTN_ELE}
The entered values still are have
    [Arguments]    ${FIRST}    ${SECOND}
    TRY
        Click on the web element    ${DATAKEY_RATING}
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
The system should be performed paginated
    ${CHECK_LENGTH}=    Get list length    ${ACTION_PAGE_ELE}    
    Run Keyword If    ${CHECK_LENGTH}>1    Pass Execution    The system performed paginated    ELSE    Fail    The system wasn't paginated
The system should be displays the option to view the results per page
    ${CHECK_LENGTH}=    Get list length    ${ACTION_PAGESIZE_ELE}    
    Run Keyword If    ${CHECK_LENGTH}>1    Pass Execution    The system performed displays the option to view the results per page
    ...    ELSE    Fail    The system wasn't displays the option to view the results per page
It should display messages when the product are found
    [Arguments]    ${CONTENT}    ${MESS}
    Open the Home Page
    Search product on the search bar    ${CONTENT}
    Display the web element    ${MESS}
    Close Browser
Click the sort dropdown
    [Arguments]    ${LOCATOR}
    Click on the web element    ${LOCATOR}
Observe the curent results list
    ${NEW_RESULT_LIST}=    Get list    ${SEARCH_RESULT_ELE} 
    RETURN    ${NEW_RESULT_LIST}
Observe the new results list
    ${CURRENT_RESULT_LIST}=    Get list    ${SEARCH_RESULT_ELE} 
    RETURN    ${CURRENT_RESULT_LIST}
Users should view the search results after selected the view options
    [Arguments]    ${SELECT_VALUE}
    TRY
    Open the Home Page
    Search product on the search bar    an
    Select Option From Dropdown    ${ACTION_sORT_ELE}    ${SELECT_VALUE}
    ${SELECTED_VALUE}=    Get Text    ${SELECT_OPTION_ELE}
    Should Be Equal As Strings    ${SELECTED_VALUE}    ${SELECT_VALUE}
    Close Browser
    EXCEPT
        Run Keyword And Continue On Failure    Log    Issues are happing 
    END

Click delivery dropdown
    [Arguments]    ${LOCATOR}
    Hover Over Elenment    ${LOCATOR}
    Click on the web element    ${LOCATOR}
Select the checkbox
    [Arguments]    ${LOCATOR}
    Hover Over Elenment    ${LOCATOR}
    Click on the web element    ${LOCATOR}
Select the Category checkbox
    Select the checkbox    ${CATEGORY_CHECKBOX_ELE}
Select the Price radio button
    Select the checkbox    ${PRICE_RADIO_ELE}
Select the Rating radio button
    Select the checkbox    ${RATING_RADIO_ELE}
Select the Delivery checkbox
    Select the checkbox    ${DELIVERY_CHECKBOX_ELE}
It should be display the result after select checkbox
    [Arguments]    ${LOCATOR_ATR}    ${LOCATOR_LIST}
    ${CHECKBOX_VALUE}=    Get Element Attribute    ${LOCATOR_ATR}    value
    ${LST}=    Create List
    ${LST2}=    Create List
    ${LST}=    Get WebElements    ${LOCATOR_LIST}
    ${LENGTH}=    Get Length    ${LST}
    FOR    ${eLEMENT}    IN    @{LST}
        ${ITEM}=    Get Element Attribute    ${ELEMENT}    data-key
        Append To List    ${LST2}    ${ITEM}
    END
    FOR    ${ELEMENT}    IN    @{LST2}       
            Run Keyword If    ${CHECKBOX_VALUE} == ${ELEMENT}    Pass Execution    Sucessfully
        
    END
The search results page should be display the result of the filtered option 
    [Arguments]    ${LOCATOR_ATR}    ${LOCATOR_LIST}    ${CHECKBOXNAME}
    TRY
    ${LST}=       Create List
    ${LST}=       Get WebElements    ${LOCATOR_LIST}
    FOR    ${ELEMENT}    IN    @{LST}
        Element Should Contain    ${ELEMENT}    ${CHECKBOXNAME}
    END
    EXCEPT
        Run Keyword And Continue On Failure    Log    Issues are happing 
    END
The search result should be display enough information with image, name, rating, and price
    TRY
    ${RESULT}=    Get WebElement    ${SEARCH_RESULT_ELE}    
    Page Should Contain Element                ${IMAGE_ELE}    ${RESULT}
    Page Should Contain Element                ${NAME_ELE}             ${RESULT}
    Page Should Contain Element                ${PRICE_ELE}      ${RESULT}
    Click on the web element                                              ${RESULT}
    Page Should Contain Element                ${RATING_ELE}      ${RATINGBOX_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Log    Issues are happing 
    END

It should display the error message
    [Arguments]    ${TEXT}
    # Wait Until Element Is Visible    class=alert-warning
    Display the web element    ${TEXT}