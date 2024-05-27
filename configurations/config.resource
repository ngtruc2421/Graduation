*** Settings ***
Library    String
Library    Collections
Library    DateTime
Library    RequestsLibrary
Library    OperatingSystem
Library    SeleniumLibrary

*** Variables ***
# Server and domain info
${URL_HOME}    https://bearstore-testsite.smartbear.com
${URL_LOGIN}    ${URL_HOME}/login 
${URL_PASSWORDRECOVERY}    ${URL_HOME}/customer/passwordrecovery 


# User infor
${NORMAL_USER}    tt1999@gmail.com
${NORMAL_USER_PASS}    12345678


# System
${BROWSER}              Chrome
${DELAY}                0
