/*ver 0.33 _0724 */

/*CREATE DB: daily_stud_db,tst_dev, okpm*/
CREATE DATABASE IF NOT EXISTS `daily_stud_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS `tst_dev_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS `okpm` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE `daily_stud_db`;

/*drop tables*/
DROP TABLE IF EXISTS daily_stud_db.t_assbook;
DROP TABLE IF EXISTS daily_stud_db.t_students;
DROP TABLE IF EXISTS daily_stud_db.t_uch_plan;
DROP TABLE IF EXISTS daily_stud_db.t_inst;
DROP TABLE IF EXISTS daily_stud_db.t_directions;
DROP TABLE IF EXISTS daily_stud_db.t_courses_ap;
DROP TABLE IF EXISTS daily_stud_db.t_profile;
DROP TABLE IF EXISTS daily_stud_db.t_staff;
DROP TABLE IF EXISTS daily_stud_db.t_staff_load;
DROP TABLE IF EXISTS daily_stud_db.t_chiar;
DROP TABLE IF EXISTS daily_stud_db.t_courses;
DROP TABLE IF EXISTS daily_stud_db.t_dom_users;
DROP TABLE IF EXISTS daily_stud_db.t_level;
DROP TABLE IF EXISTS daily_stud_db.t_control;

DROP TABLE IF EXISTS daily_stud_db.op_students_info_ad;



