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