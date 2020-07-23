*** Settings ***
Documentation  A simple test suit case
...  created by Mateus Sousa

Suite Setup       Open Browser To Google Page
Suite Teardown    Close Browser
#Test Setup        Search For Amazon Page  ${text}     ${INITIAL TEXT}
#Test Template     Search In Amazon
Resource          resource.robot

*** Test Cases ***
Open Amazon Page
    Search For Amazon Page  ${text}     ${INITIAL TEXT}

80% Of Shown Products Should Be Exclusively The Searched Product
    Search For Product On Amazon  ${product}
    Log  Total of found products
    Get Text  //*[@id="search"]/span/div/span/h1/div/div[1]/div/div/span[1]
    Validate Product

The Higher Price In The First Page Can't Be Greater Than U$2000
    Search For Product On Amazon  ${product}
    Is Cheaper

Products Different Than The Searched Product Should Be Cheaper Than The Searched Product
    Must Be Cheaper Than

#Search Product
#    Search For Product On Amazon  ${product}
#    Converting To BRL  3455
#