/* Зачетные книги студентов*/
CREATE TABLE IF NOT EXISTS
 `t_assbook` (
  `id` varchar(45) NOT NULL,
  `code_student` varchar(45) DEFAULT NULL,
  `code_up` int DEFAULT NULL,
  `code_state` int DEFAULT NULL,
  `code_group` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* кафедры институтов*/
CREATE TABLE IF NOT EXISTS
 `t_chiar` (
  `code_chiar` int NOT NULL,
  `code_dep` int DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `abbr` varchar(45) DEFAULT NULL,
  `id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code_chiar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Наименования дисциплин*/
CREATE TABLE IF NOT EXISTS
 `t_courses` (
  `code_course` int NOT NULL,
  `course_name` varchar(250) DEFAULT NULL,
  FULLTEXT KEY `name` (`course_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Дисциплины учебных планов*/
CREATE TABLE IF NOT EXISTS
 `t_courses_ap` (
  `code_course` int NOT NULL,
  `chair` varchar(250) DEFAULT NULL,
  `code_chair` int DEFAULT NULL,
  `code_ap` int DEFAULT NULL,
  `rec_mark` varchar(45) DEFAULT NULL,
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
 `t_directions` (
  `code_dir` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `code_inst` int DEFAULT NULL,
  `OKCO` varchar(15) DEFAULT NULL,
  `clip_name` varchar(45) DEFAULT NULL,
  `spec` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code_dir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* Пользователи домена sstuedudom*/
CREATE TABLE IF NOT EXISTS
 `t_dom_users` (
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
 `t_inst` (
  `inst_code` int NOT NULL, /*varchar(10) NOT NULL,*/
  `inst_name` varchar(250) DEFAULT NULL,
  `inst_abbr` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`inst_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Institutions of sstu';

/*Уровни образования*/
CREATE TABLE IF NOT EXISTS
 `t_level` (
  `name` varchar(45) DEFAULT NULL,
  `code_level` int NOT NULL,
  PRIMARY KEY (`code_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Электронная почта сотрудников (не используется)*/
CREATE TABLE IF NOT EXISTS
 `t_mail_users` (
  `code_staff` int DEFAULT NULL COMMENT '1C Un',
  `staff_id` int DEFAULT NULL COMMENT '1C Kadr',
  `email` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Профили основных образовательных программ*/
CREATE TABLE IF NOT EXISTS
 `t_profile` (
  `code_profile` varchar(11) NOT NULL,
  `name` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`code_profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*Преподаватели*/
CREATE TABLE IF NOT EXISTS
 `t_staff` (
  `code_staff` int NOT NULL COMMENT '1C Univ',
  `full_name` varchar(250) DEFAULT NULL,
  `code_chiar` int DEFAULT NULL,
  `id` int DEFAULT NULL COMMENT '1C Kadry',
  `code_pos` int DEFAULT NULL,
  `code_vid_zanl` int DEFAULT NULL,
  `stavka` varchar(45) DEFAULT NULL,
  `soc_number` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*Плановая нагрузка преподавателей по дисциплинам по видам нагрузки*/
CREATE TABLE IF NOT EXISTS
 `t_staff_load` (
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
 `t_students` (
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
 `t_uch_plan` (
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




/*Контрольная таблица*/
CREATE TABLE IF NOT EXISTS
`t_control` (
   id INT PRIMARY KEY,
   date_created VARCHAR(20)
);



/*load data files*/
LOAD DATA INFILE "/var/lib/mysql-files/zachetki.csv" INTO TABLE t_assbook COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/distsipliny_UchPlana.csv" INTO TABLE t_courses_ap COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/spetsialnosti.csv" INTO TABLE t_directions COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/profili.csv" INTO TABLE t_profile COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/sotrudniki.csv" INTO TABLE t_staff COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/nagruzka.csv" INTO TABLE t_staff_load COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/studenty.csv" INTO TABLE t_students COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/uch_plan.csv" INTO TABLE t_uch_plan COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/facultity.csv" INTO TABLE t_inst COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/cafedry.csv" INTO TABLE t_chiar COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/distsipliny.csv" INTO TABLE t_courses COLUMNS TERMINATED BY ';';
LOAD DATA INFILE "/var/lib/mysql-files/edudom_users.csv" INTO TABLE t_dom_users COLUMNS TERMINATED BY';';
LOAD DATA INFILE "/var/lib/mysql-files/level.csv" INTO TABLE t_level COLUMNS TERMINATED BY';';
LOAD DATA INFILE "/var/lib/mysql-files/list.csv" INTO TABLE t_control COLUMNS TERMINATED BY';';


/*edu_form_prefix added in ver. 0.3*/
CREATE TABLE IF NOT EXISTS op_students_info_ad
AS SELECT `id` as `number`, `full_name`, REPLACE(concat(inst_abbr, ' ', dir_nick, '-', year,code_group, ' ', plan.start, '_', plan.fin), '\r', '')  as `description`, REPLACE(replace(bdate, '.', ''), '\r', '') as bdate,
CASE
    WHEN code_form in (1, 4, 5) then 'd_'
    WHEN code_form in (2, 3) then 'z_'
    ELSE 'na_'
end as edu_form_pref
FROM `t_students`
LEFT JOIN t_assbook sbook ON t_students.code_stud = sbook.code_student
LEFT JOIN t_uch_plan plan ON plan.code = sbook.code_up
LEFT JOIN t_inst inst ON inst.inst_code=plan.code_inst
LEFT JOIN t_level level_ ON level_.code_level=plan.code_level
LEFT JOIN t_directions dir ON dir.code_dir=plan.code_dir
WHERE code_student and plan.code is not null
and left(inst_abbr, 4) != 'УПНК'
ORDER BY full_name;


/*tst_dev_db moodle*/
USE `tst_dev_db`;
/*drop tables*/
/*check_part*/
DROP TABLE IF EXISTS  `tst_dev_stud`,`no_valid_stud`, `op_students`, `op_students_info`,`op_big_groups`,`tmp_no_valid_email`, `t_control`;
                                                                                            CREATE TABLE IF NOT EXISTS `tst_dev_stud`(
    username VARCHAR(45) NOT NULL,                                                              last_name VARCHAR(250) NOT NULL,
    first_name VARCHAR(250) NOT NULL,                                                           email VARCHAR(250) NOT NULL UNIQUE,
    description VARCHAR(250) NOT NULL,                                                          auth VARCHAR(120) NOT NULL,
    idnumber VARCHAR(45) NOT NULL,                                                              lang CHAR(10) NOT NULL,
    password VARCHAR(255) DEFAULT NULL,                                                         deleted INT NOT NULL
);



CREATE TABLE IF NOT EXISTS `no_valid_stud`(
    username VARCHAR(45) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    first_name VARCHAR(250) NOT NULL,
    email VARCHAR(250) NOT NULL UNIQUE,
    description VARCHAR(250) NOT NULL,
    auth VARCHAR(120) NOT NULL,
    idnumber VARCHAR(45) NOT NULL,
    lang CHAR(10) NOT NULL,
    password VARCHAR(255) DEFAULT NULL,
    deleted INT NOT NULL
);


/*Контрольная таблица*/
CREATE TABLE IF NOT EXISTS
`t_control` (
   id INT PRIMARY KEY,
   date_created VARCHAR(20)
);



/*создание производной таблицы op_students*/
/*в таблицу для загрузки добавлен пустой столбец ''password*/
/*добавленно исключение email состоящих из одного символа 22.09.22*/
CREATE TABLE IF NOT EXISTS op_students as  /*+++++++++++*/
select username,lastname,firstname,replace(replace(replace(email,char(X'c2a0'),''),',',''),char(X'c2b6'),'') /*удаление предсказуемых ошибок в адресе*/
email,description,cohort1,auth,idnumber,lang,''password
from (SELECT trim(a.id) username, substring_index(full_name,' ',1) lastname,substring_index(trim(substring(full_name,instr(full_name,' '))),' ',1) firstname, if(trim(s.email)<>char(13)and email not like '%@%@%' and email not like '%:%' and email not like '%.@%' and email not like '%[%' and email not like '%(%' and email not like '%<%' and email not like '%]%'
and email not like '% %' and instr(s.email,'@')>1 and email like '%@%.%'
and CHAR_LENGTH (substring_index(email, '@', 1)) != 1, /*добавлен фильтр исключение emailов состоящих из одного символа*/
trim(replace(s.email,char(13),'')), concat(trim(a.id),'@no.mail')) email, /*удаление предсказуемых ошибок в адресе*/
concat(lpad(up.code,6,0),'.',up.start,'.',up.fin,'.',up.year,'.',a.code_group,' Не изменять!') description,
/* 20 символов слева являются ключем группировки!!!*/
concat(up.okco,'.',up.code_level,'.',up.code_profile) as cohort1, 'ldap' auth, trim(id) idnumber, 'ru' lang
FROM daily_stud_db.t_students s, daily_stud_db.t_assbook a, daily_stud_db.t_uch_plan up
where s.code_stud=a.code_student /*Связь ФИО с зачеткой*/
and a.code_up=up.code /*связь зачетки с учебным планом*/
and up.code_profile<>'' and up.code_profile in (select code_profile from daily_stud_db.t_profile) /*только профили из справочника*/
and up.code_level in (1,2,3,4,5,6,12,13,14,16,17,18) /*только эти уровни образования*/
and a.code_state in (1,3) /*добавлен фильтр по состоянию является студентом и студенты имеющие зодолженности*/) a where username regexp '^[0-9]+$'
/*только логины, состоящие из цифр*/
order by cohort1;



/*0.3 changed procedure of determination of edu_form*/
CREATE TABLE IF NOT EXISTS
op_students_info as SELECT `id` as `number`,`full_name`,concat(lpad(plan.code,6,0),'.',plan.start,'.',plan.fin,'.',plan.year,'.',sbook.code_group,' Не изменять') as `description`, REPLACE(`inst_abbr`, '\r', '') AS `inst_abbr`,concat (`dir_nick`,'-',`year`,`code_group`) as `sgroup`,plan.OKCO,
CASE
    WHEN code_form = 1 then 'очная'
    WHEN code_form = 2 then 'заочная-сокращенная'
    WHEN code_form = 3 then 'заочная'
    WHEN code_form = 4 then 'очная-сокращенная'
    WHEN code_form = 5 then 'очная'
ELSE 'очепятка в тексти очивидно же'
end as `edu_form`, concat(dir.clip_name,'(',plan.code_profile,',',level_.name,')') as prof_name,plan.code, t_students.bdate
FROM daily_stud_db.t_students
LEFT JOIN daily_stud_db.t_assbook `sbook` ON t_students.code_stud = sbook.code_student
LEFT JOIN daily_stud_db.t_uch_plan `plan` ON plan.code = sbook.code_up
LEFT JOIN daily_stud_db.t_inst `inst` ON inst.inst_code=plan.code_inst
LEFT JOIN daily_stud_db.t_level `level_` ON level_.code_level=plan.code_level
LEFT JOIN daily_stud_db.t_directions `dir` ON dir.code_dir=plan.code_dir
WHERE `code_student` and plan.code is not null
and left(inst_abbr,4) != 'УПНК'
ORDER BY `full_name`;



/*нормализация emailов*/
CREATE TABLE IF NOT EXISTS tmp_no_valid_email AS
SELECT op_s.* FROM op_students op_s
WHERE op_s.email IN (SELECT op_s2.email FROM op_students op_s2 WHERE op_s2.email != ''
GROUP BY op_s2.email HAVING COUNT(*) > 1)
ORDER BY op_s.email;


/*Процедура замены некорректных задублированых адресов электронной почты*/
UPDATE op_students
SET email = concat (username, '@', 'no.mail')
WHERE username IN (SELECT username from tmp_no_valid_email);

/* Добавлена новая таблица op_big_groups для не распределенных групп с более чем с 41 студентом!, которые необходимо пропуститьи, процедура удаления нераспределенных студентов из таблицы op_students AL 26.09.2022*/
CREATE TABLE IF NOT EXISTS op_big_groups as select * FROM op_students
WHERE description in (select description FROM op_students GROUP BY description HAVING COUNT(*) > 41);

/*Студенты принадлежащие вышеуказанным не распределенным группам удаляются из таблицы op_students */                                                                                    DELETE FROM  op_students 
WHERE op_students.username in (select username from op_big_groups);

/*загрузка таблицы студентов из базы moodle (tst_dev)*/
LOAD DATA INFILE "/var/lib/mysql-files/mysql_agent/std_out.csv" INTO TABLE tst_dev_stud COLUMNS TERMINATED BY ";" IGNORE 1 LINES;

/*загрузка таблицы студентов с неверным индентификатором*/
LOAD DATA INFILE "/var/lib/mysql-files/mysql_agent/no_valid_stud.csv" INTO TABLE no_valid_stud COLUMNS TERMINATED BY ";";
                                                                                            /*загрузка таблицы контроля в базу tst_dev*/
LOAD DATA INFILE "/var/lib/mysql-files/mysql_agent/c_okpm_list.csv" INTO TABLE t_control COLUMNS TERMINATED BY ';';


/*OKПM*/
USE `okpm`;

/*Удаление таблиц базы okpm*/
DROP TABLE IF EXISTS `op_students`, `op_students_info`, `new_students`, `diff_sgroup`,`no_valid_stud`, `t_control`;


/*Контрольная таблица*/
CREATE TABLE IF NOT EXISTS
`t_control` (
   id INT PRIMARY KEY,
   date_created VARCHAR(20)
);


/*копирование таблицы op_students и op_students_info из базы tst_dev_db*/
/*таблица для загрузки студентов в moodle*/
CREATE TABLE IF NOT EXISTS `op_students` AS SELECT * FROM tst_dev_db.op_students;
/*таблица с подробными сведениями о студентах*/
CREATE TABLE IF NOT EXISTS `op_students_info` AS SELECT * FROM tst_dev_db.op_students_info;
/*таблица с неправильными описаниями поле description в tst_dev (moodle)*/
CREATE TABLE IF NOT EXISTS `no_valid_stud` AS SELECT * FROM tst_dev_db.no_valid_stud;
/*формирование таблицы новых студентов new_students*/
CREATE TABLE new_students SELECT * FROM tst_dev_db.op_students where username not in (select username FROM tst_dev_db.tst_dev_stud) ORDER BY SUBSTRING_INDEX(SUBSTRING_INDEX(description, ".", 3), ".", -1);
/*формирование таблицы переведенных студентов*/
CREATE TABLE diff_sgroup as SELECT ops.username,ops.lastname, ops.firstname,ops.email,ops.description,ops.cohort1,ops.auth,ops.idnumber,'ru' lang,ops.password FROM tst_dev_db.op_students ops LEFT JOIN tst_dev_db.tst_dev_stud tdc ON ops.username = tdc.username WHERE ops.description != tdc.description ORDER BY SUBSTRING_INDEX(SUBSTRING_INDEX(ops.description, '.', 3), '.', -1);
                                                                                            /*загрузка таблицы контроля в базу okpm*/                                                   LOAD DATA INFILE "/var/lib/mysql-files/mysql_agent/c_okpm_list.csv" INTO TABLE t_control COLUMNS TERMINATED BY ';';
