<?php

//connection à la base de donnée Gaulois
//   -On indique le nom de l'hôte : c'est l'adresse IP de l'ordinateur où MySQL est installé. ici localhost.
//   -Le nom de la base de données à laqueelle vous voulez vous connecter. Ici gaulois.
//   -L'identifiant et le mot de passe. Nous n'avons pas crée de mdp lors de la création de cette bd.
//Utilisation de try catch. Sans la gestion d'execption PHP affichera la ligne qui pose problème à l'écran
//Cela inclut le mdp.Catch permet d'afficher une exeption à la place. Si tout se passe bien -> aucun message

try {
$db = new PDO(
    'mysql:host=localhost;dbname=gaulois;charset=utf8',
    'root',
    '');
}
catch (Exception $e){
    die('Erreur : ' . $e->getMessage());
}


?>