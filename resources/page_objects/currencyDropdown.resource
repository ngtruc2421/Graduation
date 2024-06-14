*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../../configurations/config.resource
*** Variables ***
${CURRENCY_DROPDOWN_ELE}    class=currency-selector
${CURRENCY_OPTIONS_ELE}     css:.currency-selector div[class="dropdown-menu show"]>a
${WATCHES_OPTION_ELE}       xpath=//ul[@id="menu-main"]//li//span[contains(text(),'Watches')] 
@{DEFAULT_VALUE_LIST}=    US Dollar - USD ($)    Pound Sterling - GBP (£)    Australian Dollar - AUD ($)    Canadian Dollar - CAD ($)
${RESULTS_WATCHES_TAB_ELE}    css:article[class="art"] div[class="art-price-block"] span
${CURRENCY_SYMBOL}    £
${ARTPRICE_ELE}    css:.art-price
${PRICEONCOMPARETAB_ELE}    css:#occ-compare span.price.unit-price
${CURRENCY_ITEM_ELE}    css:.currency-selector .dropdown-menu>a.dropdown-item
${PRODUCT_ITEM_ELE}    css:article[data-id="1"]
${PRICEBLOCK_ELE}    css:div.pd-price-block div.pd-price span
${PRICEONCART_ELE}    css:#occ-cart span.price.unit-price
${FOOTERCART_ELE}    css:div.offcanvas-cart-footer div.sub-total.price
${WISHLIST_ELE}    css:#occ-wishlist span.price.unit-price
*** Keywords ***
It should display the currency dropdown
    TRY
        Display Element    ${CURRENCY_DROPDOWN_ELE}
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
    @{CURRENCY_OPTIONS_LIST}=    Get list WebElements    ${CURRENCY_OPTIONS_ELE}
    ${LENGTH}=    Get Length    ${DEFAULT_VALUE_LIST}
    ${VALUE_CURRENCY_LIST}=    Create List
    FOR    ${E}    IN    @{CURRENCY_OPTIONS_LIST}
        ${VALUE}=    Get Text    ${E}    
        Append To List    ${VALUE_CURRENCY_LIST}    ${VALUE}                    
    END
    FOR    ${I}    IN RANGE    1    ${LENGTH}
        ${ITEM1}=    Set Variable    ${DEFAULT_VALUE_LIST}[${I}]
        ${ITEM2}=    Set Variable    ${VALUE_CURRENCY_LIST}[${I}]
        Should Be Equal As Strings    ${ITEM1}    ${ITEM2}        
    END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should display four optionS including USD, GBP, AUD, CAD" keyword 
    END
It should display default a any currency value
    TRY
    @{CURRENCY_OPTIONS_LIST}=    Get list WebElements    ${CURRENCY_ITEM_ELE}
    ${LENGTH}=    Get Length    ${CURRENCY_OPTIONS_LIST}
    FOR    ${E}    IN    @{CURRENCY_OPTIONS_LIST}            
        ${CHECK}=    Get Element Attribute    ${E}    data-selected
        Pass Execution If    "${CHECK}"=="true"    It should display default a any currency value
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

Select the ${VALUE} option on the Currency dropdown
    TRY
        ${LOCATOR}=    Set Variable    css:div.currency-selector div.dropdown-menu.show a[title="${VALUE}"]
        Click on the web element    ${LOCATOR}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the ${VALUE} option on the Currency dropdown" keyword 
    END

All product on Listing page should change currency type
    TRY
        ${PRODUCT_LIST_ELE}=    Get list WebElements    ${RESULTS_WATCHES_TAB_ELE}
        ${LENGTH}=    Get Length    ${PRODUCT_LIST_ELE}
        ${TEXT_LIST}=    Create List
        FOR    ${E}    IN    @{PRODUCT_LIST_ELE}
            ${TEXT}=    Get Text    ${E}
            Append To List    ${TEXT_LIST}    ${TEXT}
        END
        ${LENGTH}=    Get Length    ${TEXT_LIST}
        ${CHECK}=    Set Variable    ${True}
        FOR    ${E}    IN    @{TEXT_LIST}
            Should Contain    ${E}    ${CURRENCY_SYMBOL}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "All product on Listing page should change currency type" keyword 
    END

Select a product on the Featured product section
    TRY
        Hover Over Elenment    ${PRODUCT_ITEM_ELE}    300
        Click on the web element    ${PRODUCT_ITEM_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select a product on the Featured product secsion" keyword 
    END

It should changes the currency on the Detail page
    TRY
        ${VALUE}=    Wait and get element text    ${PRICEBLOCK_ELE}
        Should Contain    ${VALUE}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the curency on the Detail page" keyword 
    END

It should changes the currency on the Shopping cart
    TRY
        ${VALUE1}=    Wait and get element text    ${PRICEONCART_ELE}
        Should Contain    ${VALUE1}    ${CURRENCY_SYMBOL}
        ${VALUE2}=    Wait and get element text    ${FOOTERCART_ELE}
        Should Contain    ${VALUE2}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the currency on the Shopping cart" keyword 
    END

It should changes the currency on the Wishlist tab
    TRY
        ${VALUE}=    Wait and get element text    ${WISHLIST_ELE}
        Should Contain    ${VALUE}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the currency on the Wishlist tab" keyword 
    END

It should changes the currency on the Compare tab
    TRY
        ${VALUE}=    Wait and get element text    ${PRICEONCOMPARETAB_ELE}
        Should Contain    ${VALUE}    ${CURRENCY_SYMBOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should changes the currency on the Compare tab" keyword 
    END

It should change in real time when the user changes the currency type
    TRY
        @{LIST}    Get list WebElements    ${ARTPRICE_ELE}
        FOR    ${E}    IN    @{LIST}
            ${V}=    Wait and get element text    ${E}
            Should Contain    ${V}    ${CURRENCY_SYMBOL}
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should change in real time when the user changes the currency type" keyword 
    END
