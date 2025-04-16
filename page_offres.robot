*** Settings ***
Library   SeleniumLibrary   run_on_failure=None
Library   BuiltIn
Library   OperatingSystem
Library   XML
Resource  ./methode.resource
Resource  ./connexion.robot
Test Setup    Initialize connection     
  
# pour des probleme de screen shoot en headless mode privilgié Run Keyword And Ignore Error pour suspendre le screen
*** Variables ***
${SETSPEED}  0.3s
*** Keywords ***

# click sur les liens de page et ecrire dans le fichier texte
Write Text To File
    [Arguments]  ${number}  
    Set Selenium Speed     ${SETSPEED} 
    Sleep    3
# recuperation des élements dans la liste des offres
    ${text_title}  Get Text     (//a[contains(@id, '-2024')])[${number}]  
    ${date_file_opening}   Get Text     //*[@id="js-portlet-_tedv2_INSTANCE_bizi_"]/form/div/div[2]/table/tbody/tr[${number}]/td[5]/ul/li  
    ${date_file_ended}  Get Text    //*[@id="js-portlet-_tedv2_INSTANCE_bizi_"]/form/div/div[2]/table/tbody/tr[${number}]/td[6]            
    ${country}   Get Text     //*[@id="js-portlet-_tedv2_INSTANCE_bizi_"]/form/div/div[2]/table/tbody/tr[${number}]/td[4] 
    ${resume}    Get Text     //*[@id="js-portlet-_tedv2_INSTANCE_bizi_"]/form/div/div[2]/table/tbody/tr[${number}]/td[3]/ul 

# copie de url du pdf, recuperation de url source avec get element attribute
    Wait Until Keyword Succeeds    3x    0.7    Wait&Click    (//a[contains(@id, '-2024')])[${number}]   2
    Run Keyword And Ignore Error     Scroll Element Into View    //*[@id="FR-signed"]/img
    Sleep    3
    ${pdf_src}    SeleniumLibrary.Get Element Attribute    //*[@id="FR-signed"]/img     src
# copie de l'avis de l'offre
    Run Keyword And Ignore Error     Scroll Element Into View     //*[@id="notice-content"]/div
    Sleep    2
    ${text}     Get Text    //*[@id="notice-content"]/div
    ${URL}    Get Location  

# creation d'un fichier et verififation si fichier déja exstant pour evité les doublons
    ${filename}    Set Variable     ${text_title}.txt
    ${target_directory}    Set Variable    C:/Users/
    ${full_path}    Set Variable    ${target_directory}/${filename}
    IF   '''${target_directory}''' != '''${full_path}'''
    Create file  ${target_directory}/${filename} 
# ajouter les elements au fichier text
        Append To File  ${full_path}  \n**********************cle-valeurs a reference**************************************************\n
        Append To File  ${full_path}   url: ${url}
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}   numero de l'offre: ${text_title}
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}   date d'ouverture: ${date_file_opening}
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}   date limite de depot: ${date_file_ended}
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}   pays: ${country}  
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}   synthese: ${resume}
        Append To File  ${full_path}  \n***********************************************************************************************\n
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}  \n  # ajouter une ligne
        Append To File  ${full_path}   avis: ${text}
        Append To File  ${full_path}  \n  # ajouter une ligne a la fin du text
    ELSE
      log   fichier deja existant: ${full_path}
    END
    Sleep    1 
# retour a la liste des offres
    Go Back  
    Sleep    1
*** Test Cases ***
navigate_page
     Sleep    1
# msg cookies
     Run Keyword And Ignore Error    Wait&Click    //*[@id="cookie-consent-banner"]/div/div/div[2]/a[2]
# scroller jusqu'au premier element
     Wait Until Keyword Succeeds    3x    3     Scroll Element Into View      //*[@id="js-portlet-_tedv2_INSTANCE_bizi_"]/form/div/div[2]/table/tbody/tr[3]
# boucle pour parcourir les offres
    ${index} =  Set Variable  1
    WHILE  ${index} < 50
# retourner un message si une offre n'a pas ete prise correctement
       TRY
        Write Text To File    ${index}  
        ${index} =  Evaluate  ${index} + 1
       EXCEPT 
        log  fin des offres, dernier numero: ${index}
        BREAK
    END
    END
