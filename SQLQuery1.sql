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
	Foreign Key (Takimi) References Takimi (Nr_Takimit) ,
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
Create Table Projekti_Menagjeri_Drejtori(
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
insert into Vetura values('03567','Golf','4','2020-08-22','2006','001')
insert into Vetura values('03343','Mercedes','5','2019-04-19','2012','001')
insert into Vetura values('04644','BMV','4','2018-05-30','2013','001')
insert into Vetura values('02654','BMV','4','2019-06-20','2014','001')
insert into Vetura values('03644','Opel','4','2017-03-10','2007','001')
insert into Vetura values('01644','Tesla','6','2020-09-24','2019','001')
insert into Vetura values('08423','BMV','5','2015-05-12','2011','001')
insert into Vetura values('09634','Ford','4','2014-04-16','2010','001')
insert into Vetura values('07834','Volvo','5','2018-05-30','2016','001')

--------------- 2)Tabela Vetura----------

----------------3) Tabela StafiPuntorve--------------
Select *
from StafiPuntorve

insert into StafiPuntorve values('10001','Albin','Islami','1998-04-22','BSc','01234','001')
insert into StafiPuntorve values('10002','Visar','Mehmeti','1997-05-12','BSc','03567','001')
insert into StafiPuntorve values('10003','Endrit','Mehmeti','1997-08-18','BSc','03343','001')
insert into StafiPuntorve values('10004','Shpetim','Shyti','1997-09-23','BSc','04644','001')
insert into StafiPuntorve values('10005','Kushtrim','Jashari','1996-04-06','BSc','02654','001')
insert into StafiPuntorve values('10006','Agron','Bajrami','1997-08-28','BSc','03644','001')
insert into StafiPuntorve values('10007','Burim','Hyseni','1996-03-09','BSc','01644','001')
insert into StafiPuntorve values('10008','Blerim','Gashi','1995-04-07','BSc','08423','001')
insert into StafiPuntorve values('10009','Leotrim','Smajli','1994-08-18','BSc','09634','001')
insert into StafiPuntorve values('10010','Artan','Krasniqi','1993-06-16','BSc','07834','001')
insert into StafiPuntorve values('10011','Naim','Salihu','1993-07-11','BSc','03343','001')
insert into StafiPuntorve values('10012','Liridon','Beqiri','1996-03-15','BSc','01644','001')
insert into StafiPuntorve values('10013','Blerta','Fazliu','1997-05-15','BSc','03644','001')
insert into StafiPuntorve values('10014','Rexhep','Sahiti','1995-01-12','BSc','04644','001')
insert into StafiPuntorve values('10014','Feride','Bislimi','1997-05-15','BSc','03567','001')
insert into StafiPuntorve values('10015','Arlind','Hajdini','1996-11-11','BSc','02654','001')
insert into StafiPuntorve values('10016','Enis','Ademaj','1996-11-11','BSc','01644','001')
insert into StafiPuntorve values('10017','Ardit','Hajdari','1996-12-01','BSc','08423','001')
insert into StafiPuntorve values('10018','Kaltrina','Ademi','1994-11-01','BSc','03343','001')
insert into StafiPuntorve values('10019','Sevdije','Idrizi','1995-11-05','BSc','02654','001')
insert into StafiPuntorve values('10020','Driton','Sadiku','1996-10-05','BSc','03343','001')


----------------3) Tabela StafiPuntorve--------------


-------------4) Tabela Zyrja---------------
Select *
from Zyrja

Insert into Zyrja(Kategoria,Puntori,Selia)
values ('Zyrja A','10001','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja B','10002','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja C','80.4','10003','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja AB','83.4','10004','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja DH','85.8','10005','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja LB','70.7','10006','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja G','87.4','10007','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja OT','89.3','10008','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja TR','60.6','10009','001')
Insert into Zyrja(Kategoria,Madhesia,Puntori,Selia)
values('Zyrja ET','88.6','10010','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja AT','10011','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja GT','10012','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja FF','10013','001')
Insert into Zyrja(Kategoria,Puntori,Selia) 
values('Zyrja FG','10014','001')
Insert into Zyrja(Kategoria,Puntori,Selia) 
values('Zyrja AG','10015','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja HG','10016','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja HH','10017','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja TF','10018','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja HF','10019','001')
Insert into Zyrja(Kategoria,Puntori,Selia)
values('Zyrja MF','10020','001')


-------------4) Tabela Zyrja-------------------

---------5) Tabela DrejtoriEkzekutiv----- 
Select *
from DrejtoriEkzekutiv

