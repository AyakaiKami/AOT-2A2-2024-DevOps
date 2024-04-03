begin;

drop table if exists studenti cascade;

drop table if exists cursuri cascade;

drop table if exists note cascade;

drop table if exists profesori cascade;

drop table if exists didactic cascade;

drop table if exists prieteni cascade;

create table studenti (
	id smallint primary key,
	nr_matricol character varying(6) not null,
	nume character varying(15) not null,
	prenume character varying(30) not null,
	an numeric(1),
	grupa character(2),
	bursa numeric(6,2),
	data_nastere date,
	email character varying(40),
	created_at timestamp with time zone,
	updated_at timestamp with time zone
);

create table cursuri (
	id smallint primary key,
	titlu_curs character varying(52) not null,
	an numeric(1),
	semestru numeric(1),
	credite numeric(2),
	created_at timestamp with time zone,
	updated_at timestamp with time zone
);

create table note (
	id smallint primary key,
	id_student smallint not null,
	id_curs smallint not null,
	valoare numeric(2),
	data_notare date,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	constraint fk_note_id_student foreign key (id_student) references studenti(id),
	constraint fk_note_id_curs foreign key (id_curs) references cursuri(id)
);

create table profesori (
	id smallint primary key,
	nume character varying(15) not null,
	prenume character varying(30) not null,
	grad_didactic character varying(20),
	created_at timestamp with time zone,
	updated_at timestamp with time zone
);

create table didactic (
	id smallint primary key,
	id_profesor smallint not null,
	id_curs smallint not null,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	constraint fk_didactic_id_profesor foreign key (id_profesor) references profesori(id),
	constraint fk_didactic_id_curs foreign key (id_curs) references cursuri(id)
);

create table prieteni (
	id smallint primary key,
	id_student1 smallint not null,
	id_student2 smallint not null,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	constraint fk_prieteni_id_student1 foreign key (id_student1) references studenti(id),
	constraint fk_prieteni_id_student2 foreign key (id_student2) references studenti(id),
	constraint no_duplicates unique (id_student1, id_student2)
);

create temporary table tmp_nume(
	id smallserial primary key,
	string character varying(15)
);

create temporary table tmp_prenume_fete(
	id smallserial primary key,
	string character varying(30)
);

create temporary table tmp_prenume_baieti(
	id smallserial primary key,
	string character varying(30)
);

create temporary table tmp_materii_an_1(
	id smallserial primary key,
	string character varying(52)
);

create temporary table tmp_materii_an_2(
	id smallserial primary key,
	string character varying(52)
);

create temporary table tmp_materii_an_3(
	id smallserial primary key,
	string character varying(52)
);

create temporary table tmp_grade_didactice(
	id smallserial primary key,
	string character varying(20)
);

