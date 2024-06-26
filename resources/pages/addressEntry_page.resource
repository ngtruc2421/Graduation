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
${FIRST_NAME}                           Truc
${LAST_NAME}                            Tran
${LONDON}                               London
${NEWYORK}                              New York
${BILLINGADDRESS}                       Billing address
${ADDRESSTITLE_PAGE_ELE}                           css:.page-title

*** Keywords ***
Open the Billing Address page
    [Documentation]    Open the Billing Address page by access to Billing Address URL
    TRY
        Access to url    ${URL_BILLINGADDRESS}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't open the Billing Address page
    END
Open the Shipping Address page
    [Documentation]    Open the Shipping Address page by access to Shipping Address URL
    TRY
        Access to url    ${URL_SHIPPINGADDRESS}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't open the Shipping Address page
    END
Click on the Next button
    [Documentation]    Hover and clicking on the Next button
    TRY
        Hover Over Elenment    ${NEXT_BTN_ELE}
        Click on button    ${NEXT_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the Next button
    END

Click on the Smartbear brand
    [Documentation]    Clicking on the Smartbear brand image
    TRY
        Click on the web element    ${BRAND_IMG_ELE}        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the Smartbear brand
    END
Click on the Bill to this address button on the Billing page
    [Documentation]    Clicking on the locator that contains the locator of the Bill to this address button
    TRY
        Click on button    ${BILLTOTHISADDRESS_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the "Bill to this address" button
    END

Click on the Ship to this address button on the Shipping page
    [Documentation]    Clicking on the locator that contains the locator of the Ship to this address button
    TRY
        Click on button    ${SHIPTOTHISADDRESS_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the "Ship to this address" button
    END

Click on the Back button on the ${name} page
    [Documentation]    Clicking on the locator that contains the locator of the Back button on the ${name} page
    TRY
        Hover Over Elenment    ${BACK_BTN_ELE}
        Click on button    ${BACK_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Couldn't click on the "Back" button on the ${name} page
    END

It should be include Back button for return to the Cart page
    [Documentation]    Checking if the Cart page includes the Back button?
    TRY
        Wait until page contain element    ${ADDRESSTITLE_PAGE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    It doesn't have the "Back" button for return to the Cart page
    END

It should allow using the same address for billing and shipping
    [Documentation]    Checking if the system allow to using the same address for billing and shipping?
    TRY
        Click on the Bill to this address button on the Billing page
        Click on the Ship to this address button on the Shipping page
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    It doesn't using the same address for billing and shipping
    END

Input data for the ${name} fields
    [Documentation]    Input text for the Firstname, lastname, address1, address2 field on the page
    TRY
        Input value for a field    ${FIRST_NAME}    ${FIRSTNAME_INPUT_ELE}
        Input value for a field    ${LAST_NAME}    ${LASTNAME_INPUT_ELE}
        Input value for a field    ${LAST_NAME}    ${ADDRESS1_INPUT_ELE}
        Input value for a field    ${FIRST_NAME}    ${ADDRESS2_INPUT_ELE}

    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't input data for the ${name} fields
    END
It should validate the address
    [Documentation]    Checking if the system validates address?
    TRY
        The page should be opened    ${BILLINGADDRESS}    ${ADDRESSTITLE_PAGE_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    It doesn't validate the address
    END
It should provides input fields for ${name} address details
    [Documentation]    Checking if the system provides the input fields for ${name} address details?
    TRY
        Input value for a field    ${FIRST_NAME}    ${FIRSTNAME_INPUT_ELE}
        Input value for a field    ${LAST_NAME}     ${LASTNAME_INPUT_ELE}
        Input value for a field    ${LONDON}        ${ADDRESS1_INPUT_ELE}
        Input value for a field    ${NEWYORK}       ${ADDRESS2_INPUT_ELE}
    EXCEPT
        Run Keyword And Continue On Failure    Fail    It couldn't provide input fields for ${name} address details
    END
It should be include options to save addresses for future use
    [Documentation]    Checking if the system includes options to save addresses for future use?
    TRY
        Wait until page contain element    ${ADDRESSCARD_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    It doesn't include options to save address for future use
    END