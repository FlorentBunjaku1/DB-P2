Create DataBase Projekti_OJQ
Use Projekti_OJQ

-------------------------


-----Tabela Selia------
Create Table Selia(
	Nr_Identifikues int Primary Key,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	Qyteti varchar(25) Not Null,
	Rruga varchar(50) Not Null,
	ZipKodi int Not Null,
);
-----Tabela Selia------

-----Tabela Vetura------
Create Table Vetura(
	Nr_Targave int Primary Key,
	Lloji varchar(15),
	NumriUlseve smallint,
	DataServisimit date,
	VitiProdhimit int,
	Selia int Foreign Key References Selia(Nr_Identifikues) ON Update Cascade ON Delete Set Null
);
-----Tabela Vetura------


-----Tabela StafiPuntorve------
Create Table StafiPuntorve(
	ID_Puntori int Primary Key,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	DateLindja Date,
	Kualifikimi varchar(50),
	Vetura int Foreign Key References Vetura(Nr_Targave) ON Update Cascade ON Delete Set Null
);
-----Tabela StafiPuntorve------

-----Tabela Zyrja------
Create Table Zyrja(
	Nr_Dhomes int Primary Key Identity(1,1),
	Kategoria varchar(30) Not Null,
	Madhesia Float Default 90.5 ,
	Puntori int Foreign Key References StafiPuntorve(ID_Puntori) ON Update Cascade ON Delete Set Null UNIQUE,
	Selia int Foreign Key References Selia(Nr_Identifikues) 
);
-----Tabela Zyrja------

-----Tabela DrejtoriEkzekutiv------
Create Table DrejtoriEkzekutiv(
	Id_Drejtori int Primary Key ,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	Qyteti varchar(25) Not Null,
	Rruga varchar(50) Not Null,
	ZipKodi int Not Null,
	Zyrja int Foreign Key References Zyrja(Nr_Dhomes) ON Update Cascade ON Delete Set Null Unique,
	Selia int Foreign Key References Selia(Nr_Identifikues) UNIQUE
);
-----Tabela DrejtoriEkzekutiv------

----Tabela Vizitori-----
Create Table Vizitori(
	Leternjoftimi int Primary Key,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	KohaArdhjes int not null,
	KohaShkuarjes int not null,
	Selia int Foreign Key references Selia(Nr_Identifikues)
);
-----Tabela SallaTakimeve----
Create Table SallaTakimeve(
	Nr_Salles int Primary Key,
	Selia int Foreign Key references Selia(Nr_Identifikues)
);









