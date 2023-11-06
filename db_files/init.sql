/*create database*/
/*версия 0.3 исправленны некоторые ошибки версии 0.2 изменено название базы данных */
DROP DATABASE IF EXISTS `daily_stud_db080923`;
CREATE DATABASE IF NOT EXISTS `daily_stud_db080923` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `daily_stud_db080923`;

/*create tables*/

/* Зачетные книги студентов*/
CREATE TABLE IF NOT EXISTS
 `zm_assbook` (
  `id` varchar(45) NOT NULL,
  `code_student` varchar(45) DEFAULT NULL,
  `code_up` int DEFAULT NULL,
  `code_state` int DEFAULT NULL,
  `code_group` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* кафедры институтов*/
CREATE TABLE IF NOT EXISTS
 `zm_chiar` (
  `code_chiar` int NOT NULL,
  `code_dep` int DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `abbr` varchar(45) DEFAULT NULL,
  `id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code_chiar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Наименования дисциплин*/
CREATE TABLE IF NOT EXISTS
 `zm_courses` (
  `code_course` int NOT NULL,
  `course_name` varchar(250) DEFAULT NULL,
  FULLTEXT KEY `name` (`course_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*Дисциплины учебных планов*/
CREATE TABLE IF NOT EXISTS
 `zm_courses_ap` (
  `code_course` int NOT NULL,
  `chair` varchar(250) DEFAULT NULL,
  `code_chair` int DEFAULT NULL,
  `code_ap` int DEFAULT NULL,
  `rec_mark` varchar(11) DEFAULT NULL,
  `ass_period` int DEFAULT NULL,
  `code_payload` varchar(11) DEFAULT NULL,
  `code_ass` varchar(11) DEFAULT NULL,
  `block` int DEFAULT NULL,
  `payload_value` varchar(11) DEFAULT NULL,
  `course_index` int DEFAULT NULL,
  `block_mark` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Направления обучения*/
CREATE TABLE IF NOT EXISTS
 `zm_directions` (
  `code_dir` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `code_inst` int DEFAULT NULL,
  `OKCO` varchar(15) DEFAULT NULL,
  `clip_name` varchar(45) DEFAULT NULL,
  `spec` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code_dir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* Пользователи домена */
CREATE TABLE IF NOT EXISTS
 `zm_dom_users` (
 `login` varchar(100) NOT NULL,
 `staff_id` varchar(10) DEFAULT NULL,
 `code_staff` int DEFAULT NULL,
 `staff_snum` char(32) DEFAULT NULL,
 `email` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Формы обучения не используемая таблица исключена*/
/*CREATE TABLE IF NOT EXISTS
 `zm_forms` (
  `code_form` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code_form`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;*

/*Институты*/
CREATE TABLE IF NOT EXISTS
 `zm_inst` (
  `inst_code` varchar(10) NOT NULL,
  `inst_name` varchar(250) DEFAULT NULL,
  `inst_abbr` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`inst_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Institutions of education';

/*Уровни образования*/
CREATE TABLE IF NOT EXISTS
 `zm_level` (
  `name` varchar(45) DEFAULT NULL,
  `code_level` int NOT NULL,
  PRIMARY KEY (`code_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Электронная почта сотрудников (не используется)*/
CREATE TABLE IF NOT EXISTS
 `zm_mail_users` (
  `code_staff` int DEFAULT NULL COMMENT '1C Un',
  `staff_id` int DEFAULT NULL COMMENT '1C Kadr',
  `email` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Профили основных образовательных программ*/
CREATE TABLE IF NOT EXISTS
 `zm_profile` (
  `code_profile` varchar(11) NOT NULL,
  `name` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`code_profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Преподаватели*/
CREATE TABLE IF NOT EXISTS
 `zm_staff` (
  `code_staff` int NOT NULL COMMENT '1C Univ',
  `full_name` varchar(250) DEFAULT NULL,
  `code_chiar` int DEFAULT NULL,
  `id` int DEFAULT NULL COMMENT '1C Kadry',
  `code_pos` int DEFAULT NULL,
  `code_vid_zanl` int DEFAULT NULL,
  `stavka` varchar(45) DEFAULT NULL,
  `soc_number` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*Строки для зачисления преподавателей на список курсов*/
CREATE TABLE IF NOT EXISTS
 `zm_staff_bulk` (
  `course_string` varchar(4096) DEFAULT NULL,
  `cnt` int DEFAULT NULL,
  `mh` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*Плановая нагрузка преподавателей по дисциплинам по видам нагрузки*/
CREATE TABLE IF NOT EXISTS
 `zm_staff_load` (
  `code_course` int DEFAULT NULL,
  `code_chiar` int DEFAULT NULL,
  `code_staff` varchar(11) DEFAULT NULL,
  `code_ap` int DEFAULT NULL,
  `block` varchar(45) DEFAULT NULL,
  `ass_period` int DEFAULT NULL,
  `code_payload` varchar(11) DEFAULT NULL,
  `code_ass` varchar(11) DEFAULT NULL,
  `payload_value` varchar(45) DEFAULT NULL,
  `abbr` varchar(45) DEFAULT NULL,
  KEY `code_ass` (`code_ass`),
  KEY `code_payload` (`code_payload`),
  KEY `ass_period` (`ass_period`),
  KEY `code_ap` (`code_ap`),
  KEY `code_course` (`code_course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Студенты*/
CREATE TABLE IF NOT EXISTS
 `zm_students` (
  `code_stud` int NOT NULL,
  `full_name` varchar(245) DEFAULT NULL,
  `card_code` varchar(45) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `yes_no` varchar(45) DEFAULT NULL,
  `bdate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code_stud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*Учебные планы*/
CREATE TABLE IF NOT EXISTS
 `zm_uch_plan` (
  `code` int NOT NULL,
  `start` int DEFAULT NULL,
  `fin` int DEFAULT NULL,
  `code_inst` int DEFAULT NULL,
  `code_dir` int DEFAULT NULL,
  `dir_nick` varchar(45) DEFAULT NULL,
  `OKCO` varchar(15) DEFAULT NULL,
  `code_form` int DEFAULT NULL,
  `code_level` int DEFAULT NULL,
  `code_profile` varchar(11) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `len` varchar(45) DEFAULT NULL,
  `ack_fin` varchar(10) DEFAULT NULL,
  `exp_mark` int DEFAULT NULL,
  `code_qual` varchar(11) DEFAULT NULL,
  `clip_mark` int DEFAULT NULL,
  `info_mark` int DEFAULT NULL,
  `plus` varchar(1) DEFAULT NULL,
  `pplus` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `exp_mark` (`exp_mark`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*процедура загрузки файлов load data files*/
LOAD DATA INFILE "/var/lib/mysql-files/zachetki.csv" INTO TABLE zm_assbook COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/distsipliny_UchPlana.csv" INTO TABLE zm_courses_ap COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/spetsialnosti.csv" INTO TABLE zm_directions COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/profili.csv" INTO TABLE zm_profile COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/sotrudniki.csv" INTO TABLE zm_staff COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/nagruzka.csv" INTO TABLE zm_staff_load COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/studenty.csv" INTO TABLE zm_students COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/uch_plan.csv" INTO TABLE zm_uch_plan COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/facultity.csv" INTO TABLE zm_inst COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/cafedry.csv" INTO TABLE zm_chiar COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/distsipliny.csv" INTO TABLE zm_courses COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/edudom_users.csv" INTO TABLE zm_dom_users COLUMNS TERMINATED BY';';
LOAD DATA INFILE "/var/lib/mysql-files/level.csv" INTO TABLE zm_level COLUMNS TERMINATED BY';';

/*0.3 исправлена ошибка определение фрмы образования of edu_form добавлено исключение факультета УПНК*/
/*таблица полных сведений о студентах*/
CREATE TABLE IF NOT EXISTS
`op_students_info` as SELECT `id` as `number`,`full_name`,concat(lpad(plan.code,6,0),'.',plan.start,'.',plan.fin,'.',plan.year,'.',sbook.code_group,' Не изменять') as `description`,`inst_abbr`,concat (`dir_nick`,'-',`year`,`code_group`) as `sgroup`,plan.OKCO,
CASE 
WHEN `code_form` = 1 then 'Очная-сокращенная'
WHEN `code_form` = 2 then 'Заочная'
WHEN `code_form` = 3 then 'Заочная-сокращенная'
WHEN `code_form` = 4 then 'Очно-заочная'
WHEN `code_form` = 5 then 'Очная'
ELSE 'очепятка в тексти очивидно же'
end as `edu_form`,concat(dir.clip_name,'(',plan.code_profile,',',level_.name,')') as `prof_name`,plan.code,zm_students.bdate
FROM `zm_students`
LEFT JOIN `zm_assbook` `sbook` ON zm_students.code_stud = sbook.code_student
LEFT JOIN `zm_uch_plan` `plan` ON plan.code = sbook.code_up
LEFT JOIN `zm_inst` `inst` ON inst.inst_code=plan.code_inst
LEFT JOIN `zm_level` `level_` ON level_.code_level=plan.code_level
LEFT JOIN `zm_directions` `dir` ON dir.code_dir=plan.code_dir
WHERE `code_student` and plan.code is not null 
and inst_abbr != 'УПНК'
ORDER BY `full_name`;

/*таблица для загрузки в domain*/
/*0.3 в таблицу добавлено поле префикса edu_form_pref и исключение факультета УПНК*/
CREATE TABLE IF NOT EXISTS op_students_info_ad
AS SELECT id as number, full_name, concat (inst_abbr, ' ', dir_nick,'-', year, code_group, ' ', plan.start, '_', plan.fin) as description, replace (bdate, '.','') as bdate,
    WHEN code_form in (1, 4, 5) then 'd_'
    WHEN code_form in (2, 3) then 'z_'
    ELSE 'na_'
FROM zm_students
LEFT JOIN zm_assbook sbook ON zm_students.code_stud = sbook.code_student
LEFT JOIN zm_uch_plan plan ON plan.code = sbook.code_up
LEFT JOIN zm_inst inst ON inst.inst_code=plan.code_inst
LEFT JOIN zm_level level_ ON level_.code_level=plan.code_level
LEFT JOIN zm_directions dir ON dir.code_dir=plan.code_dir
WHERE code_student and plan.code is not null
and inst_abbr != 'УПНК'
ORDER BY full_name;

/*в таблицу для загрузки добавлен пустой столбец ''password*/
/*довалено иссключение email состоящих из одного символа 22.09.22*/
CREATE TABLE IF NOT EXISTS op_students as  /*+++++++++++*/
select username,lastname,firstname,replace(replace(replace(email,char(X'c2a0'),''),',',''),char(X'c2b6'),'') /*удаление предсказуемых ошибок в адресе*/
email,description,cohort1,auth,idnumber,lang,''password
from (SELECT trim(a.id) username, substring_index(full_name,' ',1) lastname,substring_index(trim(substring(full_name,instr(full_name,' '))),' ',1) firstname,
if(trim(s.email)<>char(13) and email not like '%@%@%' and email not like '%:%'
and email not like '%.@%' and email not like '%[%' and email not like '%(%' and email not like '%<%' and email not like '%]%'
and email not like '% %' and instr(s.email,'@')>1 and email like '%@%.%'
and CHAR_LENGTH (substring_index(email, '@', 1)) != 1,
/*добавлен фильтр исключение emailов состоящих из одного символа*/
trim(replace(s.email,char(13),'')), concat(trim(a.id),'@no.mail')) email,
/*удаление предсказуемых ошибок в адресе*/
concat(lpad(up.code,6,0),'.',up.start,'.',up.fin,'.',up.year,'.',a.code_group,' Не изменять!') description,
/* 20 символов слева являются ключем группировки!!!*/
concat(up.okco,'.',up.code_level,'.',up.code_profile) as cohort1,
'ldap' auth, trim(id) idnumber, 'ru' lang
FROM zm_students s, zm_assbook a, zm_uch_plan up
where s.code_stud=a.code_student
/*Связь ФИО с зачеткой*/
and a.code_up=up.code
/*связь зачетки с учебным планом*/
and up.code_profile<>'' and up.code_profile in (select code_profile from zm_profile)
/*только профили из справочника*/
and up.code_level in (1,2,3,4,5,6,12,13,14,16,17,18)
/*только эти уровни образования*/
and a.code_state in (1,3)
/*добавлен фильтр по состоянию является студентом и студенты имеющие зодолженности*/
 ) a where username regexp '^[0-9]+$'
 /*только логины, состоящие из цифр*/
order by cohort1;
