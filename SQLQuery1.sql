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
