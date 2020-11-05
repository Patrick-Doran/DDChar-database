CREATE TABLE user(
    u_key decimal(4,0) NOT NULL, --KEY--
    u_name varchar(25) NOT NULL
);

CREATE TABLE playerCharacter(
    pc_name varchar(20) NOT NULL, --KEY--
    pc_race varchar(15) NOT NULL,
    pc_class decimal(2,0) NOT NULL,
    pc_level decimal(2,0) NOT NULL
);

CREATE TABLE background(
    bg_race varchar(15) NOT NULL,
    bg_age deciaml(4,0) NOT NULL,   
    bg_alignment char(14) NOT NULL
);

CREATE TABLE class(
    cl_id decimal(2,0) NOT NULL, --KEY--
    cl_name varchar(15) NOT NULL
);

CREATE TABLE classWeapon(
    clwpn_prof char(1) NOT NULL,
    clwpn_name varchar(25) NOT NULL, --KEY FROM JOIN--
    clwpn_id decimal(2,0) NOT NULL --KEY FROM JOIN--
);

CREATE TABLE weapon(
    wpn_name varchar(25) NOT NULL, --KEY--
    wpn_range decimal(3,0) NOT NULL,
    wpn_damage varchar(12) NOT NULL
);

CREATE TABLE classSpell(
    clsp_ability char(3) NOT NULL,
    clsp_id decimal(2,0) NOT NULL, --KEY FROM JOIN--
    clsp_name varchar(25) NOT NULL --KEY FROM JOIN--
);

CREATE TABLE spell(
    sp_name varchar(25) NOT NULL, --KEY--
    sp_damage varchar(12) NOT NULL,
    sp_slotLevel decimal(2,0) NOT NULL,
    sp_range decimal(3,0) NOT NULL,
    sp_description varchar(144) NOT NULL
);

--POPULATE TABLE--
INSERT INTO user(u_key, u_name) 
VALUES (rowid, 'Matias'),
    (rowid, 'Patrick'),
    (rowid, 'Jaeha'),
    (rowid, 'Loic'),
    (rowid, 'Adam');

INSERT INTO playerCharacter(pc_name, pc_race, pc_class, pc_level)
VALUES ('Libson', 'HUMAN', 1, 4);

INSERT INTO class(cl_id, cl_name)
VALUES(0, 'barbarian'),
    (1, 'bard'),
    (2, 'cleric'),
    (3, 'druid'),
    (4, 'fighter'),
    (5, 'monk'),
    (6, 'paladin'),
    (7, 'ranger'),
    (8, 'rogue'),
    (9, 'sorcerer'),
    (10, 'warlock'),
    (11, 'wizard');