insert into tmp_nume (id, string) values
	(default, 'Ababei'),
	(default, 'Acasandrei'),
	(default, 'Adăscăliței'),
	(default, 'Afanasie'),
	(default, 'Agafiței'),
	(default, 'Agape'),
	(default, 'Aioanei'),
	(default, 'Alexandrescu'),
	(default, 'Alexandru'),
	(default, 'Alexe'),
	(default, 'Alexii'),
	(default, 'Amarghioalei'),
	(default, 'Ambroci'),
	(default, 'Andonesei'),
	(default, 'Andrei'),
	(default, 'Andrian'),
	(default, 'Andrici'),
	(default, 'Andronic'),
	(default, 'Andros'),
	(default, 'Anghelina'),
	(default, 'Anita'),
	(default, 'Antochi'),
	(default, 'Antonie'),
	(default, 'Apetrei'),
	(default, 'Apostol'),
	(default, 'Arhip'),
	(default, 'Arhire'),
	(default, 'Arteni'),
	(default, 'Arvinte'),
	(default, 'Asaftei'),
	(default, 'Asofiei'),
	(default, 'Aungurenci'),
	(default, 'Avadanei'),
	(default, 'Avram'),
	(default, 'Babei'),
	(default, 'Baciu'),
	(default, 'Băetu'),
	(default, 'Bălan'),
	(default, 'Balica'),
	(default, 'Banu'),
	(default, 'Bărbieru'),
	(default, 'Bârzu'),
	(default, 'Bâzgan'),
	(default, 'Bejan'),
	(default, 'Bejenaru'),
	(default, 'Belcescu'),
	(default, 'Belciuganu'),
	(default, 'Benchea'),
	(default, 'Bilan'),
	(default, 'Bîrsanu'),
	(default, 'Bivol'),
	(default, 'Bîzu'),
	(default, 'Boca'),
	(default, 'Bodnar'),
	(default, 'Boiștean'),
	(default, 'Borcan'),
	(default, 'Bordeianu'),
	(default, 'Botezatu'),
	(default, 'Bradea'),
	(default, 'Brăescu'),
	(default, 'Budacă'),
	(default, 'Bulai'),
	(default, 'Bulbuc'),
	(default, 'Burlacu'),
	(default, 'Burloiu'),
	(default, 'Bursuc'),
	(default, 'Butacu'),
	(default, 'Bute'),
	(default, 'Buză'),
	(default, 'Calancea'),
	(default, 'Călinescu'),
	(default, 'Căpșuneanu'),
	(default, 'Caraiman'),
	(default, 'Cărbune'),
	(default, 'Carp'),
	(default, 'Cătană'),
	(default, 'Catîru'),
	(default, 'Cătănoiu'),
	(default, 'Cazacu'),
	(default, 'Cazamir'),
	(default, 'Cebere'),
	(default, 'Cehan'),
	(default, 'Cernescu'),
	(default, 'Chelaru'),
	(default, 'Chelmu'),
	(default, 'Chelmuș'),
	(default, 'Chibici'),
	(default, 'Chicos'),
	(default, 'Chilaboc'),
	(default, 'Chile'),
	(default, 'Chiriac'),
	(default, 'Chirilă'),
	(default, 'Chistol'),
	(default, 'Chitic'),
	(default, 'Chmilevski'),
	(default, 'Cimpoesu'),
	(default, 'Ciobanu'),
	(default, 'Ciobotaru'),
	(default, 'Ciocoiu'),
	(default, 'Ciofu'),
	(default, 'Ciornei'),
	(default, 'Citea'),
	(default, 'Ciucanu'),
	(default, 'Clătinici'),
	(default, 'Clim'),
	(default, 'Cobuz'),
	(default, 'Coca'),
	(default, 'Cojocariu'),
	(default, 'Cojocaru'),
	(default, 'Condurache'),
	(default, 'Corciu'),
	(default, 'Corduneanu'),
	(default, 'Corfu'),
	(default, 'Corneanu'),
	(default, 'Corodescu'),
	(default, 'Coseru'),
	(default, 'Coșniță'),
	(default, 'Costan'),
	(default, 'Covătariu'),
	(default, 'Cozma'),
	(default, 'Cozmiuc'),
	(default, 'Crăciunaș'),
	(default, 'Crăiniceanu'),
	(default, 'Creangă'),
	(default, 'Crețu'),
	(default, 'Cristea'),
	(default, 'Crucerescu'),
	(default, 'Cumpăta'),
	(default, 'Curcă'),
	(default, 'Cusmuliuc'),
	(default, 'Damian'),
	(default, 'Damoc'),
	(default, 'Daneliuc'),
	(default, 'Daniel'),
	(default, 'Danilă'),
	(default, 'Darie'),
	(default, 'Dăscălescu'),
	(default, 'Dascălu'),
	(default, 'Diaconu'),
	(default, 'Dima'),
	(default, 'Dimache'),
	(default, 'Dinu'),
	(default, 'Doboș'),
	(default, 'Dochiței'),
	(default, 'Dochițoiu'),
	(default, 'Dodan'),
	(default, 'Dogaru'),
	(default, 'Domnaru'),
	(default, 'Dorneanu'),
	(default, 'Drăgan'),
	(default, 'Drăgoman'),
	(default, 'Dragomir'),
	(default, 'Dragomirescu'),
	(default, 'Duceac'),
	(default, 'Dudău'),
	(default, 'Durnea'),
	(default, 'Edu'),
	(default, 'Eduard'),
	(default, 'Eusebiu'),
	(default, 'Fedeleș'),
	(default, 'Ferestrăuariu'),
	(default, 'Filibiu'),
	(default, 'Filimon'),
	(default, 'Filip'),
	(default, 'Florescu'),
	(default, 'Fola'),
	(default, 'Frumosu'),
	(default, 'Frunză'),
	(default, 'Gălățanu'),
	(default, 'Gavriliță'),
	(default, 'Gavriliuc'),
	(default, 'Gavrilovici'),
	(default, 'Gherase'),
	(default, 'Ghercă'),
	(default, 'Ghergu'),
	(default, 'Gherman'),
	(default, 'Ghibirdic'),
	(default, 'Giosanu'),
	(default, 'Gîtlan'),
	(default, 'Giurgilă'),
	(default, 'Glodeanu'),
	(default, 'Goldan'),
	(default, 'Gorgan'),
	(default, 'Grama'),
	(default, 'Grigore'),
	(default, 'Grigoriu'),
	(default, 'Grosu'),
	(default, 'Grozavu'),
	(default, 'Gurău'),
	(default, 'Haba'),
	(default, 'Harabulă'),
	(default, 'Hardon'),
	(default, 'Harpa'),
	(default, 'Herdeș'),
	(default, 'Herscovici'),
	(default, 'Hociung'),
	(default, 'Hodoreanu'),
	(default, 'Hostiuc'),
	(default, 'Huma'),
	(default, 'Huțanu'),
	(default, 'Huzum'),
	(default, 'Iacob'),
	(default, 'Iacobuță'),
	(default, 'Iancu'),
	(default, 'Ichim'),
	(default, 'Iftimesei'),
	(default, 'Ilie'),
	(default, 'Insuratelu'),
	(default, 'Ionesei'),
	(default, 'Ionesi'),
	(default, 'Ioniță'),
	(default, 'Iordache'),
	(default, 'Iordan'),
	(default, 'Iosub'),
	(default, 'Iovu'),
	(default, 'Irimia'),
	(default, 'Ivașcu'),
	(default, 'Jecu'),
	(default, 'Jitariuc'),
	(default, 'Jitcă'),
	(default, 'Joldescu'),
	(default, 'Juravle'),
	(default, 'Larion'),
	(default, 'Lateș'),
	(default, 'Latu'),
	(default, 'Lazăr'),
	(default, 'Leleu'),
	(default, 'Leon'),
	(default, 'Leonte'),
	(default, 'Leuciuc'),
	(default, 'Leuștean'),
	(default, 'Luca'),
	(default, 'Lucaci'),
	(default, 'Lucaș'),
	(default, 'Luncașu'),
	(default, 'Lungeanu'),
	(default, 'Lungu'),
	(default, 'Lupu'),
	(default, 'Macariu'),
	(default, 'Macoveschi'),
	(default, 'Maftei'),
	(default, 'Maganu'),
	(default, 'Mangalagiu'),
	(default, 'Manolache'),
	(default, 'Manole'),
	(default, 'Marcu'),
	(default, 'Marinov'),
	(default, 'Martinaș'),
	(default, 'Marton'),
	(default, 'Matacă'),
	(default, 'Matcovici'),
	(default, 'Matei'),
	(default, 'Maties'),
	(default, 'Matrana'),
	(default, 'Maxim'),
	(default, 'Măzăreanu'),
	(default, 'Mazilu'),
	(default, 'Mazur'),
	(default, 'Melniciuc'),
	(default, 'Micu'),
	(default, 'Mihaela'),
	(default, 'Mihai'),
	(default, 'Mihăilă'),
	(default, 'Mihăilescu'),
	(default, 'Mihalachi'),
	(default, 'Mihalcea'),
	(default, 'Mihociu'),
	(default, 'Miluț'),
	(default, 'Minea'),
	(default, 'Minghel'),
	(default, 'Minuț'),
	(default, 'Miron'),
	(default, 'Mitan'),
	(default, 'Moisa'),
	(default, 'Moni'),
	(default, 'Morărescu'),
	(default, 'Moroșanu'),
	(default, 'Moscu'),
	(default, 'Motrescu'),
	(default, 'Moroi'),
	(default, 'Munteanu'),
	(default, 'Murărașu'),
	(default, 'Muscă'),
	(default, 'Muțescu'),
	(default, 'Nastac'),
	(default, 'Nechita'),
	(default, 'Neghină'),
	(default, 'Negruș'),
	(default, 'Negrușer'),
	(default, 'Negruțu'),
	(default, 'Nemțoc'),
	(default, 'Netedu'),
	(default, 'Nica'),
	(default, 'Nicu'),
	(default, 'Oana'),
	(default, 'Olănuță'),
	(default, 'Olărașu'),
	(default, 'Olariu'),
	(default, 'Olaru'),
	(default, 'Onu'),
	(default, 'Opăriuc'),
	(default, 'Oprea'),
	(default, 'Ostafe'),
	(default, 'Otrocol'),
	(default, 'Palihovici'),
	(default, 'Pantțru'),
	(default, 'Panțiruc'),
	(default, 'Păpăruz'),
	(default, 'Păscaru'),
	(default, 'Patachi'),
	(default, 'Patras'),
	(default, 'Patriche'),
	(default, 'Perciun'),
	(default, 'Perju'),
	(default, 'Petcu'),
	(default, 'Pila'),
	(default, 'Pintilie'),
	(default, 'Piriu'),
	(default, 'Platon'),
	(default, 'Plugariu'),
	(default, 'Podaru'),
	(default, 'Poenariu'),
	(default, 'Pojar'),
	(default, 'Popa'),
	(default, 'Popescu'),
	(default, 'Popovici'),
	(default, 'Popuțoaia'),
	(default, 'Postolache'),
	(default, 'Predoaia'),
	(default, 'Prisecaru'),
	(default, 'Procop'),
	(default, 'Prodan'),
	(default, 'Puiu'),
	(default, 'Purice'),
	(default, 'Răchieru'),
	(default, 'Răzvan'),
	(default, 'Reuț'),
	(default, 'Rîțcanu'),
	(default, 'Rîza'),
	(default, 'Robu'),
	(default, 'Roman'),
	(default, 'Romanescu'),
	(default, 'Romaniuc'),
	(default, 'Roșca'),
	(default, 'Rusu'),
	(default, 'Samson'),
	(default, 'Sandu'),
	(default, 'Săndulache'),
	(default, 'Sava'),
	(default, 'Săvescu'),
	(default, 'Schifirnet'),
	(default, 'Scorțanu'),
	(default, 'Scurtu'),
	(default, 'Sfârghiu'),
	(default, 'Silitră'),
	(default, 'Simiganoschi'),
	(default, 'Simion'),
	(default, 'Simionescu'),
	(default, 'Simionesei'),
	(default, 'Simon'),
	(default, 'Sitaru'),
	(default, 'Sofian'),
	(default, 'Soficu'),
	(default, 'Sparhat'),
	(default, 'Spiridon'),
	(default, 'Stan'),
	(default, 'Stavarache'),
	(default, 'Ștefan'),
	(default, 'Ștefăniță'),
	(default, 'Stîngaciu'),
	(default, 'Stiufliuc'),
	(default, 'Stoian'),
	(default, 'Stoica'),
	(default, 'Stoleru'),
	(default, 'Stolniceanu'),
	(default, 'Stolnicu'),
	(default, 'Străinu'),
	(default, 'Strîmtu'),
	(default, 'Șuhani'),
	(default, 'Tabugan'),
	(default, 'Talie'),
	(default, 'Tanasă'),
	(default, 'Teclici'),
	(default, 'Teodorescu'),
	(default, 'Teșu'),
	(default, 'Țifrea'),
	(default, 'Timofte'),
	(default, 'Țîncu'),
	(default, 'Tîrpescu'),
	(default, 'Toader'),
	(default, 'Tofan'),
	(default, 'Toma'),
	(default, 'Țoncu'),
	(default, 'Trifan'),
	(default, 'Tudosă'),
	(default, 'Tudose'),
	(default, 'Tuduri'),
	(default, 'Țuiu'),
	(default, 'Turcu'),
	(default, 'Ulinici'),
	(default, 'Unghianu'),
	(default, 'Ungureanu'),
	(default, 'Ursache'),
	(default, 'Ursachi'),
	(default, 'Urse'),
	(default, 'Ursu'),
	(default, 'Vârlan'),
	(default, 'Vârtei'),
	(default, 'Varvaroi'),
	(default, 'Vasilache'),
	(default, 'Vasiliu'),
	(default, 'Ventaniuc'),
	(default, 'Vicol'),
	(default, 'Vidru'),
	(default, 'Vînătoru'),
	(default, 'Vlad'),
	(default, 'Voaideș'),
	(default, 'Vrabie'),
	(default, 'Vrabie'),
	(default, 'Vulpescu'),
	(default, 'Zob'),
	(default, 'Zamoșteanu'),
	(default, 'Zazuleac');

