*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/searchBar.resource
Resource    ../pages/home_page.resource
Resource    products_page.resource
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
${PRICESEARCHRESULT_ELE}      class=art-price-block
${RATING_ELE}                 class=rating
${RATINGBOX_ELE}              id=content
${SELECT_OPTION_ELE}          css:select>option[selected="selected"]
${ACTION_SORT_ELE}            id=artlist-action-sort
${ACTION_PAGE_ELE}            css:select[id="artlist-action-page"]>option
${ACTION_PAGESIZE_ELE}        css:select[id="artlist-action-pagesize"]>option
${DATAKEY_RATING}             css:div[data-key="rating"]
${LISTPRODUCT_ELE}            css:.art
*** Keywords ***
Click on the Add product button on search result page
    [Documentation]    This keyword clicking on the Add product button on search result page
    TRY
        Click on button    ${ADDPRODUCTSEARCH_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the Add product button on search result page
    END 

Get name product "${NAME}" in result page
    [Documentation]    This keyword get name product "${NAME}" in result page
    TRY
        ${LIST}=    Get list WebElements   ${LISTPRODUCT_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${ELEMENT}    IN    @{LIST}
            ${LIST}=    Get list WebElements   ${PRODUCTNAME_ELE}  
            ${CLASS}=    Get From List    ${LIST}    ${INDEX}
            ${NAME_TEXT}=    Get Text    ${CLASS}
            IF    "${NAME_TEXT}" == "${NAME}"
                RETURN    ${CLASS}
            END
            ${INDEX}=    Evaluate    ${INDEX}+1
        END
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't get name product "${NAME}" in result page 
    END
   
Hover over the product item "${NAME}" in result page
    [Documentation]    This keyword hover over the product item "${NAME}" in result page
    TRY
        Wait Until Element Is Visible    ${PAGE_TITLE_ELE}
        ${PRODUCT}=    Get name product "${NAME}" in result page
        Wait Until Element Is Visible    ${PRODUCT}
        Hover Over Elenment    ${PRODUCT}    300
    EXCEPT    
        Run Keyword And Continue On Failure   Fail    Couldn't Hover over the product item "${NAME}" in result page
    END
    
Enter a value for the From field
    [Documentation]    This keyword enter a value for the From field
    [Arguments]    ${TEXT}
    TRY
        Input value for a field    ${TEXT}    ${FROM_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't enter a value for the From field 
    END

Enter a value for the To field
    [Documentation]    This keyword enter a value for the To field
    [Arguments]    ${TEXT}
    TRY
        Input value for a field    ${TEXT}    ${TO_INPUT_ELE}
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't enter a value for the To field 
    END

Click the Custom Range button
    [Documentation]    This keyword clicking the Custom Range button
    TRY
        Click on the web element    ${PRICEFILTER_BTN_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't clicking on the Custom Range button 
    END

The entered values still are have
    [Documentation]    This keyword verifies that 
    [Arguments]    ${FIRST}    ${SECOND}
    TRY
        ${FIRST_EXP}=    Get Value    ${FROM_INPUT_ELE}
        ${SECOND_EXP}=    Get Value    ${TO_INPUT_ELE}
        Should Be Equal As Strings    ${FIRST_EXP}    ${FIRST}
        Should Be Equal As Strings    ${SECOND_EXP}    ${SECOND}    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on progress performent
    END

Get list length
    [Documentation]    This keyword get list length
    [Arguments]    ${LOCATOR}
    TRY
        ${PAGE_LIST}=    Get list WebElements    ${LOCATOR}
        ${LENGTH}=    Get Length    ${PAGE_LIST}
        ${LENGTH}=    Evaluate    ${LENGTH}/2
        ${LENGTH}=    Convert To Integer    ${LENGTH}
        RETURN    ${LENGTH}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't retrieve the list length 
    END

The system should be performed paginated
    [Documentation]    This keyword verifies that the system should be performed paginated
    ${CHECK_LENGTH}=    Get list length    ${ACTION_PAGE_ELE}    
    Run Keyword If    ${CHECK_LENGTH}>1    Pass Execution    The system performed paginated    ELSE    Fail    The system wasn't paginated

The system should be displays the option to view the results per page
    [Documentation]    This keyword verifies that the system should be displays the option to view the results per page
    ${CHECK_LENGTH}=    Get list length    ${ACTION_PAGESIZE_ELE}    
    Run Keyword If    ${CHECK_LENGTH}>1    Pass Execution    The system performed displays the option to view the results per page
    ...    ELSE    Fail    The system wasn't displays the option to view the results per page

It should display messages when the product are found
    [Documentation]    This keyword verifies that it should display messages when the product are found
    [Arguments]    ${CONTENT}    ${MESS}
    TRY
        Search product on the search bar    ${CONTENT}
        Check the text elememt    ${MESS}    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't display message when the product is found 
    END

Click the sort dropdown
    [Documentation]    This keyword clicking the sort dropdown
    [Arguments]    ${LOCATOR}
    TRY
        Click on the web element    ${LOCATOR}    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't clicking the sort dropdown field
    END


Users should view the search results after selected the view options
    [Documentation]    This keyword verifies that users should view the search results after selected the view options
    [Arguments]    ${SELECT_VALUE}
    TRY
        Open the Home Page
        Search product on the search bar    an
        Select Option From Dropdown    ${ACTION_SORT_ELE}    ${SELECT_VALUE}
        ${SELECTED_VALUE}=    Get Text    ${SELECT_OPTION_ELE}
        Should Be Equal As Strings    ${SELECTED_VALUE}    ${SELECT_VALUE}
        Close All Browsers
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It couldn't view the search results after selected the view options 
    END

Click delivery dropdown
    [Documentation]    This keyword clicking delivery dropdown
    [Arguments]    ${LOCATOR}
    TRY
        Hover Over Elenment    ${LOCATOR}
        Click on the web element    ${LOCATOR}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't clicking on the delivery dropdown 
    END

Select the checkbox
    [Documentation]    This keyword elect the checkbox
    [Arguments]    ${LOCATOR}
    TRY
        Hover Over Elenment    ${LOCATOR}
        Click on the web element    ${LOCATOR}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't selecting on the checkbox
    END
Select the Category checkbox
    [Documentation]    This keyword selecting the Category checkbox
    TRY
        Select the checkbox    ${CATEGORY_CHECKBOX_ELE}
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't selecting the Category checkbox 
    END

Select the Price radio button
    [Documentation]    This keyword selecting the Price radio button
    TRY    
    Select the checkbox    ${PRICE_RADIO_ELE}
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't selecting the Price radio button 
    END

Select the Rating radio button
    [Documentation]    This keyword selecting the Rating radio button
    TRY
        Select the checkbox    ${RATING_RADIO_ELE}
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't selecting the Rating radio button 
    END

Select the Delivery checkbox
    [Documentation]    This keyword selecting the Delivery checkbox
    TRY
        Select the checkbox    ${DELIVERY_CHECKBOX_ELE}
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't selecting the Delivery checkbox 
    END

It should be display the result after select checkbox
    [Documentation]    This keyword verifies that it should be display the result after select checkbox
    [Arguments]    ${LOCATOR_ATR}    ${LOCATOR_LIST}
    TRY
        ${CHECKBOX_VALUE}=    Get Element Attribute    ${LOCATOR_ATR}    value
        ${LST2}=    Create List
        ${LST}=    Get WebElements    ${LOCATOR_LIST}
        ${LENGTH}=    Get Length    ${LST}
        FOR    ${ELEMENT}    IN    @{LST}
            ${ITEM}=    Get Element Attribute    ${ELEMENT}    data-key
            Append To List    ${LST2}    ${ITEM}
        END
        FOR    ${ELEMENT}    IN    @{LST2}       
                Run Keyword If    ${CHECKBOX_VALUE} == ${ELEMENT}    Pass Execution    Sucessfully
        END
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It isn't displayed the result after select checkbox 
    END

The search results page should be display the result of the filtered option 
    [Documentation]    This keyword verifies that the search results page should be display the result of the filtered option
    [Arguments]    ${LOCATOR_ATR}    ${LOCATOR_LIST}    ${CHECKBOXNAME}
    TRY
        ${LST}=       Get WebElements    ${LOCATOR_LIST}

        FOR    ${ELEMENT}    IN    @{LST}
            Element Should Contain    ${ELEMENT}    ${CHECKBOXNAME}
        END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The search results page isn't displayed the result of the filtered option 
    END
The search result should be display enough information with image, name, rating, and price
    [Documentation]    This keyword verifies that the search result should be display enough information with image, name, rating, and price
    TRY
        ${RESULT}=    Get WebElement    ${SEARCH_RESULT_ELE}    
        Page Should Contain Element                ${IMAGE_ELE}    ${RESULT}
        Page Should Contain Element                ${NAME_ELE}             ${RESULT}
        Page Should Contain Element                ${PRICESEARCHRESULT_ELE}      ${RESULT}
        Click on the web element                                              ${RESULT}
        Page Should Contain Element                ${RATING_ELE}      ${RATINGBOX_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The search result isn't displayed enough information 
    END

It should display the error message
    [Documentation]    This keyword verifies that it should display the error message
    [Arguments]    ${TEXT}
    TRY
        Check the text elememt    ${TEXT}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It isn't displayed the error message 
    END
