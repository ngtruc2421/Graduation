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
*** Keywords ***
Navigative to the Payement page
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
        Display the web element    Once your order is placed, you will be contacted by our staff to confirm the order
        Scroll to    document.body.scrollHeight
        Display Element    ${CARDTYPE_INPUT_ELE}
        Display Element    ${CARDNAME_INPUT_ELE}
        Display Element    ${CARDNUM_INPUT_ELE}
        Display Element    ${EXMONTH_INPUT_ELE}
        Display Element    ${EXYEAR_INPUT_ELE}
        Display Element    ${CARDCODE_INPUT_ELE}
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

Click on the Next button on the Payement page
    TRY
        Click on the Next button
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Next button on the Payement page" keyword
    END

It should validate payment information before proceeding
    TRY
        Display element    id=payment-info-validation-summary
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should validate payment information before proceeding" keyword
    END
