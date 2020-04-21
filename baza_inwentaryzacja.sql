USE mmaz;

CREATE TABLE asset_types(
id TINYINT NOT NULL AUTO_INCREMENT,
letter CHAR(1) NOT NULL,
name VARCHAR(20) NOT NULL UNIQUE,
PRIMARY KEY(id));

CREATE TABLE buildings(
id TINYINT NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY(id));

CREATE TABLE rooms(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
building_id TINYINT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(building_id) REFERENCES buildings(id));

CREATE TABLE assets(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
asset_type_id TINYINT NOT NULL, 
room_id INT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(asset_type_id) REFERENCES asset_types(id),
FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE);

CREATE TABLE reports(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
room_id INT NOT NULL,
create_date DATETIME NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE);

/*joining table between assets and reports*/
CREATE TABLE reports_assets(
report_id INT NOT NULL,
asset_id INT NOT NULL,
PRIMARY KEY(report_id, asset_id),
FOREIGN KEY(report_id) REFERENCES reports(id) ON DELETE CASCADE,
FOREIGN KEY(asset_id) REFERENCES assets(id) ON DELETE CASCADE);

CREATE TABLE USER(
id TINYINT NOT NULL AUTO_INCREMENT,
login VARCHAR(20) NOT NULL,
salt VARCHAR(30) NOT NULL,
hash varchar(64) NOT NULL,
PRIMARY KEY(id));

INSERT INTO asset_types (letter,name) VALUES ('k','komputer'), 
('k','krzesło'),('m','monitor'),('p','projektor'),('s','stół'),('t','tablica');

INSERT INTO buildings (name) VALUES ('b 34'),('rektorat');

INSERT INTO rooms (name,building_id) VALUES ('3/77',1), ('3/8',1), ('1/23',2);

INSERT INTO assets (name,asset_type_id,room_id) VALUES ('kr112',2,1), 
('m520',3,1),('p360',4,1),('kr2',2,3),,('s1001',5,2),('t345',6,3);

INSERT INTO reports (name,room_id,create_date) VALUES ('raport3/77',1,NOW()),('nieaktualny',2,NOW());