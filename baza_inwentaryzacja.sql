ALTER DATABASE `mmaz` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE mmaz;

DROP TABLE IF EXISTS asset_types;
DROP TABLE IF EXISTS buildings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS assets;
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS reports_assets;
DROP TABLE IF EXISTS users;

CREATE TABLE asset_types(
id TINYINT NOT NULL AUTO_INCREMENT,
letter CHAR(1) NOT NULL UNIQUE,
name VARCHAR(20) NOT NULL UNIQUE,
PRIMARY KEY(id));

CREATE TABLE buildings(
id TINYINT NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY(id));

CREATE TABLE rooms(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
building TINYINT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(building) REFERENCES buildings(id));

CREATE TABLE assets(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
asset_type TINYINT NOT NULL REFERENCES asset_types(id),
room INT NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
previous_room INT REFERENCES rooms(id) ON DELETE CASCADE, 
PRIMARY KEY(id));

CREATE TABLE users(
id TINYINT NOT NULL AUTO_INCREMENT,
login VARCHAR(20) NOT NULL,
salt VARCHAR(30) NOT NULL,
hash varchar(64) NOT NULL,
PRIMARY KEY(id));

CREATE TABLE reports(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
room INT NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
create_date DATETIME NOT NULL,
owner TINYINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
PRIMARY KEY(id));

/*joining table between assets and reports*/
CREATE TABLE reports_assets(
report_id INT NOT NULL REFERENCES reports(id) ON DELETE CASCADE,
asset_id INT NOT NULL REFERENCES assets(id) ON DELETE CASCADE,
PRIMARY KEY(report_id, asset_id));

INSERT INTO asset_types (letter,name) VALUES ('c','komputer'), 
('k','krzesło'),('m','monitor'),('p','projektor'),('s','stół'),('t','tablica');

INSERT INTO buildings (name) VALUES ('b 34'),('rektorat');

INSERT INTO rooms (name,building) VALUES ('3/77',1), ('3/8',1), ('1/23',2);

INSERT INTO assets (name,asset_type,room,previous_room) VALUES ('kr112',2,1,NULL), 
('m520',3,1,2),('p360',4,1,3),('kr2',2,3,NULL),('s1001',5,2,NULL),('t345',6,3,NULL);

INSERT INTO users (login,salt,hash) VALUES ('mmaz','A8Eer12ncbr','dcac78f0c294c9d7e3b5a5e18f59b6586693cffbb3bc8f7df1c0fc206f307fc7');

INSERT INTO reports (name,room,create_date,owner) VALUES ('raport3/77',1,NOW(),1),('nieaktualny',2,NOW(),1);

INSERT INTO reports_assets VALUES (1,1),(1,2),(1,3),(2,5);