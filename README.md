# Projet de POA

# PRÉREQUIS

- Maven

Pour compiler avec Maven, placez-vous dans le répertoire racine du projet (qui contient le présent README), et exécutez dans un terminal :
mvn aspectj:compile
Notez que Maven doit être dans le path si vous souhaitez pouvoir l'appeler directement comme ci-dessus.

Puis, pour exécuter l'application, exécutez :
mvn exec:exec

Pour nettoyer, supprimez simplement le répertoire target dans le répertoire racine, ou exécutez :
mvn clean
