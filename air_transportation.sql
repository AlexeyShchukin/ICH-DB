CREATE DATABASE 091224_ALex_air_transp;

CREATE TABLE IF NOT EXISTS Clients(
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    birth_date DATE
);

CREATE TABLE IF NOT EXISTS Airports(
    code CHAR(3) PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Feedbacks(
    id INT PRIMARY KEY,
    text LONGTEXT,
    date DATE,
    ticket_id INT UNIQUE,
    FOREIGN KEY (ticket_id)  REFERENCES Tickets(id)
);

CREATE TABLE IF NOT EXISTS Tickets(
    id INT PRIMARY KEY,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES Clients(id)
);

CREATE TABLE IF NOT EXISTS Trips(
    id INT PRIMARY KEY,
    airport_code CHAR(3),
    crew_id INT,
    airliner_id INT,
    FOREIGN KEY (airport_code) REFERENCES Airports(code),
    FOREIGN KEY (crew_id) REFERENCES Crew(id),
    FOREIGN KEY (airliner_id) REFERENCES Airliners(id)
);

CREATE TABLE IF NOT EXISTS Crew(
    id INT PRIMARY KEY,
    captain VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Airliners(
    id INT PRIMARY KEY,
    model VARCHAR(50),
    prod_year YEAR
);

CREATE TABLE IF NOT EXISTS Repairs(
    id INT PRIMARY KEY,
    date_start DATE,
    date_end DATE,
    airliner_id INT,
    FOREIGN KEY (airliner_id) REFERENCES Airliners(id)
);


ALTER TABLE Tickets
    ADD COLUMN trip_id INT;

ALTER TABLE Tickets
ADD CONSTRAINT fk_trips
FOREIGN KEY (trip_id) REFERENCES Trips(id);

DESCRIBE Tickets;