insert into tmp_prenume_fete (id, string) values
	(default, 'Adina'),
	(default, 'Alexandra'),
	(default, 'Alina'),
	(default, 'Ana'),
	(default, 'Anca'),
	(default, 'Anda'),
	(default, 'Andra'),
	(default, 'Andreea'),
	(default, 'Antonia'),
	(default, 'Bianca'),
	(default, 'Camelia'),
	(default, 'Claudia'),
	(default, 'Codrina'),
	(default, 'Cristina'),
	(default, 'Daniela'),
	(default, 'Daria'),
	(default, 'Delia'),
	(default, 'Denisa'),
	(default, 'Diana'),
	(default, 'Ecaterina'),
	(default, 'Elena'),
	(default, 'Eleonora'),
	(default, 'Elisa'),
	(default, 'Ema'),
	(default, 'Emanuela'),
	(default, 'Emma'),
	(default, 'Gabriela'),
	(default, 'Georgiana'),
	(default, 'Ileana'),
	(default, 'Ilona'),
	(default, 'Ioana'),
	(default, 'Iolanda'),
	(default, 'Irina'),
	(default, 'Iulia'),
	(default, 'Iuliana'),
	(default, 'Larisa'),
	(default, 'Laura'),
	(default, 'Loredana'),
	(default, 'Mădalina'),
	(default, 'Mălina'),
	(default, 'Manuela'),
	(default, 'Maria'),
	(default, 'Mihaela'),
	(default, 'Mirela'),
	(default, 'Monica'),
	(default, 'Oana'),
	(default, 'Paula'),
	(default, 'Petruța'),
	(default, 'Raluca'),
	(default, 'Sabina'),
	(default, 'Sânziana'),
	(default, 'Samina'),
	(default, 'Simona'),
	(default, 'Ștefana'),
	(default, 'Ștefania'),
	(default, 'Tamara'),
	(default, 'Teodora'),
	(default, 'Vasilica'),
	(default, 'Xena');

