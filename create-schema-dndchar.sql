CREATE TABLE user(
    u_key decimal(4,0) NOT NULL, --KEY--
    u_name varchar(25) NOT NULL
);

CREATE TABLE playerCharacter(
    pc_name varchar(20) NOT NULL, --KEY--
    pc_key deciaml(4,0) NOT NULL, --Link to user TBL--
    pc_race varchar(15) NOT NULL,
    pc_class decimal(2,0) NOT NULL,
    pc_level decimal(2,0) NOT NULL
);

CREATE TABLE background(
    bg_race varchar(15) NOT NULL,
    bg_age decimal(4,0) NOT NULL,   
    bg_alignment char(2) NOT NULL
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
VALUES (0, 'Patrick'),
    (1, 'Jaeha'),
    (2, 'Loic'),
    (3, 'Adam');

INSERT INTO playerCharacter(pc_name, pc_key, pc_race, pc_class, pc_level)
VALUES ('Libson', 0, 'HUMAN', 8, 4),
    ('Logan', 3, 'HALF-ELF', 3, 4),
    ('Ashkara', 1, 'HALF-ORC', 7, 4),
    ('Nazu', 1, 'HALF-ORC', 5, 3),
    ('Midir', 0, 'DRAGONBORN', 9, 7);

INSERT INTO background(bg_race, bg_age, bg_alignment)
VALUES ('HUMAN', 24, 'TN'),
    ('HALF-ELF', 156, 'NG'),
    ('HALF-ORC', 45, 'LG'),
    ('HALF-ORC', 60, 'LN'),
    ('DRAGONBORN', 15, 'CN');

INSERT INTO class(cl_id, cl_name)
VALUES (0, 'barbarian'),
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

INSERT INTO classWeapon(clwpn_prof, clwpn_name, clwpn_id)
VALUES ('T', 'shortsword', 8),
    ('T', 'dagger', 8),
    ('T', 'quaterstaff', 3),
    ('F', 'sickle', 3),
    ('T', 'rapier', 7),
    ('T', 'longbow', 7),
    ('T', 'dagger', 5),
    ('T', 'quaterstaff', 9),
    ('F', 'mace', 9);

INSERT INTO weapon(wpn_name, wpn_range, wpn_damage)
VALUES ('shortsword', 5, '1d6'),
    ('dagger', 100, '1d4'),
    ('quaterstaff', 5, '1d6'),
    ('sickle', 5, '1d4'),
    ('rapier', 5, '1d8'),
    ('longbow', 150, '1d8'),
    ('mace', 5, '1d6');

