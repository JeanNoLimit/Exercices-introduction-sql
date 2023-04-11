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

