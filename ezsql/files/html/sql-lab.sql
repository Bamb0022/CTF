CREATE database flaginit;
USE flaginit;
CREATE TABLE fflllaaaagggg
		(
		id int(3) NOT NULL AUTO_INCREMENT,
		username varchar(20) NOT NULL,
		flagtrue varchar(20) NOT NULL,
		PRIMARY KEY (id)
		);
CREATE TABLE emails
		(
		id int(3)NOT NULL AUTO_INCREMENT,
		email_id varchar(30) NOT NULL,
		PRIMARY KEY (id)
		);
CREATE TABLE uagents
		(
		id int(3)NOT NULL AUTO_INCREMENT,
		uagent varchar(256) NOT NULL,
		ip_address varchar(35) NOT NULL,
		username varchar(20) NOT NULL,
		PRIMARY KEY (id)
		);
CREATE TABLE referers
		(
		id int(3)NOT NULL AUTO_INCREMENT,
		referer varchar(256) NOT NULL,
		ip_address varchar(35) NOT NULL,
		PRIMARY KEY (id)
		);

INSERT INTO flaginit.fflllaaaagggg (id, username, trueflag) VALUES ('1', 'Dumb', 'D0g3{'), ('2', 'Angelina', 'onanaonana'), ('3', 'Dummy', 'onana'), ('4', 'secure', '-onana'), ('5', 'stupid', 'stupidity'), ('6', 'superman', 'genious'), ('7', 'batman', 'onana'), ('8', 'admin', 'onana}');
INSERT INTO `flaginit`.`emails` (id, email_id) VALUES ('1', 'Dumb@dhakkan.com'), ('2', 'Angel@iloveu.com'), ('3', 'Dummy@dhakkan.local'), ('4', 'secure@dhakkan.local'), ('5', 'stupid@dhakkan.local'), ('6', 'superman@dhakkan.local'), ('7', 'batman@dhakkan.local'), ('8', 'admin@dhakkan.com');



