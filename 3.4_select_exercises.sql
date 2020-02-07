#
USE albums_db;

# The name of all albums by Pink Floyd
SELECT name,artist FROM albums
WHERE artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date, name FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

# The genre for the album Nevermind
SELECT name, genre FROM albums
WHERE name = 'Nevermind';

# Which albums were released in the 1990s
SELECT name, release_date From albums
Where release_date = '1990s';

# Which albums had less than 20 million certified sales
Select name, sales From albums
Where sales < 20;

# All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
Select genre,name From albums
Where genre ='Rock';
# Because the 'Rock' is different strings with others. 








