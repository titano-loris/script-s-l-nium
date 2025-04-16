# installer "pip install pyyaml" afin de pouvoir utiliser import yaml
import yaml
import os
#WebDriverWait est utilisé pour attendre qu'un événement se produise, avantl'exécution suivante. 
from selenium.webdriver.support.ui import WebDriverWait
# "BY" est utilisé pour spécifier éléments de recherche (ici il sert pour la location "XPATH").
from selenium.webdriver.common.by import By
# import du module "expected_conditions" et le nomer "EC" pour raccourcir l'utilisation.
from selenium.webdriver.support import expected_conditions as EC

from selenium import webdriver
#driver = webdriver.Chrome()


def fill_form_validation2(type_declaration, conflit, commentaire, controle, validation):
    # recuperer le chemin courant 
    current_directory = os.getcwd()
    # Charger YAML  "traitement des declaration.YAML"
    # "r" signifit read pour lire le fichier yaml
    # Print the current working directory
    print("Current Location:", current_directory)
    with open("C://traitement/declaration/traitement_des_declarations.yaml", "r") as file:
        cfg = yaml.safe_load(file)
    # Vérifiez si le fichier YAML a été chargé correctement
    if cfg is not None:
        print(cfg['tableau_traitement_declaration']['selection_premiere_ligne'])
    else:
        print("Erreur lors du chargement du fichier YAML.")

    # Attendre et cliquer sur la première ligne du tableau de traitement de la déclaration
    test = (EC.element_to_be_clickable((By.XPATH,'tableau_traitement_declaration'))).find_element(By.ID, 'selection_premiere_ligne')
    print(test)
    
    # Attendre et cliquer sur la prise en charge
    WebDriverWait.until(EC.element_to_be_clickable((By.XPATH['actions_formulaire_traitement']['prise_charge']))).click()
   
    # Attendre et cliquer sur la confirmation de la prise en charge
    WebDriverWait.until(EC.element_to_be_clickable((By.XPATH,['traitement_declaration']['confirmation_prise_charge']))).click()
    
    # Attendre et cliquer sur l'élément de conflit
    WebDriverWait.until(EC.element_to_be_clickable((By.XPATH,[conflit]))).click()
   
    # Saisir le commentaire
    (By.XPATH,['traitement_declaration']['commentaire']).send_keys(commentaire)
 
    # Exécuter la keyword 'Element Should Contain' et récupérer le statut
    current_status = WebDriverWait.until(EC.text_to_be_present_in_element((By.XPATH,['traitement_declaration']['actualiser_controle']), 'true'))
    # Attendre et cliquer sur l'élément de validation
    WebDriverWait.until(EC.element_to_be_clickable((By.XPATH,[validation]))).click()

    # condition pour verifier la declaration ct ou mtp
    if type_declaration == 'CT':
        if validation == ['actions_formulaire_traitement']['renvoyer_demandeur']:
            # Saisir le commentaire pour la qualification
            (By.XPATH,['traitement_declaration']['qualif_commentaire_controle']).send_keys(commentaire)
            # Attendre et cliquer sur la confirmation de la validation
            WebDriverWait.until(EC.element_to_be_clickable((By.XPATH,['traitement_declaration']['confirmation_validation']))).click()
        elif validation == ['actions_formulaire_traitement']['valider']:
            # Ajouter d'autres étapes 
            pass
    else:
        # Ajouter d'autres étapes ici si type_declaration n'est pas 'CT'
        pass

    return cfg

def load_file():
    # récuperer le dossier
    current_directory = os.getcwd()
    # Charger YAML  "traitement des declaration.YAML"
    # "r" signifit read pour lire le fichier yaml
    print("Current Location:", current_directory)
    # Penser a mettre le chemin absolut ! le chemin de la fonction n'est plus la meme dans un les fichiers .robot !
    with open("C:/Users/lbartolini/Desktop/Bpi/bpi-trp-robotframework/Tests/En cours/PageObjet/Locators/traitement/declaration/traitement_des_declarations.yaml", "r") as file:
        cfg = yaml.safe_load(file)
    # Vérifiez si le fichier YAML a été chargé correctement
    if cfg is not None:
        print(cfg)
    else:
        print("Erreur lors du chargement du fichier YAML.")
    return cfg


