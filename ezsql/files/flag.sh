#!/bin/bash
# 修改数据库中的flag , 如果中间有某个语句出错，则停止执行后面的SQL语句，但不报错
mysql -e "
CREATE database IF NOT EXISTS flaginit;
USE flaginit;
CREATE TABLE IF NOT EXISTS fflllaaaagggg
		(
		id int(3) NOT NULL AUTO_INCREMENT,
		username varchar(20) NOT NULL,
		trueflag varchar(20) NOT NULL,
		PRIMARY KEY (id)
		);
CREATE TABLE IF NOT EXISTS  emails
		(
		id int(3)NOT NULL AUTO_INCREMENT,
		email_id varchar(30) NOT NULL,
		PRIMARY KEY (id)
		);
CREATE TABLE IF NOT EXISTS uagents
		(
		id int(3)NOT NULL AUTO_INCREMENT,
		uagent varchar(256) NOT NULL,
		ip_address varchar(35) NOT NULL,
		username varchar(20) NOT NULL,
		PRIMARY KEY (id)
		);
CREATE TABLE IF NOT EXISTS referers
		(
		id int(3)NOT NULL AUTO_INCREMENT,
		referer varchar(256) NOT NULL,
		ip_address varchar(35) NOT NULL,
		PRIMARY KEY (id)
		);

INSERT INTO flaginit.fflllaaaagggg (id, username, trueflag) VALUES ('1', 'Dumb', '$GZCTF_FLAG'), ('2', 'Angelina', 'onanaonana'), ('3', 'Dummy', 'onana'), ('4', 'secure', '-onana'), ('5', 'stupid', 'stupidity'), ('6', 'superman', 'genious'), ('7', 'batman', 'onana'), ('8', 'admin', 'onana}');
INSERT INTO `flaginit`.`emails` (id, email_id) VALUES ('1', 'Dumb@dhakkan.com'), ('2', 'Angel@iloveu.com'), ('3', 'Dummy@dhakkan.local'), ('4', 'secure@dhakkan.local'), ('5', 'stupid@dhakkan.local'), ('6', 'superman@dhakkan.local'), ('7', 'batman@dhakkan.local'), ('8', 'admin@dhakkan.com');
" -u root -proot

export GZCTF_FLAG=not_flag
GZCTF_FLAG=not_flag
rm -f /flag.sh