/* TABLE DELETION: deletes old tables for rerunnability */

DROP TABLE IF EXISTS tech_used;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS contributor;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS technology;
DROP TABLE IF EXISTS term;

/* TABLE CREATION: portion of the code for making the tables */

CREATE TABLE term (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    UNIQUE(name)
) engine = innodb;

CREATE TABLE technology (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    UNIQUE(name)
) engine = innodb;

CREATE TABLE class (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    code varchar(10) NOT NULL,
    year smallint NOT NULL,
    fk_term_id int(11) NOT NULL,
    FOREIGN KEY (fk_term_id) REFERENCES term(id) ON DELETE CASCADE,
    UNIQUE(name),
    UNIQUE(code)
) engine = innodb;

CREATE TABLE contributor (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    github_id varchar(100) NOT NULL,
    UNIQUE(github_id)
) engine = innodb;

CREATE TABLE project (
    id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    active bit DEFAULT 1,
    git_repo varchar(100) NOT NULL,
    fk_class_id int(11) NOT NULL,
    FOREIGN KEY (fk_class_id) REFERENCES class(id),
    UNIQUE(name)
) engine = innodb;

CREATE TABLE tech_used (
    fk_tech_id int(11) NOT NULL,
    fk_project_id int(11) NOT NULL,
    FOREIGN KEY (fk_tech_id) REFERENCES technology(id) ON DELETE CASCADE,
    FOREIGN KEY (fk_project_id) REFERENCES project(id) ON DELETE CASCADE,
    PRIMARY KEY(fk_tech_id, fk_project_id)
) engine = innodb;

/* SAMPLE DATA: inserts for the sample data */
INSERT INTO term (name) VALUES ('Fall'), ('Winter'), ('Spring'), ('Summer');
INSERT INTO technology (name) VALUES ('Python'), ('C++'), ('Java'), ('SQL'), ('Node.js'), ('Sockets');
INSERT INTO class (name, code, year, fk_term_id) VALUES ('Intro to Database', 'CS340', 2018, 1),
                                                        ('Software Engineering 2', 'CS362', 2018, 1),
                                                        ('Software Engineering 1', 'CS361', 2016, 3),
                                                        ('Intro to Networks', 'CS372', 2017, 2);
INSERT INTO contributor (first_name, last_name, github_id) VALUES ('George', 'Mistkawi', 'mistkawg'),
                                                                  ('John', 'Deer', 'deerj'),
                                                                  ('Jane', 'Doe', 'doej');
INSERT INTO project (name, active, git_repo, fk_class_id) VALUES ('Project Tracker', 1, 'https://github.com/gjmistkawi/Project-Tracker', 1),
                                                                 ('File Transfer System', 0, 'https://github.com/gjmistkawi/file-transfer-system', 4),
                                                                 ('Domininon Testing', 0, 'https://github.com/mistkawg/CS362-004-F2018', 2);
INSERT INTO tech_used (fk_tech_id, fk_project_id) VALUES (4,1), (5,1), (1,2), (2,2), (6,2), (3,3);