insert into DrejtoriEkzekutiv values('20100','Edmond','Hyseni','Mitrovice','Ardhmeria','40000','1','001')
insert into DrejtoriEkzekutiv values('20200','ALbin','Zeka','Prishtine','7 Shtatori','42000','2','002')
insert into DrejtoriEkzekutiv values('20300','Jeton','Krasniqi','Gjakove','1 Tetori','30000','3','003')
insert into DrejtoriEkzekutiv values('20400','Arlinda','Gashi','Prizren','Sami Frasheri','22000','4','004')
insert into DrejtoriEkzekutiv values('20500','Egzone','Berisha','Gjilan','Ali Kelmendi','29000','5','005')
insert into DrejtoriEkzekutiv values('20600','Ekrem','Ibishi','Ferizaj','Ferhat Draga','50000','6','006')
insert into DrejtoriEkzekutiv values('20700','Burim','Gjaka','Istog','Mustafe Shyti','46000','7','007')
insert into DrejtoriEkzekutiv values('20800','Naser','Bajrami','Peje','Bahri Kuqi','23000','8','008')
insert into DrejtoriEkzekutiv values('20900','Enver','Basholli','Lipijan','Atdheu','24000','9','009')
insert into DrejtoriEkzekutiv values('21000','Agron','Gashi','Vushtrri','Deshmoret e Kombit','42000','10','010')

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

--20200
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

insert into ZyrtarProjekteve values('10011', '10001')
insert into ZyrtarProjekteve values('10012', '10002')
insert into ZyrtarProjekteve values('10013', '10003')
insert into ZyrtarProjekteve values('10014', '10004')
insert into ZyrtarProjekteve values('10015', '10005')
insert into ZyrtarProjekteve values('10016', '10006')
insert into ZyrtarProjekteve values('10017', '10007')
insert into ZyrtarProjekteve values('10018', '10008')
insert into ZyrtarProjekteve values('10019', '10009')
insert into ZyrtarProjekteve values('10020', '10010')


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


Select t.Salla, s.Selia
From Takimi t JOIN SallaTakimeve s ON t.Salla = s.Nr_Salles
---------11) Tabela Takimi----------









---------12) Tabela Fermeri------------
Select * 
from Fermeri
Insert into Fermeri values('1234567810','Almir','Gashi','M','Vushtrri','Deshmoret e Kombit','42000','1234567810')
Insert into Fermeri values('1234567820','Andi','Beqiri','M','Mitrovice','Ardhmeria','40000','1234567810')
Insert into Fermeri values('1234567830','Leon','Krasniqi','M','Prishtine','7 Shtatori','42000','1234567810')
Insert into Fermeri values('1234567840','Besmir','Gjaka','M','Gjakove','1 Tetori','30000','1234567810')
Insert into Fermeri values('1234567850','Agron','Muja','M','Prizren','Sami Frasheri','22000','1234567810')
Insert into Fermeri values('1234567860','Gezim','Dushi','M','Gjilan','Ali Kelmendi','29000','1234567810')
Insert into Fermeri values('1234567870','Besim','Bislimi','M','Ferizaj','Ferhat Draga','50000','1234567810')
Insert into Fermeri values('1234567880','Muhamet','Topanica','M','Istog','Mustafe Shyti','46000','1234567810')
Insert into Fermeri values('1234567890','Agim','Aliu','M','Peje','Bahri Kuqi','23000','1234567810')
Insert into Fermeri values('1234567900','Albin','Berisha','M','Vushtrri','Rexhep Musa','42000','1234567810')
---------12) Tabela Fermeri------------

---------13 Tabela Shpallja----------
Select *
from Shpallja
Insert into Shpallja values('51','Vushtrri')
Insert into Shpallja values('52','Mitrovice')
Insert into Shpallja values('53','Prishtine')
Insert into Shpallja values('54','Gjakove')
Insert into Shpallja values('55','Prishtine')
Insert into Shpallja values('56','Vushtrri')
Insert into Shpallja values('57','Peje')
Insert into Shpallja values('58','Prishtine')
Insert into Shpallja values('59','Prizren')
Insert into Shpallja values('60','Lipijan')
---------13 Tabela Shpallja----------


---------14 Tabela Projekti----------
Select *
from Projekti
Insert into Projekti values('100','Egzon','2019-05-22','2019-09-28','2000')
Insert into Projekti values('101','Besfort','2018-04-12','2019-02-03','30000')
Insert into Projekti values('102','Besa','2019-06-12','2019-08-27','4000')
Insert into Projekti values('103','Behar','2019-08-02','2019-09-24','2000')
Insert into Projekti values('104','Valmir','2019-07-30','2019-10-29','5000')
Insert into Projekti values('105','Fatmir','2019-09-12','2019-11-26','2000')
Insert into Projekti values('106','Alban','2019-10-13','2019-12-19','6000')
Insert into Projekti values('107','Erblin','2019-11-30','2019-12-15','8000')
Insert into Projekti values('108','Albert','2019-12-21','2020-02-21','2000')
Insert into Projekti values('109','Bujar','2019-05-22','2019-08-23','9000')
Insert into Projekti values('110','Rinor','2019-02-19','2019-04-25','1000')
---------14 Tabela Projekti----------

