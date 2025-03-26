CREATE DATABASE IF NOT EXISTS Shchukin_091224_ptm;

CREATE TABLE IF NOT EXISTS Clients(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(50),
    address VARCHAR(50),
    registration_date DATE
);

CREATE TABLE IF NOT EXISTS Drivers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(50),
    license_number VARCHAR(50),
    license_issue_date DATE
);

CREATE TABLE IF NOT EXISTS Orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_time DATETIME,
    status VARCHAR(50),
    departure VARCHAR(50),
    arrival VARCHAR(50),
    client_id INT NOT NULL,
    driver_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Clients(id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Drivers(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Cars(
    id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(50),
    color VARCHAR(50),
    country VARCHAR(50),
    class VARCHAR(50),
    production_year YEAR
);

CREATE TABLE IF NOT EXISTS Schedule(
    id INT AUTO_INCREMENT PRIMARY KEY,
    shift_start TIME,
    shift_end TIME,
    driver_id INT NOT NULL,
    car_id INT NOT NULL,
    FOREIGN KEY (car_id) REFERENCES Cars(id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Drivers(id) ON DELETE CASCADE
);