insert into tmp_prenume_baieti (id, string) values
	(default, 'Adrian'),
	(default, 'Alex'),
	(default, 'Alexandru'),
	(default, 'Alin'),
	(default, 'Andreas'),
	(default, 'Andrei'),
	(default, 'Aurelian'),
	(default, 'Beniamin'),
	(default, 'Bogdan'),
	(default, 'Camil'),
	(default, 'Cătalin'),
	(default, 'Cezar'),
	(default, 'Ciprian'),
	(default, 'Claudiu'),
	(default, 'Codrin'),
	(default, 'Constantin'),
	(default, 'Corneliu'),
	(default, 'Cosmin'),
	(default, 'Costel'),
	(default, 'Cristian'),
	(default, 'Damian'),
	(default, 'Dan'),
	(default, 'Daniel'),
	(default, 'Danuț'),
	(default, 'Darius'),
	(default, 'Denise'),
	(default, 'Dimitrie'),
	(default, 'Dorian'),
	(default, 'Dorin'),
	(default, 'Dragoș'),
	(default, 'Dumitru'),
	(default, 'Eduard'),
	(default, 'Elvis'),
	(default, 'Emil'),
	(default, 'Ervin'),
	(default, 'Eugen'),
	(default, 'Eusebiu'),
	(default, 'Fabian'),
	(default, 'Filip'),
	(default, 'Florian'),
	(default, 'Florin'),
	(default, 'Gabriel'),
	(default, 'George'),
	(default, 'Gheorghe'),
	(default, 'Giani'),
	(default, 'Giulio'),
	(default, 'Iaroslav'),
	(default, 'Ilie'),
	(default, 'Ioan'),
	(default, 'Ion'),
	(default, 'Ionel'),
	(default, 'Ionuț'),
	(default, 'Iosif'),
	(default, 'Irinel'),
	(default, 'Iulian'),
	(default, 'Iustin'),
	(default, 'Laurențiu'),
	(default, 'Liviu'),
	(default, 'Lucian'),
	(default, 'Marian'),
	(default, 'Marius'),
	(default, 'Matei'),
	(default, 'Mihai'),
	(default, 'Mihail'),
	(default, 'Nicolae'),
	(default, 'Nicu'),
	(default, 'Nicușor'),
	(default, 'Octavian'),
	(default, 'Ovidiu'),
	(default, 'Paul'),
	(default, 'Petru'),
	(default, 'Petruț'),
	(default, 'Radu'),
	(default, 'Rareș'),
	(default, 'Răzvan'),
	(default, 'Richard'),
	(default, 'Robert'),
	(default, 'Roland'),
	(default, 'Rolland'),
	(default, 'Romanescu'),
	(default, 'Sabin'),
	(default, 'Samuel'),
	(default, 'Sebastian'),
	(default, 'Sergiu'),
	(default, 'Silviu'),
	(default, 'Ștefan'),
	(default, 'Teodor'),
	(default, 'Teofil'),
	(default, 'Tudor'),
	(default, 'Vadim'),
	(default, 'Valentin'),
	(default, 'Valeriu'),
	(default, 'Vasile'),
	(default, 'Victor'),
	(default, 'Vlad'),
	(default, 'Vladimir'),
	(default, 'Vladuț');

