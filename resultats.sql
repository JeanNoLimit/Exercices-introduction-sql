-- exercice 1 Nom des lieux qui finissent par 'um'.
SELECT nom_lieu
FROM lieu 
WHERE nom_lieu 
LIKE '%um';

-- exercice 2 Nombre de personnages par lieu (trié par nombre de personnages décroissant).
-- On peut rajouter des alias 
SELECT nom_lieu,COUNT(p.id_lieu) AS nbGaulois
FROM personnage p
INNER JOIN lieu l ON p.id_lieu = l.id_lieu
GROUP BY l.id_lieu
ORDER BY nbGaulois DESC;

--exercice 3 Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage.

SELECT nom_lieu, nom_personnage, nom_specialite, adresse_personnage 
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
ORDER BY nom_lieu, nom_personnage;

--exercice 4 Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).

SELECT nom_specialite, COUNT(id_personnage)
FROM specialite
INNER JOIN personnage ON specialite.id_specialite = personnage.id_specialite
GROUP BY specialite.id_specialite
ORDER BY COUNT(id_personnage) DESC;

--exercice 5 Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).

SELECT nom_bataille, nom_lieu, DATE_FORMAT(date_bataille, "%d/%m/%Y") 
FROM bataille
INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
ORDER BY date_bataille;

--exercice 6 Nom des potions + coût de réalisation de la potion (trié par coût décroissant).

SELECT nom_potion, SUM(qte*cout_ingredient)
FROM composer
INNER JOIN potion ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON ingredient.id_ingredient = composer.id_ingredient
GROUP BY potion.id_potion;

--exercice 7 Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.

SELECT nom_potion, nom_ingredient, cout_ingredient, qte
FROM composer
INNER JOIN potion ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON ingredient.id_ingredient = composer.id_ingredient
WHERE nom_potion LIKE 'Santé';

--exercice 8 Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'.

SELECT nom_personnage,  nom_bataille, SUM(qte) AS nbTtl
FROM prendre_casque
INNER JOIN personnage ON prendre_casque.id_personnage = personnage.id_personnage
INNER JOIN bataille ON prendre_casque.id_bataille = bataille.id_bataille
WHERE bataille.id_bataille =1
GROUP BY personnage.id_personnage
ORDER BY nbTTl DESC
LIMIT 1; --affichera un seul résultat

--Deuxième solution (pour gérer le cas où plusieurs des personnages sont à égalité)
SELECT nom_personnage,  nom_bataille, SUM(qte) AS nbTtl
FROM prendre_casque
INNER JOIN personnage ON prendre_casque.id_personnage = personnage.id_personnage
INNER JOIN bataille ON prendre_casque.id_bataille = bataille.id_bataille
WHERE bataille.id_bataille =1
GROUP BY personnage.id_personnage
HAVING nbTtl>=ALL (
	SELECT SUM(qte)
	FROM prendre_casque
	INNER JOIN personnage ON prendre_casque.id_personnage = personnage.id_personnage
	INNER JOIN bataille ON prendre_casque.id_bataille = bataille.id_bataille
	WHERE bataille.id_bataille=1
	GROUP BY personnage.id_personnage);

--exercice 9 Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit).

SELECT nom_personnage, sum(dose_boire) AS qte_bue
FROM boire
INNER JOIN personnage ON boire.id_personnage = personnage.id_personnage
GROUP BY personnage.id_personnage
ORDER BY qte_bue DESC;

--exercice 10 Nom de la bataille où le nombre de casques pris a été le plus important.

SELECT nom_bataille, SUM(qte) AS nbTtl
FROM prendre_casque
INNER JOIN bataille ON prendre_casque.id_bataille  = bataille.id_bataille
GROUP BY nom_bataille
ORDER BY nbTtl DESC
LIMIT 1;

--exercice 11 Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)

SELECT nom_type_casque, COUNT(id_casque) AS nb_casques, SUM(cout_casque) AS cout_casques
FROM casque
INNER JOIN type_casque ON casque.id_type_casque = type_casque.id_type_casque
GROUP BY nom_type_casque
ORDER BY nb_casques DESC;

