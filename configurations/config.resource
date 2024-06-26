*** Settings ***
Library    String
Library    Collections
Library    DateTime
Library    RequestsLibrary
Library    OperatingSystem
Library    SeleniumLibrary

*** Variables ***
# Server and domain info
${URL_HOME}    https://bearstore-testsite.smartbear.com/
${URL_LOGIN}    ${URL_HOME}login 
${URL_PASSWORDRECOVERY}    ${URL_HOME}customer/passwordrecovery
${URL_CONTACT}    ${URL_HOME}contactus
${URL_BOOKS}    ${URL_HOME}books 
${URL_FURNITURE}    ${URL_HOME}furniture 
${URL_SPORTS}    ${URL_HOME}sports 
${URL_GAMING}    ${URL_HOME}gaming 
${URL_WATCHES}    ${URL_HOME}watches
${URL_GIFTCARDS}    ${URL_HOME}gift-cards
${URL_WHATNEW}    ${URL_HOME}/newproducts
${URL_RECENTLYVIEWEDPRODUCTS}    ${URL_HOME}recentlyviewedproducts
${URL_COMPAREPRODUCTS}    ${URL_HOME}compareproducts
${URL_ABOUTUS}    ${URL_HOME}aboutus
${URL_DISCLAIMER}    ${URL_HOME}disclaimer
${URL_SHIPPINGINFO}    ${URL_HOME}shippinginfo
${URL_CONDITIONSOFUSE}    ${URL_HOME}conditionsofuse
${URL_CART}               ${URL_HOME}cart
${URL_LOGIN_CHECKOUT}                         ${URL_HOME}login?checkoutAsGuest=True&returnUrl=%2Fcart
${URL_BILLINGADDRESS}    ${URL_HOME}checkout/billingaddress
${URL_SHIPPINGADDRESS}    ${URL_HOME}shippingaddress

# User infor
${NORMAL_USER}    tt1999@gmail.com
${NORMAL_USER_PASS}    12345678


# System
${BROWSER}              Firefox
${DELAY}                0
