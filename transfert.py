import requests
import sys
import os

# informations de connexion ver lequel 
owncloud_url = 'https:lien vers lequel les fichier seront telecharger'
username_token_auth = sys.argv[1]
password = sys.argv[2]

# dans /usr/src/docker, "os.path.join" permet de construire le chemin vers le dossier depuis le fichier transfert.py
directory = os.path.join(os.path.dirname(__file__), 'AppelOffresTed')

# boucle for pour iterer sur les fichiers dans le dossier ./AppelOffresTed
for file in os.listdir(directory):
    file_path = os.path.join(directory, file)
    upload_url = f"{owncloud_url}/{file}"  
 # ouvrir un fichier pour le telechargement avec iteration
    with open(file_path, 'rb') as f:
        response = requests.put(
            upload_url, data=f,
            auth=(username_token_auth, password),  
            verify=False  
        )
# afficher la reponse du serveur
        if response.status_code in [201, 204]:
            print(f"Téléchargement réussi: {file}")
        else:
            print(f"Erreur lors du téléchargement {file}: {response.status_code} - {response.text}")

