DROP TABLE IF EXISTS software;
CREATE TABLE software
(
    id             SERIAL           PRIMARY KEY,
    name           VARCHAR(50)      NOT NULL,
    annotation     VARCHAR(250)     NOT NULL,
    version        VARCHAR(30)      NOT NULL,
    downloadsCount INT              NOT NULL DEFAULT 0,
    termOfUseId    INT              REFERENCES termOfUse (id),
    typeId         INT              REFERENCES softwareType (id)
);

DROP TABLE IF EXISTS softwareType;
CREATE TABLE softwareType
(
    id   SERIAL         PRIMARY KEY,
    name VARCHAR(50)    NOT NULL
);

DROP TABLE IF EXISTS author;
CREATE TABLE author
(
    id      SERIAL      PRIMARY KEY,
    name    VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS user;
CREATE TABLE user
(
    id      SERIAL      PRIMARY KEY,
    login   VARCHAR(20) NOT NULL,
    name    VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS termOfUse;
CREATE TABLE termOfUse
(
    id          SERIAL          PRIMARY KEY,
    name        VARCHAR(50)     NOT NULL,
    description VARCHAR(1500)   NOT NULL
);

DROP TABLE IF EXISTS softwareAuthor;
CREATE TABLE softwareAuthor
(
    softwareId  INT     REFERENCES software (id),
    authorId    INT     REFERENCES author (id)
);

DROP TABLE IF EXISTS statisticsOfUsage;
CREATE TABLE statisticsOfUsage
(
    softwareId  INT      REFERENCES software (id),
    userId      INT      REFERENCES user (id),
    logonCount  INT      NOT NULL DEFAULT 0
);

-- types of software
INSERT INTO     softwareType (name)     VALUES ('System software');
INSERT INTO     softwareType (name)     VALUES ('Open source');
INSERT INTO     softwareType (name)     VALUES ('Freeware');

-- authors
INSERT INTO     author (name, surname)  VALUES ('Gabriel', 'Light');
INSERT INTO     author (name, surname)  VALUES ('Samuel', 'Johns');
INSERT INTO     author (name, surname)  VALUES ('Margaret', 'Ickie');

-- terms of use
INSERT INTO     termOfUse (name, description)   VALUES ('Public Domain License', 'This is a “permissive” license that allows adopting the code into applications or projects and reusing the software as desired.');
INSERT INTO     termOfUse (name, description)   VALUES ('GNU/LGPL', 'Under an LGPL license, developers have rights to link to open source libraries within their own software. Resulting code can be licensed under any other type of license – even proprietary – when projects are compiled or linked to include an LGPL-licensed library.');
INSERT INTO     termOfUse (name, description)   VALUES ('Proprietary', 'These software licenses make the software ineligible for copying, modifying, or distribution. This is the most restrictive type of software license, protecting the developer or owner from unauthorized use of the software.');

-- software
INSERT INTO     software (name, annotation, version, downloadsCount, termOfUseId, typeId)
VALUES          ('HealthCheck System', 'System for taking care of local services, first version', '1.0.0-beta', 0, 2, 3);
INSERT INTO     software (name, annotation, version, downloadsCount, termOfUseId, typeId)
VALUES          ('Faculty training app', 'For training students to contribute to open-source code', '7.1.5', 6, 1, 2);
INSERT INTO     software (name, annotation, version, downloadsCount, termOfUseId, typeId)
VALUES          ('Faculty System Manager', '', '2.14.8', 14, 3, 1);

-- users
INSERT INTO     user (login, name, surname)    VALUES ('admin', 'Admin', 'Admin');
INSERT INTO     user (login, name, surname)    VALUES ('m.shepel', 'Maria', 'Shepel');
INSERT INTO     user (login, name, surname)    VALUES ('m.yavorskyi', 'Maksym', 'Yavorskyi');

-- statisticsOfUsage
INSERT INTO     statisticsOfUsage (softwareId, userId, logonCount)
VALUES          (3, 1, 15);
INSERT INTO     statisticsOfUsage (softwareId, userId, logonCount)
VALUES          (2, 2, 6);
INSERT INTO     statisticsOfUsage (softwareId, userId, logonCount)
VALUES          (2, 3, 1);
INSERT INTO     statisticsOfUsage (softwareId, userId, logonCount)
VALUES          (1, 1, 4);

-- authors to software relation
INSERT INTO     softwareAuthor (softwareId, authorId)
VALUES (1, 1);
INSERT INTO     softwareAuthor (softwareId, authorId)
VALUES (2, 2);
INSERT INTO     softwareAuthor (softwareId, authorId)
VALUES (3, 3);
INSERT INTO     softwareAuthor (softwareId, authorId)
VALUES (1, 2);
INSERT INTO     softwareAuthor (softwareId, authorId)
VALUES (3, 1);

COMMIT;

