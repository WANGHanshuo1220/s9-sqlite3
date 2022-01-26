import sqlite3, random, string

facture_type = ["elec", "water", "gas", "IQ"]

# ouverture/initialisation de la base de donnee 
conn = sqlite3.connect('logement.db')
conn.row_factory = sqlite3.Row
c = conn.cursor()

# A completer...
print("-----------------------------------------------")
print("-------------befor add fatrure-----------------")
print("-----------------------------------------------")
last_id = 0
for raw in c.execute('SELECT * FROM Facture'):
	print (raw.keys())
	print (raw["id"])
	print (raw["type"])
	print (raw["date"])
	print (raw["montant"])
	print (raw["valeur_comsomme"])
	last_id = raw["id"]

print("-----------------------------------------------")
print("-------------after add fatrure-----------------")
print("-----------------------------------------------")

# insertion de plusieurs donnees
values = []
for i in range(1,3):
	values.append((last_id+i, facture_type[random.randint(0,3)],"'%d/11/2020'" %(random.randint(1,30)), i+100, (i+100)*10))
c.executemany('INSERT INTO Facture VALUES (?,?,?,?,?)', values)

# lecture dans la base avec un select
for raw in c.execute('SELECT * FROM Facture'):
	print (raw.keys())
	print (raw["id"])
	print (raw["type"])
	print (raw["date"])
	print (raw["montant"])
	print (raw["valeur_comsomme"])

print("/n============================================================")
print("============================================================/n")

print("-----------------------------------------------")
print("-------------befor add mesure------------------")
print("-----------------------------------------------")
last_id = 0
for raw in c.execute('SELECT * FROM mesure'):
	print (raw.keys())
	print (raw["id"])
	print (raw["valeur"])
	print (raw["date"])
	last_id = raw["id"]

print("-----------------------------------------------")
print("-------------after add mesure------------------")
print("-----------------------------------------------")

# insertion de plusieurs donnees
values = []
for i in range(1,3):
	values.append((last_id+i, random.randint(0,3),"'%d/11/2020'" %(random.randint(1,30))))
c.executemany('INSERT INTO mesure VALUES (?,?,?)', values)

# lecture dans la base avec un select
for raw in c.execute('SELECT * FROM mesure'):
	print (raw.keys())
	print (raw["id"])
	print (raw["valeur"])
	print (raw["date"])


# fermeture
conn.commit()
conn.close()
