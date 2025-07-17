USE musicstream;

-- ¿Cuál es el artista con más oyentes?

SELECT nombre, oyentes
FROM artista
ORDER BY oyentes DESC 
LIMIT 1;

-- Cuáles son los artistas que no tienen artistas similares y a qué género pertenecen?
SELECT a.nombre, g.nombre 
FROM artista AS a
LEFT JOIN artistas_similares AS asim ON a.artista_id = asim.artista_id
JOIN canciones AS c ON a.artista_id = c.artista_id
JOIN generos AS g ON c.genero_id = g.genero_id
WHERE similar_1 IS NULL AND similar_2 IS NULL AND similar_3 IS NULL;

-- En qué año se escuchó más música?
SELECT c.año_lanzamiento, 
	SUM(e.reproducciones) AS reproducciones_totales
FROM canciones AS c
JOIN estadisticas AS e
	ON c.artista_id = e.artista_id
GROUP BY c. año_lanzamiento
ORDER BY reproducciones_totales
LIMIT 1;

-- ¿En qué año se lanzaron más canciones?
SELECT año_lanzamiento,
	COUNT(*) AS total_canciones
FROM canciones
GROUP BY año_lanzamiento
ORDER BY total_canciones DESC
LIMIT 1;

-- ¿Qué género es el que más reproducciones tiene?
SELECT g.nombre AS genero,
	SUM(e.reproducciones) AS reproducciones_totales
FROM generos AS g
JOIN canciones AS c ON c.genero_id = g.genero_id
JOIN estadisticas AS e ON c.artista_id = e.artista_id
GROUP BY g.genero_id
ORDER BY reproducciones_totales
LIMIT 1;

-- Cuáles son las 5 canciones más reproducidas por cada género?
SELECT c.nombre AS cancion, g.nombre AS genero, e.reproducciones AS reproducciones
FROM canciones AS c
JOIN estadisticas AS e ON c.artista_id = e.artista_id
JOIN generos AS g ON c.genero_id = g.genero_id
WHERE e.reproducciones IS NOT NULL AND (
	SELECT COUNT(*)
    FROM canciones AS c2
    JOIN estadisticas AS e2
		ON c2.artista_id = e2.artista_id
	WHERE c2.genero_id = c.genero_id AND e2.reproducciones > e.reproducciones
) <5
ORDER BY g.nombre, e.reproducciones DESC;

-- ¿Cuál es la canción con más reproducciones?
SELECT c.nombre AS cancion, e.reproducciones AS reproducciones
FROM canciones AS c
JOIN estadisticas AS e ON c.artista_id = e.artista_id
WHERE e.reproducciones IS NOT NULL
ORDER BY e.reproducciones DESC
LIMIT 1;

-- Cuáles son las cinco canciones con menos reproducciones?
SELECT c.nombre AS cancion, e.reproducciones AS reproducciones
FROM canciones AS c
JOIN estadisticas AS e ON c.artista_id = e.artista_id
WHERE e.reproducciones IS NOT NULL
ORDER BY e.reproducciones
LIMIT 5;




