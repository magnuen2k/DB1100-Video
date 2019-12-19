/* sletter databasen før vi oppretter den på nytt*/
DROP SCHEMA IF EXISTS BlodlabbenAS;
CREATE SCHEMA BlodlabbenAS;
USE BlodlabbenAS;

CREATE TABLE Kunde (
	id INT AUTO_INCREMENT NOT NULL,
	navn VARCHAR(40) NOT NULL,
    epost VARCHAR(40) NOT NULL,
    adresse VARCHAR(40) NOT NULL,
    postnr INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Postnr (
	postnr INT NOT NULL,
	poststed VARCHAR(20),
    PRIMARY KEY (Postnr)
);

CREATE TABLE Ordre (
	id INT AUTO_INCREMENT NOT NULL,
	dato DATETIME,
    kunde_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE Resultat (
	id INT AUTO_INCREMENT NOT NULL,
    instrument_id INT,
    tidspunkt DATETIME,
    analyse_id INT,
    resultat FLOAT,
    PRIMARY KEY (id)
);

CREATE TABLE Analyse (
	id INT AUTO_INCREMENT NOT NULL,
	analysetype_id INT,
    ordre_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE Analysetype (
	id INT AUTO_INCREMENT NOT NULL,
	navn VARCHAR(20),
    utstyrstype_id INT,
    maaleenhet VARCHAR(10),
    PRIMARY KEY (id)
);

CREATE TABLE Utstyrstype (
	id INT AUTO_INCREMENT NOT NULL,
	navn VARCHAR(20),
    PRIMARY KEY (id)
);

CREATE TABLE Instrument (
	id INT AUTO_INCREMENT NOT NULL,
	navn VARCHAR(20),
    utstyrstype_id INT,
    PRIMARY KEY (id)
);

    
INSERT INTO Postnr VALUES
	(1528, "Moss"),
    (1552, "Noerandom"),
    (6256, "Etpoststed"),
    (5153, "Etannetsted"),
    (1526, "Dilling"),
    (1580, "Rygge");

INSERT INTO Kunde VALUES
	(NULL, "Et Navn", "etnavn@gmail.com", "Hagen 1", 1528),
    (NULL, "Et Nytt Navn", "etnyttnavn@gmail.com", "Hagen 3", 6256),
    (NULL, "Enda en", "enda1@gmail.com", "Gamlehagen 15", 1552),
    (NULL, "Enda mer", "endamer@gmail.com", "Nyhagen 32", 1580);
    
INSERT INTO Ordre VALUES
	(NULL, "2018-06-28 13:42:26", 2),
	(NULL, "2019-02-10 14:12:32", 1),
    (NULL, "2019-06-13 18:34:42", 3),
    (NULL, "2019-03-17 12:52:22", 4);
		
INSERT INTO Analyse VALUES
	(NULL, 2, 1),
	(NULL, 3, 4),
    (NULL, 1, 2),
    (NULL, 3, 3);
    
INSERT INTO Resultat VALUES
	(NULL, 4, "2019-03-28 14:51:22", 1, 0.32),
	(NULL, 2, "2018-07-03 15:12:26", 4, 0.45),
    (NULL, 1, "2019-02-26 12:15:32", 2, 0.83),
    (NULL, 3, "2019-06-27 14:41:42", 3, 0.31);
    
INSERT INTO Analysetype VALUES
	(NULL, "A Vitamin", 1,"nmol/l" ),
	(NULL, "B Vitamin", 1,"nmol/l" ),
    (NULL, "C Vitamin", 1,"nmol/l" ),
	(NULL, "D Vitamin", 1,"nmol/l" ),
	(NULL, "E Vitamin", 1,"nmol/l" ),
	(NULL, "Hemoglobin", 2,"g/dL" ),
	(NULL, "Glucose", 3,"mmol/l" );

INSERT INTO Utstyrstype VALUES
	(NULL, "Kromatograf"),
    (NULL, "Hermatolog"),
    (NULL, "Glucometer");
    
INSERT INTO Instrument VALUES
	(NULL, "HPLC 1", 1),
    (NULL, "HPLC 2", 1),
    (NULL, "GC 1", 1),
    (NULL, "HEMA 1", 2),
    (NULL, "HEMA 2", 2),
    (NULL, "GLUC 1", 3),
    (NULL, "GLUC 2", 3);
    
ALTER TABLE Kunde
	ADD CONSTRAINT fk_kunde_postnr FOREIGN KEY (postnr) REFERENCES Postnr(postnr);
    
ALTER TABLE Ordre 
	ADD CONSTRAINT fk_ordre_kunde FOREIGN KEY (kunde_id) REFERENCES Kunde(id);
    
ALTER TABLE Analyse
	ADD CONSTRAINT fk_analyse_ordre FOREIGN KEY (ordre_id) REFERENCES Ordre(id),
    ADD CONSTRAINT fk_analyse_analysetype FOREIGN KEY (analysetype_id) REFERENCES Analysetype(id);
    
ALTER TABLE Resultat
	ADD CONSTRAINT fk_resultat_analyse FOREIGN KEY (analyse_id) REFERENCES Analyse(id),
    ADD CONSTRAINT fk_resultat_instrument FOREIGN KEY (instrument_id) REFERENCES Instrument(id);

ALTER TABLE Analysetype
	ADD CONSTRAINT fk_analysetype_utstyrstype FOREIGN KEY (utstyrstype_id) REFERENCES Utstyrstype(id);
    
ALTER TABLE Instrument 
	ADD CONSTRAINT fk_instrument_utstyrstype FOREIGN KEY (utstyrstype_id) REFERENCES Utstyrstype(id);

