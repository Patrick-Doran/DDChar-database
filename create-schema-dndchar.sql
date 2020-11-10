--Drop Table
DROP TABLE user;
DROP TABLE playerCharacter;
DROP TABLE background;
DROP TABLE class;
DROP TABLE classWeapon;
DROP TABLE weapon;
DROP TABLE classSpell;
DROP TABLE spell;

--Create Table
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
    bg_alignment char(20) NOT NULL
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
    sp_slotLevel decimal(2,0) NOT NULL,
    sp_range decimal(3,0) NOT NULL,
    sp_castingtype varchar(25) NOT NULL,
    sp_effect varchar(25) NOT NULL,
    sp_die varchar(12) NOT NULL
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
    ('Midir', 0, 'DRAGONBORN', 9, 7),
    ('Jojo', 1, 'HALF-ELF', 7, 1);

INSERT INTO background(bg_name, bg_race, bg_age, bg_alignment)
VALUES ('Libson', 'HUMAN', 24, 'True Neutral'),
    ('Logan', 'HALF-ELF', 156, 'Neutral Good'),
    ('Ashkara', 'HALF-ORC', 45, 'Lawful Good'),
    ('Nazu', 'HALF-ORC', 60, 'Lawful Neutral'),
    ('Midir', 'DRAGONBORN', 15, 'Chaotic Neutral'),
    ('Jojo', 'HALF-ELF', 120, 'Lawful Evil');

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
    ('T', 'quarterstaff', 3),
    ('F', 'sickle', 3),
    ('T', 'rapier', 7),
    ('T', 'longbow', 7),
    ('T', 'dagger', 5),
    ('T', 'quarterstaff', 9),
    ('F', 'mace', 9);

INSERT INTO weapon(wpn_name, wpn_range, wpn_damage)
VALUES ('shortsword', 5, '1d6'),
    ('dagger', 100, '1d4'),
    ('quarterstaff', 5, '1d6'),
    ('sickle', 5, '1d4'),
    ('rapier', 5, '1d8'),
    ('longbow', 150, '1d8'),
    ('mace', 5, '1d6');

INSERT INTO classSpell(clsp_ability, clsp_id, clsp_name)
VALUES ('WIS', 3, 'animal friendship'),
    ('WIS', 3, 'charm person'),
    ('WIS', 3, 'create or destroy water'),
    ('WIS', 3, 'cure wounds'),
    ('WIS', 3, 'healing word'),
    ('WIS', 3, 'speak with animals'),
    ('WIS', 3, 'thunderwave'), 
    ('WIS', 3, 'detect magic'),
    ('WIS', 3, 'goodberry'),
    ('WIS', 3, 'longstrider'),
    ('WIS', 3, 'animal messenger'),
    ('WIS', 3,'barkskin'),
    ('WIS', 3, 'cloud of daggers'),
    ('WIS', 3,'flame blade'),
    ('WIS', 3, 'lesser restoration'),
    ('WIS', 3,'beast sense'),
    ('WIS', 3, 'jump'),
    ('WIS', 3, 'darkvision'),
    ('WIS', 3, 'pass without trace'),
    ('WIS', 3, 'spike growth'),
    ('WIS', 3, 'gust of wind'),
    ('WIS', 3, 'protection from poison'),
    ('WIS', 3, 'detect poison and disease'),
    ('WIS', 3, 'find traps'),
    ('WIS', 7, 'animal friendship'),
    ('WIS', 7, 'barkskin'),
    ('WIS', 7, 'cure wounds'),
    ('WIS', 7, 'detect magic'),
    ('WIS', 7, 'goodberry'),
    ('WIS', 7, 'longstrider'),
    ('WIS', 7, 'speak with animals'),
    ('WIS', 7, 'animal messenger'),
    ('WIS', 7, 'beast sense'),
    ('WIS', 7, 'lesser restoration'),
    ('WIS', 7, "hunter's mark"),
    ('WIS', 7, 'ensnaring strike'),
    ('WIS', 7, 'cordon of arrows'),
    ('WIS', 7, 'pass without trace'),
    ('WIS', 7, 'spike growth'),
    ('WIS', 7, 'fog cloud'),
    ('WIS', 7, 'protection from poison'),
    ('WIS', 7, 'darkvision'),
    ('WIS', 7, 'silence'),
    ('WIS', 7, 'detect poison and disease'),
    ('WIS', 7, 'find traps'),
    ('CHR', 9, 'charm person'),
    ('CHR', 9, 'detect magic'),
    ('CHR', 9, 'fog cloud'),
    ('CHR', 9, 'thunderwave'),
    ('CHR', 9, 'cloud of daggers'),
    ('CHR', 9, 'expeditious retreat'),
    ('CHR', 9, 'false life'),
    ('CHR', 9, 'magic missile'),
    ('CHR', 9, 'witch bolt'),
    ('CHR', 9, 'jump'),
    ('CHR', 9, 'darkvision'),
    ('CHR', 9, 'scorching ray'),
    ('CHR', 9, 'spider climb'),
    ('CHR', 9, 'misty step'),
    ('CHR', 9, 'gust of wind'),
    ('CHR', 9, 'levitate'),
    ('CHR', 9, 'see invisibility'),
    ('CHR', 9, 'shatter'),
    ('CHR', 9, 'suggestion'),
    ('CHR', 9, 'burning hands');