insert into tmp_materii_an_1 (id, string) values
	(default, 'Logică'),
	(default, 'Matemetică'),
	(default, 'Introducere în programare'),
	(default, 'Arhitectura calculatoarelor și sisteme de operare'),
	(default, 'Sisteme de operare'),
	(default, 'Programare orientată-obiect'),
	(default, 'Fundamentele algebrice ale informaticii'),
	(default, 'Probabilități și statistică');

insert into tmp_materii_an_2 (id, string) values
	(default, 'Rețele de calculatoare'),
	(default, 'Baze de date'),
	(default, 'Limbaje formale, automate și compilatoare'),
	(default, 'Algoritmica grafurilor'),
	(default, 'Tehnologii WEB'),
	(default, 'Programare avansată'),
	(default, 'Ingineria Programării'),
	(default, 'Practică SGBD');

insert into tmp_materii_an_3 (id, string) values
	(default, 'Învățare automată'),
	(default, 'Securitatea informației'),
	(default, 'Inteligență artificială'),
	(default, 'Practică - Programare în Python'),
	(default, 'Calcul numeric'),
	(default, 'Grafică pe calculator'),
	(default, 'Managementul clasei de elevi'),
	(default, 'Rețele Petri și aplicații');

insert into tmp_grade_didactice (id, string) values
	(default, 'Colaborator'),
	(default, 'Asistent'),
	(default, 'Lector'),
	(default, 'Conferențiar'),
	(default, 'Profesor');