---------15 Tabela Aktiviteti-----------
Select *
from Aktiviteti
Insert into Aktiviteti values('A01','100')
Insert into Aktiviteti values('A02','101')
Insert into Aktiviteti values('A03','102')
Insert into Aktiviteti values('A04','103')
Insert into Aktiviteti values('A05','104')
Insert into Aktiviteti values('A06','105')
Insert into Aktiviteti values('A07','106')
Insert into Aktiviteti values('A08','107')
Insert into Aktiviteti values('A09','108')
Insert into Aktiviteti values('A10','109')
Insert into Aktiviteti values('A11','101')
Insert into Aktiviteti values('A12','102')
Insert into Aktiviteti values('A13','103')
Insert into Aktiviteti values('A14','104')
Insert into Aktiviteti values('A15','105')
Insert into Aktiviteti values('A16','106')
Insert into Aktiviteti values('A17','107')
Insert into Aktiviteti values('A18','108')
Insert into Aktiviteti values('A19','109')
Insert into Aktiviteti values('A20','100')
---------15 Tabela Aktiviteti-----------

----------16 Tabela GrandePerFermer---------
Select * 
from GrandePerFermer

Insert into GrandePerFermer values('A01','Aktiv',15)
Insert into GrandePerFermer values('A02','Aktiv',10)
Insert into GrandePerFermer values('A03','Aktiv',9)
Insert into GrandePerFermer values('A04','Aktiv',8)
Insert into GrandePerFermer values('A05','Aktiv',14)
Insert into GrandePerFermer values('A06','Aktiv',17)
Insert into GrandePerFermer values('A07','Aktiv',18)
Insert into GrandePerFermer values('A08','Aktiv',12)
Insert into GrandePerFermer values('A09','Aktiv',11)
Insert into GrandePerFermer values('A10','Aktiv',16)



----------17 Tabela Trajnimi
Insert Into Trajnimi Values('A11', 'Ujitia E Serave', 'Mitrovice');
Insert Into Trajnimi Values('A12', 'Mbiellia E Fidaneve', 'Vushtrri');
Insert Into Trajnimi Values('A13', 'Pesticidet', 'Rahovec');
Insert Into Trajnimi Values('A14', 'Ujitia E Serave', 'Suharek');
Insert Into Trajnimi Values('A15', 'Airosia E Serrave', 'Prishtine');
Insert Into Trajnimi Values('A16', 'Ujitia E Serave', 'Podujev');
Insert Into Trajnimi Values('A17', 'Krasitia E Mollave', 'Maxhunaj');
Insert Into Trajnimi Values('A18', 'Mbiellia E Fidaneve', 'Pestove');
Insert Into Trajnimi Values('A19', 'Cilesia E Tokes', 'Novolan');
Insert Into Trajnimi Values('A20', 'Ujitia E Serave', 'Shtime');


----------17 Tabela Orari
Insert into Orari Values('A11','2021-05-11');
Insert into Orari Values('A12','2021-06-01');
Insert into Orari Values('A13','2021-07-10');
Insert into Orari Values('A14','2021-08-15');
Insert into Orari Values('A15','2021-09-19');
Insert into Orari Values('A16','2021-11-20');
Insert into Orari Values('A17','2021-12-25');
Insert into Orari Values('A18','2021-10-11');
Insert into Orari Values('A19','2021-03-13');
Insert into Orari Values('A20','2021-02-16');



Select t.Emri, o.Data
From Orari o JOIN Trajnimi t ON o.ID_Trajnimi = t.ID_Trajnimi

---------18) Tabela TelefoniFermeri------------
Insert Into TelefoniFermeri Values('1234567810','044001002');
Insert Into TelefoniFermeri Values('1234567820','044001003');
Insert Into TelefoniFermeri Values('1234567830','044001004');
Insert Into TelefoniFermeri Values('1234567840','044001005');
Insert Into TelefoniFermeri Values('1234567850','044001006');
Insert Into TelefoniFermeri Values('1234567860','044001007');
Insert Into TelefoniFermeri Values('1234567870','044001008');
Insert Into TelefoniFermeri Values('1234567880','044001009');
Insert Into TelefoniFermeri Values('1234567890','044001102');
Insert Into TelefoniFermeri Values('1234567900','044001103');



----------19 Tabela Takimi_Stafi-----------

