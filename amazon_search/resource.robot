*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library  converter

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Chrome
${DELAY}          0.5
${VALID USER}     demo
${VALID PASSWORD}    mode
${GOOGLE URL}      https://www.google.com/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html
${INITIAL TEXT}    Amazon Brasil
${text}                                            //*[@id="tsf"]/div[2]/div[1]/div[1]/div/div[2]/input
${search_button}                                    btnK
${product}                  Iphone

*** Keywords ***
Open Browser To Google Page
    Open Browser   ${GOOGLE URL}  ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Google Page Should Be Open

#//*[@id="n/16243890011"]/span/a

Input Query
    [Arguments]  ${text}  ${INITIAL TEXT}
    Input Text  ${text}  ${INITIAL TEXT}

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
    [Arguments]  ${value}=1
    Convert Value   ${value}
