TP3 - RMI
Damien Calesse
04/04/2015


*** 1/ Introduction

Ce logiciel simule un réseau d'objets interagissant entre eux par le réseau (cf JAVA RMI).
Il est développé en Python et utilise la librairie Pyro pour les interactions entre les objets.

*** 2/ Architecture

Pour exectuer les tests, pensez à lancer le nameserver d'abord avec la commande `pyro4-ns`

Execution des test:

`./test.sh`

Execution du code :

Lancer le nameserver
`pyro4-ns`

Puis créer les objets
`./make.sh`

Créer les relations entre les objets
`python -B setup.py`

Tester les valeurs contenues dans les objets
`python -B check.py`

Envoyer un message (par défaut la valeur 1) au premier objet
`python -B send.py`


*** 3/ Code Samples 
