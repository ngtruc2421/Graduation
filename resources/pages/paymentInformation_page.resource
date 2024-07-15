*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/common_keywords.resource
Resource    ../../resources/pages/shippingOptions_page.resource
*** Variables ***
${CREDITCARD_OPTION_ELE}     xpath=//span[contains(text(),"Credit card")]
${CARDTYPE_INPUT_ELE}        id=CreditCardType
${CARDNAME_INPUT_ELE}        id=CardholderName
${CARDNUM_INPUT_ELE}         id=CardNumber
${EXMONTH_INPUT_ELE}         id=ExpireMonth
${EXYEAR_INPUT_ELE}          id=ExpireYear
${CARDCODE_INPUT_ELE}        id=CardCode
${CREDITCARD_FROM_ELE}       id=payment-info-validation-summary
${PROTOCOL}                  https
*** Keywords ***
Navigate to the Payment page
    [Documentation]    This keyword verifies that navigate to the Payment page
    TRY
        Click on the Next button           
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Navigative to the Payement page" keyword
    END
The Payement page should be have the Back button for return to the Shipping page
    [Documentation]    This keyword verifies that the Payement page should be have the Back button for return to the Shipping page
    TRY
        Click on the Back button on the Payement page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "The Payement page should be have the Back button for return to the Shipping page" keyword
    END
Select the Credit card option on the Payment page
    [Documentation]    This keyword selecting the Credit card option on the Payment page
    TRY
        Click on the web element    ${CREDITCARD_OPTION_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the Credit card option on the Payment page" keyword
    END
It should displays the Credit card form and the input fields for Credit card option
    [Documentation]    This keyword verifies that it should displays the Credit card form and the input fields for Credit card option
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
    [Documentation]    This keyword get the Card type list
    TRY
        ${list}=    Get list WebElements    ${CARDTYPE_INPUT_ELE}
        RETURN    ${list}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Next button on the Payement page" keyword
    END
The Payment page should be safe
    [Documentation]    This keyword verifies that the Payment page should be safe
    TRY
        ${location}=    Get Location
        Should Contain    ${location}    ${PROTOCOL}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the Credit card option on the Payment page" keyword
    END

Select the "${option_name}" on the "Select your credit card" dropdown field
    [Documentation]    This keyword selecting the "${option_name}" on the "Select your credit card" dropdown field
    TRY
        Click on the web element    ${CARDTYPE_INPUT_ELE}
        Click on the web element    xpath=//select[@id="CreditCardType"]//option[contains(text(),"${option_name}")]
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the "${option_name}" on the "Select your credit card" dropdown field" keyword
    END

Enters the "${card_name}" on the "Cardholder name" field
    [Documentation]    This keyword enters the "${card_name}" on the "Cardholder name" field
    TRY
        Input value for a field    ${card_name}    ${CARDNAME_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Enters the "${card_name}" on the "Cardholder name" field" keyword
    END

Enters the "${card_number}" on the "Card number" field
    [Documentation]    This keyword enters the "${card_number}" on the "Card number" field
    TRY
        Input value for a field    ${card_number}    ${CARDNUM_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Enters the "${card_number}" on the "Card number" field" keyword
    END

Enters the "${card_code}" on the "Card code" field
    [Documentation]    This keyword enters the "${card_code}" on the "Card code" field
    TRY
        Input value for a field    ${card_code}    ${CARDCODE_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Enters the "${card_code}" on the "Card code" field" keyword
    END

Select the "${mm}" on the "Valid until" month dropdown field
    [Documentation]    This keyword select the "${mm}" on the "Valid until" month dropdown field
    TRY
        Click on the web element    ${EXMONTH_INPUT_ELE}
        Click on the web element    xpath=//select[@id="ExpireMonth"]//option[contains(text(),"${mm}")]
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the ${mm} on the "Valid until" dropdown field" keyword
    END
Select the "${yyyy}" on the "Valid until" year dropdown field
    [Documentation]    This keyword select the "${yyyy}" on the "Valid until" year dropdown field
    TRY
        Click on the web element    ${EXYEAR_INPUT_ELE}
        Click on the web element    xpath=//select[@id="ExpireYear"]//option[contains(text(),"${yyyy}")]
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Select the ${yyyy} on the "Valid until" dropdown field" keyword
    END

Click on the Next button on the Payment page
    [Documentation]    This keyword click on the Next button on the Payment page
    TRY
        Click on the Next button
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Next button on the Payement page" keyword
    END

It should validate payment information before proceeding
    [Documentation]    This keyword verifies that it should validate payment information before proceeding
    TRY
        Wait until page contain element    ${CREDITCARD_FROM_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should validate payment information before proceeding" keyword
    END
It should display the warning message
    [Documentation]    This keyword verifies that it should display the warning message
    [Arguments]    ${cardholdername}    ${cardnumber}    ${cardcode}    ${mess}
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
        Enters the "${cardholdername}" on the "Cardholder name" field
        Enters the "${cardnumber}" on the "Card number" field
        Select the "05" on the "Valid until" month dropdown field
        Select the "2030" on the "Valid until" year dropdown field
        Enters the "${cardcode}" on the "Card code" field
        Click on the Next button on the Payment page
        Check the text elememt    ${mess}
        Close the web page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue with the "It should display the warning message" keyword
    END