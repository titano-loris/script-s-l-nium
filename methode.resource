*** Settings ***
Library  SeleniumLibrary
Library  DateTime


# le fichier méthode regroupe les actions personalisable de robot framework

*** Variables ***
${mode_test}     debug
*** Keywords ***
Wait&Click
    [Arguments]    ${element}     ${sleepTime}=0s
    Wait Until Page Contains Element    ${element}     timeout=20s
    sleep    ${sleepTime}
    Click Element  ${element}

WaitForText
    [Arguments]    ${element}     ${sleepTime}=0s
      Wait Until Page Contains Element    ${element}     timeout=20s
    sleep    ${sleepTime}
    Get Text  ${element}

Timer_KO
     [Arguments]      ${input}
     ${count}=   Get Length     ${input}
     Should Be True      ${count}      5 < ${count} < 50	
     ${seconds}=    Calculate Seconds    ${count}
     Log    Count in seconds: ${seconds}
Calculate Seconds 
    #associer seulement avec Timer_KO
    [Arguments]    ${count}
    ${conversion_factor}=    Set Variable    0.1   # a ajuster si besoin
    ${seconds}=    Evaluate    ${count} * ${conversion_factor}
    RETURN    ${seconds}

checking
    [Arguments]     ${source}
    Wait Until Element Is Visible     ${source}
    IF 
    ...    "${source}" == "true"
    ...    Log     Element: ${source}
    ...    ELSE
    ...    Log   element non trouvé

Click&Double
    [Arguments]    ${element}
    Wait Until Page Contains Element     ${element}
    Click Element  ${element}
    Wait Until Page Contains Element     ${element}
    Click Element  ${element}

reload_page
# utiliser le rafraichissement de page
    Execute JavaScript    location.reload(true);
    Sleep   1

type
    [Arguments]    ${element}    ${value}
    Input Text     ${element}    ${value}

select
    [Arguments]        ${element}  ${value}
    Select From List By Label   ${element}  ${value}

verifyText
    [Arguments]                  ${element}  ${value}  ${sleepTime}=0s
    sleep    ${sleepTime}
    Element Should Contain       ${element}  ${value}
