*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           MyLibrary.py

*** Variables ***
${BROWSER}        Chrome
${DELAY}          0.5
${GOOGLE URL}      https://www.google.com/
${INITIAL TEXT}    Amazon Brasil
${text}                                            //*[@id="tsf"]/div[2]/div[1]/div[1]/div/div[2]/input
${search_button}                                    btnK
${product}                  Iphone
${value}                    1
${LIMIT PRICE}              2000

*** Keywords ***
Open Browser To Google Page
    Open Browser   ${GOOGLE URL}  ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Google Page Should Be Open


Input Query
    [Arguments]  ${t1}  ${INITIAL TEXT}
    Input Text  ${t1}  ${INITIAL TEXT}

Search For Amazon Page
    [Arguments]  ${text}  ${INITIAL TEXT}
    Input Query  ${text}  ${INITIAL TEXT}
    Press Search Button     ${search_button}
    Go To Amazon Page

Press Search Button
    [Arguments]  ${search_button}
    Click Button  ${search_button}

Google Page Should Be Open
    Title Should Be    Google
#

Go To Amazon Page
    Click Link  //*[@id="rso"]/div[1]/div/div/div[1]/a
    Title Should Be  Amazon.com.br | Compre livros, informática, Tvs, Casa & Cozinha, Kindle, Echo e Fire TV

Search For Product On Amazon
    [Arguments]  ${product}
    Input Query  //*[@id="twotabsearchtextbox"]  ${product}
    Click Button  //*[@id="nav-search"]/form/div[2]/div/input

Converting To BRL
    [Arguments]  ${value}
    Log  ${value}
    Convert Value  ${value}

Is Cheaper
    ${products}=  Get Source
    Is Cheap  ${products}  ${LIMIT PRICE}

Validate Product
#    [Arguments]  ${html}=0
    ${html}=  Get Source
    Is Product  ${html}

Must Be Cheaper Than
    ${products}=  Get Source
    Cheaper Than  ${products}