INSERT INTO spell(sp_name, sp_slotlevel, sp_range, sp_castingtype, sp_effect, sp_die)
VALUES ('animal friendship', 1, 30, 'action', 'charm', 'N/A'),
    ('charm person', 1, 30, 'action', 'charm', 'N/A'),
    ('create or destroy water', 1, 30, 'action', 'creation','N/A'),
    ('cure wounds', 1, 5, 'action', 'healing', '1d8'),
    ('healing word', 1, 60, 'bonus', 'healing', '1d4'),
    ('speak with animals', 1, 0, 'action', 'communication', 'N/A'), 
    ('thunderwave', 1, 15, 'action', 'damage', '2d8'),
    ('detect magic', 1, 30, 'action', 'detection', 'N/A'),
    ('goodberry', 1, 5, 'action', 'healing', 'N/A'),
    ('longstrider', 1, 5, 'action', 'buff', 'N/A'),
    ('animal messenger', 2, 30, 'action', 'communication', 'N/A'),
    ('barkskin', 2, 5, 'action', 'buff', 'N/A'),
    ('cloud of daggers', 2, 60, 'action', 'damage', '4d4'),
    ('flame blade', 2, 0, 'bonus','damage', '3d6'),
    ('lesser restoration', 2, 0, 'action', 'healing', 'N/A'),
    ('beast sense', 2, 5, 'action', 'detection', 'N/A'),
    ("hunter's mark", 1, 90, 'bonus', 'damage', '1d6'),
    ('ensnaring strike', 1, 0, 'bonus', 'damage', '1d6'),
    ('cordon of arrows', 1, 5, 'action', 'damage', '1d6'),
    ('pass without trace', 2, 0, 'action', 'buff', 'N/A'),
    ('silence', 2, 120, 'action', 'control', 'N/A'),
    ('spike growth', 2, 150, 'action', 'control', '2d4'),
    ('fog cloud', 1, 120, 'action', 'control', 'N/A'),
    ('expeditious retreat', 1, 0, 'bonus', 'movement', 'N/A'),
    ('false life', 1, 0, 'action', 'healing', '1d4'),
    ('magic missile', 1, 120, 'action', 'damage', '1d4'),
    ('witch bolt', 1, 30, 'action', 'damage', '1d12'),
    ('jump', 1, 5, 'action', 'movement', 'N/A'),
    ('mage armor', 1, 5, 'action', 'buff', 'N/A'),
    ('scorching ray', 2, 120, 'action', 'damage', '2d6'),
    ('spider climb', 2, 5, 'action', 'buff', 'N/A'),
    ('misty step', 2, 5, 'bonus', 'movement', 'N/A'),
    ('gust of wind', 2, 0, 'action', 'control', 'N/A'),
    ('protection from poison', 2, 5, 'action', 'buff', 'N/A'),
    ('levitate', 2, 60, 'action', 'movement', 'N/A'),
    ('darkvision', 2, 5, 'action', 'buff', 'N/A'),
    ('see invisibility', 2, 0, 'action', 'detection', 'N/A'),
    ('shatter', 2, 60, 'action', 'damage', '3d8'),
    ('silence', 2, 120, 'action', 'control', 'N/A'),
    ('detect poison and disease', 1, 0, 'action', 'detection', 'N/A'),
    ('find traps', 2, 120, 'action', 'detection', 'N/A'),
    ('suggestion', 2, 30, 'action', 'control', 'N/A'),
    ('burning hands', 1, 0, 'action', 'damage', '3d6');

