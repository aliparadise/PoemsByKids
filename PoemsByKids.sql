--1. What grades are stored in the database?

SELECT * FROM Grade;

--2. What emotions may be associated with a poem?

SELECT * FROM Emotion;

--3. How many poems are in the database?

SELECT Count (Poem.Id)
FROM Poem

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?

SELECT TOP 76 Name
FROM Author
ORDER BY Name

--5. Starting with the above query, add the grade of each of the authors.

SELECT TOP 76 Author.Name, Grade.Name
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
ORDER BY Author.Name

--6. Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP 76 Author.Name, Grade.Name, Gender.Name
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
JOIN Gender ON Gender.Id = Author.GenderId
ORDER BY Author.Name

--7. What is the total number of words in all poems in the database?

SELECT SUM (Poem.WordCount) 'Total Word Count'
FROM Poem

--8. Which poem has the fewest characters?

SELECT TOP 1 Poem.Title, Poem.CharCount
FROM Poem
ORDER BY Poem.CharCount

--9. How many authors are in the third grade?

SELECT COUNT(Author.Id) 'Number of Authors in the Third Grade'
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
WHERE Grade.Name = '3rd Grade'

--10. How many total authors are in the first through third grades?

SELECT COUNT(Author.Id) 'Number of Authors in the First through Third Grade'
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
WHERE Grade.Name = '1st Grade' OR Grade.Name = '2nd Grade' OR Grade.Name = '3rd Grade'

--11. What is the total number of poems written by fourth graders?

SELECT COUNT(Poem.Id) 'Total number of Poems Written By Fourth Graders'
FROM Poem
JOIN Author ON Author.Id = Poem.AuthorId
JOIN Grade ON Grade.Id = Author.GradeId
WHERE Grade.Name = '4th Grade'


--12. How many poems are there per grade?

SELECT Grade.Name, COUNT(Poem.Id) 'Poems For Each Grade'
FROM Poem
JOIN Author ON Author.Id = Poem.AuthorId
JOIN Grade ON Grade.Id = Author.GradeId
GROUP BY Grade.Id, Grade.Name

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)

SELECT Grade.Name, COUNT(Author.Id) 'Number of Authors in Each Grade'
FROM Author
JOIN Grade ON Grade.Id = Author.GradeId
GROUP BY Grade.Id, Grade.Name
ORDER BY Grade.Id

--14. What is the title of the poem that has the most words?

SELECT TOP 1 Poem.Title, Poem.WordCount
FROM Poem 
ORDER BY Poem.WordCount DESC

--15. Which author(s) have the most poems? (Remember authors can have the same name.)

SELECT TOP 1 Author.Name, COUNT(Poem.AuthorId)
FROM Poem
JOIN Author ON Author.Id = Poem.AuthorId
GROUP BY Author.Id, Author.Name
ORDER BY Count(Poem.AuthorId) DESC

SELECT a.Id, a.Name, COUNT(p.Id) NumberofPoems
FROM Author a
JOIN Poem p ON p.AuthorId = a.Id
GROUP BY a.Id, a.Name
ORDER BY NumberofPoems DESC

SELECT Author.Name, Author.Id
FROM Author
WHERE Author.Name = 'jessica'

--16. How many poems have an emotion of sadness?

SELECT COUNT (PoemEmotion.EmotionId) 'Number of Poems with Emotion of Sadness'
FROM PoemEmotion
JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
WHERE Emotion.Name = 'Sadness'

--17. How many poems are not associated with any emotion?

SELECT COUNT (*) 'Emotionless Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
WHERE pe.Id is NULL

--18. Which emotion is associated with the least number of poems?

SELECT TOP 1 Emotion.Name Emotion, COUNT(Poem.Id) 'Number of Poems'
FROM Poem 
JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
GROUP BY Emotion.Name
ORDER BY COUNT(Poem.Id)

--19. Which grade has the largest number of poems with an emotion of joy?

SELECT TOP 1 g.Name, COUNT(p.Id) AS NumOfPoems FROM 
Grade g
JOIN Author a ON a.GradeId = g.Id
JOIN Poem p ON p.AuthorId = a.Id
JOIN PoemEmotion pe on pe.PoemId = p.Id
JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Joy'
GROUP BY g.Id, g.Name
ORDER BY COUNT(p.Id) DESC;

--20. Which gender has the least number of poems with an emotion of fear?

SELECT g.Name FROM Gender g
JOIN Author a ON g.Id = a.GenderId
JOIN Poem p ON p.AuthorId = a.Id
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Fear'
GROUP BY g.Id, G.Name
ORDER BY COUNT(p.Id);