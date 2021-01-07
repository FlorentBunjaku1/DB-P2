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


--------------- 2)Tabela Vetura----------
Select *
from Vetura order by Selia

insert into Vetura values('01234','Audi','4','2020-09-25','2008','001')
insert into Vetura values('03567','Golf','4','2020-08-22','2006','002')
insert into Vetura values('03343','Mercedes','5','2019-04-19','2012','003')
insert into Vetura values('04644','BMV','4','2018-05-30','2013','004')
insert into Vetura values('02654','BMV','4','2019-06-20','2014','005')
insert into Vetura values('03644','Opel','4','2017-03-10','2007','006')
insert into Vetura values('01644','Tesla','6','2020-09-24','2019','007')
insert into Vetura values('08423','BMV','5','2015-05-12','2011','008')
insert into Vetura values('09634','Ford','4','2014-04-16','2010','009')
insert into Vetura values('07834','Volvo','5','2018-05-30','2016','010')

--------------- 2)Tabela Vetura----------

----------------3) Tabela StafiPuntorve--------------
Select *
from StafiPuntorve

insert into StafiPuntorve values('10001','Albin','Islami','1998-04-22','BSc','01234','001')
insert into StafiPuntorve values('10002','Visar','Mehmeti','1997-05-12','BSc','03567','002')
insert into StafiPuntorve values('10003','Endrit','Mehmeti','1997-08-18','BSc','03343','003')
insert into StafiPuntorve values('10004','Shpetim','Shyti','1997-09-23','BSc','04644','004')
insert into StafiPuntorve values('10005','Kushtrim','Jashari','1996-04-06','BSc','02654','005')
insert into StafiPuntorve values('10006','Agron','Bajrami','1997-08-28','BSc','03644','006')
insert into StafiPuntorve values('10007','Burim','Hyseni','1996-03-09','BSc','01644','007')
insert into StafiPuntorve values('10008','Blerim','Gashi','1995-04-07','BSc','08423','008')
insert into StafiPuntorve values('10009','Leotrim','Smajli','1994-08-18','BSc','09634','009')
insert into StafiPuntorve values('10010','Artan','Krasniqi','1993-06-16','BSc','07834','010')

----------------3) Tabela StafiPuntorve--------------


-------------4) Tabela Zyrja---------------
Select *
from Zyrja
Insert into Zyrja(Kategoria,Puntori,Selia)
values ('Zyrja A','10001','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja B','10002','002')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja C','80.4','10003','003')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja AB','83.4','10004','004')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja DH','85.8','10005','005')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja LB','70.7','10006','006')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja G','87.4','10007','007')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja OT','89.3','10008','008')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja TR','60.6','10009','009')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja ET','88.6','10010','010')


-------------4) Tabela Zyrja-------------------

---------5) Tabela DrejtoriEkzekutiv----- 
Select *
from DrejtoriEkzekutiv

insert into DrejtoriEkzekutiv(Id_Drejtori,Emri,Mbimeri,Qyteti,Rruga,ZipKodi)
values('20100','Agron','Gashi','Vushtrri','Deshmoret e Kombit','42000')
insert into DrejtoriEkzekutiv(Id_Drejtori,Emri,Mbimeri,Qyteti,Rruga,ZipKodi,Zyrja,Selia)
values('20300','ALbin','Zeka','Prishtine','7 Shtatori','42000','2','002')
insert into DrejtoriEkzekutiv(Id_Drejtori,Emri,Mbimeri,Qyteti,Rruga,ZipKodi,Zyrja,Selia)
values('20400','Jeton','Krasniqi','Gjakove','1 Tetori','30000','3','003')
insert into DrejtoriEkzekutiv values('20200','Edmond','Hyseni','Mitrovice','Ardhmeria','40000','1','001')
insert into DrejtoriEkzekutiv values('20500','Arlinda','Gashi','Prizren','Sami Frasheri','22000','4','004')
insert into DrejtoriEkzekutiv values('20600','Egzone','Berisha','Gjilan','Ali Kelmendi','29000','5','005')
insert into DrejtoriEkzekutiv values('20700','Ekrem','Ibishi','Ferizaj','Ferhat Draga','50000','6','006')
insert into DrejtoriEkzekutiv values('20800','Burim','Gjaka','Istog','Mustafe Shyti','46000','7','007')
insert into DrejtoriEkzekutiv values('20900','Naser','Bajrami','Peje','Bahri Kuqi','23000','8','008')
insert into DrejtoriEkzekutiv values('21000','Enver','Basholli','Lipijan','Atdheu','24000','9','009')

