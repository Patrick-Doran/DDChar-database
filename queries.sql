--List all names--
SELECT u_name
FROM user;

--List user name and character name--
SELECT u_name, pc_name
FROM user, playerCharacter
WHERE u_key = pc_key;

--List all non-human player characters--
SELECT pc_name
FROM playerCharacter
WHERE pc_race != 'HUMAN';

--List all spells that can be cast by Patrick's characters--
SELECT clsp_name
FROM classSpell
INNER JOIN playerCharacter, user
ON classSpell.clsp_id = playerCharacter.pc_class
    AND playerCharacter.pc_key = 0;

--List all characters that have proficeincy in a weapon that deals 1d6 damage--
SELECT pc_name
FROM playerCharacter
INNER JOIN classWeapon, weapon
ON playerCharacter.pc_class = classWeapon.clwpn_id
    AND classWeapon.clwpn_prof = 'T'
    AND classWeapon.clwpn_name = weapon.wpn_name
    AND weapon.wpn_damage = '1d6';