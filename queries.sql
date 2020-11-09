--1) List all names--
SELECT u_name AS user
FROM user;

--2) List user name and character name--
SELECT u_name AS user, pc_name AS name
FROM user, playerCharacter
WHERE u_key = pc_key;

--3) List all non-human player characters--
SELECT pc_name AS name
FROM playerCharacter
WHERE pc_race != 'HUMAN';

--4) How many characters does each Player have--
SELECT u_name AS user, COUNT(pc_key) AS total
FROM user, playerCharacter
WHERE u_key = pc_key
GROUP BY u_name;

--5) List all spells that can be cast by Patrick's characters--
SELECT clsp_name AS name
FROM classSpell
INNER JOIN playerCharacter, user
ON classSpell.clsp_id = playerCharacter.pc_class
    AND playerCharacter.pc_key = 0;

--6) List all characters that have proficeincy in a weapon that deals 1d6 damage--
SELECT pc_name AS name
FROM playerCharacter
INNER JOIN classWeapon, weapon
ON playerCharacter.pc_class = classWeapon.clwpn_id
    AND classWeapon.clwpn_prof = 'T'
    AND classWeapon.clwpn_name = weapon.wpn_name
    AND weapon.wpn_damage = '1d6';

--7) List all player characters that are older than 20 human years--
SELECT DISTINCT pc_name AS name
FROM playerCharacter
INNER JOIN background
ON pc_race = bg_race
WHERE bg_age > 20;

--8) List all spells usable by a druid that are a bonus action--
SELECT sp_name AS spells
FROM spell
INNER JOIN classSpell
ON classSpell.clsp_name = spell.sp_name
WHERE classSpell.clsp_id = 3 AND spell.sp_castingtype = 'bonus';

--9) List out what spells Midir can use and their spell slots--
SELECT DISTINCT sp_name AS spell, sp_slotLevel AS level
FROM spell
INNER JOIN playerCharacter, classSpell
ON playerCharacter.pc_class = classSpell.clsp_id
    AND classSpell.clsp_name = spell.sp_name
WHERE playerCharacter.pc_name = 'Midir';

--10) Which characters can use a sickle and also use animal friendship, list character, user, and class--
SELECT pc_name AS name, u_name AS user, pc_class AS class
FROM playerCharacter, user
INNER JOIN classWeapon, classSpell
ON pc_class = clwpn_id
    AND clwpn_name = 'sickle'
    AND pc_class = clsp_id
    AND clsp_name = 'animal friendship'
    AND pc_key = u_key;