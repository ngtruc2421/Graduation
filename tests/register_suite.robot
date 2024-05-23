*** Settings ***
Resource    ../resources/pages/base_page.resource
Library    SeleniumLibrary
*** Test Cases ***
Verify that user can register account 
    Open Register page