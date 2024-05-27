*** Settings ***
Library    String
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem
Library    SeleniumLibrary

*** Variables ***
# Server and domain info
${URL_HOME}    https://bearstore-testsite.smartbear.com
${URL_LOGIN}    ${URL_HOME}/login  


# User infor
${NORMAL_USER}    tt1999@gmail.com
${NORMAL_USER_PASS}    12345678


# System
${BROWSER}              Chrome
${DELAY}                0