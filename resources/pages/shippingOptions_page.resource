*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/common_keywords.resource
Resource    ../../resources/pages/shippingOptions_page.resource
Resource    ../../resources/pages/addressEntry_page.resource
Resource    ../../resources/pages/productdetail_page.resource
*** Variables ***
${SHIPPING_OPTION_ELE}        css:td[class="cart-summary-label"]>span:nth-child(2)
${TOTAL_ELE}                  css:tr[class="cart-summary-total"]>td[class="cart-summary-value"]>span
${SHIPPING_OPTIONS_ELE}       css:ul.shipping-options>li
${JAVASCRIP_VALUE}            window.scrollTo(0, document.body.scrollHeight)
${SHIPPING_ITEM_ELE}          xpath=//span[contains(text(),"By Ground")]
${BYGROUND}                   By Ground
${DOLAR}                      $
${SELECTSHIPPINGMETHOD}       Select shipping method
${SHIPPINGMETHOD_PAGETITLE_ELE}       css:.page-title
*** Keywords ***
It should display available options for shipping
    [Documentation]    This keyword verifies that it should display available options for shipping
    TRY
        ${shipping_option_list}=    Get list WebElements    ${SHIPPING_OPTIONS_ELE}
        FOR    ${e}    IN    @{shipping_option_list}
            Wait until page contain element    ${e}
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
        Wait Until Page Contains Element    ${NEXT_BTN_ELE}
        Click on the Next button
        Execute Javascript    ${JAVASCRIP_VALUE}
        ${value}=    Wait and get element text    ${SHIPPING_OPTION_ELE}
        Should Be Equal As Strings    ${value}    ${BYGROUND}    
        ${sum}=    Wait and get element text    ${TOTAL_ELE}
        ${sum}=    Split String    ${sum}    ${DOLAR}    1
        ${number_string_without_commas}=    Replace String    ${sum}[1]    ,    ${EMPTY}
        ${number_string_without_decimal}=    Replace String    ${number_string_without_commas}    .    ${EMPTY}
        ${number_string_covert_int}=    Convert To Integer    ${number_string_without_decimal}
        Run Keyword If    ${number_string_covert_int}<0    Fail    Don't have total price
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "User should select the shipping option" keyword
    END
The Shipping page should be Open
    [Documentation]    This keyword the Shipping page should be Open
    TRY
        The page should be opened    ${SELECTSHIPPINGMETHOD}    ${SHIPPINGMETHOD_PAGETITLE_ELE}
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