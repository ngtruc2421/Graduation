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
${SCROLL_VALUE}               300
${ARTLIST_ACTION_SORT_ELE}               class=artlist-action--sort
${PRODUCT_KEYWORD}            an
${VALUE}                      value
${DATA_KEY}                   data-key
${TITLE_SEARCH_PAGE_ELE}      css:.page-title

*** Keywords ***
Click on the Add product button on search result page
    [Documentation]    This keyword clicking on the Add product button on search result page
    TRY
        Click on button    ${ADDPRODUCTSEARCH_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Click on the Add product button on search result page
    END 

Get name product "${name}" in result page
    [Documentation]    This keyword get name product "${name}" in result page
    TRY
        ${list}=    Get list WebElements   ${LISTPRODUCT_ELE}
        ${index}=    Set Variable    0
        FOR    ${element}    IN    @{list}
            ${list2}=    Get list WebElements   ${PRODUCTNAME_ELE}  
            ${class}=    Get From List    ${list2}    ${index}
            ${name_text}=    Get Text    ${class}
            IF    "${name_text}" == "${NAME}"
                RETURN    ${class}
            END
            ${index}=    Evaluate    ${index}+1
        END
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't get name product "${name}" in result page 
    END
   
Hover over the product item "${name}" in result page
    [Documentation]    This keyword hover over the product item "${name}" in result page
    TRY
        Wait Until Element Is Visible    ${TITLE_SEARCH_PAGE_ELE}
        ${product}=    Get name product "${name}" in result page
        Wait Until Element Is Visible    ${product}
        Hover Over Elenment    ${product}    ${SCROLL_VALUE}   
    EXCEPT    
        Run Keyword And Continue On Failure   Fail    Couldn't Hover over the product item "${name}" in result page
    END
    
Enter a value for the From field
    [Documentation]    This keyword enter a value for the From field
    [Arguments]    ${text}
    TRY
        Input value for a field    ${text}    ${FROM_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't enter a value for the From field 
    END

Enter a value for the To field
    [Documentation]    This keyword enter a value for the To field
    [Arguments]    ${text}
    TRY
        Input value for a field    ${text}    ${TO_INPUT_ELE}
    
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
    [Arguments]    ${first}    ${second}
    TRY
        ${first_exp}=    Get Value    ${FROM_INPUT_ELE}
        ${second_exp}=    Get Value    ${TO_INPUT_ELE}
        Should Be Equal As Strings    ${first_exp}    ${first}
        Should Be Equal As Strings    ${second_exp}    ${second}    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on progress performent
    END

Get list length
    [Documentation]    This keyword get list length
    [Arguments]    ${locator}
    TRY
        ${page_list}=    Get list WebElements    ${locator}
        ${length}=    Get Length    ${page_list}
        ${length}=    Evaluate    ${length}/2
        ${length}=    Convert To Integer    ${length}
        RETURN    ${length}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't retrieve the list length 
    END

The system should be performed paginated
    [Documentation]    This keyword verifies that the system should be performed paginated
    ${check_length}=    Get list length    ${ACTION_PAGE_ELE}    
    Run Keyword If    ${check_length}>1    Pass Execution    The system performed paginated    ELSE    Fail    The system wasn't paginated

The system should be displays the option to view the results per page
    [Documentation]    This keyword verifies that the system should be displays the option to view the results per page
    ${check_length}=    Get list length    ${ACTION_PAGESIZE_ELE}    
    Run Keyword If    ${check_length}>1    Pass Execution    The system performed displays the option to view the results per page
    ...    ELSE    Fail    The system wasn't displays the option to view the results per page

It should display messages when the product are found
    [Documentation]    This keyword verifies that it should display messages when the product are found
    [Arguments]    ${content}    ${mess}
    TRY
        Search product on the search bar    ${content}
        Check the text elememt    ${mess}  
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't display message when the product is found 
    END

Click the sort dropdown
    [Documentation]    This keyword clicking the sort dropdown
    [Arguments]    ${locator}
    TRY
        Click on the web element    ${locator}   
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't clicking the sort dropdown field
    END


Users should view the search results after selected the view options
    [Documentation]    This keyword verifies that users should view the search results after selected the view options
    [Arguments]    ${select_value}
    TRY
        Search product on the search bar    ${PRODUCT_KEYWORD}
        Wait until page contain element    ${ARTLIST_ACTION_SORT_ELE}
        Select Option From Dropdown    ${ACTION_SORT_ELE}    ${select_value}
        ${selected_value}=    Wait and get element text    ${SELECT_OPTION_ELE}
        Should Be Equal As Strings    ${selected_value}    ${select_value}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It couldn't view the search results after selected the view options 
    END

Click delivery dropdown
    [Documentation]    This keyword clicking delivery dropdown
    [Arguments]    ${locator}
    TRY
        Hover Over Elenment    ${locator}
        Click on the web element    ${locator}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't clicking on the delivery dropdown 
    END

Select the checkbox
    [Documentation]    This keyword elect the checkbox
    [Arguments]    ${locator}
    TRY
        Hover Over Elenment    ${locator}
        Click on the web element    ${locator}
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
    [Arguments]    ${locator_atr}    ${locator_list}
    TRY
        ${checkbox_value}=    Get Element Attribute    ${locator_atr}    value
        ${lst2}=    Create List
        ${lst}=    Get WebElements    ${locator_list}
        ${length}=    Get Length    ${lst}
        FOR    ${element}    IN    @{lst}
            ${item}=    Get Element Attribute    ${element}    data-key
            Append To List    ${lst2}    ${item}
        END
        FOR    ${element}    IN    @{lst2}       
                Run Keyword If    ${checkbox_value} == ${element}    Pass Execution    Sucessfully
        END
    
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It isn't displayed the result after select checkbox 
    END

The search results page should be display the result of the filtered option 
    [Documentation]    This keyword verifies that the search results page should be display the result of the filtered option
    [Arguments]    ${locator_atr}    ${locator_list}    ${checkboxname}
    TRY
        ${lst}=       Get WebElements    ${locator_list}

        FOR    ${element}    IN    @{lst}
            Element Should Contain    ${element}    ${checkboxname}
        END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The search results page isn't displayed the result of the filtered option 
    END
The search result should be display enough information with image, name, rating, and price
    [Documentation]    This keyword verifies that the search result should be display enough information with image, name, rating, and price
    TRY
        ${result}=    Get WebElement    ${SEARCH_RESULT_ELE}    
        Page Should Contain Element                ${IMAGE_ELE}    ${result}
        Page Should Contain Element                ${NAME_ELE}             ${result}
        Page Should Contain Element                ${PRICESEARCHRESULT_ELE}      ${result}
        Click on the web element                                              ${IMAGE_ELE}
        Page Should Contain Element                ${RATING_ELE}      ${RATINGBOX_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    The search result isn't displayed enough information 
    END

It should display the error message
    [Documentation]    This keyword verifies that it should display the error message
    [Arguments]    ${text}
    TRY
        Check the text elememt    ${text}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It isn't displayed the error message 
    END
