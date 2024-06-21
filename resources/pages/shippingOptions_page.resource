*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/common_keywords.resource
Resource    ../../resources/pages/shippingOptions_page.resource
Resource    ../../resources/pages/addressEntry_page.resource
Resource    ../../resources/pages/productdetail_page.resource
*** Variables ***
${SHIPPING_OPTION_ELE}     css:td[class="cart-summary-label"]>span:nth-child(2)
${TOTAL_ELE}               css:tr[class="cart-summary-total"]>td[class="cart-summary-value"]>span
${SHIPPING_OPTIONS_ELE}    css:ul.shipping-options>li
${JAVASCRIP_VALUE}         window.scrollTo(0, document.body.scrollHeight)
${SHIPPING_ITEM_ELE}       xpath=//span[contains(text(),"By Ground")]
*** Keywords ***
It should display available options for shipping
    [Documentation]    This keyword verifies that it should display available options for shipping
    TRY
        ${SHIPPING_OPTION_LIST}=    Get list WebElements    ${SHIPPING_OPTIONS_ELE}
        FOR    ${E}    IN    @{SHIPPING_OPTION_LIST}
            Wait until page contain element    ${E}
        END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should display available options for shipping" keyword
    END
The system should allow select the shipping option
    [Documentation]    This keyword verifies that the system should allow select the shipping option
    TRY
        Click on button    ${SHIPPING_ITEM_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "User should select the shipping option" keyword
    END
The system should be update the order total accordingly after user select the shipping option
    [Documentation]    This keyword verifies that the system should be update the order total accordingly after user select the shipping option
    TRY
        Click on the Next button
        Click on the Next button
        Execute Javascript    ${JAVASCRIP_VALUE}
        ${VALUE}=    Wait and get element text    ${SHIPPING_OPTION_ELE}
        Should Be Equal As Strings    ${VALUE}    By Ground
        ${SUM}=    Wait and get element text    ${TOTAL_ELE}
        ${SUM}=    Split String    ${SUM}    $    1
        ${NUMBER_STRING_WITHOUT_COMMAS}=    Replace String    ${SUM}[1]    ,    ${EMPTY}
        ${NUMBER_STRING_WITHOUT_DECIMAL}=    Replace String    ${NUMBER_STRING_WITHOUT_COMMAS}    .    ${EMPTY}
        ${NUMBER_STRING_COVERT_INT}=    Convert To Integer    ${NUMBER_STRING_WITHOUT_DECIMAL}
        Run Keyword If    ${NUMBER_STRING_COVERT_INT}<0    Fail    Don't have total price
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "User should select the shipping option" keyword
    END
The Shipping page should be Open
    [Documentation]    This keyword the Shipping page should be Open
    TRY
        The page should be opened    Select shipping method    ${PAGE_TITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "The Shipping page should be Open" keyword
    END

The system should show a "Back" button to return to the Address Entry page
    [Documentation]    This keyword verifies that the system should show a "Back" button to return to the Address Entry page
    TRY
        Click on the Back button on the Shipping page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "The system should show a "Back" button to return to the Address Entry page" keyword
    END