*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by their nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.
Suite Setup       Open Browser To Google Page
Suite Teardown    Close Browser
#Test Setup        Go To Google Page
Test Template     Search In Amazon
Resource          resource.robot

*** Test Cases ***  text   INITIAL TEXT
Searching For Amazon Page   ${text}   ${INITIAL TEXT}

*** Keywords ***
Search In Amazon
    [Arguments]         ${text}    ${INITIAL TEXT}
    Search For Amazon Page  ${text}     ${INITIAL TEXT}
    Search Product

#80% Of Shown Products Should Be Exclusively The Searched Product


Search Product
    Search For Product On Amazon  ${product}
    Get Text  //*[@id="search"]/span/div/span/h1/div/div[1]/div/div/span[1]

