CREATE DATABASE week13_avtos;
use week13_avtos;

CREATE TABLE IF NOT EXISTS AvtoMark ( -- Mersedes
id INT PRIMARY KEY,
`name` VARCHAR(50));

CREATE TABLE IF NOT EXISTS AvtoModel ( -- S200
id INT PRIMARY KEY,
avtoMark_id INT,
`name` VARCHAR(50),
FOREIGN KEY (avtoMark_id) REFERENCES AvtoMark(id)
);

CREATE TABLE IF NOT EXISTS AvtoDescribe (
id INT PRIMARY KEY,
tankType ENUM('Бензин','Световая энергия','Сила мысли'),
gearType ENUM('Механика','Автомат','Вариатор'),
engine_volume INT);

CREATE TABLE IF NOT EXISTS Avto (
id INT PRIMARY KEY,
autoNummer VARCHAR(10),
yearProd INT,
avtoMark_id INT,
avtoModel_id INT,
avtoDescribe_id INT,
FOREIGN KEY (avtoMark_id) REFERENCES AvtoMark(id),
FOREIGN KEY (avtoModel_id) REFERENCES AvtoModel(id),
FOREIGN KEY (avtoDescribe_id) REFERENCES AvtoDescribe(id)
);

CREATE TABLE IF NOT EXISTS AvtoCurPrice (
id INT PRIMARY KEY,
avtoId INT,
price INT,
data_cr DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (avtoId) REFERENCES Avto(id)
);