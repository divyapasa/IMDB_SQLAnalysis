-- To display all the information of the tables IMDB_1 and IMDB_2
SELECT * FROM IMDB_1
SELECT * FROM IMDB_2

-- To display unique Genre from IMDB_1 (110 unique Genre are available)
SELECT DISTINCT Genre FROM IMDB_1   

-- Listing the IMDB_1 in the asc order of their Year released
SELECT * FROM IMDB_1 ORDER BY Year asc

-- List the Movie name and imdb rating of the IMDB_1 in desc order  
SELECT Title, imdbRating FROM IMDB_1 
ORDER BY imdbRating desc

-- Display all the Movies that released after 1990  (124 rows)
SELECT Title, Released, Country FROM  IMDB_2
WHERE Released > '1990-01-01 00:00:00:000'

-- Display all the Movies that released after 1990 and in Country USA
SELECT Title, Released, Country FROM  IMDB_2
WHERE Released > '1990-01-01 00:00:00:000' and  Country = 'USA'

-- Display Title, Released, Country and BoxOffice 
SELECT Title, Released, Country, BoxOffice, Metascore FROM  IMDB_2
WHERE Released > '1990-01-01 00:00:00:000' and Metascore > 90 and  Country = 'USA' and  BoxOffice  IS  NOT NULL
ORDER BY Released desc

SELECT title, Actors FROM IMDB_1 
WHERE Director = 'Luc Besson'

-- Display the Movies that have a Runtime of less than 150 minutes
SELECT DISTINCT Actors, Director, Title, Runtime FROM IMDB_1   
WHERE Runtime< '150 min' 

-- List all the Movies that was acted by Arnold Schwarzenegger

SELECT title, Actors FROM IMDB_1
WHERE (Actors LIKE '%Arnold Schwarzenegger%')


-- Movies that were released in New zealand

SELECT title, Country, Released FROM IMDB_2
WHERE (Country LIKE '%New Zealand%')
ORDER BY Released desc

--Display movie names that were released by Paramount Pictures with BoxOffice collection
SELECT title, Production, BoxOffice FROM IMDB_2
WHERE Production = 'Paramount Pictures' and BoxOffice IS NOT NULL

-- Movies that have websites 
SELECT  Title, Website FROM IMDB_2
WHERE Website IS NOT NULL 

-- Movies that were nominated for Oscars but not won

SELECT title, Awards FROM IMDB_2 
WHERE (Awards LIKE '%Nominated%')


-- Display Movies that have an imdbID ending with 61

--Find records that have imdbID ending with 61 and Metscore greater than or equal to 90
SELECT title, imdbID, imdbVotes, Metascore FROM IMDB_2
WHERE imdbID LIKE '%61' and imdbVotes > 100000 and Metascore >= 90
ORDER BY imdbVotes desc

--Find records that have imdbID ending with 61 and Metscore greater than or equal to 90
SELECT title, imdbID, imdbVotes, Metascore FROM IMDB_2
WHERE imdbID LIKE '%61' and imdbVotes > 100000 and Metascore < 90 
ORDER BY imdbVotes desc

-- Display records where given imdbID  is not required
SELECT * FROM IMDB_2 
WHERE imdbID != 'tt0111161'

-- Display records of all directors but not 'Steven Spielberg', 'Tomm Moore'
SELECT * FROM IMDB_1 
WHERE Director not in ('Steven Spielberg', 'Tomm Moore')

-- Display all records with directors names 'Steven Spielberg', 'Tomm Moore'
SELECT * FROM IMDB_1 
WHERE Director  in ('Steven Spielberg', 'Tomm Moore')

-- Display Movie names with rating, genre that released in 1994
SELECT title,imdbrating, Genre 
FROM IMDB_1 
WHERE Year = '1994'

-- Display all records between the year 1994 to 2015
SELECT * FROM IMDB_1 
WHERE Year between '1994' and '2015'
ORDER BY Year asc

--
SELECT Director 
FROM IMdb_1
WHERE Title = 'The GodFather'


SELECT Director 
FROM  IMDB_1
WHERE Title= 'The GodFather'

SELECT a.Title, a.director, b.Writer
FROM IMDB_1 a, IMDB_2 b
WHERE a.Title= b.Title


-- Display title, director, writer, imdbrating, imdbVotes where Metascore is not null (USING SUB QUERY)
SELECT a.Title, a.director, a.imdbRating, b.writer, b.Metascore,b.imdbVotes
FROM IMDB_1 a, IMDB_2 b
WHERE a.Title= b.Title
AND Metascore IS NOT NULL
AND b.Writer >
(SELECT Director 
FROM  IMDB_1
WHERE Title= 'The GodFather')
ORDER BY Metascore

-- WRONG
SELECT  a.Actors, count(b.production)
FROM	IMDB_1 a, IMDB_2 b
WHERE a.title = b.Title
GROUP BY b.Production

--Display number of Movies made for each year
SELECT Count(Director) as NoOfMovies ,Year
FROM IMDB_1
GROUP BY Year

--Inner Join
--Showing Movies that were Nominated for Oscars using join/inner join
SELECT IMDB_1. Title, IMDB_2.Awards, IMDB_1.Director
FROM IMDB_1
JOIN IMDB_2 ON IMDB_1.Title= IMDB_2.Title
WHERE Awards like '%Nominated%'


--Display Movies that Won Oscars whose director is Francis Ford Coppola
SELECT IMDB_1. Title, IMDB_2.Awards, IMDB_1.Director    -- Count(ImDB_1.Title)
FROM IMDB_1
JOIN IMDB_2 ON IMDB_1.Title= IMDB_2.Title
WHERE Awards LIKE '%Won%' 
AND Director LIKE  '%Francis%'

-- Based on the Year released, show BoxOffice total for that corresponding year
select a.Year,
sum(b.BoxOffice) as Total_BoxOffice
FROM IMDB_1 a, IMDB_2 b
WHERE a.Title = b.Title and b.BoxOffice  is  not null                             
GROUP BY a.Year
ORDER BY a.Year


--Creating CTE to find the average imdb rating based on Genre

WITH avg_imdbRating AS(
 SELECT Genre, AVG(imdbrating) AS average_IMDBRating
 FROM IMDB_1
 GROUP BY Genre)
SELECT a.title, a.director, a.actors, av.average_IMDBRating
FROM IMDB_1 a
JOIN avg_imdbRating av
ON a.Genre= av.Genre;

--Temp table
--
SELECT Title, Awards
INTO Movies_Won_Awards
FROM IMDB_2
WHERE Awards LIKE '%Won%'

SELECT * FROM Movies_Won_Awards

--Creating View to store data for later Visualizations

CREATE VIEW IMDBMoviesView AS 
SELECT a.title, a.genre, a.plot, a.director, b.writer, b.website 
FROM IMDB_1 a , IMDB_2 b
WHERE a.title = b.Title AND  b.website IS NOT NULL

SELECT * FROM IMDBMoviesView

--END

