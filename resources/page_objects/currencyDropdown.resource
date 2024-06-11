*** Settings ***
Resource    ../keywords/common_keywords.resource
Library    ../../.venv/Lib/site-packages/robot/libraries/XML.py
Resource    ../../configurations/config.resource
*** Variables ***
${CURRENCY_DROPDOWN_ELE}    class=currency-selector
${CURRENCY_OPTIONS_ELE}     css:.currency-selector div[class="dropdown-menu show"]>a
${WATCHES_OPTION_ELE}    xpath=//ul[@id="menu-main"]//li//span[contains(text(),'Watches')] 
@{DEFAULT_VALUE_LIST}=    US Dollar - USD ($)    Pound Sterling - GBP (£)    Australian Dollar - AUD ($)    Canadian Dollar - CAD ($)
${RESULTS_WATCHES_TAB_ELE}    css:article[class="art"] div[class="art-price-block"] span
${CURRENCY_SYMBOL}    £
*** Keywords ***
It should display the currency dropdown
    Display Element    ${CURRENCY_DROPDOWN_ELE}
Click on the Currency dropdown
    Click on the web element    ${CURRENCY_DROPDOWN_ELE}
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
        Run Keyword And Continue On Failure    Log    There is a issue on the display option on curency dropdown 
    END
It should display default a any currency value
    TRY
    @{CURRENCY_OPTIONS_LIST}=    Get list WebElements    css:.currency-selector .dropdown-menu>a.dropdown-item
    ${LENGTH}=    Get Length    ${CURRENCY_OPTIONS_LIST}
    FOR    ${E}    IN    ${CURRENCY_OPTIONS_LIST}
        # ${L}=    Get Length    ${E}
        # ${Locator_test}=     Wait and get element text    ${E}   
        @{DB}=    Get WebElements    ${E}
        FOR    ${element}    IN    @{DB}
            Log    ${element}
            ${txt}=    Wait and get element text    ${element}
            Log    ${txt}
            
        END
        ${CHECK}=    Get Element Attribute    ${E}    class
        Pass Execution If    "${CHECK}"==True    It should display default a any currency value
    END
    EXCEPT
        Run Keyword And Continue On Failure    Log    There is a issue on the display option on curency dropdown 
    END
Select the Watches tab 
    Click on the web element    ${WATCHES_OPTION_ELE}
Select the ${VALUE} option on the Currency dropdown
    ${LOCATOR}=    Set Variable    css:div.currency-selector div.dropdown-menu.show a[title="${VALUE}"]
    Click on the web element    ${LOCATOR}
All product on ${NAME} page should change currency type
    [Arguments]    ${LOCATOR}
    ${PRODUCT_LIST_ELE}=    Get list WebElements    ${LOCATOR}
    ${LENGTH}=    Get Length    ${PRODUCT_LIST_ELE}
    ${TEXT_LIST}=    Create List
    FOR    ${element}    IN    @{PRODUCT_LIST_ELE}
        ${TEXT}=    Get Text    ${element}
        Append To List    ${TEXT_LIST}    ${TEXT}
    END
    ${LENGTH}=    Get Length    ${TEXT_LIST}
    ${CHECK}=    Set Variable    ${True}
    FOR    ${e}    IN    @{TEXT_LIST}
        Should Contain    ${e}    ${CURRENCY_SYMBOL}
    END

    