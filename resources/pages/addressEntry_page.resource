*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_keywords.resource
*** Variables ***
${ADDRESSCARD_ELE}                      class=address-list-item
${FIRSTNAME_INPUT_ELE}                  id=NewAddress_FirstName
${LASTNAME_INPUT_ELE}                   id=NewAddress_LastName
${ADDRESS1_INPUT_ELE}                   id=NewAddress_Address1
${ADDRESS2_INPUT_ELE}                   id=NewAddress_Address2
${CITY_INPUT_ELE}                       id=NewAddress_City
${COUNTRYID_INPUT_ELE}                  id=NewAddress_CountryId
${EMAIL_INPUT_ELE}                      id=NewAddress_Email
${PHONENUMBER_INPUT_ELE}                id=NewAddress_PhoneNumber
${BACK_BTN_ELE}                         xpath=//span[contains(text(),"Back")]
${SHIPTOTHISADDRESS_BTN_ELE}            xpath=//span[contains(text(),"Ship to this address")]
${BILLTOTHISADDRESS_BTN_ELE}            xpath=//span[contains(text(),"Bill to this address")]
${NEXT_BTN_ELE}                         xpath=//span[contains(text(),"Next")]
${BRAND_IMG_ELE}                        css:a[class="brand"]
*** Keywords ***
Open the Billing Address page
    TRY
        Access to url    ${URL_BILLINGADDRESS}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Open the Billing Address page" keyword
    END
Open the Shipping Address page
    TRY
        Access to url    ${URL_SHIPPINGADDRESS}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Open the Shipping Address page" keyword
    END
Click on the Next button
    TRY
        Hover Over Elenment    ${NEXT_BTN_ELE}
        Click on button    ${NEXT_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Next button" keyword
    END

Click on the Smartbear brand
    TRY
        Click on the web element    ${BRAND_IMG_ELE}        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Smartbear brand" keyword
    END
Click on the Bill to this address button on the Billing page
    TRY
        Click on button    ${BILLTOTHISADDRESS_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Bill to this address button on the Billing page" keyword
    END

Click on the Ship to this address button on the Shipping page
    TRY
        Click on button    ${SHIPTOTHISADDRESS_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Ship to this address button on the Shipping page" keyword
    END

Click on the Back button on the ${NAME} page
    TRY
        Hover Over Elenment    ${BACK_BTN_ELE}
        Click on button    ${BACK_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Click on the Back button on the Billing page" keyword
    END

It should be include Back button for return to the Cart page
    TRY
        Display Element    ${PAGETITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should be include Back button for return to the Cart page" keyword
    END

It should allow using the same address for billing and shipping
    Click on the Bill to this address button on the Billing page
    Click on the Ship to this address button on the Shipping page
Input data for the ${NAME} fields
    TRY
        Input value for a field    Truc    ${FIRSTNAME_INPUT_ELE}
        Input value for a field    Tran    ${LASTNAME_INPUT_ELE}
        Input value for a field    Tran    ${ADDRESS1_INPUT_ELE}
        Input value for a field    Truc    ${ADDRESS2_INPUT_ELE}

    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "Observe the input fields for the billing address details" keyword
    END
It should validate the address
    TRY
        The page should be opened    Billing address    ${PAGE_TITLE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should validate the address" keyword
    END
It should provides input fields for ${NAME} address details
    TRY
        Input value for a field    Truc    ${FIRSTNAME_INPUT_ELE}
        Input value for a field    Tran    ${LASTNAME_INPUT_ELE}
        Input value for a field    London    ${ADDRESS1_INPUT_ELE}
        Input value for a field    New York    ${ADDRESS2_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    There is a issue on the "It should provides input fields for billing address details" keyword
    END
It should be include options to save addresses for future use
    TRY
        Display Element    ${ADDRESSCARD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a issue on the "IIt should be include options to save addresses for future use" keyword
    END