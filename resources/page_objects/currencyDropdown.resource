*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../../configurations/config.resource
*** Variables ***
${CURRENCY_DROPDOWN_ELE}    class=currency-selector
${CURRENCY_OPTIONS_ELE}     css:.currency-selector div[class="dropdown-menu show"]>a
${WATCHES_OPTION_ELE}       xpath=//ul[@id="menu-main"]//li//span[contains(text(),'Watches')] 
@{DEFAULT_VALUE_LIST}=    US Dollar - USD ($)    Pound Sterling - GBP (£)    Australian Dollar - AUD ($)    Canadian Dollar - CAD ($)
${RESULTS_WATCHES_TAB_ELE}    css:article[class="art"] div[class="art-price-block"] span
${CURRENCY_SYMBOL}        £
${ARTPRICE_ELE}            css:.art-price
${PRICEONCOMPARETAB_ELE}    css:#occ-compare span.price.unit-price
${CURRENCY_ITEM_ELE}        css:.currency-selector .dropdown-menu>a.dropdown-item
${PRICEBLOCK_ELE}        css:div.pd-price-block div.pd-price span
${PRICEONCART_ELE}        css:#occ-cart span.price.unit-price
${FOOTERCART_ELE}        css:div.offcanvas-cart-footer div.sub-total.price
${WISHLIST_ELE}          css:#occ-wishlist span.price.unit-price
*** Keywords ***
It should display the currency dropdown
    TRY
        Wait until page contain element    ${CURRENCY_DROPDOWN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should display the currency dropdown" keyword 
    END
Click on the Currency dropdown
    TRY
        Click on the web element    ${CURRENCY_DROPDOWN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Currency dropdown" keyword 
    END

It should display four optionS including USD, GBP, AUD, CAD
    TRY
    @{currency_options_list}=    Get list WebElements    ${CURRENCY_OPTIONS_ELE}
    ${length}=    Get Length    ${DEFAULT_VALUE_LIST}
    ${value_currency_list}=    Create List
    FOR    ${E}    IN    @{currency_options_list}
        ${VALUE}=    Get Text    ${E}    
        Append To List    ${value_currency_list}    ${VALUE}                    
    END
    FOR    ${I}    IN RANGE    1    ${length}
        ${ITEM1}=    Set Variable    ${DEFAULT_VALUE_LIST}[${I}]
        ${ITEM2}=    Set Variable    ${value_currency_list}[${I}]
        Should Be Equal As Strings    ${ITEM1}    ${ITEM2}        
    END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should display four optionS including USD, GBP, AUD, CAD" keyword 
    END
It should display default a any currency value
    TRY
    @{currency_options_list}=    Get list WebElements    ${CURRENCY_ITEM_ELE}
    ${length}=    Get Length    ${currency_options_list}
    FOR    ${e}    IN    @{currency_options_list}            
        ${check}=    Get Element Attribute    ${e}    data-selected
        Pass Execution If    "${check}"=="true"    It should display default a any currency value
    END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should display default a any currency value" keyword 
    END
Select the Watches tab 
    TRY
        Click on the web element    ${WATCHES_OPTION_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the Watches tab" keyword 
    END

Select the ${value} option on the Currency dropdown
    TRY
        ${locator}=    Set Variable    css:div.currency-selector div.dropdown-menu.show a[title="${value}"]
        Click on the web element    ${locator}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the ${value} option on the Currency dropdown" keyword 
    END

All product on Listing page should change currency type
    TRY
        ${product_list_ele}=    Get list WebElements    ${RESULTS_WATCHES_TAB_ELE}
        # ${length}=    Get Length    ${product_list_ele}
        ${text_list}=    Create List
        FOR    ${e}    IN    @{product_list_ele}
            ${text}=    Get Text    ${e}
            Append To List    ${text_list}    ${text}
        END
        # ${LENGTH}=    Get Length    ${text_list}
        ${check}=    Set Variable    ${True}
        FOR    ${e}    IN    @{text_list}
            Should Contain    ${e}    ${CURRENCY_SYMBOL}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "All product on Listing page should change currency type" keyword 
    END


It should changes the currency on the Detail page
    TRY
        ${value}=    Wait and get element text    ${PRICEBLOCK_ELE}
        Should Contain    ${value}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the curency on the Detail page" keyword 
    END

It should changes the currency on the Shopping cart
    TRY
        ${value1}=    Wait and get element text    ${PRICEONCART_ELE}
        Should Contain    ${value1}    ${CURRENCY_SYMBOL}
        ${value2}=    Wait and get element text    ${FOOTERCART_ELE}
        Should Contain    ${value2}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the currency on the Shopping cart" keyword 
    END

It should changes the currency on the Wishlist tab
    TRY
        ${value}=    Wait and get element text    ${WISHLIST_ELE}
        Should Contain    ${value}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the currency on the Wishlist tab" keyword 
    END

It should changes the currency on the Compare tab
    TRY
        ${value}=    Wait and get element text    ${PRICEONCOMPARETAB_ELE}
        Should Contain    ${value}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the currency on the Compare tab" keyword 
    END

It should change in real time when the user changes the currency type
    TRY
        @{list}    Get list WebElements    ${ARTPRICE_ELE}
        FOR    ${e}    IN    @{list}
            ${v}=    Wait and get element text    ${e}
            Should Contain    ${v}    ${CURRENCY_SYMBOL}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should change in real time when the user changes the currency type" keyword 
    END