do $$
declare
	imortal constant timestamp with time zone := current_timestamp; 
begin
	declare
		nume_numar constant smallint := currval(pg_get_serial_sequence('tmp_nume', 'id'));
		prenumef_numar constant smallint := currval(pg_get_serial_sequence('tmp_prenume_fete', 'id'));
		prenumeb_numar constant smallint := currval(pg_get_serial_sequence('tmp_prenume_baieti', 'id'));
	
		v_student studenti;
		v_prenume character varying(30);
		v_temp smallint;
		v_rd smallint;
	begin
		for v_i in 1..1025
		loop
			v_student.id := v_i;
		
			v_rd = random_between(1, nume_numar);
			select string into v_student.nume from tmp_nume where id = v_rd;
			if (random() < 0.5)
			then
				v_rd = random_between(1, prenumef_numar);
				select string into v_student.prenume from tmp_prenume_fete where id = v_rd;
				loop
					v_rd = random_between(1, prenumef_numar);
					select string into v_prenume from tmp_prenume_fete where id = v_rd;
					exit when v_student.prenume <> v_prenume;
				end loop;
			else
				v_rd = random_between(1, prenumeb_numar);
				select string into v_student.prenume from tmp_prenume_baieti where id = v_rd;
				loop
					v_rd = random_between(1, prenumeb_numar);
					select string into v_prenume from tmp_prenume_baieti where id = v_rd;
					exit when v_student.prenume <> v_prenume;
				end loop;
			end if;
		
			if (random() < 0.6 and length(concat(v_student.prenume, ' ', v_prenume)) <= 30)
			then
				v_student.prenume := concat(v_student.prenume, ' ', v_prenume);
			end if;
		
			loop
				v_student.nr_matricol = concat(
					random_between(100, 999)::text,
					chr(random_between(65, 90)),
					chr(random_between(65, 90)),
					random_between(0, 9)::text
				);
				select count(*) into v_temp from studenti where nr_matricol = v_student.nr_matricol;
				exit when v_temp = 0;
			end loop;
		
			loop
				v_student.an := random_between(1, 3);
				v_student.grupa := concat(chr(random_between(0, 1) + 65), chr(random_between(0, 5) + 49));
				select count(*) into v_temp from studenti where an = v_student.an and grupa = v_student.grupa;
				exit when v_temp < 30;
			end loop;
	
			v_student.bursa := 0;
			if (random() < 0.1)
			then
				v_student.bursa := random_between(0, 9) * 100 + 500;
			end if;
      
			v_student.data_nastere := to_date('01-01-1994','DD-MM-YYYY') + random_between(0, 364);
      
			v_temp := null;
			if (strpos(v_student.prenume, ' ') = 0)
			then
				v_student.email := concat(
					lower(v_student.nume),
					'.',
					lower(v_student.prenume)
				);
			else
				v_student.email := concat(
					lower(v_student.nume),
					'.',
					lower(substr(v_student.prenume, 1, strpos(v_student.prenume, ' ') - 1))
				);
			end if;
	
			loop
				select count(*) into v_temp from studenti where email = concat(v_student.email, v_temp::text);
				exit when v_temp = 0;
				v_temp := random_between(0, 99);
			end loop;
		
			if (random() < 0.5)
			then
				v_student.email := concat(v_student.email, '@gmail.com');
			else
				v_student.email := concat(v_student.email, '@info.ro');
			end if;
	
			v_student.created_at = imortal;
			v_student.updated_at = imortal;
	
			insert into studenti values (v_student.*);
		end loop;

		raise notice 'S-au înmatriculat 1025 de studenți.';
	end;

	declare
		stud_numar studenti.id%type;
		v_prietenie prieteni;
		v_temp smallint;
	begin
		select count(*) into stud_numar from studenti;
		
		for v_i in 1..20000
		loop
			v_prietenie.id := v_i;
			loop
				v_prietenie.id_student1 := random_between(1, stud_numar);
				v_prietenie.id_student2 := random_between(1, stud_numar);
				
				if (v_prietenie.id_student1 = v_prietenie.id_student2)
				then
					v_temp := 1;
				else
					select count(*)
					into v_temp
					from prieteni
					where
						(id_student1 = v_prietenie.id_student1 and id_student2 = v_prietenie.id_student2) or
						(id_student1 = v_prietenie.id_student2 and id_student2 = v_prietenie.id_student1);
				end if;
				exit when v_temp = 0; 
			end loop;
			v_prietenie.created_at := imortal - concat(random_between(0, 999)::text, ' days')::interval;
			v_prietenie.updated_at := v_prietenie.created_at;
			insert into prieteni values (v_prietenie.*);
		end loop;
		raise notice 'S-au legat 20000 de prietenii.';
	end;

	declare
		v_curs cursuri;
	begin
		v_curs.created_at := imortal - '1200 days'::interval;
		v_curs.updated_at := v_curs.created_at;
		
		for v_i in 1..8
		loop
			if (v_i < 5)
			then
				v_curs.semestru := 1;
			else
				v_curs.semestru := 2;
			end if;
			
			if (v_i in (2, 3, 6, 7))
			then
				v_curs.credite := 5;
			elsif (v_i in (1, 5))
			then
				v_curs.credite := 4;
			elsif (v_i in (4, 8))
			then
				v_curs.credite := 6;
			end if;
		
			v_curs.id := v_i;
			select string into v_curs.titlu_curs from tmp_materii_an_1;
			insert into cursuri values (v_curs.*);
			
			v_curs.id := v_i + 8;
			select string into v_curs.titlu_curs from tmp_materii_an_2;
			insert into cursuri values (v_curs.*);
		
			v_curs.id := v_i + 16;
			select string into v_curs.titlu_curs from tmp_materii_an_3;
			insert into cursuri values (v_curs.*);
		end loop;
		raise notice 'S-au descoperit 24 de discipline împarțite pe 3 ani.';
	end;

	declare
		v_nota note;
		v_an studenti.an%type;
		v_nid smallint := 1;
	begin
		for v_i in 1..1025
		loop
			select an into v_an from studenti where id = v_i;
			v_nota.id_student := v_i;
		
			if (v_an >= 1)
			then
				for v_j in 1..8
				loop
					v_nota.id := v_nid;
					v_nota.id_curs := v_j;
					v_nota.valoare := random_between(0, 6) + 4;
					if (v_j <= 4)
					then
						v_nota.created_at := date_trunc('year', imortal) + concat((random_between(0, 13) + 40 - 365 * v_an)::text, ' days')::interval;
					else
						v_nota.created_at := date_trunc('year', imortal) + concat((random_between(0, 13) + 180 - 365 * v_an)::text, ' days')::interval;
					end if;
					v_nota.updated_at := v_nota.created_at;
					v_nota.data_notare := v_nota.created_at;
					insert into note values (v_nota.*);
					v_nid := v_nid + 1;
				end loop;
			end if;
		
			if (v_an >= 2)
			then
				for v_j in 1..8
				loop
					v_nota.id := v_nid;
					v_nota.id_curs := v_j + 8;
					v_nota.valoare := random_between(0, 6) + 4;
					if (v_j <= 4)
					then
						v_nota.created_at := date_trunc('year', imortal) + concat((random_between(0, 13) + 40 - 365 * v_an)::text, ' days')::interval;
					else
						v_nota.created_at := date_trunc('year', imortal) + concat((random_between(0, 13) + 180 - 365 * v_an)::text, ' days')::interval;
					end if;
					v_nota.updated_at := v_nota.created_at;
					v_nota.data_notare := v_nota.created_at;
					insert into note values (v_nota.*);
					v_nid := v_nid + 1;
				end loop;
			end if;
		
			if (v_an >= 3)
			then
				for v_j in 1..8
				loop
					v_nota.id := v_nid;
					v_nota.id_curs := v_j + 16;
					v_nota.valoare := random_between(0, 6) + 4;
					if (v_j <= 4)
					then
						v_nota.created_at := date_trunc('year', imortal) + concat((random_between(0, 13) + 40 - 365 * v_an)::text, ' days')::interval;
					else
						v_nota.created_at := date_trunc('year', imortal) + concat((random_between(0, 13) + 180 - 365 * v_an)::text, ' days')::interval;
					end if;
					v_nota.updated_at := v_nota.created_at;
					v_nota.data_notare := v_nota.created_at;
					insert into note values (v_nota.*);
					v_nid := v_nid + 1;
				end loop;
			end if;
		end loop;
		raise notice 'Studenții s-au prezentat la examene.';
	end;

	declare
		nume_numar constant smallint := currval(pg_get_serial_sequence('tmp_nume', 'id'));
		prenumef_numar constant smallint := currval(pg_get_serial_sequence('tmp_prenume_fete', 'id'));
		prenumeb_numar constant smallint := currval(pg_get_serial_sequence('tmp_prenume_baieti', 'id'));
	
		v_prof profesori;
		v_prenume character varying(30);
		v_rd smallint;
	begin
		for v_i in 1..30
		loop
			v_prof.id := v_i;
		
			v_rd = random_between(1, nume_numar);
			select string into v_prof.nume from tmp_nume where id = v_rd;
			if (random() < 0.5)
			then
				v_rd = random_between(1, prenumef_numar);
				select string into v_prof.prenume from tmp_prenume_fete where id = v_rd;
				loop
					v_rd = random_between(1, prenumef_numar);
					select string into v_prenume from tmp_prenume_fete where id = v_rd;
					exit when v_prof.prenume <> v_prenume;
				end loop;
			else
				v_rd = random_between(1, prenumeb_numar);
				select string into v_prof.prenume from tmp_prenume_baieti where id = v_rd;
				loop
					v_rd = random_between(1, prenumeb_numar);
					select string into v_prenume from tmp_prenume_baieti where id = v_rd;
					exit when v_prof.prenume <> v_prenume;
				end loop;
			end if;
		
			if (random() < 0.6 and length(concat(v_prof.prenume, ' ', v_prenume)) <= 30)
			then
				v_prof.prenume := concat(v_prof.prenume, ' ', v_prenume);
			end if;
		
			v_rd = random_between(1, 5);
			select string into v_prof.grad_didactic from tmp_grade_didactice;
		
			v_prof.created_at := imortal - '1000 days'::interval;
			v_prof.updated_at := v_prof.created_at;
		
			insert into profesori values (v_prof.*);
		end loop;
		raise notice 'S-au angajat 30 de profesori.';
	end;

	declare
		v_did didactic;
		v_nid smallint := 1;
	begin
		v_did.created_at := imortal - '1000 days'::interval;
		v_did.updated_at := v_did.created_at;
	
		for v_i in 1..24
		loop
			v_did.id_profesor := v_i;
			v_did.id_curs := v_i;
			v_did.id := v_nid;
			insert into didactic values (v_did.*);
			v_nid := v_nid + 1;
		end loop;
	
		for v_i in 1..50
		loop
			v_did.id_profesor := random_between(1, 30);
			v_did.id_curs := random_between(1, 24);
			v_did.id := v_nid;
			insert into didactic values (v_did.*);
			v_nid := v_nid + 1;
		end loop;
		raise notice 'Profesorii și-au revizuit cursurile.';
	end;
	raise notice 'S-a generat facultatea.';
end;
$$ language plpgsql;

drop table tmp_nume;
drop table tmp_prenume_fete;
drop table tmp_prenume_baieti;
drop table tmp_materii_an_1;
drop table tmp_materii_an_2;
drop table tmp_materii_an_3;
drop table tmp_grade_didactice;

commit;





















