Create DataBase Projekti_OJQ
Use Projekti_OJQ

-------------------------


-----Tabela DrejtoriEkzekutiv------
Create Table DrejtoriEkzekutiv(
	Id_Drejtori int Primary Key 
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	Qyteti varchar(25) Not Null,
	Rruga varchar(50) Not Null,
	ZipKodi int Not Null,
	Zyrja int Foregin Key Zyrja(Nr_Dhomes) ON Update Cascade ON Delete Set Null
);
-----Tabela DrejtoriEkzekutiv------

-----Tabela Selia------
Create Table Selia(
	Nr_Identifikues int Primary Key,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	Qyteti varchar(25) Not Null,
	Rruga varchar(50) Not Null,
	ZipKodi int Not Null,
	Drejtori int Foreign Key References DrejtoriEkzekutiv(Id_Drejtori) On Update Cascade ON Delete Set Null
);
-----Tabela Selia------