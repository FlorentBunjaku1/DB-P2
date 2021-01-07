Create DataBase Projekti_OJQ
Use Projekti_OJQ
Use Master

Drop DataBase Projekti_OJQ
-------------------------


-----Tabela Selia------
Create Table Selia(
	Nr_Identifikues int Primary Key,
	Emri varchar(20) Not Null,
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
	Vetura int Foreign Key References Vetura(Nr_Targave) ON Update Cascade ON Delete Set Null,
	Selia int Foreign Key References Selia(Nr_Identifikues)
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

-----Tabela Telefoni------
Create Table Telefoni(
	Id_Drejtori int,
	Nr_Telefonit int,
	Foreign Key (Id_Drejtori) References DrejtoriEkzekutiv(Id_Drejtori) ,
	Primary Key (ID_Drejtori, Nr_Telefonit)
);
-----Tabela Telefoni------


----Tabela Vizitori-----
Create Table Vizitori(
	Leternjoftimi int Primary Key,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	KohaArdhjes date not null,
	KohaShkuarjes date not null,
	Selia int Foreign Key references Selia(Nr_Identifikues) Unique
);
-----Tabela SallaTakimeve----
Create Table SallaTakimeve(
	Nr_Salles int Primary Key,
	Selia int Foreign Key references Selia(Nr_Identifikues) Unique
);

-----Tabela MenagjeriProjekteve----
Create Table MenagjeriProjekteve(
	ID_Puntori int,
	Foreign Key (ID_Puntori) References StafiPuntorve(ID_Puntori),
	Primary Key (ID_Puntori)
);
-----Tabela MenagjeriProjekteve----

-----Tabela ZyrtarProjekteve----
Create Table ZyrtarProjekteve(
	ID_Puntori int Primary Key,
	Menagjeri int,
	Foreign Key (Menagjeri) References MenagjeriProjekteve(ID_Puntori),
	Foreign Key (ID_Puntori) References StafiPuntorve(ID_Puntori),
);
-----Tabela ZyrtarProjekteve----

-----Tabela Takimi----
Create Table Takimi(
	Nr_Takimit int Primary Key,
	KohaTakimit time,
	Salla int Foreign Key References SallaTakimeve(Nr_Salles),
	Drejotri int Foreign Key References DrejtoriEkzekutiv(Id_Drejtori)
);
-----Tabela Takimi----





-----Tabela Takimi_Stafi----
Create Table Takimi_Stafi(
	Takimi int,
	Stafi int,
	Primary Key (Takimi, Stafi) ,
	Foreign Key (Takimi) References Takimi (Nr_Takimit ) ,
	Foreign Key (Stafi) References StafiPuntorve (ID_Puntori) 
);
-----Tabela Takimi_Stafi----

-----Tabela Fermeri----
Create Table Fermeri(
	Leternjoftimi int Primary Key,
	Emri varchar(20) Not Null,
	Mbimeri varchar(20) Not Null,
	Gjinia char(1) NOT NULL,
	Qyteti varchar(25) Not Null,
	Rruga varchar(50) Not Null,
	ZipKodi int Not Null,
	Informuesi int Foreign Key References Fermeri(Leternjoftimi),
	Check (Gjinia IN ('M','F','N'))
);


-----Tabela Fermeri----

-----Tabela TelefoniFermeri----
Create Table TelefoniFermeri(
	Fermeri int,
	Nr_Telefonit int,
	Foreign Key (Fermeri) References Fermeri(Leternjoftimi) ,
	Primary Key (Fermeri, Nr_Telefonit)
);
-----Tabela TelefoniFermeri----

-----Tabela Shpallja----
Create Table Shpallja(
	Numri_Shpalljes int Primary Key,
	Vendi_Aplikimit varchar(50) NOT NULL
);
-----Tabela Shpallja----

-----Tabela Shpallja_Fermeri----
Create Table Shpallja_Fermeri(
	Shpallja int,
	Fermeri int,
	KohaAplikimit date,
	Primary Key (Shpallja, Fermeri),
	Foreign Key (Shpallja) References Shpallja(Numri_Shpalljes),
	Foreign Key (Fermeri) References Fermeri(Leternjoftimi) 
);
-----Tabela Shpallja_Fermeri----

-----Tabela Menaxheri_Zyrtari_SHF----
Create Table Menagjeri_Zyrtari_SHF(
	Zyrtari int Unique,
	Menagjeri int Unique,
	Primary Key (Zyrtari, Menagjeri),
	Fermeri int ,
	Shpallja int ,
	Foreign Key (Fermeri,Shpallja) References Shpallja_Fermeri(Shpallja,Fermeri),
	Foreign Key (Zyrtari) References ZyrtarProjekteve(ID_Puntori),
	Foreign Key (Menagjeri) References MenagjeriProjekteve(ID_Puntori) 
);
-----Tabela Menaxheri_Zyrtari_SHF----

-----Tabela Projekti----
Create Table Projekti(
	Nr_Projektit int Primary Key,
	Emri_Donatorit varchar(50),
	DataFillimit date,
	DataPerfundimit date,
	Buxheti Money Default 10000
);
-----Tabela Projekti----

-----Tabela Projekti_Menaxheri_Drejotri----
Create Table Projekti_Menagjeri_Drejotri(
	Projekti int Primary Key,
	Menagjeri int Foreign Key References MenagjeriProjekteve(ID_Puntori),
	Drejtori int Foreign Key References DrejtoriEkzekutiv(Id_drejtori),
	Foreign Key (Projekti) References Projekti(Nr_Projektit)
);
-----Tabela Projekti_Menaxheri_Drejotri----


-----Tabela Aktiviteti----
Create Table Aktiviteti(
	ID_Aktiviteti char(20) Primary Key,
	Projekti int Foreign Key References Projekti(Nr_Projektit)
);
-----Tabela Aktiviteti----

-----Tabela GrandePerFermer----
Create Table GrandePerFermer(
	ID_Grandi char(20) Primary  Key ,
	Lloji varchar(50),
	NumriFermereve int NOT NULL,
	Foreign Key (ID_Grandi) References Aktiviteti(ID_Aktiviteti)
);
-----Tabela GrandePerFermer----

-----Tabela Trajnimi----
Create Table Trajnimi(
	ID_Trajnimi char(20) Primary Key,
	Emri varchar(25),
	Vendi varchar(40),
	Foreign Key (ID_Trajnimi) References Aktiviteti(ID_Aktiviteti)
);
-----Tabela Trajnimi----


-----Tabela Orari----
Create Table Orari(
	ID_Trajnimi char(20),
	Data date,
	Primary Key(ID_Trajnimi,Data),
	Foreign Key (ID_Trajnimi) References Trajnimi(ID_Trajnimi) 
);
-----Tabela Orari----


-----Tabela Menagjeri_Aktiviteti_Shpallja----
Create Table Menagjeri_Aktiviteti_Shpallja(
	Aktiviteti char(20) Unique,
	Menagjeri int Unique,
	Shpallja int Foreign Key References Shpallja(Numri_Shpalljes),
	Primary key (Aktiviteti, Menagjeri),
	Foreign Key(Menagjeri) References MenagjeriProjekteve(ID_Puntori),
	Foreign Key(Aktiviteti) References Aktiviteti(ID_Aktiviteti)
);
-----Tabela Menagjeri_Aktiviteti_Shpallja----

---Insertimi i seteve te te dhenave per tabelat Prind---

-------------------1) Tabela Selia-------------
insert into Selia values ('001','Selia1','Vushtrri','Deshmoret e Kombit','42000')
insert into Selia values ('002','Selia2','Mitrovice','Ardhmeria','40000')
insert into Selia values ('003','Selia3','Prishtine','7 Shtatori','42000')
insert into Selia values ('004','Selia4','Gjakove','1 Tetori','30000')
insert into Selia values ('005','Selia5','Prizren','Sami Frasheri','22000')
insert into Selia values ('006','Selia6','Gjilan','Ali Kelmendi','29000')
insert into Selia values ('007','Selia7','Ferizaj','Ferhat Draga','50000')
insert into Selia values ('008','Selia8','Istog','Mustafe Shyti','46000')
insert into Selia values ('009','Selia9','Peje','Bahri Kuqi','23000')
insert into Selia values ('010','Selia10','Lipijan','Atdheu','24000')

Select * from Selia;
-------------------1) Tabela Selia------------

------------------2) Tabela Vizitori----------
insert into Vizitori values('1243724628','Donjeta','Krasniqi','2020-12-29','2020-12-30','001')
insert into Vizitori values('1243724392','Arton','Gashi','2021-01-04','2021-01-06','002')
insert into Vizitori values('1143324622','Endrit','Bajrami','2021-01-07','2021-01-08','003')
insert into Vizitori values('1443724327','Edmond','Muriqi','2021-01-01','2021-01-02','004')
insert into Vizitori values('1267424622','Liridon','Hyseni','2021-01-03','2021-01-04','005')
insert into Vizitori values('1243722629','Arlind','Islami','2021-01-10','2021-01-11','006')
insert into Vizitori values('1223726627','Ilir','Krasniqi','2021-01-12','2021-01-13','007')
insert into Vizitori values('1243726543','Lirim','Beqiri','2021-01-14','2021-01-15','008')
insert into Vizitori values('1223694628','Egzon','Rugova','2021-01-16','2021-01-17','009')
insert into Vizitori values('1243714629','Arsim','Leci','2021-01-18','2021-01-19','010')

Select * from Vizitori
order by selia;

------------------2) Tabela Vizitori----------


































