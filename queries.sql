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
INNER JOIN background
ON bg_name = pc_name
WHERE bg_race != 'HUMAN';

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

--6) List all characters that have proficiency in a weapon that deals 1d6 damage--
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
ON pc_name = bg_name
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

--11) List spells that the class druid can cast but the class ranger cannot
SELECT sp_name FROM spell
INNER JOIN classSpell ON classSpell.clsp_name = spell.sp_name
WHERE clsp_id = 3 AND clsp_name NOT IN (
    SELECT clsp_name FROM classSpell
    WHERE clsp_id = 7);

--12) List how many spells each class has per slot level
SELECT cl_name AS class, IFNULL(sp_slotLevel, 'N/A') AS slotlevel, COUNT(sp_slotLevel) AS num_spells FROM class
LEFT JOIN (
    SELECT * FROM classSpell
    INNER JOIN spell ON spell.sp_name = classSpell.clsp_name) AS table1 ON table1.clsp_id = class.cl_id
GROUP BY cl_name, sp_slotLevel;

--13) List characters that have a charm type spell and are proficient with a dagger weapon
SELECT pc_name FROM playerCharacter
INNER JOIN class ON class.cl_id = playerCharacter.pc_class
INNER JOIN classWeapon ON classWeapon.clwpn_id = class.cl_id
INNER JOIN classSpell ON classSpell.clsp_id = class.cl_id
INNER JOIN spell ON spell.sp_name = classSpell.clsp_name
WHERE sp_effect = 'charm' AND clwpn_name = 'dagger'
GROUP BY pc_name

--14) List spells usable by characters that are Half-Elves
SELECT sp_name AS spell FROM spell
INNER JOIN classSpell ON classSpell.clsp_name = spell.sp_name
INNER JOIN class ON class.cl_id = classSpell.clsp_id
INNER JOIN playerCharacter ON playerCharacter.pc_class = class.cl_id
INNER JOIN background ON playerCharacter.pc_name = background.bg_name
WHERE bg_race = 'HALF-ELF' AND sp_slotLevel <= pc_level
GROUP BY sp_name

--15) List spells that are exclusively used by wizards
SELECT sp_name AS spell FROM spell
INNER JOIN classSpell ON classSpell.clsp_name = spell.sp_name
WHERE clsp_id = 11 AND sp_name NOT IN (
    SELECT clsp_name FROM classSpell
    WHERE clsp_id != 11);

--16) List spells that only rangers cannot use
SELECT sp_name AS spell FROM spell
INNER JOIN classSpell ON classSpell.clsp_name = spell.sp_name
WHERE sp_name NOT IN (
    SELECT clsp_name FROM classSpell
    WHERE clsp_id = 7)
GROUP BY sp_name;

--17) List characters and the weapons they are proficient in
SELECT pc_name AS character, wpn_name AS weapon FROM playerCharacter, weapon
INNER JOIN classWeapon ON playerCharacter.pc_class = classWeapon.clwpn_id
WHERE classWeapon.clwpn_name = weapon.wpn_name AND clwpn_prof = 'T';

--18) List classes without bonus action spells at level 1
SELECT cl_name AS class FROM class
WHERE cl_name NOT IN (
    SELECT cl_name FROM class
    INNER JOIN classSpell ON classSpell.clsp_id = class.cl_id
    WHERE clsp_name IN (
        SELECT sp_name FROM spell
        WHERE sp_castingtype = 'bonus' AND sp_slotLevel = 1)
    GROUP BY cl_name);

--19) List classes that can deal damage at 100+ range
SELECT cl_name AS class FROM class
INNER JOIN classSpell ON classSpell.clsp_id = class.cl_id
INNER JOIN spell ON spell.sp_name = classSpell.clsp_name
WHERE sp_name IN (
SELECT sp_name FROM spell
WHERE sp_die != 'N/A' AND sp_range >= 100 AND sp_effect = 'damage')
GROUP BY cl_name
UNION
SELECT cl_name AS class FROM class
INNER JOIN classWeapon ON classWeapon.clwpn_id = class.cl_id
INNER JOIN weapon ON weapon.wpn_name = classWeapon.clwpn_name
WHERE clwpn_prof = 'T' AND wpn_range >= 100;

--20) List the alignments of the characters of each user
SELECT bg_alignment AS alignment, u_name AS user FROM background, user
INNER JOIN playerCharacter ON playerCharacter.pc_key = user.u_key
WHERE bg_name = pc_name
ORDER BY u_name ASC;