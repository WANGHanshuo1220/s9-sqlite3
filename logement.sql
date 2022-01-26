-- sqlite3 exp.db
-- .read logment.sql

DROP TABLE IF EXISTS Facture;
DROP TABLE IF EXISTS logement;
DROP TABLE IF EXISTS piece;
DROP TABLE IF EXISTS Capteur;
DROP TABLE IF EXISTS Adresse;
DROP TABLE IF EXISTS Ville;
DROP TABLE IF EXISTS type_cap;
DROP TABLE IF EXISTS mesure;

DROP TABLE IF EXISTS Possede_logement_piece;
DROP TABLE IF EXISTS Possede_piece_capteur;
DROP TABLE IF EXISTS Possede_type_capteur;
DROP TABLE IF EXISTS Possede_capteur_mesure;
DROP TABLE IF EXISTS Possede_logement_address;
DROP TABLE IF EXISTS alimenter_facture_logement;

-- commandes de destruction des tables
CREATE TABLE Facture (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT NOT NULL, date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            montant INTEGER, valeur_comsomme INTEGER);

CREATE TABLE logement (id INTEGER PRIMARY KEY AUTOINCREMENT, number_tele  INTEGER, date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            address_id TEXT NOT NULL,
            FOREIGN KEY (address_id) REFERENCES Addresse(address_id) );

CREATE TABLE piece (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL, coordonnee INTEGER);

CREATE TABLE Capteur (id INTEGER PRIMARY KEY AUTOINCREMENT, ref_a_piece TEXT NOT NULL,
                port_communication INTEGER, date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE Adresse (id INTEGER PRIMARY KEY AUTOINCREMENT, Numero INTEGER NOT NULL, 
            Voie TEXT NOT NULL, Nom_voie TEXT NOT NULL, Code INTEGER NOT NULL, FOREIGN KEY (Code) REFERENCES Ville(Code));

CREATE TABLE type_cap (id INTEGER PRIMARY KEY AUTOINCREMENT, plage_precision INTEGER, 
            ref_commeriale TEXT NOT NULL, unit TEXT NOT NULL);

CREATE TABLE mesure (id INTEGER PRIMARY KEY AUTOINCREMENT, valeur INTEGER, date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE Ville (Code INTEGER PRIMARY KEY, Nom TEXT NOT NULL);

-- Associations
CREATE TABLE Possede_logement_piece (idLoge INTEGER NOT NULL, idpiece INTEGER NOT NULL, 
            FOREIGN KEY (idLoge) REFERENCES logement(id), FOREIGN KEY (idpiece) REFERENCES piece(id), PRIMARY KEY (idLoge,idpiece));

CREATE TABLE Possede_piece_capteur (idpiece INTEGER NOT NULL, idCapteur INTEGER NOT NULL,
            FOREIGN KEY (idpiece) REFERENCES piece(id), FOREIGN KEY (idCapteur) REFERENCES Capteur(id), PRIMARY KEY (idpiece,idCapteur));

CREATE TABLE Possede_type_capteur (idtype INTEGER NOT NULL, idCapteur INTEGER NOT NULL, 
            FOREIGN KEY (idtype) REFERENCES type(id), FOREIGN KEY (idCapteur) REFERENCES Capteur(id), PRIMARY KEY (idtype,idCapteur));

CREATE TABLE Possede_capteur_mesure (idCapture INTEGER NOT NULL, idmesure INTEGER NOT NULL,
            FOREIGN KEY (idCapture) REFERENCES Capteur(id), FOREIGN KEY (idmesure) REFERENCES mesure(id), PRIMARY KEY (idCapture,idmesure));

CREATE TABLE Possede_logement_address (idLoge INTEGER NOT NULL, idaddress INTEGER NOT NULL,
            FOREIGN KEY (idLoge) REFERENCES logement(id), FOREIGN KEY (idaddress) REFERENCES Addresse(id), PRIMARY KEY (idLoge,idaddress));

CREATE TABLE alimenter_facture_logement (idfacture INTEGER NOT NULL, idloge INTEGER NOT NULL,
            FOREIGN KEY (idfacture) REFERENCES Facture(id), FOREIGN KEY (idloge) REFERENCES Addresse(id), PRIMARY KEY (idfacture,idloge));

-- build home
INSERT INTO logement ( number_tele, address_id) VALUES ("1111", "127.0.0.1");

INSERT INTO Adresse (Numero, Voie, Nom_voie, Code) VALUES
       (4, "allée", "des groseilliers", 92140),
       (14, "rue", "Berthelot", 94200),
       (18, "rue", "d Estrée", 75007),
       (56, "rue", "Arthur Rimbaud", 93300);

INSERT INTO Ville VALUES (92140, "Clamart"),
       (94200, "Ivry sur Seine"),
       (75007, "Paris"),
       (93300, "Aubervilliers");

INSERT INTO piece (nom, coordonnee) VALUES
        ("whs", 009),
        ("cqy", 110),
        ("zwh", 318),
        ("wyt", 006);

INSERT INTO type_cap (plage_precision, ref_commeriale, unit) VALUES
        (2, "A123", "kg"),
        (2, "B123", "m\s"),
        (2, "C123", "Celsius"),
        (2, "D123", "humidité");

INSERT INTO Capteur (ref_a_piece, port_communication) VALUES
        ("111", 1),
        ("222", 2),
        ("333", 3),
        ("444", 4);

INSERT INTO mesure (valeur) VALUES
        (0000),
        (1111),
        (2222),
        (3333),
        (4444),
        (5555),
        (6666),
        (7777);

INSERT INTO Facture (type, montant, valeur_comsomme) VALUES
        ("elec", 100, 1000),
        ("water", 200, 2000),
        ("gas", 300, 3000),
        ("IQ", 0, 999999);

INSERT INTO Possede_logement_piece VALUES
        (1, 1),
        (1, 2),
        (1, 3),
        (1, 4);

INSERT INTO Possede_piece_capteur VALUES
        (1, 1),
        (2, 2),
        (3, 3),
        (4, 4);

INSERT INTO Possede_type_capteur VALUES
        (1, 1),
        (2, 2),
        (3, 3),
        (4, 4);

INSERT INTO Possede_capteur_mesure VALUES
        (1, 1),
        (1, 2),
        (2, 3),
        (2, 4),
        (3, 5),
        (3, 6),
        (4, 7),
        (4, 8);

INSERT INTO Possede_logement_address VALUES
        (1, 1);

INSERT INTO alimenter_facture_logement VALUES
        (1, 1),
        (2, 1),
        (3, 1),
        (4, 1);