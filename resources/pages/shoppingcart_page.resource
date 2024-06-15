*** Settings ***
Resource    ../keywords/common_keywords.resource
Resource    ../page_objects/sidebar.resource

*** Variables ***
${LISTNAME_ELE}                    css:.col a[title="Description"]
${LISTDATE_ELE}                    css:.delivery-date
${LISTPRICE_ELE}                   css:.cart-col-price[data-caption="Price"] .price
${LISTTOTAL_ELE}                   css:.cart-col-price[data-caption="Total"] .price
${LIST_QUANTITY_ELE}               css=[id^="itemquantity"]
*** Keywords ***
The image "${NAME}" should be displayed in the shopping cart page
    TRY
        Wait until page contain element    css:.img-fluid[alt="Picture of ${NAME}"]
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process The image "${NAME}" should be displayed in the shopping cart page
    END

There is 2 product in shopping cart 
    TRY
        There is at least 1 product in shopping cart
        Click on the "Go To Cart" button
        The page should be opened    Shopping cart    ${PAGE_TITLE_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in progress verify There is 2 product in shopping cart 
    END

The name "${NAME}" should be displayed in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Get Text    ${element}
            IF    ("${name_text}"=="${NAME}")
                RETURN
            END
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The name "${NAME}" should be displayed in shopping cart page
    END

The arrival date of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Get Text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_DATE}=    Get list WebElements    ${LISTDATE_ELE}
                ${DATE_ELE}=    Get From List    ${LIST_DATE}    ${INDEX}
                Wait until page contain element    ${DATE_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The arrival date of product "${NAME}" should be display in shopping cart page
    END

The Price per item of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Get Text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_PRICE}=    Get list WebElements    ${LISTPRICE_ELE}
                ${PRICE_ELE}=    Get From List    ${LIST_PRICE}    ${INDEX}
                Wait until page contain element    ${PRICE_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${NAME}" should be display in shopping cart page
    END

The quantity of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Get Text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_QUANTITY}=    Get list WebElements    ${LIST_QUANTITY_ELE}
                ${QUANTITY_ELE}=    Get From List    ${LIST_QUANTITY}    ${INDEX}
                Wait until page contain element    ${QUANTITY_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${NAME}" should be display in shopping cart page
    END

The Total price for the item of product "${NAME}" should be display in shopping cart page
    TRY
        ${LIST_NAME}=    Get list WebElements    ${LISTNAME_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_NAME}
            ${name_text}=     Get Text    ${element}
            IF    ("${name_text}"=="${NAME}")
                ${LIST_TOTAL}=    Get list WebElements    ${LISTTOTAL_ELE}
                ${TOTAL_ELE}=    Get From List    ${LIST_TOTAL}    ${INDEX}
                Wait until page contain element    ${TOTAL_ELE}
                RETURN
            END
            ${INDEX}=    Evaluate    ${INDEX} + 1
        END
    EXCEPT   
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process verify The Price per item of product "${NAME}" should be display in shopping cart page
    END

