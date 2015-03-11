/* TP REST 2015 : conception d'un client web FTP en php
 *
 * CALESSE Damien
 * LEROY Pierre
 *
 * 11/03/15
 *
 *********************************************************/

Introduction
************
	Cette application web donne accès à un client FTP qui pourra accéder à un serveur FTP (celui
	créé lors du TP1 par exemple).

Architecture
************
	L'application est organisé selon la structure MVC - Modele Vue Controleur - ce qui permet
	un maintien simple et efficace, compréhensible et universel.

Usage
*****
	Prérequis : php5 et apache2 doivent être installés sur le serveur web. php doit être disponible en 
	ligne de commande pour les tests unitaires et la génération de la documentation.

		* Tests unitaires :
	(Dans un terminal)
	php phpunit.phar tests/FTPTest.php

		* Generation de la documentation :
	(Dans un terminal)
	./phpDocumentor.phar -d . -t docs --ignore "vendor/*" --template="responsive-twig"

