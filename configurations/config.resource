*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    String
Library    RequestsLibrary
*** Variables ***
${URL_HOME}    https://bearstore-testsite.smartbear.com
${URL_LOGIN}    ${URL_HOME}/login  
${BROWSER}    chrome