---------5) Tabela DrejtoriEkzekutiv-------

---------6) Tabela Telefoni------------
Select *
from Telefoni
insert into Telefoni values('20100','044628833')
insert into Telefoni values('20200','044628834')
insert into Telefoni values('20300','044628835')
insert into Telefoni values('20400','044628836')
insert into Telefoni values('20500','044628832')
insert into Telefoni values('20600','044628831')
insert into Telefoni values('20700','044628837')
insert into Telefoni values('20800','044628838')
insert into Telefoni values('20900','044628839')
insert into Telefoni values('21000','044628810')

---------6) Tabela Telefoni------------


------------------7) Tabela Vizitori--------
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

------------------7) Tabela Vizitori----------

--------------8) Tabela SallaTakimeve---------
Select * 
from SallaTakimeve

insert into SallaTakimeve values('101','001')
insert into SallaTakimeve values('102','002')
insert into SallaTakimeve values('103','003')
insert into SallaTakimeve values('104','004')
insert into SallaTakimeve values('105','005')
insert into SallaTakimeve values('106','006')
insert into SallaTakimeve values('107','007')
insert into SallaTakimeve values('108','008')
insert into SallaTakimeve values('109','009')
insert into SallaTakimeve values('110','010')
--------------8) Tabela SallaTakimeve-------------

----------- 9)Tabela Menaxheriprojekteve---------
Select *
from MenagjeriProjekteve
insert into MenagjeriProjekteve values('10001')
insert into MenagjeriProjekteve values('10002')
insert into MenagjeriProjekteve values('10003')
insert into MenagjeriProjekteve values('10004')
insert into MenagjeriProjekteve values('10005')
insert into MenagjeriProjekteve values('10006')
insert into MenagjeriProjekteve values('10007')
insert into MenagjeriProjekteve values('10008')
insert into MenagjeriProjekteve values('10009')
insert into MenagjeriProjekteve values('10010')
----------- 9)Tabela Menaxheriprojekteve---------


----------10) Tabela ZyrtarProjekteve-----------Duhet me shtu edhe Menaxheri--
Select *
from ZyrtarProjekteve
insert into ZyrtarProjekteve values('10001')
insert into ZyrtarProjekteve values('10002')
insert into ZyrtarProjekteve values('10003')
insert into ZyrtarProjekteve values('10004')
insert into ZyrtarProjekteve values('10005')
insert into ZyrtarProjekteve values('10006')
insert into ZyrtarProjekteve values('10007')
insert into ZyrtarProjekteve values('10008')
insert into ZyrtarProjekteve values('10009')
insert into ZyrtarProjekteve values('10010')


----------10) Tabela ZyrtarProjekteve-------------




---------11) Tabela Takimi----------
Select *
from Takimi

insert into Takimi values('1','13:00:00','101','20100')
insert into Takimi values('2','14:00:00','102','20200')
insert into Takimi values('3','15:00:00','103','20300')
insert into Takimi values('4','16:00:00','104','20400')
insert into Takimi values('5','17:00:00','105','20500')
insert into Takimi values('6','18:00:00','106','20600')
insert into Takimi values('7','19:00:00','107','20700')
insert into Takimi values('8','20:00:00','108','20800')
insert into Takimi values('9','20:30:00','109','20900')
insert into Takimi values('10','21:00:00','110','21000')
---------4) Tabela Takimi----------










