Select * 
from Takimi_Stafi 
Insert into Takimi_Stafi values('1','10001')
Insert into Takimi_Stafi values('2','10002')
Insert into Takimi_Stafi values('3','10003')
Insert into Takimi_Stafi values('4','10004')
Insert into Takimi_Stafi values('5','10005')
Insert into Takimi_Stafi values('6','10006')
Insert into Takimi_Stafi values('7','10007')
Insert into Takimi_Stafi values('8','10008')
Insert into Takimi_Stafi values('9','10009')
Insert into Takimi_Stafi values('10','10010')
Insert into Takimi_Stafi values('1','10011')
Insert into Takimi_Stafi values('2','10012')
Insert into Takimi_Stafi values('3','10013')
Insert into Takimi_Stafi values('4','10014')
Insert into Takimi_Stafi values('5','10015')
Insert into Takimi_Stafi values('6','10016')
Insert into Takimi_Stafi values('7','10017')
Insert into Takimi_Stafi values('8','10018')
Insert into Takimi_Stafi values('9','10019')
Insert into Takimi_Stafi values('10','10020')
Insert into Takimi_Stafi values('5','10001')
Insert into Takimi_Stafi values('6','10011')
Insert into Takimi_Stafi values('7','10006')
Insert into Takimi_Stafi values('8','10016')
Insert into Takimi_Stafi values('9','10011')
Insert into Takimi_Stafi values('10','10013')











---------20 Tabela Shpallja_Fermeri----------
Insert Into Shpallja_Fermeri Values('51','1234567810','2021-09-28');
Insert Into Shpallja_Fermeri Values('51','1234567830','2021-09-18');
Insert Into Shpallja_Fermeri Values('51','1234567850','2021-09-08');
Insert Into Shpallja_Fermeri Values('51','1234567900','2021-09-13');
Insert Into Shpallja_Fermeri Values('51','1234567890','2021-08-25');
Insert Into Shpallja_Fermeri Values('51','1234567880','2021-07-27');
Insert Into Shpallja_Fermeri Values('52','1234567810','2021-06-24');
Insert Into Shpallja_Fermeri Values('52','1234567900','2021-05-22');
Insert Into Shpallja_Fermeri Values('52','1234567860','2021-04-21');
Insert Into Shpallja_Fermeri Values('52','1234567870','2021-03-29');
Insert Into Shpallja_Fermeri Values('53','1234567870','2021-02-20');
Insert Into Shpallja_Fermeri Values('53','1234567810','2021-01-30');
Insert Into Shpallja_Fermeri Values('53','1234567830','2021-01-26');
Insert Into Shpallja_Fermeri Values('53','1234567850','2021-02-28');
Insert Into Shpallja_Fermeri Values('53','1234567880','2021-04-27');
Insert Into Shpallja_Fermeri Values('54','1234567880','2021-10-28');
Insert Into Shpallja_Fermeri Values('54','1234567900','2021-08-29');
Insert Into Shpallja_Fermeri Values('54','1234567820','2021-07-20');
Insert Into Shpallja_Fermeri Values('54','1234567830','2021-06-21');
Insert Into Shpallja_Fermeri Values('54','1234567840','2021-05-23');
Insert Into Shpallja_Fermeri Values('55','1234567860','2021-12-26');
Insert Into Shpallja_Fermeri Values('56','1234567850','2021-05-21');
Insert Into Shpallja_Fermeri Values('57','1234567820','2021-12-18');
Insert Into Shpallja_Fermeri Values('58','1234567900','2021-05-17');
Insert Into Shpallja_Fermeri Values('59','1234567810','2021-04-19');
Insert Into Shpallja_Fermeri Values('60','1234567820','2021-01-20');



Select *
From Shpallja_Fermeri

---------20 Tabela ShpalljaFermeri----------

---------21 Tabela Projekti_Menagjeri_Drejtori----------

Select *
from Projekti_Menagjeri_Drejtori
Insert into Projekti_Menagjeri_Drejtori values('100','10001','20100')
Insert into Projekti_Menagjeri_Drejtori values('101','10002','20200')
Insert into Projekti_Menagjeri_Drejtori values('102','10003','20300')
Insert into Projekti_Menagjeri_Drejtori values('103','10004','20400')
Insert into Projekti_Menagjeri_Drejtori values('104','10005','20500')
Insert into Projekti_Menagjeri_Drejtori values('105','10006','20600')
Insert into Projekti_Menagjeri_Drejtori values('106','10007','20700')
Insert into Projekti_Menagjeri_Drejtori values('107','10008','20800')
Insert into Projekti_Menagjeri_Drejtori values('108','10009','20900')
Insert into Projekti_Menagjeri_Drejtori values('109','10010','21000')
---------21 Tabela Projekti_Menagjeri_Drejtori----------



















































