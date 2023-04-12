<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <title>Informations Gaulois</title>
</head>
<body>
    
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
//requette sql pour récupérer nom des personnages, leur lieu d'habitation et la spécialité des perso. Trié par nom de lieu et nom perso
$mysqlQuery='SELECT nom_personnage, nom_lieu,nom_specialite 
            FROM personnage p
            INNER JOIN lieu l ON p.id_lieu = l.id_lieu
            INNER JOIN specialite s ON p.id_specialite = s.id_specialite
            ORDER BY  nom_lieu, nom_personnage ;';
//PersonnagesStatement contient le résultat de la requête sous la fomre d'un objet PDOStatement(https://www.php.net/manual/fr/class.pdostatement.php)
$personnagesStatement = $db->prepare($mysqlQuery);
//fetchAll va chercher les données dans personnagesStatement et permet de récupérer les données dans un format exploitable sous forme de tableau PHP
$personnagesStatement->execute();
$listePersonnages = $personnagesStatement->fetchAll();

echo "<div class=container-sm>",
        "<table class='table'>",
            "<thread>",
                "<tr>",
                    "<th>Lieu d'habitation</th>",
                    "<th>Nom du personnage</th>",
                    "<th>Spécialité </th>",
                "</tr>",
            "<thread>",
            "<tbody>";


foreach ($listePersonnages as $personnage) {
    echo "<tr>",
            "<td>".$personnage['nom_lieu']."</td>",
            "<td>".$personnage['nom_personnage']."</td>",
            "<td>".$personnage['nom_specialite']."</td>",
        "</tr>";
}

echo        "</tbody>",
        "</table>",
    "</div>";


?>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>