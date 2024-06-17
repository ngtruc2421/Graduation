*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/common_keywords.resource
Resource    ../../resources/pages/shippingOptions_page.resource
*** Variables ***
*** Keywords ***
Navigative to the Payement page
    Click on the Next button
The Payement page should be have the Back button for return to the Shipping page
    Click on the Back button on the Payement page

    