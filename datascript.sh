#!/bin/bash
sudo yum update
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo dnf install mysql-community-client -y
sudo dnf install mysql-community-server -y

sudo systemctl start mysqld.service
sudo systemctl enable mysqld 

ROOTPASSWORD=$(sudo grep "password" /var/log/mysqld.log | awk '{print $13}')

sleep 5

USER="root"
PASSWORD="Password@123"
DATABASE="react_node_app"


sudo mysql -u "$USER" -p"$ROOTPASSWORD" --connect-expired-password <<EOF
ALTER USER '$USER'@'localhost' IDENTIFIED BY 'NewStrongPassword@123';
FLUSH PRIVILEGES;
CREATE DATABASE $DATABASE;
CREATE USER 'appuser'@'%' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE.* TO 'appuser'@'%';
FLUSH PRIVILEGES;
USE $DATABASE;
CREATE TABLE author (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    bio TEXT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE book (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    releaseDate DATE NOT NULL,
    description TEXT NOT NULL,
    pages INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    authorId INT DEFAULT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_66a4f0f47943a0d99c16ecf90b2 FOREIGN KEY (authorId) REFERENCES author(id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO author (id, name, birthday, bio, createdAt, updatedAt) VALUES
(1, 'J.K. Rowling', '1965-07-31', 
   'J.K. Rowling is a British author best known for writing the Harry Potter fantasy series. The series has won multiple awards and sold over 500 million copies, becoming the best-selling book series in history. Rowling has also written other novels, including The Casual Vacancy and the Cormoran Strike crime series under the pen name Robert Galbraith.', 
   '2024-05-29', '2024-05-29'),

(3, 'Jane Austen', '1775-12-16', 
   'Jane Austen was an English novelist known for her wit, social commentary, and romantic stories. Her six major novels, which explore themes of love, marriage, and money, have earned her a place as one of the greatest writers in the English language.', 
   '2024-05-29', '2024-05-29'),

(4, 'Harper Lee', '1960-07-11', 
   'Harper Lee was an American novelist best known for her Pulitzer Prize-winning novel To Kill a Mockingbird. The novel explores themes of racial injustice and the importance of compassion. Lee published a sequel, Go Set a Watchman, in 2015.', 
   '2024-05-29', '2024-05-29'),

(5, 'J.R.R. Tolkien', '1954-07-29', 
   'J.R.R. Tolkien was a British philologist and writer best known for his fantasy novels The Hobbit and The Lord of the Rings. Tolkien\'s works have had a profound influence on the fantasy genre and popular culture.', 
   '2024-05-29', '2024-05-29'),

(6, 'Mary Shelley', '1818-08-30', 
   'Mary Shelley was a British novelist, playwright, and short story writer, the daughter of Mary Wollstonecraft Godwin and the wife of poet Percy Bysshe Shelley. Frankenstein, or, The Modern Prometheus (1818) is her most famous work.', 
   '2024-05-29', '2024-05-29'),

(7, 'Douglas Adams', '1979-10-12', 
   'Douglas Adams was an English science fiction writer, satirist, humorist, dramatist, screenwriter, and occasional actor. He is best known for The Hitchhiker\'s Guide to the Galaxy comedy series, which inspired a radio comedy, several books, stage shows, comic books, a 1981 TV series, a 1984 video game, a 2005 feature film, and a 2008 sequel film.', 
   '2024-05-29', '2024-05-29');

INSERT INTO book (id, title, releaseDate, description, pages, createdAt, updatedAt, authorId) VALUES
(1, 'Harry Potter and the Sorcerer\'s Stone', '1997-07-26', 
   'On his birthday, Harry Potter discovers that he is the son of two well-known wizards, from whom he has inherited magical powers. He must attend a magical school of magic and sorcery, where he establishes a friendship with two young men who will become companions on his adventure. During his first year at Hogwarts, he discovers that a malevolent and powerful wizard named Lord Voldemort is in search of a philosopher\'s stone that prolongs the life of its owner.', 
   223, '2024-05-29', '2024-05-29', 1),

(3, 'Harry Potter and the Chamber of Secrets', '1998-07-02', 
   'Harry Potter and the sophomores investigate a malevolent threat to their Hogwarts classmates, a menacing beast that hides within the castle.', 
   251, '2024-05-29', '2024-05-29', 1),

(4, 'Pride and Prejudice', '1813-01-28', 
   'An English novel of manners by Jane Austen, first published in 1813. The story centers on the relationships between the Bennet sisters, in particular Elizabeth Bennet the middle daughter, and the wealthy Mr. Darcy. It satirizes the social classes of the English gentry through a witty and ironic narrative voice.', 
   224, '2024-05-29', '2024-05-29', 3),

(5, 'Harry Potter and the Prisoner of Azkaban', '1999-07-08', 
   'Harry\'s third year of studies at Hogwarts is threatened by Sirius Black\'s escape from Azkaban prison. Apparently, Black is a dangerous wizard who was an accomplice of Lord Voldemort and who will try to take revenge on Harry Potter.', 
   317, '2024-05-29', '2024-05-29', 1),

(6, 'Harry Potter and the Goblet of Fire', '2000-07-08', 
   'Hogwarts prepares for the Triwizard Tournament, in which three schools of wizardry will compete. To everyone\'s surprise, Harry Potter is chosen to participate in the competition, in which he must fight dragons, enter the water and face his greatest fears.', 
   636, '2024-05-29', '2024-05-29', 1),

(7, 'The Hitchhiker\'s Guide to the Galaxy', '1979-10-12', 
   'A comic science fiction comedy series created by Douglas Adams. The story follows the comedic misadventures of Arthur Dent, a hapless Englishman, following the destruction of the Earth by the Vogons, a race of unpleasant bureaucratic aliens. Arthur escapes with his friend Ford Prefect, who reveals himself to be an undercover researcher for the titular Hitchhiker\'s Guide to the Galaxy, a galactic encyclopedia containing information about anything and everything.', 
   184, '2024-05-29', '2024-05-29', 7),

(8, 'Frankenstein; or, The Modern Prometheus', '1818-08-30', 
   'A Gothic novel by Mary Shelley that tells the story of Victor Frankenstein, a young scientist who creates a grotesque creature in an unorthodox scientific experiment. Frankenstein is horrified by his creation and abandons it, but the creature seeks revenge. The novel explores themes of scientific responsibility, creation versus destruction, and the nature of good and evil.', 
   211, '2024-05-29', '2024-05-29', 6),

(9, 'The Lord of the Rings: The Fellowship of the Ring', '1954-07-29', 
   'The first book in J.R.R. Tolkien\'s epic fantasy trilogy, The Lord of the Rings. The Fellowship of the Ring follows the hobbit Frodo Baggins as he inherits the One Ring, an evil artifact of power created by the Dark Lord Sauron. Frodo embarks on a quest to destroy the Ring in the fires of Mount Doom, accompanied by a fellowship of eight companions.', 
   482, '2024-05-29', '2024-05-29', 5);


EOF
