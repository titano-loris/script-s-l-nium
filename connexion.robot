*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${url}     https:// lien sur le site
  

*** Keywords ***
Initialize connection
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${user_data_dir3}=    Set Variable    -window-size=1920,1080
 
    Call Method    ${chrome_options}    add_argument    --headless    #chrome en mode headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox    #suprime les caractéristique de sécurité de chrome pouvant interferer avec l'env. ci/cd
    Call Method    ${chrome_options}    add_argument    --disable-notifications  #retire les notifications web qui peuvent interferer avec les test auto
    Call Method    ${chrome_options}    add_argument    --disable-infobars     # retire les message infobar comme "chrome est controlé pars un automat"
    Call Method    ${chrome_options}    add_argument    ${user_data_dir3}
    Open Browser    ${url}   headlesschrome    options=${chrome_options}     # specifier le navigateur avec le built-in  pour le headless mode

