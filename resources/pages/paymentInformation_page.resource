*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/common_keywords.resource
Resource    ../../resources/pages/shippingOptions_page.resource
*** Variables ***
${CREDITCARD_OPTION_ELE}    xpath=//span[contains(text(),"Credit card")]
${CARDTYPE_INPUT_ELE}    id=CreditCardType
${CARDNAME_INPUT_ELE}    id=CardholderName
${CARDNUM_INPUT_ELE}    id=CardNumber
${EXMONTH_INPUT_ELE}    id=ExpireMonth
${EXYEAR_INPUT_ELE}    id=ExpireYear
${CARDCODE_INPUT_ELE}    id=CardCode
${CREDITCARD_FROM_ELE}    id=payment-info-validation-summary
*** Keywords ***
Navigate to the Payment page
    TRY
        Click on the Next button           
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Navigative to the Payement page" keyword
    END
The Payement page should be have the Back button for return to the Shipping page
    TRY
        Click on the Back button on the Payement page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "The Payement page should be have the Back button for return to the Shipping page" keyword
    END
Select the Credit card option on the Payment page
    TRY
        Click on the web element    ${CREDITCARD_OPTION_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the Credit card option on the Payment page" keyword
    END
It should displays the Credit card form and the input fields for Credit card option
    TRY
        Check the text elememt    Once your order is placed, you will be contacted by our staff to confirm the order
        Scroll to    document.body.scrollHeight
        Wait until page contain element    ${CARDTYPE_INPUT_ELE}
        Wait until page contain element    ${CARDNAME_INPUT_ELE}
        Wait until page contain element    ${CARDNUM_INPUT_ELE}
        Wait until page contain element    ${EXMONTH_INPUT_ELE}
        Wait until page contain element    ${EXYEAR_INPUT_ELE}
        Wait until page contain element    ${CARDCODE_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should displays the Credit card form and the input fields for Credit card option" keyword
    END

Get the Card type list
    TRY
        ${LIST}=    Get list WebElements    ${CARDTYPE_INPUT_ELE}
        RETURN    ${LIST}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Next button on the Payement page" keyword
    END
The Payment page should be safe
    TRY
        ${LOCATION}=    Get Location
        Should Contain    ${LOCATION}    https
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the Credit card option on the Payment page" keyword
    END

Select the "${OPTION_NAME}" on the "Select your credit card" dropdown field
    TRY
        Click on the web element    ${CARDTYPE_INPUT_ELE}
        Click on the web element    xpath=//select[@id="CreditCardType"]//option[contains(text(),"${OPTION_NAME}")]
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the "${OPTION_NAME}" on the "Select your credit card" dropdown field" keyword
    END

Enters the "${CARD_NAME}" on the "Cardholder name" field
    TRY
        Input value for a field    ${CARD_NAME}    ${CARDNAME_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Enters the "${CARD_NAME}" on the "Cardholder name" field" keyword
    END

Enters the "${CARD_NUMBER}" on the "Card number" field
    TRY
        Input value for a field    ${CARD_NUMBER}    ${CARDNUM_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Enters the "${CARD_NUMBER}" on the "Card number" field" keyword
    END

Enters the "${CARD_CODE}" on the "Card code" field
    TRY
        Input value for a field    ${CARD_CODE}    ${CARDCODE_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Enters the "${CARD_CODE}" on the "Card code" field" keyword
    END

Select the "${MM}" on the "Valid until" month dropdown field
    TRY
        Click on the web element    ${EXMONTH_INPUT_ELE}
        Click on the web element    xpath=//select[@id="ExpireMonth"]//option[contains(text(),"${MM}")]
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the ${MM} on the "Valid until" dropdown field" keyword
    END
Select the "${YYYY}" on the "Valid until" year dropdown field
    TRY
        Click on the web element    ${EXYEAR_INPUT_ELE}
        Click on the web element    xpath=//select[@id="ExpireYear"]//option[contains(text(),"${YYYY}")]
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the ${YYYY} on the "Valid until" dropdown field" keyword
    END

Click on the Next button on the Payment page
    TRY
        Click on the Next button
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Next button on the Payement page" keyword
    END

It should validate payment information before proceeding
    TRY
        Wait until page contain element    ${CREDITCARD_FROM_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should validate payment information before proceeding" keyword
    END
It should display the warning message
    [Arguments]    ${CARDHOLDERNAME}    ${CARDNUMBER}    ${CARDCODE}    ${MESS}
    TRY
        Open the Login page
        Log in the system    ${NORMAL_USER}    ${NORMAL_USER_PASS}
        Select a product on the Featured product section
        Click on Add Product button from product detail page
        Click the "Checkout" button in the sidebar
        Click on the Bill to this address button on the Billing page
        Click on the Ship to this address button on the Shipping page
        Navigate to the Payment page
        Select the Credit card option on the Payment page
        Select the "Master Card" on the "Select your credit card" dropdown field
        Enters the "${CARDHOLDERNAME}" on the "Cardholder name" field
        Enters the "${CARDNUMBER}" on the "Card number" field
        Select the "05" on the "Valid until" month dropdown field
        Select the "2030" on the "Valid until" year dropdown field
        Enters the "${CARDCODE}" on the "Card code" field
        Click on the Next button on the Payment page
        Check the text elememt    ${MESS}
        Close the web page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue with the "It should display the warning message" keyword
    END